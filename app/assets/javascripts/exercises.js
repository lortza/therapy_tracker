const populateDefaultValues = function(exercises) {
  document.addEventListener('DOMContentLoaded', function () {
    console.log(exercises)
    const exerciseDropdown = document.getElementById('exercise_log_exercise_id');
    const sets = document.getElementById('exercise_log_sets');
    const reps = document.getElementById('exercise_log_reps');
    const repLength = document.getElementById('exercise_log_rep_length');

      // exercises.find(function(el){
      //   return el[0] === 2
      // })


    exerciseDropdown.addEventListener('change', function (event) {
      event.preventDefault();
      console.log(event.target.value);




      // async function getExercises(url){
      //   const response = await fetch(url)
      //   const data = await response.json().body
      //   return data
      // }
      // const api = 'http://localhost:3000/exercises'
      // getExercises(api).then(exercises => console.log(exercises))


      // function getExercise(url) {
      //   return new Promise((resolve, reject) => {
      //     fetch(url)
      //     .then(response => response)
      //     .then(data => resolve(data))
      //     .catch(err => reject(err));
      //   });
      // }
      // const api = 'http://localhost:3000/exercises/1'
      // getExercise(api).then(exercise => console.log(exercise))


      // sets.value = 7;
      // reps.value = 7;
      // repLength.value = 7;
    })

  });

}
