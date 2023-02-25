import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/share/location_text_style.dart';
import 'package:location/views/share/total_widget.dart';

import '../models/habitation.dart';

class ResaLocation extends StatefulWidget {
  const ResaLocation(this._habitation, {Key? key}) : super(key: key);
  final Habitation _habitation;

  @override
  State<ResaLocation> createState() => _ResaLocationState();
}

class _ResaLocationState extends State<ResaLocation> {
  bool _value = false;
  DateTime dateDebut = DateTime.now();
  DateTime dateFin = DateTime.now();
  String nbPersonnes = '1';
  List<OptionPayanteCheck> optionPayanteChecks = [];
  var format = NumberFormat('### €');
  double prixTotal = 0;
  @override
  void initState() {
    super.initState();
    _loadOptionPayantes();
  }
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Réservation'),
      ),
      body: ListView(
        padding: EdgeInsets.all(4.0),
        children: [
          _buildResume(widget._habitation),
          _buildDates(),
          _buildNbPersonnes(),
          _buildOptionsPayantes(context),
          TotalWidget(prixTotal),
          _buildRentButton(),
        ],
      )
    );
  }

  _buildResume(Habitation habitation) {
    return Container(
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.house),
            title: Text(habitation.libelle),
            subtitle: Text(habitation.adresse),
          )
        ],
      )
    );
  }

  _buildDates() {
    return Container(
      color: Colors.grey.shade100,
      padding: EdgeInsets.all(5.0),
      child:
      GestureDetector(
          onTap: () {
            dateTimeRangePicker();
          },
      child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 5.0),
              child: Icon(Icons.calendar_today_outlined),
            ),
            Text(
                DateFormat('dd MMM yyyy', 'fr').format(dateDebut),
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
                DateFormat('dd MMM yyyy', 'fr').format(dateFin),
                style: LocationTextStyle.calendarDateTextStyle,
            ),
      ]

    )
        )
    );
  }

  _buildNbPersonnes() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Nombre de personnes"),
          Container(
            width: 50,
            child:
            DropdownButton<String>(
                value: nbPersonnes,
                isExpanded: true,
                items: <String>['1', '2', '3', '4', '5', '6', '7', '8'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value.toString()),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    nbPersonnes = newVal!;
                  });
                }),
          )

        ],
      ),
    );
  }

  _buildOptionsPayantes(BuildContext context) {

    return Center(
      child:
        Column(
            children: Iterable.generate( optionPayanteChecks.length, (i) =>
              CheckboxListTile(
                title: Text("${optionPayanteChecks.elementAt(i).libelle} (${format.format(optionPayanteChecks.elementAt(i).prix)})"),
                subtitle: Text(
                  "${optionPayanteChecks.elementAt(i).description}",
                  style: LocationTextStyle.regularGreyTextStyle,
                ),
                selected: optionPayanteChecks.elementAt(i).checked,
                value: optionPayanteChecks.elementAt(i).checked,
                onChanged: (bool? value) {
                  setState(() {
                    optionPayanteChecks.elementAt(i).checked = value!;
                    _calculPrice();
                  });
                },
              )
            ).toList()
        )
    );
  }

  _calculPrice(){
    prixTotal = 0;
    optionPayanteChecks.forEach((element) {
      if(element.checked){
        prixTotal += element.prix;
      }
    });
  }

  _buildRentButton() {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
        height: 50,
        decoration: BoxDecoration(
            color: Colors.indigo.shade800,
            borderRadius: BorderRadius.circular(5.0)
        ),
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(
            style: LocationTextStyle.rentTextStyle,
            "Louer",
            textAlign: TextAlign.center,
          )],
        )

    );
  }

  void _loadOptionPayantes() {
    widget._habitation.optionpayantes.forEach((element) {
      optionPayanteChecks.add(
          OptionPayanteCheck(element.id, element.libelle, false, description: element.description, prix: element.prix)
      );
    });

  }

  dateTimeRangePicker() async {
    DateTimeRange? datePicked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 2),
      initialDateRange: DateTimeRange(start: dateDebut, end: dateFin),
      cancelText: 'Annuler',
      confirmText: 'Valider',
      locale: const Locale("fr", "FR"),
    );
    if (datePicked != null) {
      setState(() {
        dateDebut = datePicked.start;
        dateFin = datePicked.end;
      });
    }
  }

}
