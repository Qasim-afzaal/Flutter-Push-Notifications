# Flutter Push Notifications

This repository contains a Flutter project demonstrating the implementation of push notifications using Firebase Cloud Messaging (FCM). Push notifications are essential for keeping users engaged by delivering timely and relevant information, even when the app is not in use.

## Features

- **Firebase Cloud Messaging (FCM) Integration**: Seamless integration with Firebase Cloud Messaging for sending and receiving push notifications.
- **Platform Support**: Fully functional on both Android and iOS platforms.
- **Foreground and Background Notifications**: Handles notifications while the app is in the foreground, background, or terminated.
- **Custom Notification Payloads**: Supports custom notification payloads to display different types of notifications.
- **Local Notifications**: Utilize local notifications for in-app alerts.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed on your development machine.
- [Firebase account](https://firebase.google.com/) with a project set up.

### Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/yourusername/flutter-push-notifications.git
   cd flutter-push-notifications
   ```

2. **Install dependencies**:

   ```bash
   flutter pub get
   ```

3. **Configure Firebase**:
   - Follow the [Firebase setup instructions for Flutter](https://firebase.flutter.dev/docs/overview) to add Firebase to your Flutter project.
   - Download the `google-services.json` file for Android and place it in the `android/app` directory.
   - Download the `GoogleService-Info.plist` file for iOS and place it in the `ios/Runner` directory.

4. **Configure Apple Push Notification service (APNs) for iOS**:
   - Enable Push Notifications and Background Modes (Remote Notifications) in your Xcode project.
   - Create an APNs Key in your [Apple Developer account](https://developer.apple.com/account/resources/authkeys/list) and download the key file.
   - Upload the APNs key file to the Firebase Console under Project Settings > Cloud Messaging > iOS app configuration.
   - Ensure your app’s bundle identifier matches the one used in the Firebase Console and the Apple Developer account.

### Usage

1. **Run the app**:

   ```bash
   flutter run
   ```

2. **Send a test notification**:
   - Go to the Firebase Console.
   - Navigate to the "Cloud Messaging" section.
   - Click on "Send your first message".
   - Fill in the required details and send the notification.

### Customization

- **Notification Handling**: Modify the notification handling logic in the `lib/main.dart` file to suit your app's requirements.
- **Custom Notification UI**: Customize the notification appearance by modifying the `flutter_local_notifications` package settings.

## Contributing

We welcome contributions to enhance the functionality and improve the codebase. Please feel free to submit a pull request or open an issue.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

For detailed documentation on Flutter and Firebase, refer to the official documentation:
- [Flutter](https://flutter.dev/docs)
- [Firebase](https://firebase.google.com/docs)

Happy coding!

---

**Note**: This project is a basic example to get you started with push notifications in Flutter. For production-level apps, additional configurations and error handling may be required.
