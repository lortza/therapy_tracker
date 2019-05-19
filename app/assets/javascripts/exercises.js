function listToggler() {
  document.addEventListener('DOMContentLoaded', function () {
    let exerciseList = document.getElementById('exercise-list')

    exerciseList.addEventListener('click', function (event) {
      let element = event.target
      if(element.classList.contains('exercise-description-toggle')){
        let description = element.parentElement.parentElement.querySelector('.exercise-description');
        if(element.classList.contains('fa-chevron-down')){
          element.classList.remove('fa-chevron-down')
          element.classList.add('fa-chevron-left')
          description.style.display = 'block';
        } else {
          element.classList.remove('fa-chevron-left')
          element.classList.add('fa-chevron-down')
          description.style.display = 'none';
        }
      }
    });
  });
}


function dropdownSwitcher() {
  document.addEventListener('DOMContentLoaded', function () {
    const exerciseDropdown = document.getElementById('exercise_log_exercise_id');
    const initialExerciseId = exerciseDropdown.options[exerciseDropdown.selectedIndex].value;

    const baseUrl = window.location.origin
    const apiUrl = `${baseUrl}/exercises/${initialExerciseId}.json`

    const sets = document.getElementById('exercise_log_sets');
    const reps = document.getElementById('exercise_log_reps');
    const repLength = document.getElementById('exercise_log_rep_length');
    const perSide = document.getElementById('exercise_log_per_side');
    const resistance = document.getElementById('exercise_log_resistance');


    function populateDOM(data) {
      console.log(data);
      sets.value = data.default_sets;
      reps.value = data.default_reps;
      repLength.value = data.default_rep_length;
      perSide.checked = data.default_per_side;
      resistance.value = data.default_resistance;
    }

    function getExercise(url) {
      fetch(url)
        .then(response => response.json())
        .then(populateDOM)
        .catch(err => console.log(err));
    }

    // Populate Default values on pageload
    if(!sets){
      getExercise(apiUrl);
    }

    // Populate Default values on dropdown change
    exerciseDropdown.addEventListener('change', function (event) {
      event.preventDefault();
      const selectedExerciseId = event.target.value;
      const apiUrl = `${baseUrl}/exercises/${selectedExerciseId}.json`

      getExercise(apiUrl);
    })
  });
}
