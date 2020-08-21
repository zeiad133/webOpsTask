require 'rails_helper'

RSpec.describe "Posts", type: :request do


  describe ".authenticate" do
    before :all do
      @user = FactoryGirl.create(:user)
      auth = {
        email: @user.email,
        password: @user.password
      }

      post "/api/user_token" , :params => { :auth => {:email => @user.email , :password => @user.password} }
      @credentials = response.body
      @token = JSON.parse(@credentials)

      # expect(response.status).to eq(201)
      # expect(response.body).to eq({ "message" => "Hello world!" }.to_json)
    end

    it "User can View Posts" do
      get "/api/posts" , headers: { "Authorization" => @token["jwt"] }
      expect(response).to have_http_status(200)
    end

    it "User can Create Posts" do
      post "/api/posts" ,:params => { :post => {:title => "string" , :body => "body" , :comment_description => "comment" , :tag_description => "tag"} } ,  headers: { "Authorization" => @token["jwt"] }
      expect(response).to have_http_status(201)
    end


    it "User can't Create Post Without Tag" do
      post "/api/posts" ,:params => { :post => {:title => "string" , :body => "body" , :comment_description => "comment" } } ,  headers: { "Authorization" => @token["jwt"] }
      expect(response).to have_http_status(422)
    end


    it "User Can Delete His Post" do
      @post = FactoryGirl.create(:post , {:title=>"My Post", :body=>"Delete Now" , user:@user})
      delete "/api/posts/#{@post.id}" ,  headers: { "Authorization" => @token["jwt"] }
      expect(response).to have_http_status(200)
    end

    
    it "User Can update His Post" do
      @post = FactoryGirl.create(:post , {:title=>"My Post", :body=>"Delete Now" , user:@user})
      patch "/api/posts/#{@post.id}" , :params => { :post => {:title => "string" , :body => "body" , :comment_description => "comment" , :tag_description => "tag"} } , headers: { "Authorization" => @token["jwt"] }
      expect(response).to have_http_status(200)
    end

    it "User Can't Update another user's Post" do
      @new_user = FactoryGirl.create(:user , {:name=>"zeiad", :email=>"new@gmail.com" , password:"11223344"})
      @post = FactoryGirl.create(:post , {:title=>"My Post", :body=>"Delete Now" , user:@new_user})
      patch "/api/posts/#{@post.id}" , :params => { :post => {:title => "string" , :body => "body" , :comment_description => "comment" , :tag_description => "tag"} } , headers: { "Authorization" => @token["jwt"] }
      expect(response).to have_http_status(422)
    end

    it "User Can't Delete another user's Post" do
      @new_user = FactoryGirl.create(:user , {:name=>"zeiad", :email=>"new@gmail.com" , password:"11223344"})
      @post = FactoryGirl.create(:post , {:title=>"My Post", :body=>"Delete Now" , user:@new_user})
      delete "/api/posts/#{@post.id}" , headers: { "Authorization" => @token["jwt"] }
      expect(response).to have_http_status(422)
    end





  



end



  # describe "GET /posts" do
   
  # end


end
