import 'package:flutter/material.dart';
import 'package:transporto_registravimas/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:transporto_registravimas/models/todo.dart';
import 'package:transporto_registravimas/models/vehicle.dart';
import 'package:transporto_registravimas/pages/vehicle_seling.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> _todoList;
  List<Vehicle> _vehicleList;

  String radioItem = '';
  String _selection = '';
  String _selectionFunction = '';
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

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
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
            return Container(
              child: Column(
                key: Key(vehicleId),
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Radio(
                        groupValue: radioItem,
                        value: name,
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
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Route route = MaterialPageRoute(
                      builder: (context) => new VehicleSellingPage());
                  Navigator.push(context, route);
                },
                child: Text('Parduodu transporto priemonę'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () {},
                child: Text('Perku transporto priemonę'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () {},
                child: Text('Keičiu valdytoją'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () {},
                child: Text('Užsakau registracijos numerį'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () {},
                child: Text('Užsakau registracijos liudijimą'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () {},
                child: Text('Skaičiuoju registracijos mokestį'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title:
            new Text('Transporto priemonių registravimo elektroninė paslauga'),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Atsijungti',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: signOut)
        ],
      ),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 250.0),
            child: showVehicleList(),
          ),
          showOptions(context),
        ],
      ),
      /*
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddTodoDialog(context);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        )
        */
    );
  }
}
