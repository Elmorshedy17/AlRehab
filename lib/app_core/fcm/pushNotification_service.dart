import 'dart:developer';
import 'dart:io';

import 'package:rehab/app_core/app_core.dart';
import 'package:rehab/app_core/fcm/FcmTokenManager.dart';
import 'package:rehab/app_core/fcm/localNotificationService.dart';
import 'package:rehab/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final prefs = locator<PrefsService>();

  Future initialize() async {
    _fcm.requestPermission(alert: true, badge: true, sound: true);

    _fcm.getToken().then((token) {
      print(token);
      locator<FcmTokenManager>().inFcm.add(token!);
    });

    if (Platform.isIOS) {
      _fcm.subscribeToTopic('Ios');
    } else {
      _fcm.subscribeToTopic('Android');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      var notificationData = remoteMessage.data;
      var notificationHead = remoteMessage.notification;

      var title = notificationHead?.title;
      var body = notificationHead?.body;
      var id = notificationData['id'];

      locator<LocalNotificationService>()
          .showNotification("$title", "$body", "$id");
    });

    // FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      // _serializeAndNavigate(remoteMessage);
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        _serializeAndNavigate(remoteMessage);
      }
    });

    //
    // Future<void> onBackgroundMessage(RemoteMessage message) async {
    //   await Firebase.initializeApp();
    //   _serializeAndNavigate(message);
    //   return Future.value();
    // }
  }

  void _serializeAndNavigate(RemoteMessage message) {
    // if (locator<PrefsService>().userObj == null) {
    //   locator<NavigationService>().pushNamedTo(
    //     AppRoutesNames.loginPage,
    //   );
    // } else {
    //   locator<NavigationService>().pushNamedTo(
    //     AppRoutesNames.mainTabsWidget,
    //   );
    // }

    locator<NavigationService>().pushNamedTo(
      AppRoutesNames.HomePage,
    );


  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp(
        // options: DefaultFirebaseOptions.currentPlatform,
        );
    log('Handling a background message ${message.messageId}');
  }
}

Future<void> setupInteractedMessage() async {
  await Future.delayed(const Duration(seconds: 3));
  print("application launched !!!");

  // Get any messages which caused the application to open from
  // a terminated state.
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  // if (locator<PrefsService>().userObj == null) {
  //   locator<NavigationService>().pushNamedTo(
  //     AppRoutesNames.loginPage,
  //   );
  // } else {
  //   locator<NavigationService>().pushNamedTo(
  //     AppRoutesNames.mainTabsWidget,
  //   );
  // }
  locator<NavigationService>().pushNamedTo(
    AppRoutesNames.HomePage,
  );

}
