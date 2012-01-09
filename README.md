FbGraphRails
============

A (really) simple gem around [fb_graph][1] for canvas authentication in Facebook.


Installation
------------

     gem install fb_graph_rails
     
or  put the requirement into your gem file:

     gem 'fb_graph_rails'
     

Configuration
-------------

Create a YAML file in `config/facebook.yml` holding the configuration
keys of your application and your facebook secret. 

    development: &defaults
      client_id: your_client_id
      client_secret: your_client_secret
    # scope: user_about_me,user_activities,user_birthday,user_education_history,user_events,user_groups,user_hometown,user_interests,user_likes,user_location,user_notes,user_online_presence,user_photo_video_tags,user_photos,user_relationships,user_relationship_details,user_religion_politics,user_status,user_videos,user_website,user_work_history,email,read_friendlists,read_insights,read_mailbox,read_requests,read_stream,xmpp_login,ads_management,user_checkins,publish_stream,create_event,rsvp_event,sms,offline_access,publish_checkins,manage_pages,friends_about_me,friends_activities,friends_birthday,friends_education_history,friends_events,friends_groups,friends_hometown,friends_interests,friends_likes,friends_location,friends_notes,friends_online_presence,friends_photo_video_tags,friends_photos,friends_relationships,friends_relationship_details,friends_religion_politics,friends_status,friends_videos,friends_website,friends_work_history,manage_friendlists,friends_checkins,manage_notifications # ,user_address,user_mobile_phone
      scope: [email, user_about_me]
      canvas_url: http://apps.facebook.com/your_app
      model: your_user_model
     
    test:
      <<: *defaults
     
    production:
      <<: *defaults

Usage
-----

You need to define your user model with the following columns:

<dl>
  <dt>identifier</dt>
  <dd>FB user id (t.string :identifier, :limit => 20)</dd>
  <dt>access_token</dt>
  <dd>OAuth Access token (t.string :access_token)</dd>
</dl>

Include our `FbGraphRails::FbModel` into your user model:

    class FacebookUser < ActiveRecord::Base
        include FbGraphRails::FbModel
         ...
    end

and include into your controller our authentication filter:

    class QuizzesController < ApplicationController
     
      fb_authenticate
      ....
    
    end

Copyright
=========

This project rocks and uses MIT-LICENSE.

* [Paul Spieker][p] &lt;<paul.spieker@familienservice.de>&gt;
* [Fabian Otto][f] &lt;<fabian.otto@familienservice.de>&gt;

[1]:https://github.com/nov/fb_graph 
[p]:https://github.com/spieker
[f]:https://github.com/zickzackv
