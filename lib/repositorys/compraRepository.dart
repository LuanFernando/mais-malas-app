import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mais_malas/models/compraModel.dart';

class CompraRepository {
  //Metodo para salvar a compra
  Future<bool> salvarCompra(var dadosCompra) async {
    //Dados para enviar via post
    Map<String, String> _body = {
      'input-acao': 'cadastrar_compra',
      'idProduto': dadosCompra['idProduto'],
      'precoProduto': dadosCompra['precoProduto'],
    };

    http.Response response = await http.post(
        Uri.parse("https://maismalas.000webhostapp.com/api/compras.php"),
        body: _body);
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
    http.Response response = await http
        .get(Uri.parse("https://maismalas.000webhostapp.com/api/compras.php"));
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
