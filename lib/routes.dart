import 'package:flutter/material.dart';
import 'package:mais_malas/ui/cadastrar_produto_page.dart';
import 'package:mais_malas/ui/carrinho_compras_page.dart';
import 'package:mais_malas/ui/home_page.dart';
import 'package:mais_malas/ui/vermais_page.dart';

//Map de rotas do aplicativo
Map<String, WidgetBuilder> getPages = {
  '/': (context) => HomePage(),
  '/vermais': (context) => VerMaisPage(),
  '/carrinhocompras': (context) => CarrinhoComprasPage(),
  '/cadastrarproduto': (context) => CadastrarProdutoPage(),
};
