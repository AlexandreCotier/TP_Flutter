import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation_bar_widget.dart';

class Profil extends StatefulWidget {
  static String routeName = '/profil';

  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBarWidget(3),
        appBar: AppBar(
          title: Text('Réservation'),
        ),
        body: ListView(
          padding: EdgeInsets.all(4.0),
          children: [
            Container(
              child: Text('Profil à faire')
            )
          ],
        )
    );
  }
}
