# Therapy Tracker

[![CircleCI](https://circleci.com/gh/lortza/therapy_tracker.svg?style=svg)](https://circleci.com/gh/lortza/therapy_tracker)

[![Maintainability](https://api.codeclimate.com/v1/badges/4f0468795ab338217d80/maintainability)](https://codeclimate.com/github/lortza/therapy_tracker/maintainability)

[![Test Coverage](https://api.codeclimate.com/v1/badges/4f0468795ab338217d80/test_coverage)](https://codeclimate.com/github/lortza/therapy_tracker/test_coverage)

This is an app to track physical therapy exercise logs.

- Ruby
- Rails
- Postgres
- Devise
- RSpec
- [Dependabot](https://app.dependabot.com/accounts/lortza/) dependency manager
- Admin namespace for Users

## Dev Setup

Clone this repo, set your Ruby version to 2.5.3, and run `bundle install` to install gems!
Run `rails db:setup` to create and seed your database.
Run `rails s` to start your Rails server.
Visit localhost:3000 on your browser!

### Linters

This project uses [standard rb](https://github.com/standardrb/standard) (in support of the [VS Code extension](https://github.com/standardrb/vscode-standard-ruby?tab=readme-ov-file)) and [scss-lint](https://github.com/sds/scss-lint). Run them locally on your machine like this:

```
bundle exec standardrb

bundle exec scss-lint app/assets/stylesheets/**.scss
```

## Placeholder Tones

Placeholder tones used are from [https://freesound.org/](https://freesound.org/) licensed under the Attribution Noncommercial License.

## Features

Add your own exercises, types of pain you experience, and your target body parts for physical therapy. Then track them all with the logging feature. This app is designed to be mobile-first, so it's super handy to enter data on your phone.

### Exercise Logging

Log every time you do an exercise, tracking your sets, reps, burn reps, and resistance levels. You can also write notes on your progress. Data entry is minimized by having default set/rep information automatically populated into the form fields whenever you select an exercise from the dropdown.

![alt text](/public/screenshots/index.png "index page")

#### Rep Counter

One of my favorite features of this application is the rep counter. After entering a new exercise log, you can launch the counter and it will play beeps and count your reps for you, indicating which set and rep you're on.

![alt text](/public/screenshots/rep_counter.png "rep counter")

The rep counter is all async javascript. As a backend Rubyist, this part makes my brain hurt.

```javascript
var repsCounter = 1;
async function countReps() {
  while (repsCounter <= reps) {
    console.log(`Set ${setsCounter}, rep ${repsCounter}`);
    repDisplayer.textContent = repsCounter;
    soundRep.play().catch((e) => {
      console.log(e);
    });

    await sleep(repLength * 1000);
    repsCounter++;
  }
  repsCounter = 1;
  console.log(`Set ${setsCounter} complete`);
  beginFinishedIndicator.textContent = "Rest...";
  repDisplayer.textContent = 0;
}
```

### Pain Logging

One of the challenges of reporting pain back to a physical therapist is getting accurate data on how often and how severe pain is. Replacing the anecdotal version of pain with a data version gives everybody a better picture of what's happening. The pain tracking lets you enter date/time, body part, the pain level, pain quality, and what may have triggered the pain.

### Physical Therapy Session Logging

A lot can happen at a PT session. You'll be doing workouts, getting consultation, and being assigned homework. The physical therapy tracking makes it easy to stay on top of what you've accomplished and what you need to work on between sessions.

Physical therapy session logging is defaulted to off. Users can turn on physical therapy session logging in their settings.

![alt text](/public/screenshots/pt_session.png "physical therapy session notes")

### Sublingual Immunotherapy Tracking

Sublingual immunotherapy (SLIT) are allergy drops taken daily. They are administered by placing drops unter the tongue and holding for 2 minutes. Patients need to present their adherence logs to their provider when ordering new vials. This app supports adherence tracking with easy one-touch logging. Skipped doses are displayed in the log stream view. Users can produce a pdf of adherence logs based on a date range of their choosing. The one-touch logging also starts a 2-min timer that ends with a chime and link to dismiss.

SLIT logging is defaulted to off. Users can turn on SLIT logging in their settings.

![alt text](/public/screenshots/slit_index.png "SLIT tracking")

### Reporting

Data is best served in a way that is visually meaningful. That is why we have chart representation of the data from your logs.

![alt text](/public/screenshots/chart.png "charts page")

The reporting is possibly the flashiest part of this app, but the least complicated. I used the `chartkick` gem to render the charts.

```html
<h3>Exercises vs Pain</h3>
<h4>Grouped by Day</h4>
<%= area_chart [ {name: 'Qty Exercises', data:
@report.exercise_logs.group_by_day(:occurred_at).count}, {name: 'Pain Levels
Total', data: @report.pain_logs.group_by_day(:occurred_at).sum(:pain_level)}, ]
%>
```

## Contributing

This project is not currently open to receiving contributions.
