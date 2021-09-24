import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mais_malas/controllers/produtoController.dart';

class VerMaisPage extends StatefulWidget {
  VerMaisPage({
    Key? key,
  }) : super(key: key);

  @override
  _VerMaisPageState createState() => _VerMaisPageState();
}

class _VerMaisPageState extends State<VerMaisPage> {
  //Nova instancia de produtoController
  final controller = Get.put(ProdutoController());
  @override
  void initState() {
    super.initState();
    //Pegando o valor passado entre telas usando Get
    controller.produtoM.value = (Get.arguments as Map)['produto'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title:
            Obx(() => Text(controller.produtoM.value.nomeProduto.toString())),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Banner da foto do produto
            Container(
              width: double.infinity,
              height: 140.0,
              color: Colors.black,
              child: Center(
                child: Icon(
                  Icons.photo,
                  color: Colors.white,
                  size: 100.0,
                ),
              ),
            ),
            //Banner da foto do produto final
            SizedBox(
              height: 16.0,
            ),
            //Descrição do produto
            Container(
              width: double.infinity,
              height: 100.0,
              child: Center(
                child: Obx(() => Text(
                      "Descrição do produto \n\n" +
                          controller.produtoM.value.descricaoProduto.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            //Descrição do produto final
            //Chamando button comprar
            _buildButtonComprar(),
          ],
        ),
      ),
    );
  }
}

//Criando um button
_buildButtonComprar() {
  return Padding(
    padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 40.0),
    child: InkWell(
      splashColor: Colors.white,
      onTap: () {
        //TO DO: Chamar o metodo para comprar
        print('Comprar');
      },
      child: Container(
          width: double.infinity,
          height: 60.0,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          child: Center(
            child: Text(
              'COMPRAR',
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
    ),
  );
}
