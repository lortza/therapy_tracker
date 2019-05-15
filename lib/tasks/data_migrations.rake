# run task like:
# rake data:session_ex_to_logs

namespace :data do
  desc "move data from pt_session_exercises to exercise_logs"
  task :session_ex_to_logs => :environment do
    ex_log_count = ExerciseLog.count
    pt_ex_count = PtSessionExercise.count
    puts "Current ExerciseLog.count: #{ex_log_count}"
    puts "Current PtSessionExercise.count: #{pt_ex_count}"
    PtSession.all.each do |pt_session|
      puts pt_session
      pt_session.pt_session_exercises.each do |pt_ex|
        puts pt_ex.exercise_name
        ExerciseLog.create!(
          user_id: pt_session.user_id,
          pt_session_id: pt_session.id,
          body_part_id: pt_session.body_part_id,
          datetime_occurred: pt_ex.created_at,
          exercise_id: pt_ex.exercise_id,
          sets: pt_ex.sets ? pt_ex.sets : pt_ex.exercise.default_sets,
          reps: pt_ex.reps ? pt_ex.reps : pt_ex.exercise.default_reps,
          rep_length: pt_ex.exercise.default_rep_length,
          per_side: pt_ex.exercise.default_per_side,
          resistance: pt_ex.resistance
        )
        puts "ExerciseLog.count: #{ExerciseLog.count}"
      end
    end

    puts "Should have #{ex_log_count + pt_ex_count} ExerciseLogs"
    puts "Actual count: #{ExerciseLog.count}"
  end

  task :remove_old_session_ex => :environment do
    # handled via migrations. No need to remove additional data.
  end
end
