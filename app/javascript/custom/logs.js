document.addEventListener('turbo:load', function () {
  const homeworkList = document.getElementById('homework-list')
  const homeworkToggle = document.getElementById('homework-list-toggle')

  if(homeworkToggle){
    homeworkToggle.addEventListener('click', function(event){
      event.preventDefault();
      button = event.target;

      if(homeworkToggle.classList.contains('fa-caret-right')){
        homeworkToggle.classList.add('fa-caret-down')
        homeworkToggle.classList.remove('fa-caret-right')
        homeworkList.classList.remove('hidden')
      } else {
        homeworkToggle.classList.add('fa-caret-right')
        homeworkToggle.classList.remove('fa-caret-down')
        homeworkList.classList.add('hidden')
      }
    });
  }//end if

});
