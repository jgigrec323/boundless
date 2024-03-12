import 'package:firebase_database/firebase_database.dart';

class Users {
  String id = "";
  String firstname = "";
  String lastname = "";
  String phone = "";
  String password = "";

  Users(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.phone,
      required this.password});

  Users.fromSnapshot(DataSnapshot dataSnapshot) {
    id = dataSnapshot.key!;

    var data = dataSnapshot.value as Map?;

    if (data != null) {
      firstname = data["firstname"];
      lastname = data["lastname"];
      phone = data["phone"];
      password = data["password"];
    }
  }

  String getInitials() {
    String firstInitial = firstname.isNotEmpty ? firstname[0] : '';
    String lastInitial = lastname.isNotEmpty ? lastname[0] : '';

    return '$firstInitial$lastInitial'.toUpperCase();
  }
}
