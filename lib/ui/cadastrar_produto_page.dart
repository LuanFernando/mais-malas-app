import 'package:flutter/material.dart';

class CadastrarProdutoPage extends StatefulWidget {
  const CadastrarProdutoPage({Key? key}) : super(key: key);

  @override
  _CadastrarProdutoPageState createState() => _CadastrarProdutoPageState();
}

class _CadastrarProdutoPageState extends State<CadastrarProdutoPage> {
  @override
  Widget build(BuildContext context) {
    //Para que as guias funcionem da maneira mais adequada é necessario usar um TabController para manter as guias
    //selecionadas e o conteudo sincronizados entre as seções.
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.black,
          title: const Text(
            "Produto",
            style: TextStyle(color: Colors.white),
          ),
          //Precisamos Cria as Tab parte superior aonde exibirá um widget Text ou Icon para que vizualmente
          //possamos nos localizar em qual seção estamos.
          bottom: TabBar(indicatorColor: Colors.red, tabs: [
            Tab(child: const Text('Nova Mala')),
            Tab(child: const Text('Outros')),
          ]),
        ),
        //Aqui criamos as seções (ou melhor dizendo os widget aonde ficarão os conteudos referente a cada Tab(guia))
        body: TabBarView(children: [
          _buildNovaMala(),
          _buildOutros(),
        ]),
      ),
    );
  }
}

//Widget referente aos conteudos de nova mala
_buildNovaMala() {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: ListView(
      scrollDirection: Axis.vertical,
      children: [
        Form(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildInformeCamposObrigatorios(),
            _buildTextFormFieldPersonalizado(
                "Nome do produto", TextInputType.text),
            _buildTextFormFieldPersonalizado(
                "Descrição do produto", TextInputType.text),
            _buildTextFormFieldPersonalizado(
                "Preço do produto", TextInputType.number),
            _buildButtonCadastrar(),
          ],
        )),
      ],
    ),
  );
}

//Widget referente aos conteudos de outros
//Este Tab(guia estou criando apenas para testar se vai dar overflowed em algum widget)
_buildOutros() {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: ListView(
      scrollDirection: Axis.vertical,
      children: [
        Form(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildInformeCamposObrigatorios(),
            _buildTextFormFieldPersonalizado("Campo 01", TextInputType.text),
            _buildTextFormFieldPersonalizado("Campo 02", TextInputType.text),
            _buildTextFormFieldPersonalizado("Campo 03", TextInputType.number),
            _buildTextFormFieldPersonalizado("Campo 04", TextInputType.text),
            _buildTextFormFieldPersonalizado("Campo 05", TextInputType.text),
            _buildTextFormFieldPersonalizado("Campo 06", TextInputType.number),
            _buildTextFormFieldPersonalizado("Campo 07", TextInputType.text),
            _buildTextFormFieldPersonalizado("Campo 08", TextInputType.text),
            _buildTextFormFieldPersonalizado("Campo 09", TextInputType.number),
          ],
        )),
      ],
    ),
  );
}

//Mensagem acima do Formulario informando que todos os campos são obrigatórios
_buildInformeCamposObrigatorios() {
  return Padding(
    padding: EdgeInsets.only(top: 40.0, bottom: 16.0),
    child: const Text(
      "* Preencha todos os campos!",
      style: TextStyle(fontSize: 16.0),
    ),
  );
}

//Widget TextFormField -usando componentização em flutter
//Componentização é reutilização de codigo,não sendo necessario criar inumeras vezes o mesmo widget.
_buildTextFormFieldPersonalizado(var hintText, TextInputType textInputType) {
  return Padding(
    padding: EdgeInsets.only(top: 16.0),
    child: TextFormField(
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    ),
  );
}

//Contruindo um button personalizado
_buildButtonCadastrar() {
  return Padding(
    padding: EdgeInsets.only(top: 40.0, left: 8.0, right: 8.0),
    child: Container(
      width: double.infinity,
      height: 60.0,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          'Cadastrar',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    ),
  );
}
