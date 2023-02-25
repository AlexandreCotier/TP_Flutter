import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/share/location_text_style.dart';

class TotalWidget extends StatefulWidget {
  const TotalWidget(this._prixTotal, {Key? key}) : super(key: key);
  final double _prixTotal;
  @override
  State<TotalWidget> createState() => _TotalWidgetState();
}

class _TotalWidgetState extends State<TotalWidget> {
  var format = NumberFormat('###.## €');

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.indigo.shade800,
        ),
        borderRadius: BorderRadius.circular(5.0)
      ),
      child:
      Row(
        children: [
          Expanded(
            flex: 6,
            child: Text(
                "TOTAL",
                textAlign: TextAlign.center,
                style: LocationTextStyle.totalPriceTextStyle,
            )),
          Expanded(
              flex: 1,
              child: Text(format.format(widget._prixTotal),
                style: LocationTextStyle.totalPriceTextStyle,
              ),

            )
        ],
      )
    );
  }
}
