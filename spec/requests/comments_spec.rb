require 'rails_helper'

RSpec.describe "Comments", type: :request do


  describe ".authenticate" do
    before :all do
      @user = FactoryGirl.create(:user , {:name=>"zeiad", :email=>"comment@gmail.com" , password:"11223344"})
      @post = FactoryGirl.create(:post , {:title=>"My Post", :body=>"Delete Now" , user:@user})
      auth = {
        email: @user.email,
        password: @user.password
      }

      post "/api/user_token" , :params => { :auth => {:email => @user.email , :password => @user.password} }
      @credentials = response.body
      @token = JSON.parse(@credentials)
    end



    it "User Can Add Comments to Post" do
      post "/api/comments" ,:params => { :comment => {:description => "string" , :post_id => @post.id} } ,  headers: { "Authorization" => @token["jwt"] }
      expect(response).to have_http_status(201)
    end


    it "User Can't Add Comments without  Post" do
      post "/api/comments" ,:params => { :comment => {:description => "string"} } ,  headers: { "Authorization" => @token["jwt"] }
      expect(response).to have_http_status(422)
    end



    it "User Can Delete His Comment" do
      @comment = FactoryGirl.create(:comment , {:description=>"My Post" , user:@user , post:@post})
      delete "/api/comments/#{@comment.id}" ,  headers: { "Authorization" => @token["jwt"] }
      expect(response).to have_http_status(200)
    end

    

    
    it "User Can update His Comment" do
      @comment = FactoryGirl.create(:comment , {:description=>"My Post" , user:@user , post:@post})
      patch "/api/comments/#{@comment.id}" , :params => { :comment => {:description => "string"} } ,  headers: { "Authorization" => @token["jwt"] }
      expect(response).to have_http_status(200)
    end

    it "User Can't Update another user's Comment" do
      @new_user = FactoryGirl.create(:user , {:name=>"zeiad", :email=>"new@gmail.com" , password:"11223344"})
      @comment = FactoryGirl.create(:comment , {:description=>"My Post" , user:@new_user , post:@post})
      patch "/api/comments/#{@comment.id}" , :params => { :comment => {:description => "string"} } ,  headers: { "Authorization" => @token["jwt"] }
      expect(response).to have_http_status(422)
    end

    it "User Can't Delete another user's Comment" do
      @new_user = FactoryGirl.create(:user , {:name=>"zeiad", :email=>"new@gmail.com" , password:"11223344"})
      @comment = FactoryGirl.create(:comment , {:description=>"My Post" , user:@new_user , post:@post})
      delete "/api/comments/#{@comment.id}" , headers: { "Authorization" => @token["jwt"] }
      expect(response).to have_http_status(422)
    end





  



end






end
