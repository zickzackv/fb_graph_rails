Rails.application.routes.draw do

  mount FbGraphRails::Engine => "/fb_graph_rails"
end
