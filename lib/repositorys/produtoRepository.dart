import 'dart:convert';
import 'package:mais_malas/imports.dart';
import 'package:http/http.dart' as http;

class ProdutoRepository {
  //Capturando a url base e juntando com o caminho que desejamos ir.
  var urlProdutos = dotenv.env['URLBASE'].toString() + 'produtos.php';

  Future<List<ProdutoModel>> listarProdutos() async {
    //Fazendo uma request
    http.Response response = await http.get(Uri.parse(urlProdutos));

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
        produtoModel.dataAtualizacao = item['dataAtualizacao'].toString();

        //Adicionando o produto a lista
        listaProdutos.add(produtoModel);
      }

      return listaProdutos;
    } else {
      if (response.statusCode == 500) {
        print("Servidor offline");
      }
      print(response.body);
      print("Caso de erro irá cair neste else");
      return [];
    }
  }

  //Metodo para salvar os dados de um produto no banco de dados.
  Future<int> cadastrarProduto(
      var nomeProduto, var descricaoProduto, var precoProduto) async {
    //Juntando todos os dados que serão cadastrados em um Map
    Map<String, dynamic> _body = {
      'input-acao': 'cadastrar_produto',
      'nomeProduto': nomeProduto.toString(),
      'descricaoProduto': descricaoProduto.toString(),
      'precoProduto': precoProduto.toString()
    };

    print(_body);

    http.Response response =
        await http.post(Uri.parse(urlProdutos), body: _body);

    if (response.statusCode == 200) {
      var data = response.body;
      //print(data);
      //Se der certo o cadastro retorna 1 , caso contrario retorna 0
      return (data.toString() == 'true' ? 1 : 0);
    } else {
      //Retorna 0 quando não for cadastrado
      return 0;
    }
  }
}
