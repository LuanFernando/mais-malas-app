import 'package:mais_malas/imports.dart';

class CarrinhoComprasPage extends StatefulWidget {
  const CarrinhoComprasPage({Key? key}) : super(key: key);

  @override
  _CarrinhoComprasPageState createState() => _CarrinhoComprasPageState();
}

class _CarrinhoComprasPageState extends State<CarrinhoComprasPage> {
  @override
  Widget build(BuildContext context) {
    //Nova instancia de compraController
    final _controllerCompra = Get.put(CompraController());

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        title: Text("Meu Carrinho"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: FutureBuilder(
            future: _controllerCompra.listarCompras(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<CompraModel> listaCompra = snapshot.data;
                return ListView.builder(
                    itemCount: listaCompra.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildCardComprados(listaCompra[index]);
                    });
              } else {
                //Chamando o widget de circularProgress personalizado
                return buildCircularProgressIndicatorPerson();
              }
            }),
      ),
    );
  }
}

//Card de produtos comprados
_buildCardComprados(CompraModel compraModel) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: double.infinity,
      height: 80.0,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Data compra: " + compraModel.dataCompra.toString(),
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8.0),
          Text(
            "Valor da compra: R\$" + compraModel.valorCompra.toString(),
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    ),
  );
}
