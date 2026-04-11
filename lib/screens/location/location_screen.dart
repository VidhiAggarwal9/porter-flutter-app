import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../services/gps_service.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  String latitude = "";
  String longitude = "";
  bool loading = false;

  void getLocation() async {

    setState(() {
      loading = true;
    });

    Position? position = await GPSService().getLocation();

    if (position != null) {
      setState(() {
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
        loading = false;
      });
    } else {
      setState(() {
        latitude = "Error getting location";
        longitude = "";
        loading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: getLocation,
              child: const Text("Get Location"),
            ),
            const SizedBox(height: 20),
            loading
                ? const CircularProgressIndicator()
                : Column(
              children: [
                Text("Latitude: $latitude"),
                const SizedBox(height: 10),
                Text("Longitude: $longitude"),
              ],)],),),);}
}