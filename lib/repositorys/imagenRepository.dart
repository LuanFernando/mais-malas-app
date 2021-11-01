import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mais_malas/models/imageModel.dart';

import '../imports.dart';

class ImagenRepository {
  ///Método retorna todas as imagens feitas uploads
  Future<List<ImageModel>> getAllImagenUploads() async {
    final url = dotenv.env['URLBASE'].toString();

    http.Response response = await http.get(Uri.parse(url + "images.php"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<ImageModel> lista = [];
      ImageModel imageModel;
      for (var img in data) {
        imageModel = new ImageModel();
        imageModel.id = img['id'].toString();
        imageModel.nomeImagen = img['nome_imagen'].toString();
        imageModel.diretorioImagen = img['diretorio_imagen'].toString();
        imageModel.dataUpload = img['data_upload'].toString();
        lista.add(imageModel);
      }
      return lista;
    } else {
      print(response.body);
      return [];
    }
  }
}
