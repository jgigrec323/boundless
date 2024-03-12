import 'dart:convert';
import 'package:boundless/models/address.dart';
import 'package:boundless/utils/config.dart';
import 'package:provider/provider.dart';
import 'package:boundless/utils/requestAssistant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AssistantMethods {
  static Future<String> searchCoordinateAdress(
      Position position, context) async {
    String placeAdress = "";
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    var response = await RequestAssistant.getRequest(url);

    if (response != "failed") {
      placeAdress = response["results"][0]["formatted_address"];

      Address userPickUpAddress = Address(
          placeFormattedAdress: "",
          placeName: placeAdress,
          placeId: response["results"][0]["place_id"],
          latitude: position.latitude,
          longitude: position.longitude);

      /*  Provider.of<AppData>(context, listen: false)
          .updatePickUpLocationAddress(userPickUpAddress); */
    }

    return placeAdress;
  }
}
/*
  static Future<String> searchCoordinateAdressDropOff(
      Position position, context) async {
    String placeAdress = "";
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    var response = await RequestAssistant.getRequest(url);

    if (response != "failed") {
      placeAdress = response["results"][0]["formatted_address"];

      Address userDropOffLocation = Address(
          placeFormattedAdress: "",
          placeName: placeAdress,
          placeId: response["results"][0]["place_id"],
          latitude: position.latitude,
          longitude: position.longitude);

      Provider.of<AppData>(context, listen: false)
          .updateDropOffLocation(userDropOffLocation);
    }

    return placeAdress;
  }

  static Future<DirectionDetails?> obtainPlaceDirectionsDetails(
      LatLng initialPosition, LatLng finalPosition) async {
    String directionUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapKey";

    var res = await RequestAssistant.getRequest(directionUrl);

    if (res == "failed") {
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails(
        durationValue: 0,
        distanceText: '',
        encodedPoints: '',
        distanceValue: 0,
        durationText: '');
    if (res["status"] == "OK") {
      directionDetails.encodedPoints =
          res["routes"][0]["overview_polyline"]["points"];

      directionDetails.distanceText =
          res["routes"][0]["legs"][0]["distance"]["text"];
      directionDetails.distanceValue =
          res["routes"][0]["legs"][0]["distance"]["value"];

      directionDetails.durationText =
          res["routes"][0]["legs"][0]["duration"]["text"];
      directionDetails.durationValue =
          res["routes"][0]["legs"][0]["duration"]["value"];
    }

    return directionDetails;
  }

  static int calculateFares(DirectionDetails directionDetails) {
    double timeTravaledFare = (directionDetails.durationValue / 60) * 2500;
    double distanceTraveledFare =
        (directionDetails.distanceValue / 1000) * 2500;

    double totalFaresAmount = timeTravaledFare + distanceTraveledFare;

    return totalFaresAmount.truncate();
  }

  static void getCurrentOnlineUserInfo() async {
    firebaseUser = FirebaseAuth.instance.currentUser!;
    String userId = firebaseUser!.uid;
    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child("users").child(userId);

    reference.once().then((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        userCurrentInfo = Users.fromSnapshot(dataSnapshot);
        print(userCurrentInfo);
      }
    });
  }

  static double createRandomNumber(int num) {
    var random = Random();
    int radNumber = random.nextInt(num);
    return radNumber.toDouble();
  }

  static sendNotificationToDriver(
      String token, context, String ride_request_id) async {
    var destination =
        Provider.of<AppData>(context, listen: false).dropOffLocation;
    Map<String, String> headerMap = {
      'Content-Type': 'application/json',
      'Authorization': serverToken,
    };
    Map notificationMap = {
      'body': 'Adresse de départ, ${destination.placeName}',
      'title': 'Nouvelle course'
    };
    Map dataMap = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'ride_request_id': ride_request_id,
    };
    Map sendNotificationMap = {
      "notification": notificationMap,
      "data": dataMap,
      "priority": "high",
      "to": token,
    };

    var res = await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: headerMap,
      body: jsonEncode(sendNotificationMap),
    );
  }

  static void retrieveHistoryInfo(context) {
    //retrieve and display trip history
    newRequestRef.orderByChild("rider_firstname").once().then((event) {
      var datasnapshot = event.snapshot;
      if (datasnapshot.value != null) {
        //update number total of trip counts to provider
        Map<dynamic, dynamic> keys = datasnapshot.value as Map;
        int tripCounter = keys.length;
        Provider.of<AppData>(context, listen: false)
            .updateTripsCounter(tripCounter);

        //update tripHistory keys to provider
        List<String> tripHistoryKeys = [];
        keys.forEach((key, value) {
          tripHistoryKeys.add(key);
        });
        Provider.of<AppData>(context, listen: false)
            .updateTripKeys(tripHistoryKeys);
      }
      obtainTripRequestHistoryData(context);
    });
  }

  static void obtainTripRequestHistoryData(context) {
    var keys = Provider.of<AppData>(context, listen: false).tripHistoryKeys;
    print(keys);
    for (String key in keys) {
      newRequestRef.child(key).once().then((event) {
        var datasnapshot = event.snapshot;
        if (datasnapshot.value != null) {
          newRequestRef
              .child(key)
              .child("rider_firstname")
              .once()
              .then((event) {
            var dsnap = event.snapshot;
            String firstname = dsnap.value.toString();
            if (firstname == userCurrentInfo!.firstname) {
              var history = History.fromSnapshot(datasnapshot);
              Provider.of<AppData>(context, listen: false)
                  .updateTripHistoryData(history);
            }
          });
        }
      });
    }
  }

  static String formatTripDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate =
        "${DateFormat.MMMd().format(dateTime)}, ${DateFormat.y().format(dateTime)} - ${DateFormat.jm().format(dateTime)}";

    return formattedDate;
  }
} */