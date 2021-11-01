class ImageModel {
  String? id;
  String? nomeImagen;
  String? diretorioImagen;
  String? dataUpload;

  ImageModel({this.id, this.nomeImagen, this.diretorioImagen, this.dataUpload});

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomeImagen = json['nome_imagen'];
    diretorioImagen = json['diretorio_imagen'];
    dataUpload = json['data_upload'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome_imagen'] = this.nomeImagen;
    data['diretorio_imagen'] = this.diretorioImagen;
    data['data_upload'] = this.dataUpload;
    return data;
  }
}
