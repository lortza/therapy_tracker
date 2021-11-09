function easyButtonListToggler() {
  document.addEventListener('DOMContentLoaded', function () {
    let exerciseList = document.getElementById('easy-button-list')

    exerciseList.addEventListener('click', function (event) {
      let element = event.target
      if(element.classList.contains('easy-button-description-toggle')){
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
