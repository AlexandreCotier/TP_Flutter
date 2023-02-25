import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/services/habitation_service.dart';

import '../models/habitation.dart';
import '../models/location.dart';
import '../services/location_service.dart';
import '../share/location_text_style.dart';
import 'bottom_navigation_bar_widget.dart';

class LocationList extends StatefulWidget {
  static String routeName = '/locations';
  const LocationList({Key? key}) : super(key: key);

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  final LocationService service = LocationService();
  final HabitationService habitationService = HabitationService();
  late Future<List<Location>> _locations;

  @override
  void initState(){
    super.initState();
    _locations = service.getLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(2),
      appBar: AppBar(
        title: Text('Mes locations'),
      ),
      body: Center(
        child: FutureBuilder<List<Location>>(
          future: _locations,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final locations = snapshot.data!;
              return ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) =>
                _buildRow(locations[index], context),
                itemExtent: 180,
                );
      } else if (snapshot.hasError) {
        return Text('${snapshot.error}');
      } else {
        return CircularProgressIndicator();
      }
    },
      )
    )
    );
  }

  //Center(
  //child: ListView.builder(
  //itemCount: widget._locations.length,
  //itemBuilder: (context, index) =>
  //_buildRow(widget._locations[index], context),
  //itemExtent: 180,
  //),
  //),

  _buildRow(Location location, BuildContext context){
    return Container(
        margin: EdgeInsets.all(4.0),
        child: Column(
            children: [
              _buildResume(location),
              _buildDates(location),
              _buildInvoice(location)
            ],
          ),
    );
  }

  _buildResume(Location location) {
    Habitation habitation = habitationService.getHabitationById(location.idhabitation);
    var format = NumberFormat("### €");
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: ListTile(
                  title: Text(habitation.libelle),
                  subtitle: Text(habitation.adresse),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(format.format(habitation.prixmois),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    fontSize: 22,
                  ),),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildDates(Location location) {
    return Container(
        color: Colors.grey.shade100,
        padding: EdgeInsets.all(5.0),
        child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5.0),
                    child: Icon(Icons.calendar_today_outlined),
                  ),
                  Text(
                    DateFormat('dd MMM yyyy', 'fr').format(location.dateDebut),
                    style: LocationTextStyle.calendarDateTextStyle,

                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30.0, right: 30.0),
                    child:
                    CircleAvatar(
                      backgroundColor: Colors.indigo.shade800,
                      child: Icon(Icons.arrow_right_alt),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 5.0),
                    child: Icon(Icons.calendar_today_outlined),
                  ),
                  Text(
                    DateFormat('dd MMM yyyy', 'fr').format(location.dateFin),
                    style: LocationTextStyle.calendarDateTextStyle,
                  ),
                ]

            )
    );
  }

  _buildInvoice(Location location) {
    return Container(
        margin: EdgeInsets.only(left: 20.0,top: 5.0),
        child: Row(
          children: [
            location.facture != null
                ? Text('Facture délivrée le ${DateFormat('dd MMM yyyy', 'fr').format(location.facture!.date)}') :
            Text('Aucune facture'),
          ],
        )
    );
  }

}
