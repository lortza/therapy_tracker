# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create(:user) }

  describe 'Public access to users' do
    it 'denies access to users#edit' do
      get edit_user_settings_path(user.id)
      expect(response).to be_unauthorized
    end

    it 'denies access to users#update' do
      patch user_path(user, user: user.attributes)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'Authenticated access to users' do
    before { sign_in(user) }

    describe '#edit' do
      it 'renders users#edit' do
        get edit_user_settings_path(user.id)

        expect(response).to be_successful
        expect(response).to render_template(:edit)
      end
    end

    describe '#update' do
      let(:user) { create(:user, enable_slit_tracking: false) }

      it 'updates the user' do
        patch user_path(user, user: { id: user.id, enable_slit_tracking: true })

        expect(user.reload.enable_slit_tracking).to eq(true)
      end

      context 'when there is a return_to location' do
        it 'redirects back to the previous url' do
          session = { return_to: exercise_logs_path }
          allow_any_instance_of(UsersController).to receive(:session).and_return(session)
          patch user_path(user, user: { id: user.id, enable_slit_tracking: true })

          expect(response).to redirect_to(exercise_logs_path)
        end
      end

      context 'when there is not a return_to location' do
        it 'redirects to the root_url' do
          patch user_path(user, user: { id: user.id, enable_slit_tracking: true })

          expect(response).to redirect_to(root_url)
        end
      end
    end
  end
end
