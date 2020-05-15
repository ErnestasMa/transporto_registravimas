import 'package:firebase_database/firebase_database.dart';

class Vehicle {
  String key; //vehicle id
  String name;
  String vin;
  String registrationNr;
  String registrationCertificateNr;
  String statusId;
  String userId;

  Vehicle(
    this.name,
    this.vin,
    this.registrationNr,
    this.registrationCertificateNr,
    this.statusId,
    this.userId,
  );

  Vehicle.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        name = snapshot.value["name"],
        vin = snapshot.value["vin"],
        registrationNr = snapshot.value["registrationNr"],
        registrationCertificateNr = snapshot.value["registrationCertificateNr"],
        statusId = snapshot.value["statusId"],
        userId = snapshot.value["userId"];

  toJson() {
    return {
      "name": name,
      "vin": vin,
      "registrationNr": registrationNr,
      "registrationCertificateNr": registrationCertificateNr,
      "statusId": statusId,
      "userId": userId,
    };
  }
}
