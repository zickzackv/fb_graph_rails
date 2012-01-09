module FbGraphRails::FbActionControllerExtension 

  module ClassMethods

    def fb_authenticate *args
      before_filter :fb_auth_required, *args 
    end

  end # module 

  module InstanceMethods

    def fb_auth_required
      unless self.authenticated?
        auth = self.class.fb_auth
        auth.from_signed_request(params[:signed_request]) unless params[:signed_request].blank?
        if auth.authorized?
          authenticate self.class.fb_model.identify(auth.user)
          return true
        else
          url = auth.authorize_uri(self.class.fb_canvas_url, :scope => self.class.fb_auth_scope).html_safe
          return render :inline => "<script>top.location.href = '#{url}';</script>"

        end
      end
    end

    def require_authentication
      authenticate self.class.fb_model.find_by_id(session[:current_user])
    rescue Unauthorized => e
      redirect_to root_url and return false
    end

    def authenticate(user)
      raise Unauthorized unless user
      session[:current_user] = user.id
    end

    def unauthenticate
      current_user.destroy
      @current_user = session[:current_user] = nil
    end
    
    def current_user
      @current_user ||= self.class.fb_model.find(session[:current_user])
    rescue ActiveRecord::RecordNotFound
      nil
    end

    def authenticated?
      !current_user.blank? and current_user.fb_profile rescue false
    end

  end # module
  
  def self.included receiver
    receiver.extend ClassMethods
    receiver.send :include, InstanceMethods
    receiver.send :include, FbGraphRails::FbConfig
  end # def 
end 

ActionController::Base.send :include, FbGraphRails::FbActionControllerExtension
