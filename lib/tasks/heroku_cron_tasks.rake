# frozen_string_literal: true

namespace :heroku_cron do
  namespace :slit_logs do
    desc 'Create Skipped Dose'
    task create_skipped_dose: :environment do
      # rake heroku_cron:slit_logs:create_skipped_dose

      # Heroku runs this daily at 6am UTC / 2am EST: https://dashboard.heroku.com/apps/therapytracker/scheduler
      # UTC is 4 hours ahead of Eastern Time: https://savvytime.com/converter/utc-to-est
      SlitLogSkippedDoseService.call
    end
  end
end
