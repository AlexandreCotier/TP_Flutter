import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ValidationLocation extends StatefulWidget {
  const ValidationLocation({Key? key}) : super(key: key);
  static String routeName = '/validation_location';
  @override
  State<ValidationLocation> createState() => _ValidationLocationState();
}

class _ValidationLocationState extends State<ValidationLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Validation location'),
        ),
        body: ListView(
          children: [
            Container(
              child: Text('Confirmation ok'),
            )
          ],
        )
    );
  }
}
