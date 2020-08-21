require 'rails_helper'

RSpec.describe "Tags", type: :request do


  describe ".authenticate" do
    before :all do
      @user = FactoryGirl.create(:user , {:name=>"zeiad", :email=>"tag@gmail.com" , password:"11223344"})
      @post = FactoryGirl.create(:post , {:title=>"My Post", :body=>"Delete Now" , user:@user})
      auth = {
        email: @user.email,
        password: @user.password
      }

      post "/api/user_token" , :params => { :auth => {:email => @user.email , :password => @user.password} }
      @credentials = response.body
      @token = JSON.parse(@credentials)
    end



    it "User can add tags to Post" do
      post "/api/tags" ,:params => { :tag => {:description => "My Tag" , :post_id => @post.id } } ,  headers: { "Authorization" => @token["jwt"] }
      expect(response).to have_http_status(201)
    end

    it "User can't add tags without it's post" do
      post "/api/tags" , :params => { :tag => {:description => "My Tag"  } } ,  headers: { "Authorization" => @token["jwt"] }
      expect(response).to have_http_status(422)
    end


    
    it "User Can update any Tag" do
      @tag = FactoryGirl.create(:tag , {:description=>"My Post" , post:@post})
      patch "/api/tags/#{@tag.id}" , :params => { :tag => {:description => "My Tag"  } } ,  headers: { "Authorization" => @token["jwt"] }
      expect(response).to have_http_status(200)
    end
  



end



end
