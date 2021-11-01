import 'package:mais_malas/imports.dart';

class ProdutoController extends GetxController {
  //Nova instancia de produtoRepository
  final ProdutoRepository _produtoRepository = ProdutoRepository();

  //TextEditingController
  TextEditingController nomeProduto = new TextEditingController();
  TextEditingController descricaoProduto = new TextEditingController();
  TextEditingController precoProduto = new TextEditingController();

  //FormKey chave do formulario cadastrar produto
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  //Variavel usada para controlar o loading do button Cadastrar
  RxBool isLoading = false.obs;

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

  //Redireciona para rota upload image
  redirecionaUploadImage() {
    Get.toNamed("/uploads");
  }

  //Redireciona para rota meus uploads
  redirecionaMeusUploads() {
    Get.toNamed("/meusuploads");
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

  //Metodo para validar os campos do formulario e depois chamar o metodo cadastrar produto
  validarFormulario() {
    if (formKey.currentState!.validate()) {
      cadastrarProduto();
    }
  }

  //Metodo para cadastrar os produtos.
  //Devemos passar o apenas o nome do produto, descrição do produto e o preço do produto.
  cadastrarProduto() {
    //Mudar estado da varivel isLoading
    isloadingCadastrar();
    _produtoRepository
        .cadastrarProduto(
            nomeProduto.text, descricaoProduto.text, precoProduto.text)
        .then((value) {
      //Mudar estado da varivel isLoading
      isloadingCadastrar();
      //Limpar campos do formulario
      limparCamposFormulario();
      //Exibir mensagem de retorno
      exibirMensagemRetorno(value);
    });
  }

  //Exibir mensagem de retorno
  exibirMensagemRetorno(int retorno) {
    if (retorno == 1) {
      Get.snackbar('Produtos', 'Produto cadastrado com sucesso.',
          backgroundColor: Colors.white, colorText: Colors.black);
    } else {
      Get.snackbar('Produtos', 'Produto não cadastrado!!.',
          backgroundColor: Colors.white, colorText: Colors.black);
    }
  }

  //Limpar campos TextEditController
  limparCamposFormulario() {
    nomeProduto.clear();
    descricaoProduto.clear();
    precoProduto.clear();
  }

  //Metodo para isLoading mudar os estado da variavel
  isloadingCadastrar() {
    return (isLoading.value == false
        ? isLoading.value = true
        : isLoading.value = false);
  }
}
