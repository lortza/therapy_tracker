# frozen_string_literal: true

require "rails_helper"

RSpec.describe PainsController, type: :controller do
  login_user

  let(:valid_attributes) { build(:pain, user_id: subject.current_user.id).attributes }
  let(:invalid_attributes) { build(:pain, user_id: subject.current_user.id, name: "").attributes }

  describe "GET #index" do
    it "returns a success response" do
      Pain.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      pain = Pain.create! valid_attributes
      get :edit, params: {id: pain.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Pain" do
        expect {
          post :create, params: {pain: valid_attributes}
        }.to change(Pain, :count).by(1)
      end

      it "redirects to the pain index page" do
        post :create, params: {pain: valid_attributes}
        expect(response).to redirect_to(Pain)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the new pain template)" do
        post :create, params: {pain: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { build(:pain, user_id: subject.current_user.id, name: "updated name").attributes }

      it "updates the requested pain" do
        pain = Pain.create! valid_attributes
        put :update, params: {id: pain.to_param, pain: new_attributes}
        pain.reload
        expect(pain.name).to eq(new_attributes["name"])
      end

      it "redirects to the pain index page" do
        pain = Pain.create! valid_attributes
        put :update, params: {id: pain.to_param, pain: valid_attributes}
        expect(response).to redirect_to(Pain)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the edit pain template)" do
        pain = Pain.create! valid_attributes
        put :update, params: {id: pain.to_param, pain: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested pain" do
      pain = Pain.create! valid_attributes
      expect {
        delete :destroy, params: {id: pain.to_param}
      }.to change(Pain, :count).by(-1)
    end

    it "redirects to the pains list" do
      pain = Pain.create! valid_attributes
      delete :destroy, params: {id: pain.to_param}
      expect(response).to redirect_to(pains_url)
    end
  end
end
