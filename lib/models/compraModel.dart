class CompraModel {
  String? idCompraProduto;
  String? idProduto;
  String? dataCompra;
  String? valorCompra;

  CompraModel(
      {this.idCompraProduto,
      this.idProduto,
      this.dataCompra,
      this.valorCompra});

  CompraModel.fromJson(Map<String, dynamic> json) {
    idCompraProduto = json['idCompraProduto'];
    idProduto = json['idProduto'];
    dataCompra = json['dataCompra'];
    valorCompra = json['valorCompra'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idCompraProduto'] = this.idCompraProduto;
    data['idProduto'] = this.idProduto;
    data['dataCompra'] = this.dataCompra;
    data['valorCompra'] = this.valorCompra;
    return data;
  }
}
