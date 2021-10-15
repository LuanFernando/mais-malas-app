import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mais_malas/comuns.dart';
import 'package:mais_malas/routes.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Comuns().tituloApp,
      theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.blue,
          //Colando um tema Global para os Widget ElevatedButton
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: TextButton.styleFrom(
            backgroundColor: Colors.black,
          ))),
      initialRoute: '/',
      routes:
          getPages, //Aqui defino as routes ,chamando uma classe especifica de routes
    );
  }
}
