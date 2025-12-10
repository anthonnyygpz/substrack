# Substrack

Substrack es una aplicación de Flutter para el seguimiento de suscripciones.

## Primeros Pasos

Esta sección te guiará para tener una copia del proyecto en funcionamiento en tu máquina local para desarrollo y pruebas.

### Prerrequisitos

Asegúrate de tener el [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado en tu máquina.

### Instalación y Configuración

1.  **Clona el repositorio**
    ```bash
    git clone https://github.com/ignacio-g-pardella/substrack.git
    cd substrack
    ```

2.  **Configuración de Firebase**

    Este proyecto utiliza Firebase para la autenticación, la base de datos y otras funcionalidades. Deberás configurar tu propio proyecto de Firebase para poder ejecutar la aplicación.

    *   Crea un nuevo proyecto en la [Consola de Firebase](https://console.firebase.google.com/).

    *   **Para Android:**
        1.  En la configuración de tu proyecto de Firebase, añade una nueva aplicación de Android.
        2.  Sigue los pasos de configuración y descarga el archivo `google-services.json`.
        3.  Coloca el archivo `google-services.json` en el directorio `android/app/`.

    *   **Para iOS:**
        1.  En la configuración de tu proyecto de Firebase, añade una nueva aplicación de iOS.
        2.  Sigue los pasos de configuración y descarga el archivo `GoogleService-Info.plist`.
        3.  Abre el proyecto de iOS en Xcode y arrastra el archivo `GoogleService-Info.plist` a la carpeta `Runner`.

    *   **Para Web:**
        1.  En la configuración de tu proyecto de Firebase, añade una nueva aplicación Web.
        2.  Copia el objeto de configuración de Firebase.
        3.  Pega la configuración en el archivo `web/index.html` dentro de la etiqueta `<head>`.

3.  **Instalar dependencias**

    Ejecuta el siguiente comando para instalar todas las dependencias del proyecto.
    ```bash
    flutter pub get
    ```

### Ejecutando la Aplicación

Una vez que hayas completado los pasos de configuración, puedes ejecutar la aplicación en un emulador o en un dispositivo físico.

```bash
flutter run
```

Para obtener ayuda sobre cómo empezar con el desarrollo en Flutter, consulta la
[documentación en línea](https://docs.flutter.dev/), que ofrece tutoriales,
ejemplos, orientación sobre el desarrollo móvil y una referencia completa de la API.