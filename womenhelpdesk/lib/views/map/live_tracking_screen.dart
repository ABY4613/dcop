import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../models/alert_model.dart';

class LiveTrackingScreen extends StatefulWidget {
  final AlertModel alert;
  const LiveTrackingScreen({super.key, required this.alert});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        markerId: MarkerId(widget.alert.id),
        position: LatLng(widget.alert.latitude, widget.alert.longitude),
        infoWindow: InfoWindow(title: widget.alert.userName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tracking ${widget.alert.userName}')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.alert.latitude, widget.alert.longitude),
          zoom: 15,
        ),
        markers: _markers,
        onMapCreated: (controller) {},
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Implement resolve alert logic
        },
        label: const Text('Resolve Alert'),
        icon: const Icon(Icons.check),
        backgroundColor: Colors.green,
      ),
    );
  }
}
