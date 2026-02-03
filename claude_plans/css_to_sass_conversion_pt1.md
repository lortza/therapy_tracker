Plan: Convert Custom SCSS to Plain CSS (Phase 1)

 Objective

 Convert all custom SCSS files to plain CSS following Rails 8's "no-build" approach, while temporarily keeping Bootstrap 4 + dartsass-rails for Bootstrap compilation only.

 Scope

 - Convert: 11 custom SCSS files → CSS
 - Keep unchanged: Bootstrap 4.1.3 compilation via dartsass-rails
 - Result: Zero visual regressions, simpler build process for custom styles

 ---
 Implementation Steps

 1. Convert Sass Variables to CSS Custom Properties

 File: app/assets/stylesheets/_variables.scss → app/assets/stylesheets/variables.css

 Actions:
 - Convert all Sass variables ($variable-name) to CSS custom properties (--variable-name)
 - Calculate lighten($yellow, 30%) manually to hex value #ffff99
 - Move all variable definitions inside :root selector
 - Replace file extension .scss → .css

 Key conversions:
 // Before (Sass)
 $white: #fff;
 $light-yellow: lighten($yellow, 30%);

 // After (CSS)
 :root {
   --white: #fff;
   --light-yellow: #ffff99;  /* calculated from lighten(#ffcc00, 30%) */
 }

 ---
 2. Convert Feature SCSS Files to CSS

 Convert each file by:
 1. Replacing Sass variables with CSS custom properties: $brand-main → var(--brand-main)
 2. Calculating all darken() functions to hex values (12 instances total)
 3. Flattening nested selectors
 4. Expanding the mixin in logs.scss
 5. Renaming .scss → .css

 Files to convert (11 total):

 A. buttons.scss → buttons.css

 - Replace 3 instances of darken() with calculated hex values
 - Replace Sass variables with var(--variable-name)
 - Flatten &:hover nesting

 B. forms.scss → forms.css

 - Replace Sass variables with CSS custom properties
 - Flatten nested selectors
 - No color functions to convert

 C. logs.scss → logs.css

 - Expand mixin: Replace @include log-type-color($color) with explicit CSS
 - Create 4 separate class blocks for: .pain-log, .exercise-log, .therapy-log, .slit-log
 - Replace Sass variables with CSS custom properties
 - Flatten nested selectors

 D. pagination_links.scss → pagination_links.css

 - Replace 6 instances of darken() with calculated hex values
 - Replace Sass variables with CSS custom properties
 - Flatten &:hover and &.active nesting

 E. pt_sessions.scss → pt_sessions.css

 - Minimal file, just rename and update variable syntax
 - No color functions

 F. rep_counter.scss → rep_counter.css

 - Replace Sass variables with CSS custom properties
 - No color functions or nesting

 G. search_bar.scss → search_bar.css

 - Replace Sass variables with CSS custom properties
 - Flatten nested selectors

 H. shared.scss → shared.css

 - Largest file (index page styling)
 - Replace Sass variables with CSS custom properties
 - Flatten nested selectors
 - No color functions

 I. slit.scss → slit.css

 - Replace 3 instances of darken() with calculated hex values
 - Replace Sass variables with CSS custom properties
 - Flatten nested selectors

 J. utilities.scss → utilities.css

 - Replace Sass variables with CSS custom properties
 - No color functions or nesting

 ---
 3. Update Main Entry Point

 File: app/assets/stylesheets/application.scss

 Actions:
 - Keep as .scss file (needed for Bootstrap compilation)
 - Update imports to reference new .css files
 - Keep @import "bootstrap" unchanged

 Structure:
 // Import custom variables (now CSS custom properties)
 @import "variables";

 // Import Bootstrap (still Sass)
 @import "bootstrap";

 // Import custom CSS files
 @import "buttons";
 @import "forms";
 @import "logs";
 @import "pagination_links";
 @import "pt_sessions";
 @import "rep_counter";
 @import "search_bar";
 @import "shared";
 @import "slit";
 @import "utilities";

 Note: Sass's @import can import both .scss and .css files, so this works during the transition.

 ---
 4. Verify Compilation Works

 No changes needed:
 - Keep dartsass-rails gem (still needed for Bootstrap)
 - Keep Procfile.dev line: css: bin/rails dartsass:watch
 - Dart Sass will compile both Bootstrap (Sass) and custom files (CSS)

 ---
 Detailed Conversion Reference

 Color Function Calculations

 All darken() instances need manual calculation:

 buttons.scss (3 instances):
 - darken($brand-main, 10%) → #0056b3 (from #007bff)
 - darken($secondary, 10%) → #545b62 (from #6c757d)
 - darken($light-gray, 5%) → #d6d8db (from #e2e3e5)

 pagination_links.scss (6 instances):
 - darken($white, 10%) → #e6e6e6
 - darken($white, 25%) → #bfbfbf
 - darken($brand-main, 10%) → #0056b3
 - darken($white, 15%) → #d9d9d9
 - Additional instances for hover/active states

 slit.scss (3 instances):
 - darken($light-yellow, 10%) → #ffff66
 - darken(#d4edda, 10%) → #afd7b7
 - darken(#afd7b7, 10%) → #8ac199

 Nesting Flattening Example

 // Before (Sass with nesting)
 .btn-success {
   background-color: $brand-main;

   &:hover {
     background-color: darken($brand-main, 10%);
   }
 }

 // After (Plain CSS)
 .btn-success {
   background-color: var(--brand-main);
 }

 .btn-success:hover {
   background-color: #0056b3;
 }

 Mixin Expansion Example

 // Before (logs.scss with mixin)
 @mixin log-type-color($color) {
   .log-icon { color: $color; }
   .log-title { color: $color; }
 }

 .pain-log { @include log-type-color($pain-color); }

 // After (logs.css explicit classes)
 .pain-log .log-icon { color: var(--pain-color); }
 .pain-log .log-title { color: var(--pain-color); }

 ---
 Critical Files to Modify

 1. app/assets/stylesheets/_variables.scss → variables.css
 2. app/assets/stylesheets/buttons.scss → buttons.css
 3. app/assets/stylesheets/forms.scss → forms.css
 4. app/assets/stylesheets/logs.scss → logs.css
 5. app/assets/stylesheets/pagination_links.scss → pagination_links.css
 6. app/assets/stylesheets/pt_sessions.scss → pt_sessions.css
 7. app/assets/stylesheets/rep_counter.scss → rep_counter.css
 8. app/assets/stylesheets/search_bar.scss → search_bar.css
 9. app/assets/stylesheets/shared.scss → shared.css
 10. app/assets/stylesheets/slit.scss → slit.css
 11. app/assets/stylesheets/utilities.scss → utilities.css
 12. app/assets/stylesheets/application.scss (update imports only, keep as .scss)

 Total: 11 files converted to CSS, 1 file updated (application.scss)

 ---
 Verification Steps

 1. Compilation Check

 # Start Rails server with CSS watching
 bin/dev

 # Check terminal for compilation errors
 # Should see: "Build succeeded" or similar

 2. Visual Regression Testing

 Test all pages that use custom styles:
 - Homepage (/) - shared.css, utilities.css
 - Logs index (/logs) - logs.css, pagination_links.css
 - Pain log form (/pain_logs/new) - forms.css, buttons.css
 - Exercise log form (/exercise_logs/new) - forms.css, buttons.css
 - Rep counter modal - rep_counter.css
 - SLIT logs (/slit_logs) - slit.css
 - PT sessions (/pt_session_logs) - pt_sessions.css
 - Search functionality - search_bar.css
 - Pagination (any paginated page) - pagination_links.css

 3. Browser DevTools Check

 - Inspect app/assets/builds/application.css
 - Verify CSS custom properties are defined in :root
 - Check that styles are applied correctly
 - No console errors

 4. Responsive Testing

 - Test mobile layout (navbar, forms, cards)
 - Verify Bootstrap responsive utilities still work
 - Check button hover states work

 ---
 Rollback Plan

 If issues arise:
 1. Git revert commits
 2. Restart bin/dev to recompile original SCSS
 3. All original .scss files remain in git history

 ---
 Future Work (Not in this plan)

 Phase 2: Bootstrap → Tailwind migration
 - Replace Bootstrap with Tailwind CSS
 - Convert navbar to Tailwind utilities + Stimulus
 - Replace modals with Turbo Frames + Stimulus or Headless UI
 - Remove dartsass-rails gem entirely
 - Achieve true "no-build" CSS setup

 ---
 Benefits of This Approach

 ✅ Low Risk: Bootstrap unchanged, so navbar/modals keep working
 ✅ Incremental: Can verify each file conversion independently
 ✅ Reversible: Git history preserves original SCSS
 ✅ Rails 8 Aligned: Custom styles use modern CSS patterns
 ✅ Faster Development: No Sass compilation for custom styles (in future)
 ✅ Standards-Based: CSS custom properties are native browser features

 ---
 Notes

 - The Heroku deprecation warnings about Sass @import will remain until Phase 2 (Bootstrap removal)
 - dartsass-rails gem stays in Gemfile for now
 - Procfile.dev CSS watch command remains unchanged
 - This is a preparatory step toward full "no-build" in Phase 2