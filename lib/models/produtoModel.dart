class ProdutoModel {
  String? idProduto;
  String? nomeProduto;
  String? descricaoProduto;
  String? precoProduto;
  String? dataCadastro;
  String? dataAtualizacao;

  ProdutoModel(
      {this.idProduto,
      this.nomeProduto,
      this.descricaoProduto,
      this.precoProduto,
      this.dataCadastro,
      this.dataAtualizacao});

  ProdutoModel.fromJson(Map<String, dynamic> json) {
    idProduto = json['idProduto'];
    nomeProduto = json['nomeProduto'];
    descricaoProduto = json['descricaoProduto'];
    precoProduto = json['precoProduto'];
    dataCadastro = json['dataCadastro'];
    dataAtualizacao = json['dataAtualizacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idProduto'] = this.idProduto;
    data['nomeProduto'] = this.nomeProduto;
    data['descricaoProduto'] = this.descricaoProduto;
    data['precoProduto'] = this.precoProduto;
    data['dataCadastro'] = this.dataCadastro;
    data['dataAtualizacao'] = this.dataAtualizacao;
    return data;
  }
}
