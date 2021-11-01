import 'package:get/get.dart';
import 'package:mais_malas/imports.dart';
import 'package:mais_malas/repositorys/imagenRepository.dart';

class ImageController extends GetxController {
  final imagenRepository = ImagenRepository();

  ///Método retorna todas as imagens feitas uploads
  Future<List<ImageModel>> getAllImagenUploads() {
    return imagenRepository.getAllImagenUploads().then((value) => value);
  }
}
