# Mobile Application Development Project for COMP3130

# Spotto

<p align="center">
  <img src="https://github.com/MQ-COMP3130/mobile-application-development-mohnish-sharma/blob/main/images/logo.png?raw=true" alt="logo" />
</p>

Logo from ![Iconduck.](https://iconduck.com/icons/19815/binoculars)
Converted with ![appicon.](https://www.appicon.co)
*"Every car has a story. Let Spotto help you tell it"*

Spotto is mobile application designed for automotive enthusiasts to share their sighting of rare, or interesting vehicles. Users will be able to capture photos, tagged with location data, and add some short detailed information about the cars they encounter in their day to day lives. The app creates a personal digital collection of spotted vehicles, with an option to contribute to a global database that users can access to browse finds and connect with fellow enthusiasts. 

*See my original design proposal in the /design/ directory.*
*See the functioning MVP in the /spotto/ directory.*


## Target Audience:
- User age range: 15+
- Primary users: Automotive enthusiasts
- Secondary users: Casual hobbyists, vehicle collections, automotive content creators

## Features and Functionality:
- Photo Capture & Storage: Users will be able to take photos of vehicles and add descriptions, which could contain car spec's & more if the post was made by a automotive enthusiast, buit is not required, and casual hobbyist's are welcome to share their thoughts and opinions.

- Community: Voting system, top 5 voted posts will be shown on the home page.

- Authentication: Firebase-integrated user authentication.

## Design changes from Deliveriable 1
- Slight changes to the UI
- No map feature
- Less feed options
    - No Private/Public options (as theres no friend system)
    - No sorting (all posts are sorted by new, execept for top 5 featured)
- More streamlined photo submission, (instead of in app camera, users can upload from their camera roll).

## Development 
### Development Platform

- IDE: Android Studio with Flutter plugin
    - Min SDK version: 23
- Framework: Flutter 3.x with Dart
- Backend: Firebase (Firestore, Authentication, Storage)

### Testing Devices
- Primary Development: Android Studio Emulator (Pixel 8 API 34)

### Database Architecture

- Firestore `cars` collection storing vehicle posts with voting data
- Firestore `users` collection for authentication 


## Tests

### Widget Tests
**Basic Rendering** (`"should render basic UI elements"`):
> Verifies core elements render correctly - welcome text, buttons, etc.

**User Interaction** (`"should handle button taps"`)
> Ensures user interactions are properly registered

### Unit Tests

**Timestamps Formatting** (`"formatTimestampShort returns empty string for null timestamp"`):
> Ensures null timestamps are properly hanlded and displayewd

**View Selection Tests** (`"getSelectedViewContent returns correct view for valid options"`):
> Ensures view selection modes (on the collections page (grid, list, and map)) work correctly, and redirect to gridview as a default incase user's select an invalid option

## Screenshots:
<p align="center">
  <img src="https://github.com/MQ-COMP3130/mobile-application-development-mohnish-sharma/blob/main/images/sc1.png?raw=true" alt="sc1" />
  <img src="https://github.com/MQ-COMP3130/mobile-application-development-mohnish-sharma/blob/main/images/sc2.png?raw=true" alt="sc2" />
  <img src="https://github.com/MQ-COMP3130/mobile-application-development-mohnish-sharma/blob/main/images/sc3.png?raw=true" alt="sc3" />
  <img src="https://github.com/MQ-COMP3130/mobile-application-development-mohnish-sharma/blob/main/images/sc4.png?raw=true" alt="sc4" />
  <img src="https://github.com/MQ-COMP3130/mobile-application-development-mohnish-sharma/blob/main/images/sc5.png?raw=true" alt="sc5" />
</p>
