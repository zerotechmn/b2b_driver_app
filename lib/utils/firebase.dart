// import 'package:firebase_messaging/firebase_messaging.dart';

// Future<void> requestNotificationPermission() async {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   // Request permissions (needed for iOS)
//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     badge: true,
//     sound: true,
//   );

//   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//   } else {}
// }

// Future<String?> getFCMToken() async {
//   try {
//     String? token = await FirebaseMessaging.instance.getToken();
//     if (token != null) {
//       return token;
//     } else {
//       return null;
//     }
//   } catch (e) {
//     return null;
//   }
// }
