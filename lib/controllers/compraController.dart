import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mais_malas/repositorys/compraRepository.dart';

import '../comuns.dart';

class CompraController extends GetxController {
  //Nova instancia de repository compra
  final _repositoryCompra = CompraRepository();

  //Metodo de salvar compra
  salvarCompra(var dadosCompra) {
    _repositoryCompra.salvarCompra(dadosCompra).then((value) {
      if (value == true) {
        Get.snackbar(Comuns().tituloCompra, Comuns().sucessoCompra,
            backgroundColor: Color(0xFF00ACC1));
      } else {
        Get.snackbar(Comuns().tituloCompra, Comuns().falhaCompra,
            backgroundColor: Color(0xFFC62828));
      }
    });
  }

  //Metodo listar todas as compras já salvas no banco de dados
  listarCompras() {
    return _repositoryCompra.listarTodasCompras().then((value) => value);
  }
}
