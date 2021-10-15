import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mais_malas/comuns.dart';
import 'package:mais_malas/controllers/produtoController.dart';
import 'package:mais_malas/models/produtoModel.dart';
import 'package:mais_malas/ui/widgets_uteis/circular_progress_indicator_person.dart';

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
        title: Text(Comuns().tituloApp,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          //TO DO: Redirecionar para a tela que apresenta todos os produtos já comprados.
          IconButton(
              onPressed: () {
                //Chama o metodo para redirecionar rota para pagina carrinho de compras
                controller.redirecionaCarrinhoCompras();
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                //Chama metodo de exibir mensagem de ajuda.
                controller.mensagemButtonAjuda();
              },
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
                //Chamando o widget circularProgress personalizado.
                return buildCircularProgressIndicatorPerson();
              }
            }),
      ),
      //FloatButton para redirecionar para tela de cadastrar mala.
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          //Chamando o metodo para redirecionar para o cadastrar produto.
          controller.redirecionaCadastrarProduto();
        },
        child: Image.asset(
          "assets/imagens/mala-de-viagem.png",
          color: Colors.white,
          width: double.infinity,
        ),
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
                Text("id: " + produtoModel.idProduto.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0)),
                SizedBox(width: 8.0),
                //NomeProduto
                Text("Nome: " + produtoModel.nomeProduto.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0))
              ],
            ),
            //Espaçamento entre  row
            SizedBox(height: 8.0),
            //Row com Foto ,descricaoProduto
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Espaçamento lateral
                SizedBox(width: 8.0),
                //Campo de foto para o produto
                Container(
                  width: 90.0,
                  height: 80.0,
                  color: Colors.black,
                  //Abaixo centralizando uma imagen
                  child: Center(
                      child: Image.asset(
                    "assets/imagens/suitcase.png",
                    fit: BoxFit.cover,
                  )),
                ),
                //Campo de foto para o produto final

                //Espaçamento entre foto e texto
                SizedBox(width: 24.0),

                //Coluna 2
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      produtoModel.descricaoProduto.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    //Descrição do produto
                    TextButton(
                        onPressed: () {
                          //Chama a controller e redireciona para page ver_mais
                          controller.redirecionaVerMais(
                              'vermais', produtoModel);
                        },
                        //Row para texto e icon
                        child: Row(children: [
                          //Chamada de ação texto
                          Text("Ver mais", style: TextStyle(fontSize: 16.0)),
                          //Icon
                          Icon(Icons.navigate_next)
                        ])),
                    //Row para texto e icon final),
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
