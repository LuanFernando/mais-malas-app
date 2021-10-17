import 'package:mais_malas/imports.dart';

class ProdutoController extends GetxController {
  //Nova instancia de produtoRepository
  final ProdutoRepository _produtoRepository = ProdutoRepository();

  //Variaveis auxiliares
  Rx<ProdutoModel> produtoM = ProdutoModel().obs;

  //Metodo chama o listar da classe produtoRepository
  listarProdutos() {
    return _produtoRepository.listarProdutos().then((value) => value);
  }

  //Redireciona para rota ver mais.
  redirecionaVerMais(var rota, ProdutoModel produtoModel) {
    //Com Get.toNamed o gerenciador de estado procura por esta rota na classe routes e redireciona.
    Get.toNamed('/${rota.toString()}', arguments: {'produto': produtoModel});
  }

  //Redireciona para rota carrinho de compras
  redirecionaCarrinhoCompras() {
    Get.toNamed("/carrinhocompras");
  }

  //Redireciona para rota cadastrar produto
  redirecionaCadastrarProduto() {
    Get.toNamed('/cadastrarproduto');
  }

  //Metodo para exibir mensagem do button de ajuda
  mensagemButtonAjuda() {
    //Abaixo cria o widget de alertDialog
    Get.dialog(AlertDialog(
      title: Text("Ajuda"),
      content: Text(Comuns().mensagemAjuda),
      actions: [
        IconButton(
            onPressed: () {
              //Abaixo fecha o widget
              Get.back();
            },
            icon: Icon(Icons.close, color: Colors.red))
      ],
    ));
  }
}
