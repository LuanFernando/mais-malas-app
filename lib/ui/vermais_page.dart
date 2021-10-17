import 'package:mais_malas/imports.dart';

class VerMaisPage extends StatefulWidget {
  VerMaisPage({
    Key? key,
  }) : super(key: key);

  @override
  _VerMaisPageState createState() => _VerMaisPageState();
}

class _VerMaisPageState extends State<VerMaisPage> {
  //Nova instancia de produtoController e compraController
  final _controllerProduto = Get.put(ProdutoController());
  final _controllerCompra = Get.put(CompraController());

  @override
  void initState() {
    super.initState();
    //Pegando o valor passado entre telas usando Get
    _controllerProduto.produtoM.value = (Get.arguments as Map)['produto'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Obx(() =>
            Text(_controllerProduto.produtoM.value.nomeProduto.toString())),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Banner da foto do produto
                Container(
                  width: double.infinity,
                  height: 140.0,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0))),
                  child: Center(
                    child: Image.asset("assets/imagens/suitcase.png"),
                  ),
                ),
                //Banner da foto do produto final
                SizedBox(
                  height: 8.0,
                ),
                //Row com Texto e icon: informando lista de imagens abaixo
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Espaçamento lateral
                    SizedBox(width: 8.0),
                    Text(
                      "Fotos",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.navigate_next)
                  ],
                ),
                //Row com Texto e icon: informando lista de imagens final
                //
                //Lista com as imagens/fotos da mala
                listaDeImagens(),
                //Lista com as imagens/fotos da mala  final
                SizedBox(height: 8.0),
                //Descrição do produto
                Container(
                  margin: EdgeInsets.all(16.0),
                  width: double.infinity,
                  //height: 100.0,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Obx(() => Text(
                                _controllerProduto
                                    .produtoM.value.descricaoProduto
                                    .toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),
                        SizedBox(height: 16.0),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 5.0,
                          children: [Text(Comuns().textLoremIpsum)],
                        )
                      ]),
                ),
                //Descrição do produto final

                //Espaçamento
                SizedBox(height: 16.0),
                //o Widget abaixo permite personalizar um texto
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: Comuns().siglaReal,
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: _controllerProduto.produtoM.value.precoProduto
                          .toString(),
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold))
                ])),

                //Chamando button comprar
                _buildButtonComprar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Criando um button
  _buildButtonComprar() {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 40.0),
      child: InkWell(
        splashColor: Colors.white,
        onTap: () {
          //Chamando o metodo salvar compra e passando os dados idProduto e valor do produto para ser salvo no banco de dados.
          _controllerCompra.salvarCompra({
            'idProduto': _controllerProduto.produtoM.value.idProduto.toString(),
            'precoProduto':
                _controllerProduto.produtoM.value.precoProduto.toString()
          });
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
}

//Lista de imagens de malas
//Todas as imagens da mala aparece aqui
listaDeImagens() {
  return Padding(
    padding: EdgeInsets.only(left: 8.0, right: 8.0),
    child: Container(
      width: double.infinity,
      height: 90.0,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          //Abaixo lista de widget para simular fotos da mala
          cardFotoMala(),
          cardFotoMala(),
          cardFotoMala(),
          cardFotoMala(),
          cardFotoMala(),
        ],
      ),
    ),
  );
}

//Card Imagen/Foto da mala (widget da lista de Imagens)
cardFotoMala() {
  return Container(
    margin: EdgeInsets.all(6.0),
    padding: EdgeInsets.all(6.0),
    width: 80.0,
    height: 80.0,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.0))),
    child: Image.asset(
      "assets/imagens/suitcase.png",
      fit: BoxFit.cover,
    ),
  );
}
