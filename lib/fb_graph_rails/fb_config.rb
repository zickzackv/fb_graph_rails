module FbGraphRails
  module FbConfig

    module ClassMethods

      def fb_config
        YAML.load_file("#{Rails.root}/config/facebook.yml")[Rails.env].symbolize_keys
      rescue Errno::ENOENT => e
        raise StandardError.new("config/facebook.yml could not be loaded.")
      end

      def fb_app
        FbGraph::Application.new fb_config[:client_id], :secret => fb_config[:client_secret]
      end

      def fb_auth(redirect_uri = nil)
        FbGraph::Auth.new fb_config[:client_id], fb_config[:client_secret], :redirect_uri => redirect_uri
      end
      
      def fb_model
        @_model ||= fb_config[:model].constantize
        #TODO: say why the class could not be found
      end
      
      def fb_canvas_url
        @_canvas_url ||= fb_config[:canvas_url]
      end
    end # module


    def self.included reciever
      reciever.extend ClassMethods
    end # def

  end # module

end # module 


# ActionController::Base.send :include, FbGraphRails::FbConfig
