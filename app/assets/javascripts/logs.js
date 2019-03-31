document.addEventListener('DOMContentLoaded', function () {
  let homeworkList = document.getElementById('homework-list')
  let homeworkToggle = document.getElementById('homework-list-toggle')

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
  })
});
