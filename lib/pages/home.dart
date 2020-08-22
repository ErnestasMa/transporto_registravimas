import 'package:flutter/material.dart';
import 'package:transporto_registravimas/pages/polution_calc.dart';
import 'package:transporto_registravimas/pages/vehicle_buy.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:transporto_registravimas/models/vehicle.dart';
import 'package:transporto_registravimas/pages/vehicle_seling.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.userId, this.logoutCallback})
      : super(key: key);

  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Vehicle> _vehicleList;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String radioItem = '';
  String _selection = '';
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _textEditingController = TextEditingController();

  StreamSubscription<Event> _onVehicleChangedSubscription;
  StreamSubscription<Event> _onVehicleAddedSubscription;

  Query _vehicleQuery;

  @override
  void initState() {
    super.initState();

    _vehicleList = new List();

    _vehicleQuery = _database
        .reference()
        .child("vehicle")
        .orderByChild("userId")
        .equalTo(widget.userId);
    _onVehicleAddedSubscription =
        _vehicleQuery.onChildAdded.listen(onEntryAdded);
    _onVehicleChangedSubscription =
        _vehicleQuery.onChildChanged.listen(onEntryChanged);
  }

  @override
  void dispose() {
    _onVehicleAddedSubscription.cancel();
    _onVehicleChangedSubscription.cancel();
    super.dispose();
  }

  onEntryChanged(Event event) {
    var oldEntry = _vehicleList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _vehicleList[_vehicleList.indexOf(oldEntry)] =
          Vehicle.fromSnapshot(event.snapshot);
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      _vehicleList.add(Vehicle.fromSnapshot(event.snapshot));
    });
  }



  Widget showVehicleList() {
    if (_vehicleList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _vehicleList.length,
          itemBuilder: (BuildContext context, int index) {
            String vehicleId = _vehicleList[index].key;
            String name = _vehicleList[index].name;
            String vin = _vehicleList[index].vin;
            String registrationNr = _vehicleList[index].registrationNr;
            String statusId = _vehicleList[index].statusId;
            return Container(
              child: Column(
                key: Key(vehicleId),
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Radio(
                        groupValue: radioItem,
                        value: vin,
                        onChanged: (val) {
                          setState(() {
                            radioItem = val;
                            _selection = val;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          name,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Valst. Nr: ' + registrationNr,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(60.0, 8.0, 8.0, 8.0),
                        child: Text(
                          "VIN: " + vin,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(60.0, 8.0, 8.0, 8.0),
                        child: Text(
                          "Statusas: " + statusId,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: const Divider(
                      color: Colors.black,
                      height: 20,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                  ),
                ],
              ),
            );
          });
    } else {
      return Center(
          child: Text(
        "Šiuo metu neturite transporto priemonių",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30.0),
      ));
    }
  }

  Widget showOptions(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              height: 40.0,
              minWidth: 280.0,
              color: Colors.white54,
              onPressed: () {
                print(_selection);
                if (_selection != '') {
                  Route route = MaterialPageRoute(
                      builder: (context) => new VehicleSellingPage(_selection));
                  Navigator.push(context, route);
                } else {
                  _scaffoldKey.currentState.showSnackBar(new SnackBar(
                      content:
                          new Text('Prašome pasirinkti transporto priemonę')));
                }
              },
              child: Text('Parduodu transporto priemonę'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              height: 40.0,
              minWidth: 280.0,
              color: Colors.white54,
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (context) => new VehicleBuyPage());
                Navigator.push(context, route);
              },
              child: Text('Perku transporto priemonę'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              height: 40.0,
              minWidth: 280.0,
              color: Colors.white54,
              onPressed: () {
                functionNotDone();
              },
              child: Text('Keičiu valdytoją'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              height: 40.0,
              minWidth: 280.0,
              color: Colors.white54,
              onPressed: () {   functionNotDone();},
              child: Text('Užsakau registracijos numerį'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              height: 40.0,
              minWidth: 280.0,
              color: Colors.white54,
              onPressed: () {   functionNotDone();},
              child: Text('Užsakau registracijos liudijimą'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              height: 40.0,
              minWidth: 280.0,
              color: Colors.white54,
              onPressed: () {
                functionNotDone();
//                Route route = MaterialPageRoute(
//                    builder: (context) => new PollutionCalcPage());
//                Navigator.push(context, route);
              },
              child: Text('Skaičiuoju registracijos mokestį'),
            ),
          ],
        ),
      ],
    );
  }

  Widget showSnackBar(BuildContext context) {
    void showSnackBarMessage(String message,
        [MaterialColor color = Colors.lightBlue]) {
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: new Text(message)));
    }
  }

  functionNotDone(){
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content:
        new Text('Ši funkcija nėra realizuota')));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title:
            new Text('Transporto priemonių registravimo elektroninė paslauga'),

      ),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: showVehicleList(),
          ),
          Container(alignment: Alignment.center, child: showOptions(context)),
        ],
      ),
    );
  }
}
