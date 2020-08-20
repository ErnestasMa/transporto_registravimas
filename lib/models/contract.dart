import 'package:firebase_database/firebase_database.dart';

class Contract {
  String key;
  String carID;
  String vin;
  String sellerID;
  String registrationCertificateNr;
  String date;
  String location;
  String price;
  String km;

  Contract(
      this.carID,
      this.vin,
      this.sellerID,
      this.registrationCertificateNr,
      this.date,
      this.location,
      this.price,
      this.km,
      );

  Contract.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        carID = snapshot.value["carID"],
        vin = snapshot.value["vin"],
        sellerID = snapshot.value["sellerID"],
        registrationCertificateNr = snapshot.value["registrationCertificateNr"],
        date = snapshot.value["date"],
        location = snapshot.value["location"],
        price = snapshot.value["price"],
        km = snapshot.value["km"];


  toJson() {
    return {
      "carID": carID,
      "vin": vin,
      "sellerID": sellerID,
      "registrationCertificateNr": registrationCertificateNr,
      "date": date,
      "location": location,
      "price": price,
      "km": km,

    };
  }
}
