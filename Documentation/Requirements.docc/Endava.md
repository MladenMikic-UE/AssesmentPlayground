# Endava Requirements

## Intro

The purpose of this assignment is to help us define your seniority level.
Below, we have listed requirements for an RSS Feed app that we believe allows a candidate to show their skills.

## Main

[ADD]
1. As a user, I can add RSS feed by specifying an RSS feed URL
[DELETE]
2. As a user, I can remove RSS feeds
[LIST READ]
3. As a user, I can see added RSS feeds
* Each RSS feed presentation should include RSS feed name, image (if it exists), description
[READ]
4. As a user, I can select an RSS feed to open a screen with the RSS feed items
* Each RSS feed item presentation should include an image (if it exists), title, description
5. As a user, I can select an RSS item to access the related website/feed
[READ]
The app can open an RSS item link in WebView or device browser.

## Optional

1. As a user, I can turn on notifications for new feed items for subscribed RSS feeds
2. As a user, I can add RSS feeds to Favorites
3. Feel free to add any additional functionality as you see fit.

## Additional

This is an open concept assignment. You have the full freedom regarding the tech stack, architecture, UI and UX design. 
If you want to discuss anything before you start, we can do that of course
When you are done with your assignment, push your solution to GitHub and send us a link to that repository
We will not specify a deadline, but we will ping you in a week just to check if everything is clear. 
If you have any questions during the assignment period, feel free to reach out via email. 
If anything unexpected comes up and you see that it will affect your work on this, just let us know
For testing, this is one of the sites where you can find popular RSS feeds: https:// blog.feedspot.com/world_news_rss_feeds/

# Endava Analysis

## Data Model
RSSFeed
* title
* description
* image
* url
* notifications status
* favorites status

# Endava Assesment Known Issues

## Bugs 12.02.2024.
TODO: Fix: Fix loading screen bug. The loading screen is black when the app starts for a few seconds.
TODO: Fix: When a detail view is pushed then SwiftUI presents a invisible navigationBar. [P-random]
TODO: Fix: Fixed iOS 15 iPhone 8 small UI-UX issues.

## Architecture
TODO: Build a another interactor for network requsts [P2]
TODO: Add new child coordinators (1 level will mostly be enought) [P7]

## Refactorings
TODO: Cleanup the Model (its a mess) [P2]
- limit the update based on the availability state
- remove the user defaults nonsense
- Add Fav options
TODO: Add a logger [P1]
TODO: Refactor state machine. [P3]
TODO: Find a theme solution. The theme should be an Envir object.
TODO: Cleanup project folder structure.

## Features
TODO: F1: Create an error pipeline and handle leftover errors. (AppError and child errors) [P5]
TODO: F1: Present errors to the user (.isUserFacing) [P5]
TODO: Add close button view with coordinator for web page dismissal per button [P6]

## Test
TODO: Test: Write (all the missing) unit tests. [P4]

## UI
TODO: Build Fav tab
TODO: Build Fav button
