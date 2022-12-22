import 'package:flower/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController googleMapController;
  Set<Marker> markars = {};
  @override
  // بدي اعمل عملية البيرميشن اول ما يفتح الصفحة
  void initState() {
    locationPermission();
    super.initState();
  }
Future<void> locationPermission()async{
    await Permission.location.request();
}
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
      ),
      body: Center(
        child: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(1, 1),
            zoom: 14,
          ),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: (controller) => setState(() {
            googleMapController = controller;
          }),
          onTap: (latLng) => setState(() {
            markars.add(
              Marker(
                markerId: MarkerId(latLng.toString()),
                position: latLng,
                draggable: true,
              ),
            );
          }),
          markers: markars,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: green,
         onPressed: () {
          googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(1, 1),
                zoom: 14,
              ),
            ),
          );
        },
        child: Icon(
          Icons.navigation_outlined,
        ),
      ),
    );
  }
}
