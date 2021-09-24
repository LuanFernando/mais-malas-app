import 'dart:convert';

import 'package:mais_malas/models/produtoModel.dart';
import 'package:http/http.dart' as http;

class ProdutoRepository {
  Future<List<ProdutoModel>> listarProdutos() async {
    //Fazendo uma request
    http.Response response = await http
        .get(Uri.parse('https://maismalas.000webhostapp.com/api/produtos.php'));

    //IF ELSE para verificar o statusCode
    if (response.statusCode == 200) {
      var produtos = jsonDecode(response.body);

      //Nova instancia de ProdutoModel e List
      ProdutoModel? produtoModel;
      List<ProdutoModel> listaProdutos = [];

      for (var item in produtos) {
        produtoModel = new ProdutoModel();

        //Adicionando o que veio do banco aos atributos da produtoModel
        produtoModel.idProduto = item['idProduto'].toString();
        produtoModel.nomeProduto = item['nomeProduto'].toString();
        produtoModel.descricaoProduto = item['descricaoProduto'].toString();
        produtoModel.precoProduto = item['precoProduto'].toString();
        produtoModel.precoProduto = item['dataAtualizacao'].toString();

        //Adicionando o produto a lista
        listaProdutos.add(produtoModel);
      }

      return listaProdutos;
    } else {
      if (response.statusCode == 500) {
        print("Servidor offline");
      }
      print("Caso de erro irá cair neste else");
      return [];
    }
  }
}
