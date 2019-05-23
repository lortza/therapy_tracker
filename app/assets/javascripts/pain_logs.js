function painLevelDropdownSwitcher() {
  document.addEventListener('DOMContentLoaded', function () {
    const painDropdown = document.getElementById('pain_log_pain_id');
    const painLevel = document.getElementById('pain_log_pain_level');
    const description = document.getElementById('pain_log_pain_description');
    const trigger = document.getElementById('pain_log_trigger');

    function populateNoPainData() {
      painLevel.value = 0;
      description.value = 'none';
      trigger.focus();
      trigger.select();
    }

    function resetData() {
      painLevel.value = null;
      description.value = '';
    }

    painDropdown.addEventListener('change', function (event) {
      const selectedPainItem = painDropdown.options[painDropdown.selectedIndex].text.toLowerCase();
      event.preventDefault();

      if (selectedPainItem === 'none') {
        populateNoPainData();
      } else {
        resetData();
      }
    })
  });
}
