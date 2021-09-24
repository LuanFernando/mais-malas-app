import 'package:get/get.dart';
import 'package:mais_malas/models/produtoModel.dart';
import 'package:mais_malas/repositorys/produtoRepository.dart';

class ProdutoController extends GetxController {
  //Nova instancia de produtoRepository
  final ProdutoRepository _produtoRepository = ProdutoRepository();

  //Variaveis auxiliares
  Rx<ProdutoModel> produtoM = ProdutoModel().obs;

  //Metodo chama o listar da classe produtoRepository
  listarProdutos() {
    return _produtoRepository.listarProdutos().then((value) => value);
  }

  //Redireciona rota
  redirecionaRota(var rota, ProdutoModel produtoModel) {
    //Com Get.toNamed o gerenciador de estado procura por esta rota na classe routes e redireciona.
    Get.toNamed('/${rota}', arguments: {'produto': produtoModel});
  }
}
