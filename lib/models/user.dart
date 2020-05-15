import 'package:firebase_database/firebase_database.dart';

class User {
  String key; //user id
  String userStatus;
  String name;
  String personalCode;
  String homeAddress;
  String eMail;
  String phoneNumber;
  String location;

  User(
      this.userStatus,
      this.name,
      this.personalCode,
      this.homeAddress,
      this.eMail,
      this.phoneNumber,
      this.location,
      );

  User.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        userStatus = snapshot.value["userStatus"],
        name = snapshot.value["name"],
        personalCode = snapshot.value["personalCode"],
        homeAddress = snapshot.value["homeAddress"],
        eMail = snapshot.value["eMail"],
        phoneNumber = snapshot.value["phoneNumber"],
        location = snapshot.value["location"];

  toJson() {
    return {
      "userStatus": userStatus,
      "name": name,
      "personalCode": personalCode,
      "homeAddress": homeAddress,
      "eMail": eMail,
      "phoneNumber": phoneNumber,
      "location": location,
    };
  }
}
