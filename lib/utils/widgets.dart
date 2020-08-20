import 'package:flutter/material.dart';


class PhoneAuthWidgets {
  static Widget getLogo({String logoPath, double height}) => Material(
    type: MaterialType.transparency,
    elevation: 10.0,
    child: Image.asset(logoPath, height: height),
  );
}

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneNumberField({Key key, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, spreadRadius: 1),
        ],
      ),
      height: 50,
      child: Row(
        children: <Widget>[
          SizedBox(width: 8.0),
          Expanded(
            child: TextFormField(
              controller: controller,
              autofocus: false,
              keyboardType: TextInputType.phone,
              key: Key('EnterPhone-TextFormField'),
              decoration: InputDecoration(
                border: InputBorder.none,
                errorMaxLines: 1,
                prefixText: '+370 '
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IDNumberField extends StatelessWidget {
  final TextEditingController controller;

  const IDNumberField({Key key, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, spreadRadius: 1),
        ],
      ),
      height: 50,
      child: Row(
        children: <Widget>[
          SizedBox(width: 8.0),
          Expanded(
            child: TextFormField(
              controller: controller,
              autofocus: false,
              keyboardType: TextInputType.phone,
              key: Key('EnterId-TextFormField'),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  errorMaxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class SubTitle extends StatelessWidget {
  final String text;

  const SubTitle({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(' $text',
            style: TextStyle(color: Colors.white, fontSize: 14.0)));
  }
}
