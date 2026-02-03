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
- When building a new feature, write tests for all new code written or new behaviors.                                                       


## Current Projects

### Convert legacy async JavaScript to Rails 8 Turbo Tooling

#### Conversion approach in order of priority:
1. Completed

2. exercise_logs.js - Convert to Stimulus Controller
Contains two functions:
- counter() - A complex timer/counter for exercise reps with audio cues
- burnDropdowns() - Creates dynamic dropdowns for burn sets/reps (currently commented out in views)

Conversion approach:
* Create app/javascript/controllers/exercise_counter_controller.js for the counter
* Keep the core logic but wrap it in a Stimulus controller with proper lifecycle methods
* Add data attributes to the modal in _rep_counter_modal.html.erb
* Remove the burnDropdowns function entirely (it's commented out everywhere)
* Estimated effort: 1-2 hours (counter is complex with audio, timers, and state management)

3. Determine css needs to become independent of Sass compiling.

4. Scan application for other legacy code that is not idiomatic Rails 8 and create a plan for replacement.

5. Start Upgrade to Rails 8.1
