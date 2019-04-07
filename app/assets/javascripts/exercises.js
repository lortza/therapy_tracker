document.addEventListener('DOMContentLoaded', function () {
  const exerciseDropdown = document.getElementById('exercise_log_exercise_id');
  const initialExerciseId = exerciseDropdown.options[exerciseDropdown.selectedIndex].value;

  const baseUrl = window.location.origin
  const apiUrl = `${baseUrl}/exercises/${initialExerciseId}.json`

  const sets = document.getElementById('exercise_log_sets');
  const reps = document.getElementById('exercise_log_reps');
  const repLength = document.getElementById('exercise_log_rep_length');


  function populateDOM(data) {
    console.log(data);
    sets.value = data.default_sets;
    reps.value = data.default_reps;
    repLength.value = data.default_rep_length;
  }

  function getExercise(url) {
    fetch(url)
      .then(response => response.json())
      .then(populateDOM)
      .catch(err => console.log(err));
  }

  // Populate Default values on pageload
  getExercise(apiUrl);

  // Populate Default values on dropdown change
  exerciseDropdown.addEventListener('change', function (event) {
    event.preventDefault();
    const selectedExerciseId = event.target.value;
    const apiUrl = `${baseUrl}/exercises/${selectedExerciseId}.json`

    getExercise(apiUrl);
  })
});
