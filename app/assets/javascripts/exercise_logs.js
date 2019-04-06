// Need to add pause and stop buttons

let counter = function(setsInput, repsInput, repLengthInput){

  document.addEventListener('DOMContentLoaded', function () {
    const sets = setsInput;
    const reps = repsInput;
    const minRepLength = 2;
    const repLength = repLengthInput === 0 ? minRepLength : repLengthInput;
    const setRest = 5;

    const startButton = document.getElementById('start_button');
    const setDisplayer = document.getElementById('set');
    const repDisplayer = document.getElementById('rep');
    const repLengthDisplayer = document.getElementById('rep-length');
    const beginFinishedIndicator = document.getElementById('begin-finished-indicator');

    const soundExerciseBegin = new Audio('/sounds/exercise_begin.wav');
    var playButton = document.getElementById('play_button');

    playButton.addEventListener('click', function (event) {
      event.preventDefault();
      soundExerciseBegin.play();
    });

    function sleep(ms) {
      return new Promise(resolve => setTimeout(resolve, ms));
    }

    var repsCounter = 1;
    async function countReps() {
      while (repsCounter <= reps) {
        console.log(`Set ${setsCounter}, rep ${repsCounter}`);
        repDisplayer.textContent = repsCounter;

        await sleep(repLength * 1000);
        repsCounter++
      }
      repsCounter = 1;
      console.log(`Set ${setsCounter} complete`);
      beginFinishedIndicator.textContent = 'Rest...';

    };

    var setsCounter = 1;
    async function countSets() {
      while (setsCounter <= sets) {
        console.log("Begin Set " + setsCounter);
        setDisplayer.textContent = setsCounter;
        beginFinishedIndicator.textContent = 'Begin!';

        await sleep(2 * 1000);
        await countReps();
        await sleep(setRest * 1000);
        setsCounter++
      }
      setsCounter = 1;
      console.log(`Exercise complete`)
      beginFinishedIndicator.textContent = 'Finished!';
    };

    startButton.addEventListener('click', function (event) {
      event.preventDefault;
      beginFinishedIndicator.classList.add('hidden')

      beginFinishedIndicator.textContent = 'Begin!';
      beginFinishedIndicator.classList.remove('hidden')
      countSets();
    });

  });
};
