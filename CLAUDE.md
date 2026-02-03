# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Therapy Tracker is a Rails 8 application for tracking physical therapy exercises, pain logs, PT session notes, and sublingual immunotherapy (SLIT) adherence. The app is mobile-first and focuses on minimal data entry with features like an async JavaScript rep counter and charting via Chartkick.

**Key Stack:**
- Ruby 3.3.6
- Rails 8.0.0
- PostgreSQL
- Hotwire (Turbo + Stimulus)
- RSpec for testing
- Devise for authentication
- StandardRB for Ruby linting

## Development Commands

### Setup
```bash
bundle install
rails db:setup              # Creates, loads schema, and seeds database
rails s                     # Start server on localhost:3000
```

### Testing
```bash
bundle exec rspec                                    # Run all tests
bundle exec rspec spec/models/user_spec.rb           # Run specific test file
bundle exec rspec spec/models/user_spec.rb:10        # Run specific test at line 10
bundle exec guard                                    # Auto-run tests on file changes
```

### Linting
```bash
bundle exec standardrb                               # Ruby linter (auto-fixes with --fix)
bundle exec scss-lint app/assets/stylesheets/**.scss # SCSS linter
```

### Database
```bash
rails db:migrate
rails db:rollback
rails db:seed
rake db:seed:dump           # Dump current data to seeds.rb (seed_dump gem)
```

### Analysis Tools
```bash
bundle exec erd             # Generate ERD diagram
bundle exec rubycritic      # Code complexity and churn analysis
```

## Architecture

### Authentication & Authorization
- **Devise** handles user authentication
- Sign-up is disabled in routes (users must be created by admin)
- All controllers inherit from `ApplicationController` which requires authentication via `before_action :authenticate_user!`
- Admin namespace exists at `/admin` with admin-only access controlled by `require_admin` before_action
- Authorization pattern: `authorized_user?(object)` checks `object.user_id == current_user.id`

### Logging System Architecture
The app has a unified logging system for different health tracking types:

**Log Types (all user-scoped):**
- `ExerciseLog` - tracks sets, reps, burn reps, resistance, notes
- `PainLog` - tracks pain level, quality, triggers, body part
- `PtSessionLog` - tracks PT session notes, homework exercises (join table: `PtHomeworkExercise`)
- `SlitLog` - one-touch allergy drop adherence tracking


**Quick Logging (presets for Logs):**
The `PainLogQuickFormValue` facilitates quick logging of common pains by storing presets. This allows users to select a common pain and preset level from a dropdown for one-touch logging.

**Unified Log Display:**
The `Log` concern (app/models/concerns/log.rb) provides `Log.all(user)` which aggregates all log types into a single chronological stream sorted by `occurred_at`. This powers the main logs index page.

### Feature Toggles
Users can enable/disable select tracking features in their settings:
- `enable_pt_session_tracking` (default: false)
- `enable_slit_tracking` (default: false)

### Rep Counter System
The rep counter (app/javascript/custom/exercise_logs.js) is async JavaScript that:
- Plays audio cues for exercise start, reps, set completion, and exercise completion
- Manages state with `isRunning` and `shouldStop` flags
- Uses `async/await` with sleep promises for timing
- Handles Turbo navigation by cloning/replacing event listeners to avoid duplicates
- Audio files are in `/public/sounds/` (licensed from freesound.org under Attribution Noncommercial)
The rep counter technology is in flux and will be converted over to Turbo tooling.

### Decorators Pattern
Uses Draper gem for presentation logic:
- `PaginatingDecorator` extends `Draper::CollectionDecorator` to work with will_paginate
- Decorate collections before rendering: `user.exercise_logs.decorate`

### Searchable & Sortable Concerns
Models include `Searchable` and `Sortable` concerns for consistent query interfaces across resources.

### Reporting
Charts are rendered with the `chartkick` gem using `groupdate` for time-series aggregation. The `Report` model provides query interfaces for chart data.

## Key Patterns
Key patterns are important to identify though it is worth noting that this application is a legacy Rails app that is in the process of being upgraded to Rails 8. Any patterns that are not idiomatic Rails 8 should not be replicated unless it is just a step in a larger plan for eventual upgrade to the Rails 8 approach. 

### Controller Authorization
Most controllers follow this pattern:
```ruby
before_action :set_resource, only: [:show, :edit, :update, :destroy]
before_action :authorize_resource, only: [:show, :edit, :update, :destroy]

private

def authorize_resource
  redirect_to root_path, alert: authorization_alert unless authorized_user?(@resource)
end
```

### Scoping by Current User
All resources are scoped to `current_user`:
```ruby
@exercises = current_user.exercises
```

### Turbo & Stimulus Integration
The app uses Hotwire (Turbo + Stimulus) for dynamic interactions. JavaScript files in `app/javascript/custom/` are legacy but still functional. New JavaScript should use Stimulus controllers in `app/javascript/controllers/`. Ideally, all JavaScript in the `custom` directory will be converted over to Rails 8 Turbo tooling.

## Testing Notes

