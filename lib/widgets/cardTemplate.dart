import 'package:flutter/material.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/constants/color.dart';

// ignore: must_be_immutable
class CardTemplate extends StatefulWidget {
  Widget? child = Container();

  CardTemplate({@required this.child});

  @override
  _CardTemplateState createState() => _CardTemplateState();
}

class _CardTemplateState extends State<CardTemplate> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.06,
          MediaQuery.of(context).size.height * 0.2,
          MediaQuery.of(context).size.width * 0.06,
          MediaQuery.of(context).size.height * 0.3,
        ),
        width: MediaQuery.of(context).size.width * 0.88,
        height: MediaQuery.of(context).size.height * 0.55,
        child: Card(
          shadowColor: shadowGrey,
          elevation: space_2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(space_5)),
          child: widget.child,
        ));
  }
}
