# ``Movemedical Requirements``

## Main

The app is a repository of:
1) RSS feeds
2) Appointments

## Actions
Repository object []
1) [ADD]
2) [DELETE]
3) [READ]
4) [READ-LIST]

## UI-UX
Dynamic gradient is best used for actions and user guidance.
Process: Dynamic gradient is great to show some progress.
AR: Dynamic gradient is good to simulater user movement.

Using gradient means going with a flat design language.
TODO: Test gradient with 3D UI.

## Architecture
TODO: Add the onboarding coordinator.

### Progressive UI
The end:
- The icon.
The start:
- The icon with a localized string.

Buttons:
The end:
- Glass.
The start:
- Flat.

Animations:
All things must have a beginning and ending. (Animate objects at start and end)

Priorities:
1)
TODO: Add a new add_new_object screen that is agnostic to model
2)
DONE: Setup swift gen for localizations
DONE: Fix localization on all projects
3)


### Technical Debt
1) Use New Coordinators
2) Refactor state machine
3) Write tests for state machine and others using new framework (Nimble)
4) Implement snapshot testing
https://medium.com/cstech/ui-test-automation-snapshot-testing-in-ios-bd8bcb595cf8
