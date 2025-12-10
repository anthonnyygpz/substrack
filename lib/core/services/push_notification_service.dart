import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart'; // Necesario para kIsWeb

// Esta función debe estar FUERA de la clase (top-level)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // En Web, este handler no se ejecuta igual que en móvil.
  // El Service Worker (archivo .js) maneja el background en Web.
  if (kIsWeb) return;
  print("Notificación en Background: ${message.messageId}");
}

class PushNotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // 1. Pedir permisos
    await _requestPermission();

    // 2. Definir handler de background (Solo Móvil)
    // En web, esto lanza error si intentas registrarlo, así que lo condicionamos.
    if (!kIsWeb) {
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );
    }

    // 3. Configurar notificaciones locales
    await _setupLocalNotifications();

    // 4. Obtener el token
    // IMPORTANTE: En web necesitas la vapidKey generada en la consola de Firebase.
    final token = await _firebaseMessaging.getToken(
      vapidKey: kIsWeb
          ? 'BOXLgCDZAOs3HiVGa4IVHcDz1Eknd3MuuokFempUP_cFT2BdB7B9ue731GoOpqUTo89FvQsiBvulYNSoG4rm6u4'
          : null,
    );
    print("FCM Token: $token");

    // 5. Configurar Listeners
    _setupMessageHandlers();
  }

  static Future<void> _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('Estado del permiso: ${settings.authorizationStatus}');
  }

  static Future<void> _setupLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    // Configuración básica para Linux/Web si fuera necesario,
    // aunque en Web es mejor usar elementos UI HTML o Snackbars para foreground.

    final InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // Solo inicializamos local notifications si NO es web, o si tienes configuración web específica.
    // Para simplificar y evitar errores de "platform channels", lo limitamos a móvil aquí
    // o asegúrate de que tu plugin flutter_local_notifications soporte web en tu versión.
    if (!kIsWeb) {
      await _localNotifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: (response) {
          print("Tocó la notificación local: ${response.payload}");
        },
      );
    }
  }

  static void _setupMessageHandlers() {
    // A. App en Primer Plano (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Mensaje en Foreground: ${message.notification?.title}');

      if (message.notification != null) {
        if (kIsWeb) {
          // En Web, no usamos flutter_local_notifications para foreground usualmente.
          // Es mejor mostrar un SnackBar o un Toast personalizado.
          print("Mostrar alerta visual en web (SnackBar o Dialog)");
        } else {
          _showLocalNotification(message);
        }
      }
    });

    // B. App abierta desde Segundo Plano
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageNavigation);
  }

  static Future<void> checkInitialMessage() async {
    RemoteMessage? initialMessage = await _firebaseMessaging
        .getInitialMessage();
    if (initialMessage != null) {
      _handleMessageNavigation(initialMessage);
    }
  }

  static void _handleMessageNavigation(RemoteMessage message) {
    print("Navegar usando data: ${message.data}");
  }

  static void _showLocalNotification(RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null && !kIsWeb) {
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'Notificaciones Importantes',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        payload: message.data.toString(),
      );
    }
  }
}