- RSpec with Factory Bot for fixtures
- Capybara + Selenium for feature tests
- Shoulda Matchers for model validation tests
- Database Cleaner configured for test cleanup
- Devise test helpers available via `spec/support/controller_macros.rb`

## Deployment

- Uses Sentry for error tracking (configured in ApplicationController)
- GitHub Actions CI runs tests and linting on push/PR to main
- CircleCI also configured (legacy)
- Code Climate tracks maintainability and test coverage

## Important Notes

- This is a personal project not currently accepting contributions
- User sign-up is disabled; users must be created by admin
- Mobile-first design philosophy
- Focus on minimal data entry for ease of use during physical therapy


## Development Practices
- When building new features, write tests for all new code written.
- Use standardrb formatting for ruby code. 
- Convert to a Rails tag helper (ex: tag.div) instead of interpolating inside of an erb tag in HTML.
- Do not modify production code just to accommodate tests.


## Current Projects

### Convert legacy async JavaScript to Rails 8 Turbo Tooling

#### Conversion approach in order of priority:
1. Completed

2. Update all javascripts that are not idiomatic Rails 8 into stimulus and turbo tooling.
  High Priority:
  1. Done: Convert SLIT timer inline script to Stimulus controller
  2. Fix bootstrap_controller.js event listener bug

  Medium Priority:
  3. Remove local: true from all forms

  Low Priority:
  4. Delete unused JavaScript files 

3. Determine css needs to become independent of Sass compiling. Do we need `gem "dartsass-rails"`, etc?

4. Scan application for other legacy code that is not idiomatic Rails 8 and create a plan for replacement. Some examples (but not an exhaustive list of possible code patterns) are: 1. update any old links using the old Rails UJS style syntax. 2. update any forms using "local: true".
4.a. Is this file idiomatic Rails 8 "app/views/slit_logs/quick_log_create.turbo_stream.erb"?

5. Start Upgrade to Rails 8.1


## Bugs discovered on staging
* All Bugs are currently fixed



## Deployment warnings
Heroku gives warnings during the deployment process about changes that should be made. This is a list of items that Heroku has mentioned.

1. Sass deprecations:
```
DEPRECATION WARNING [import]: Sass @import rules are deprecated and will be removed in Dart Sass 3.0.0.
       
       More info and automated migrator: https://sass-lang.com/d/import
       
         ╷
       4 │ @import "variables";
         │         ^^^^^^^^^^^
         ╵
           app/assets/stylesheets/application.scss 4:9  root stylesheet
       
       DEPRECATION WARNING [import]: Sass @import rules are deprecated and will be removed in Dart Sass 3.0.0.
       
       More info and automated migrator: https://sass-lang.com/d/import
       
         ╷
       6 │ @import "bootstrap"; // Custom bootstrap variables must be set or imported *before* bootstrap.
         │         ^^^^^^^^^^^
         ╵
           app/assets/stylesheets/application.scss 6:9  root stylesheet
       
       DEPRECATION WARNING [import]: Sass @import rules are deprecated and will be removed in Dart Sass 3.0.0.
       
       More info and automated migrator: https://sass-lang.com/d/import
       
         ╷
       9 │ @import "buttons";
         │         ^^^^^^^^^
         ╵
           app/assets/stylesheets/application.scss 9:9  root stylesheet
       
       DEPRECATION WARNING [import]: Sass @import rules are deprecated and will be removed in Dart Sass 3.0.0.
       
       More info and automated migrator: https://sass-lang.com/d/import
       
          ╷
       10 │ @import "forms";
          │         ^^^^^^^
          ╵
           app/assets/stylesheets/application.scss 10:9  root stylesheet
       
       DEPRECATION WARNING [import]: Sass @import rules are deprecated and will be removed in Dart Sass 3.0.0.
       
       More info and automated migrator: https://sass-lang.com/d/import
       
          ╷
       11 │ @import "logs";
          │         ^^^^^^
          ╵
           app/assets/stylesheets/application.scss 11:9  root stylesheet
       
       DEPRECATION WARNING [global-builtin]: Global built-in functions are deprecated and will be removed in Dart Sass 3.0.0.
       Use color.adjust instead.
       
       More info and automated migrator: https://sass-lang.com/d/import
       
         ╷
       8 │ $light-yellow: lighten($yellow, 30%);
         │                ^^^^^^^^^^^^^^^^^^^^^
         ╵
           app/assets/stylesheets/_variables.scss 8:16  @import
           app/assets/stylesheets/application.scss 4:9  root stylesheet
       
       DEPRECATION WARNING [color-functions]: lighten() is deprecated. Suggestions:
       
       color.scale($color, $lightness: 70.8333333333%)
       color.adjust($color, $lightness: 30%)
       
       More info: https://sass-lang.com/d/color-functions
       
         ╷
       8 │ $light-yellow: lighten($yellow, 30%);
         │                ^^^^^^^^^^^^^^^^^^^^^
         ╵
           app/assets/stylesheets/_variables.scss 8:16  @import
           app/assets/stylesheets/application.scss 4:9  root stylesheet
       
      ```
