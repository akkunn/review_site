require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:user3) { FactoryBot.create(:user) }
  let(:school) { FactoryBot.create(:school) }
  let(:review) { FactoryBot.create(:review, user_id: user.id, school_id: school.id) }
  let!(:notification) { FactoryBot.create(:notification, review_id: review.id, visited_id: user.id, visiter_id: user2.id) }

  describe "#index" do
    context "as an authenticated user" do
      before do
        sign_in user
        get notifications_path
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "displays a correct page" do
        expect(response.body).to include("通知")
        expect(response.body).to include(user.name)
        expect(response.body).to include(notification.review.name)
      end
    end

    context "as a guest" do
      it "redirects to login page" do
        get notifications_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#destroy" do
    context "as an authorized user" do
      it "deletes a notification" do
        sign_in user
        expect {
          delete notification_path(notification)
        }.to change { Notification.count }.by(-1)
      end
    end

    context "as an unauthorized user" do
      before do
        sign_in user3
      end

      it "doesn't delete a notification" do
        expect {
          delete notification_path(notification)
        }.not_to change { Notification.count }
      end

      it "redirects to notification index page" do
        delete notification_path(notification)
        expect(response).to redirect_to notifications_path
      end
    end

    context "as a guest" do
      it "doesn't delete a notification" do
        expect {
          delete notification_path(notification)
        }.not_to change { Notification.count }
      end

      it "redirects to login page" do
        delete notification_path(notification)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#destroy_all" do
    context "as an authorized user" do
      it "deletes a notification" do
        sign_in user
        delete destroy_all_notification_path(user_id: notification.visited.id)
        expect(user.passive_notifications.count).to eq(0)
      end
    end

    context "as an unauthorized user" do
      before do
        sign_in user3
      end

      it "doesn't delete a notification" do
        expect {
          delete destroy_all_notification_path(user_id: notification.visited.id)
        }.not_to change { Notification.count }
      end

      it "redirects to notification index page" do
        delete destroy_all_notification_path(user_id: notification.visited.id)
        expect(response).to redirect_to notifications_path
      end
    end

    context "as a guest" do
      it "doesn't delete a notification" do
        expect {
          delete destroy_all_notification_path(user_id: notification.visited.id)
        }.not_to change { Notification.count }
      end

      it "redirects to login page" do
        delete destroy_all_notification_path(user_id: notification.visited.id)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
