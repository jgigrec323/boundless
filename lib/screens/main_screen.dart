import 'dart:async';

import 'package:boundless/utils/constants.dart';
import 'package:boundless/widgets/custom_btn.dart';
import 'package:boundless/widgets/drawer_btn.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const String id = 'main_screen';
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController newGoogleMapController;
  void showBottomWidget() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          child: Column(
            children: [
              BtnPrincipal(text: "Add a request", onPressed: () {}),
              BtnPrincipal(text: "See all requests", onPressed: () {}),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      //TODO: handle also the points when the location is not accepted (inform the user)
      if (permission == LocationPermission.denied) {
        // Permission denied by user
        // Handle the error or show an appropriate message
        return;
      } else if (permission == LocationPermission.deniedForever) {
        // Permission permanently denied by user
        // Handle the error or show an appropriate message
        return;
      }
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Permission not granted
      // Handle the error or show an appropriate message
      return;
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Location services disabled
      // Handle the error or show an appropriate message
      return;
    }

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      newGoogleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 14,
          ),
        ),
      );
    });

    /* String address =
        await AssistantMethods.searchCoordinateAdress(position, context);
    initGeoFireListener();
    AssistantMethods.retrieveHistoryInfo(context); */
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          //googlemap
          GoogleMap(
            padding: EdgeInsets.only(bottom: 200),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (controller) {
              _controller.complete(controller);
              newGoogleMapController = controller;
              _getCurrentLocation();
            },
          ),
          //drawer
          Positioned(
            top: 50,
            left: 25,
            child: GestureDetector(
              onTap: () {
                showBottomWidget();
              },
              child: DrawerBtn(
                drawerOpen: true,
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: const BoxDecoration(
                color: Constants.mainColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5.0,
                    spreadRadius: 0,
                    offset: const Offset(0.0, 0.0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 320,
                    height: 50,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Constants.whiteColor),
                          foregroundColor:
                              MaterialStateProperty.all(Constants.blackColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)))),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "     Add a request", //add five spaces
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 320,
                    height: 50,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Constants.whiteColor),
                          foregroundColor:
                              MaterialStateProperty.all(Constants.blackColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)))),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "     See all requests",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 230,
            right: 20,
            child: GestureDetector(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Constants.mainColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 2), // Adjust offset as needed
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  size: 35,
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
