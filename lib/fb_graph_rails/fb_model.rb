# Extension for your fb users
#
# === Column names ===
#
# ::: identifier
#    FB user id (t.string :identifier, :limit => 20)
# ::: access_token
#    OAuth Access token (t.string :access_token)
#
# ===  Expample ===
# 
#   class FacebookUser < ActiveRecord::Base
#      include FbGraphRails::FbModel
#      ...
#   end
#

module FbGraphRails
  module FbModel 

    module ClassMethods

      def identify(fb_user)
        _fb_user_ = self.find_or_initialize_by_identifier(fb_user.identifier.try(:to_s))
        _fb_user_.access_token = fb_user.access_token.access_token
        _fb_user_.save!
        _fb_user_
      end # def
      
    end # module

    module InstanceMethods
      def fb_profile
        @_profile ||= FbGraph::User.me(self.access_token).fetch
      end
    end # module

    def self.included reciever
      reciever.extend ClassMethods
      reciever.send :include, InstanceMethods
      reciever.send :include, FbGraphRails::FbConfig
    end # def

  end # module

end # module 
