class AddAutoCalculateScoreRangeStepsToSurveys < ActiveRecord::Migration[8.1]
  def change
    add_column :surveys, :auto_calculate_score_range_steps, :boolean, default: true, null: false
  end
end
