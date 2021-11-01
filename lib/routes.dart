import 'package:mais_malas/imports.dart';

//Map de rotas do aplicativo
Map<String, WidgetBuilder> getPages = {
  '/': (context) => HomePage(),
  '/vermais': (context) => VerMaisPage(),
  '/carrinhocompras': (context) => CarrinhoComprasPage(),
  '/cadastrarproduto': (context) => CadastrarProdutoPage(),
  '/uploads': (context) => UploadImagen(),
  '/meusuploads': (context) => MeusUploads(),
};
