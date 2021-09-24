import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mais_malas/controllers/produtoController.dart';
import 'package:mais_malas/models/produtoModel.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Nova instancia da ProdutoController
  final controller = Get.put(ProdutoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('+Malas',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.help,
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: FutureBuilder(
            future: controller.listarProdutos(),
            builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
              if (asyncSnapshot.hasData) {
                List<ProdutoModel> listaProduto = asyncSnapshot.data;
                return ListView.builder(
                  itemCount: listaProduto.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildCardProduto(listaProduto[index]);
                  },
                );
              } else {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Aguarde a carregar..',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 16.0),
                      CircularProgressIndicator(color: Colors.black),
                    ]);
              }
            }),
      ),
    );
  }

//Criando card produto
  _buildCardProduto(ProdutoModel produtoModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 130.0,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(30.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Row com idProduto e nomeProduto
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //IdProduto
                Text(produtoModel.idProduto.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0)),
                SizedBox(width: 8.0),
                //NomeProduto
                Text(produtoModel.nomeProduto.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0))
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            //Row com Foto ,descricaoProduto
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 8.0),
                //Campo de foto para o produto
                Container(
                  width: 90.0,
                  height: 80.0,
                  color: Colors.white,
                  child: Center(
                      child: Icon(
                    Icons.photo,
                    size: 40.0,
                  )),
                ),
                //Campo de foto para o produto final
                SizedBox(width: 8.0),

                SizedBox(
                  width: 16.0,
                ),
                //Coluna 2
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Descrição do produto
                    Text(
                      produtoModel.descricaoProduto.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextButton(
                        onPressed: () {
                          //Chama a controller e redireciona para page ver_mais
                          controller.redirecionaRota('vermais', produtoModel);
                        },
                        child: Text(
                          "Ver mais",
                          style: TextStyle(fontSize: 16.0),
                        )),
                  ],
                )
                //Coluna 2 final
              ],
            ),
            //Final Row
          ],
        ),
      ),
    );
  }
}
