# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }

  describe "Public access to users" do
    it "denies access to users#edit" do
      get edit_user_settings_path(user.id)
      expect(response).to be_unauthorized
    end

    it "denies access to users#update" do
      patch user_path(user, user: user.attributes)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "Authenticated access to users" do
    before { sign_in(user) }

    describe "#edit" do
      it "renders users#edit" do
        get edit_user_settings_path(user.id)

        expect(response).to be_successful
        expect(response).to render_template(:edit)
      end
    end

    describe "#update" do
      let(:user) { create(:user, enable_slit_tracking: false) }

      it "updates the user" do
        patch user_path(user, user: {id: user.id, enable_slit_tracking: true})

        expect(user.reload.enable_slit_tracking).to eq(true)
      end

      context "when there is a return_to location" do
        it "redirects back to the previous url" do
          session = {return_to: exercise_logs_path}
          allow_any_instance_of(UsersController).to receive(:session).and_return(session)
          patch user_path(user, user: {id: user.id, enable_slit_tracking: true})

          expect(response).to redirect_to(exercise_logs_path)
        end
      end

      context "when there is not a return_to location" do
        it "redirects to the root_url" do
          patch user_path(user, user: {id: user.id, enable_slit_tracking: true})

          expect(response).to redirect_to(root_url)
        end
      end

      context "with slit_configuration nested attributes" do
        context "when creating a new slit_configuration" do
          let(:user) { create(:user, enable_slit_tracking: false) }

          it "creates the slit_configuration with provided attributes" do
            expect(user.slit_configuration).to be_nil

            expect {
              patch user_path(user, user: {
                enable_slit_tracking: true,
                slit_configuration_attributes: {
                  max_bottle_doses: 30,
                  hold_time_seconds: 90,
                  drops_dose_qty: 4
                }
              })
            }.to change(SlitConfiguration, :count).by(1)

            user.reload
            expect(user.slit_configuration).to be_present
            expect(user.slit_configuration.max_bottle_doses).to eq(30)
            expect(user.slit_configuration.hold_time_seconds).to eq(90)
            expect(user.slit_configuration.drops_dose_qty).to eq(4)
          end
        end

        context "when updating an existing slit_configuration" do
          let(:user) { create(:user, enable_slit_tracking: true) }
          let!(:slit_config) do
            create(:slit_configuration,
              user: user,
              max_bottle_doses: 20,
              hold_time_seconds: 60,
              drops_dose_qty: 3)
          end

          it "updates the existing slit_configuration" do
            patch user_path(user, user: {
              enable_slit_tracking: true,
              slit_configuration_attributes: {
                id: slit_config.id,
                max_bottle_doses: 40,
                hold_time_seconds: 120,
                drops_dose_qty: 5
              }
            })

            user.reload
            expect(user.slit_configuration.max_bottle_doses).to eq(40)
            expect(user.slit_configuration.hold_time_seconds).to eq(120)
            expect(user.slit_configuration.drops_dose_qty).to eq(5)
          end

          it "does not create a duplicate slit_configuration" do
            expect {
              patch user_path(user, user: {
                enable_slit_tracking: true,
                slit_configuration_attributes: {
                  id: slit_config.id,
                  max_bottle_doses: 50,
                  hold_time_seconds: 60,
                  drops_dose_qty: 3
                }
              })
            }.not_to change(SlitConfiguration, :count)
          end
        end

        context "when slit_configuration_attributes are not included" do
          let(:user) { create(:user, enable_slit_tracking: true) }
          let!(:slit_config) do
            create(:slit_configuration,
              user: user,
              max_bottle_doses: 25,
              hold_time_seconds: 75,
              drops_dose_qty: 2)
          end

          it "preserves the existing slit_configuration" do
            patch user_path(user, user: {
              enable_slit_tracking: false
            })

            user.reload
            expect(user.slit_configuration).to be_present
            expect(user.slit_configuration.max_bottle_doses).to eq(25)
            expect(user.slit_configuration.hold_time_seconds).to eq(75)
            expect(user.slit_configuration.drops_dose_qty).to eq(2)
          end
        end
      end
    end
  end
end
