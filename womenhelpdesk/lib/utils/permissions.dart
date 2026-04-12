import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.request();
    return status.isGranted;
  }

  static Future<bool> requestMicrophonePermission() async {
    var status = await Permission.microphone.request();
    return status.isGranted;
  }

  static Future<bool> requestLocationPermission() async {
    var status = await Permission.location.request();
    return status.isGranted;
  }

  static Future<void> requestAllPermissions() async {
    await [
      Permission.camera,
      Permission.microphone,
      Permission.location,
      Permission.notification,
    ].request();
  }
}
