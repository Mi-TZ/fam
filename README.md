
# Fampay Flutter Intern Assignment

Name: Mithilesh Mahajan

## Project Description

This Flutter project is a standalone container that displays a dynamic list of **Contextual Cards**. The container is designed to be plug-and-play, meaning it can be easily integrated into any screen or widget. These contextual cards are rendered based on JSON data fetched from an API, allowing the display properties (such as images, color, text, buttons, etc.) to be dynamically updated from the backend.

---

## Screenshots

<div style="display: flex; justify-content: center; gap: 10px;">
  <img src="assets/screenshots/Screenshot_20241215_191620.jpg" alt="Screenshot 1" style="width: 30%; height: auto;">
  <img src="assets/screenshots/Screenshot_20241215_191622.jpg" alt="Screenshot 2" style="width: 30%; height: auto;">
  <img src="assets/screenshots/Screenshot_20241215_191636.jpg" alt="Screenshot 3" style="width: 30%; height: auto;">
</div>

## Screen Recording

[Screen Recording](assets/screenshots/Screenrecording_20241215_191539.mp4)

## Apk File

[Apk](app-release.apk)

## Directory Structure

The project follows a well-structured directory hierarchy to keep the codebase organized and maintainable:

```
lib/
├── core/
│   ├── constants/
│   │   └── api_constants.dart           # Contains constants for API endpoints and related configurations.
│   └── utils/
│       ├── color_utils.dart             # Helper functions for managing colors and gradients.
│       └── text_utils.dart              # Helper functions for handling text formatting and parsing.
├── modules/
│   └── home/
│       ├── controllers/
│       │   └── card_controller.dart     # Contains logic to handle the card data and actions.
│       ├── models/
│       │   ├── card_model.dart          # Defines the structure of a contextual card.
│       │   ├── cta_model.dart           # Defines the structure of the Call to Action button.
│       │   ├── entity_model.dart        # Defines the structure for entity data in formatted text.
│       │   ├── formatted_text_model.dart # Defines how formatted text data is structured.
│       │   ├── gradient_model.dart       # Defines the structure for gradient data.
│       │   ├── image_asset_model.dart    # Defines the structure for image asset data.
│       ├── services/
│       │   ├── api_service.dart         # Handles API requests to fetch contextual cards.
│       │   └── deep_link_service.dart   # Handles deep link actions triggered from the cards.
│       └── views/
│           ├── card_page.dart           # Displays the contextual cards on the screen.
│           ├── home_view.dart           # Main view that contains the list of cards.
│           └── splash_screen.dart       # Splash screen displayed when the app starts.
└── main.dart                             # Entry point for the Flutter app.
```

### Breakdown:

- **core/**: Contains the fundamental utilities and constants used throughout the app. This is where you’ll find shared functions and configurations like API constants, color utilities, and text formatting helpers.
  
- **modules/home/**: This is where the core functionality resides for displaying the contextual cards. It contains:
  - **controllers/**: Logic for managing data and actions related to the cards.
  - **models/**: Data structures that define how card-related data (like card content, buttons, formatted text, etc.) is represented.
  - **services/**: Handles interactions with external resources, such as the API and deep links.
  - **views/**: UI components that display the contextual cards and related views like the home page and splash screen.

- **main.dart**: The entry point for the Flutter app that initializes the app and sets up routes for navigation.

---

## How to Run

1. **Prerequisites**: Ensure you have Flutter SDK installed and configured. You can follow the setup instructions from the [official Flutter documentation](https://flutter.dev/docs/get-started/install).

2. **Clone the repository**:
   ```bash
   git clone [repository_url]
   ```

3. **Run the app**:
   Navigate to the project directory and run the app using the following command:
   ```bash
   flutter run
   ```

---
