require 'spec_helper'

describe ItemsController do

  describe "Get #index" do
    it "should redirect to the sign-in page if a user is not signed in" do
      get :index
      response.should redirect_to new_user_session_path
    end

    it "should redirect to users/dashboard if a user is signed in" do
      user = FactoryGirl.create(:user)
      sign_in user
      get :index
      response.should redirect_to users_dashboard_path
    end
  end

  describe "Get #new" do
    it "should redirect to the sign-in page if a user is not signed in" do
      get :new
      response.should redirect_to new_user_session_path
    end

    it "should render a new template if a user is signed in" do
      user = FactoryGirl.create(:user)
      sign_in user
      get :new
      response.should render_template(:new)
    end
  end

  describe "Post #create" do
    it "should create an item if all information is valid" do
      user = FactoryGirl.create(:user)
      sign_in user
      post :create, item: {description: "Grocery shopping", 
                      duedate: "2014-02-16"}
      response.should redirect_to users_dashboard_path
    end

    it "should render template new if description is less than 10 characters" do
      user = FactoryGirl.create(:user)
      sign_in user
      post :create, item: {description: "fail", 
                      duedate: "2014-02-16"}
      response.should render_template(:new)
    end
  end

  describe "Get #edit" do
    it "should render edit template if user is signed in" do
       user = FactoryGirl.create(:user)
       sign_in user
       item = FactoryGirl.create(:item, user: user)
       get :edit, id: item.id
       expect(assigns(:item)).to  eq item
    end 

    it "should redirect to the sign-in page if a user is not signed in" do
      get :edit, id: 1
      response.should redirect_to new_user_session_path
    end

  end

  describe "Patch #update" do

      it "should render template edit if description is less than 10 characters" do
        user = FactoryGirl.create(:user)
        sign_in user
        item = FactoryGirl.create(:item, user: user)
        patch :update, {id: item.id, item: {description: "fail", duedate: item.duedate}}
        response.should render_template(:edit)
    end

    it "should update item if user is signed in and all item info is valid" do
      user = FactoryGirl.create(:user)
      sign_in user
      item = FactoryGirl.create(:item, user: user)
      patch :update, {id: item.id, item: {description: "this is a testing item", duedate: item.duedate}}
      expect(assigns(:item).description).to eq "this is a testing item"
    end

  end

  describe "Delete #destroy" do
    it "should raise error if user is not signed in" do
      user = FactoryGirl.create(:user)
      item = FactoryGirl.create(:item, user: user)
      delete :destroy, id: item.id
      expect(response).to_not be_success
    end

    it "should delete an item if user is signed in" do 
      user = FactoryGirl.create(:user)
      sign_in user
      item = FactoryGirl.create(:item, user: user)
      delete :destroy, id: item.id
      expect(response).to redirect_to users_dashboard_path
    end
  end

  describe "Get #show" do
    it "should redirect to user/dashboard" do
      user = FactoryGirl.create(:user)
      sign_in user
      item = FactoryGirl.create(:item, user: user)
      delete :show, id: item.id
      expect(response).to redirect_to users_dashboard_path
    end
  end

end
