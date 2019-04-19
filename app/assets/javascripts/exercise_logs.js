// Need to add pause and stop buttons

function counter(setsInput, repsInput, repLengthInput){
  document.addEventListener('DOMContentLoaded', function () {
    // Default Values
    const sets = setsInput;
    const reps = repsInput;
    const minRepLength = 2;
    const repLength = repLengthInput === 0 ? minRepLength : repLengthInput;
    const setRest = 5;

    // DOM Elements
    const startButton = document.getElementById('start_button');
    const setDisplayer = document.getElementById('set');
    const repDisplayer = document.getElementById('rep');
    const repLengthDisplayer = document.getElementById('rep-length');
    const beginFinishedIndicator = document.getElementById('begin-finished-indicator');

    // Audio Files
    const soundExerciseBegin = new Audio('/sounds/exercise_begin.wav');
    const soundExerciseComplete = new Audio('/sounds/exercise_complete.m4a');
    const soundSetComplete = new Audio('/sounds/set_complete.m4a');
    const soundRep = new Audio('/sounds/rep.m4a');

    function sleep(ms) {
      return new Promise(resolve => setTimeout(resolve, ms));
    }

    function completeExercise() {
      console.log(`Exercise complete`)
      beginFinishedIndicator.textContent = 'Finished!';
      setDisplayer.textContent = 0;
      repDisplayer.textContent = 0;
      soundExerciseComplete.play().catch(e => {
        console.log(e);
      });
    }

    var repsCounter = 1;
    async function countReps() {
      while (repsCounter <= reps) {
        console.log(`Set ${setsCounter}, rep ${repsCounter}`);
        repDisplayer.textContent = repsCounter;
        soundRep.play().catch(e => {
          console.log(e);
        });;

        await sleep(repLength * 1000);
        repsCounter++
      }
      repsCounter = 1;
      console.log(`Set ${setsCounter} complete`);
      beginFinishedIndicator.textContent = 'Rest...';
      repDisplayer.textContent = 0;
    };

    var setsCounter = 1;
    async function countSets() {
      soundExerciseBegin.play().catch(e => {
        console.log(e);
      });;

      while (setsCounter <= sets) {
        console.log("Begin Set " + setsCounter);
        setDisplayer.textContent = setsCounter;
        beginFinishedIndicator.textContent = 'Begin!';

        await sleep(2 * 1000);
        await countReps();
        soundSetComplete.play().catch(e => {
          console.log(e);
        });;
        await sleep(setRest * 1000);
        setsCounter++
      }
      setsCounter = 1;
      completeExercise();
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


function burnDropdowns(setsInput, repsInput){
  document.addEventListener('DOMContentLoaded', function () {
    // Default Values
    const sets = setsInput;
    const reps = repsInput;

    // DOM Elements
    const burnSetContainer = document.getElementById('burn-set-container');
    const burnRepContainer = document.getElementById('burn-rep-container');


    document.getElementById('exercise_log_burn_set').remove();

    var setsDropdown = document.createElement('select');
    setsDropdown.setAttribute('id', 'exercise_log_sets');
    setsDropdown.setAttribute('class', 'form-control');
    setsDropdown.setAttribute('name', 'exercise_log[sets]');

    var setsOptions = document.createDocumentFragment()

    var setsLoopCount = 0;
    while (setsLoopCount <= setsInput) {
      var option = document.createElement('option');
      option.setAttribute('value', setsLoopCount);
      option.text = setsLoopCount;

      setsOptions.appendChild(option);
      setsLoopCount++
    }


    document.getElementById('exercise_log_burn_rep').remove();

    var repsDropdown = document.createElement('select');
    repsDropdown.setAttribute('id', 'exercise_log_reps');
    repsDropdown.setAttribute('class', 'form-control');
    repsDropdown.setAttribute('name', 'exercise_log[reps]');

    var repsOptions = document.createDocumentFragment()

    var repsLoopCount = 0;
    while (repsLoopCount <= repsInput) {
      var option = document.createElement('option');
      option.setAttribute('value', repsLoopCount);
      option.text = repsLoopCount;

      repsOptions.appendChild(option);
      repsLoopCount++
    }


    setsDropdown.appendChild(setsOptions);
    burnSetContainer.appendChild(setsDropdown);
    repsDropdown.appendChild(repsOptions);
    burnRepContainer.appendChild(repsDropdown);

  });
};
