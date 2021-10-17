import 'dart:convert';
import 'package:mais_malas/imports.dart';
import 'package:http/http.dart' as http;

class CompraRepository {
  //Capturando a url base e juntando com o caminho que desejamos ir.
  var urlCompras = dotenv.env['URLBASE'].toString() + 'compras.php';
  //Metodo para salvar a compra
  Future<bool> salvarCompra(var dadosCompra) async {
    //Dados para enviar via post
    Map<String, String> _body = {
      'input-acao': 'cadastrar_compra',
      'idProduto': dadosCompra['idProduto'],
      'precoProduto': dadosCompra['precoProduto'],
    };

    http.Response response =
        await http.post(Uri.parse(urlCompras), body: _body);
    //IF ELSE verificando se deu certo a inserção da compra
    if (response.statusCode == 200) {
      return true;
    } else {
      if (response.statusCode == 500) {
        print("Erro de Servidor!");
      }
      return false;
    }
  }

  //Listar todas as compras salvas no banco de dados
  Future<List<CompraModel>> listarTodasCompras() async {
    http.Response response = await http.get(Uri.parse(urlCompras));
    if (response.statusCode == 200) {
      //Nova instancia de compraModel
      CompraModel compraModel;
      //Lista de objeto compraModel
      List<CompraModel> listaCompra = [];

      var dataCompra = jsonDecode(response.body);

      for (var item in dataCompra) {
        compraModel = new CompraModel();
        compraModel.idCompraProduto = item['idCompraProduto'].toString();
        compraModel.idProduto = item['idProduto'];
        compraModel.dataCompra = item['dataCompra'];
        compraModel.valorCompra = item['valorCompra'];

        listaCompra.add(compraModel);
      }
      return listaCompra;
    } else {
      if (response.statusCode == 500) {
        print("Erro de Servidor!");
      }

      return [];
    }
  }
}
