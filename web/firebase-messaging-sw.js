importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts(
  "https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js",
);

// Configura aquí tus credenciales de Firebase (las mismas de tu google-services.json o firebase_options.dart)
firebase.initializeApp({
  apiKey: "AIzaSyDnSt62K0zIXJLZ74wBuDGT_VS8WE-FNdo",
  authDomain: "subtrack-a020a.firebaseapp.com",
  databaseURL: "https://subtrack-a020a-default-rtdb.firebaseio.com",
  projectId: "subtrack-a020a",
  storageBucket: "subtrack-a020a.firebasestorage.app",
  messagingSenderId: "46329965836",
  appId: "1:46329965836:web:2056368e07d06f1d53ed29",
  measurementId: "G-67Q7V2H6GW",
});

const messaging = firebase.messaging();

// Opcional: Manejador de fondo para personalizar la notificación del sistema
messaging.onBackgroundMessage(function (payload) {
  console.log(
    "[firebase-messaging-sw.js] Notificación en segundo plano recibida ",
    payload,
  );

  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: "/icons/Icon-192.png", // Asegúrate de tener este icono en web/icons
  };

  return self.registration.showNotification(
    notificationTitle,
    notificationOptions,
  );
});
