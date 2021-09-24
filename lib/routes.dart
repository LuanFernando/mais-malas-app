import 'package:flutter/material.dart';
import 'package:mais_malas/ui/home_page.dart';
import 'package:mais_malas/ui/vermais_page.dart';

Map<String, WidgetBuilder> getPages = {
  '/': (context) => HomePage(),
  '/vermais': (context) => VerMaisPage(),
};
