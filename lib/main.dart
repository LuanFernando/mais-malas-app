import 'package:mais_malas/imports.dart';

Future main() async {
  //Iniciando arquivo de variveis de ambiente
  await dotenv.load(fileName: '.env');
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
