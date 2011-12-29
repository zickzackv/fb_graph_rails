require 'test_helper'

module FbGraphRails
  class CanvasAuthControllerTest < ActionController::TestCase
    test "should get create" do
      get :create
      assert_response :success
    end
  
  end
end
