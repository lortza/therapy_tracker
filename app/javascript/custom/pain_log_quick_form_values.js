function painLogQuickFormValueListToggler() {
  document.addEventListener('turbo:load', function () {
    let exerciseList = document.getElementById('quick-log-button-list')

    exerciseList.addEventListener('click', function (event) {
      let element = event.target
      if(element.classList.contains('quick-log-button-description-toggle')){
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

// Export function to window for inline script access
window.painLogQuickFormValueListToggler = painLogQuickFormValueListToggler;
