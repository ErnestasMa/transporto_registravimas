import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final car = Image.asset('assets/images/car.png');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
      DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.directions_transit)),
                  Tab(icon: Icon(Icons.directions_bike)),
                ],
              ),
              title: Text('Transporto registravimas'),
            ),
            body: TabBarView(
              children: [
                Icon(Icons.directions_car),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
            ),
        ),
      ),
    );
  }
}
