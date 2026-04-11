import 'package:geolocator/geolocator.dart';
class GPSService {
  Future<Position?> getLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;
      // Check GPS enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }
      // Check permission
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        return null;
      }
      // Get location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch (e) {
      print("Location error: $e");
      return null;
    }
  }
}