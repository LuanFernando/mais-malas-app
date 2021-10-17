import 'package:mais_malas/imports.dart';

/*
* Widget CircularProgressIndicator Personalizado
* O widget é composto por uma : Column,Stack ,SizedBox e Image.
*/
Widget buildCircularProgressIndicatorPerson() {
  return Column(
    //Centralizando os widgets no centro da column
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      //Widget child 01 - Stack tem 2 Widgets (Image e SizedBox) como children.
      Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/icons/luggage.png",
            width: 40.0,
            height: 40.0,
          ),
          SizedBox(
            //Para definir um tamanho para o widget circularProgressIndicator é necessario primeiramento,
            //Unir ele a um SizedBox, apos isso basta informar suas dimenções width & height para que o widget
            //CircularProgreeIndicator saiba até aonde ele pode se extender.
            height: 80.0,
            width: 80.0,
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
        ],
      ),
      SizedBox(
        height: 20.0,
      ),
      //Texto mensagem informando o que esta sendo processado na tela.
      Text('Aguarde a carregar.')
    ],
  );
}
