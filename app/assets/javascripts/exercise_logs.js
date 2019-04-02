// var myEl = document.getElementsByTagName("p")[0];
// myEl.addEventListener("click", function(){
//     console.log("Clicked the first <p>!");
//   });
//
document.addEventListener('DOMContentLoaded', function () {

  const startButton = document.getElementById('start_button')
  const sets = 2;
  const reps = 3;
  const repLength = 1;
  const setRest = 5;
  const exerciseName = 'curls';

  function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  var repsCounter = 1;
  async function countReps() {
    while (repsCounter <= reps) {
      console.log(`Set ${setsCounter}, rep ${repsCounter}`);
      await sleep(repLength * 1000);
      repsCounter++
    }
    repsCounter = 1;
    console.log(`Set ${setsCounter} complete`);
  };

  var setsCounter = 1;
  async function countSets() {
    while (setsCounter <= sets) {
      console.log("Begin Set " + setsCounter);
      await sleep(2 * 1000);
      await countReps();
      await sleep(setRest * 1000);
      setsCounter++
    }
    setsCounter = 1;
    console.log(`${exerciseName} complete`);
  };

  startButton.addEventListener('click', function (event) {
    event.preventDefault;
    console.log(event)
    countSets();
  });

  
});
