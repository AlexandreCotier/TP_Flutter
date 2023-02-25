import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/share/location_style.dart';
import 'package:location/share/location_text_style.dart';
import 'package:location/views/resa_location.dart';
import 'package:location/views/share/habitation_features_widget.dart';
import 'package:location/views/share/habitation_option.dart';
import '../models/habitation.dart';

class HabitationDetails extends StatefulWidget {
  final Habitation _habitation;

  const HabitationDetails(this._habitation, {Key? key}) : super(key: key);

  @override
  State<HabitationDetails> createState() => _HabitationDetailsState();
}

class _HabitationDetailsState extends State<HabitationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._habitation.libelle),
      ),
      body: ListView(
        padding: EdgeInsets.all(4.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              'http://192.168.1.44:8888/static/images/locations/${widget._habitation.image}',
              fit: BoxFit.fitWidth,
            ),
            ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(widget._habitation.adresse),
          ),
          HabitationFeaturesWidget(widget._habitation),
            if(widget._habitation.options.isNotEmpty)(
              Container(
                margin: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Inclus",
                      style: LocationTextStyle.subTitleboldTextStyle,
                    ),
                    Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10.0 ,right: 10.0),
                          child: Divider(
                            height: 36,
                            thickness: 1,
                          ),
                        )
                    ),
                  ],
                ),
              )
            ),
            _buildItem(),
            if(widget._habitation.optionpayantes.isNotEmpty)(
              Container(
              margin: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                      "Options",
                      style: LocationTextStyle.subTitleboldTextStyle,
                  ),
                  Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10.0 ,right: 10.0),
                        child: Divider(
                          height: 36,
                          thickness: 1,
                        ),
                      )
                  ),
                ],
              ),
            )
            ),
            _buildOptionsPayantes(),
            _buildRentButton(),
        ],
      ),
    );
  }

  _buildItem() {
     var width = (MediaQuery.of(context).size.width / 2) - 15;

     return Wrap(
      spacing: 2.0,
      children: Iterable.generate(
        widget._habitation.options.length,
          (i) => Container(
            margin: EdgeInsets.all(2.0),
            padding: EdgeInsets.only(left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget._habitation.options.elementAt(i).libelle),
                Text(
                  widget._habitation.options.elementAt(i).description,
                  style: LocationTextStyle.regularGreyTextStyle,
                ),
              ],

            )
          )
      ).toList()
     );
  }

  _buildRentButton() {
    var format = NumberFormat("### €");

    return Container(
      decoration: BoxDecoration(
        color: LocationStyle.backgroundColorPurple,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              format.format(widget._habitation.prixmois),

            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResaLocation(widget._habitation)),
                );
              },
              child: Text('Louer'),
            ),
          )
        ],
      ),
    );
  }

  _buildOptionsPayantes() {
    var width = (MediaQuery.of(context).size.width / 2) - 15;
    var format = NumberFormat("### €");

    return Wrap(
        spacing: 2.0,
        children: Iterable.generate(
            widget._habitation.optionpayantes.length,
                (i) => Container(
                margin: EdgeInsets.all(2.0),
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget._habitation.optionpayantes.elementAt(i).libelle),
                    Text(
                      format.format(widget._habitation.optionpayantes.elementAt(i).prix),
                      style: LocationTextStyle.regularGreyTextStyle,
                    ),
                  ],

                )
            )
        ).toList()
    );
  }
}
