import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPicker extends StatefulWidget {
  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  late GoogleMapController _mapController;
  LatLng _pickedLocation = LatLng(0.0, 0.0); // Initial location

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick a Location'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // Handle the selected location
              Navigator.of(context).pop(_pickedLocation);
            },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _pickedLocation,
          zoom: 15,
        ),
        onTap: _selectLocation,
        onMapCreated: (controller) {
          setState(() {
            _mapController = controller;
          });
        },
        markers: {
          Marker(
            markerId: MarkerId('pickedLocation'),
            position: _pickedLocation,
          ),
        },
      ),
    );
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
    _moveCameraToPosition(position);
  }

  void _moveCameraToPosition(LatLng position) {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position,
          zoom: 15,
        ),
      ),
    );
  }
}
