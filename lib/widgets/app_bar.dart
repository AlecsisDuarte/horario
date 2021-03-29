import 'package:flutter/material.dart';

AppBar showAppBar(BuildContext context) {
  // AppBar widget to be shown on pages
  return AppBar(
    centerTitle: true,
    elevation: 0.0,
    backgroundColor: Theme.of(context).primaryColor,
    title: RichText(
      text: new TextSpan(children: <TextSpan>[
        new TextSpan(
          text: 'HORA',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w300,
            color: Theme.of(context).textTheme.bodyText1?.color,
          ),
        ),
        new TextSpan(
          text: 'RIO',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            color: Theme.of(context).accentColor,
          ),
        ),
      ]),
    ),
  );
}
