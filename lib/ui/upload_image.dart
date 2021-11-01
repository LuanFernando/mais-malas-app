import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';
import '../imports.dart';

class UploadImagen extends StatefulWidget {
  const UploadImagen({Key? key}) : super(key: key);

  @override
  _UploadImagenState createState() => _UploadImagenState();
}

class _UploadImagenState extends State<UploadImagen> {
  /// Lista de assets
  List<Asset> images = [];

  /// Variavel auxiliar para manipular o circularProgress
  bool isLoading = false;

  /// Construindo o Grid para exibir as imagens
  Widget buildGridView() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: GridView.count(
          /// Quantidade de imagens por linha
          crossAxisCount: 3,

          ///Espaçamento de 5 horizontal
          crossAxisSpacing: 5,

          /// Espaçamento de 5 vertical
          mainAxisSpacing: 5,

          /// Recebendo um List.generate como filho
          /// O filho precisa receber a quantidade de imagens ele deverá rendenizar,
          /// um index para saber qual imagen rendenizar.
          children: List.generate(images.length, (index) {
            ///Recebendo uma imagen no asset Instanciado
            Asset asset = images[index];

            /// Retornando uma AssetThumb
            /// AssetThumb recebe um asset e as definições de largura e altura que deve ser rendenizado
            /// as imagens.
            return AssetThumb(asset: asset, width: 300, height: 300);
          }),
        ),
      ),
    );
  }

  /// Método para carregar as imagens
  Future<void> _loadAssets() async {
    /// Instancia de Lista de Asset
    List<Asset> resultList = [];

    /// try ()catch
    try {
      /// Lista de asset recebe as imagens selecionadas da galeria
      /// MultiImagePicker oferece alguns recursos para manipular as seleções de imagens
      /// masImages - define o quanto de imagens podem ser selecionadas de uma vez.
      /// enableCamera -
      /// selectedAssets -  recebe uma Lista de asset
      resultList = await MultiImagePicker.pickImages(
          maxImages: 300,
          enableCamera: true,
          selectedAssets: images,
          cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
          materialOptions: MaterialOptions(
              actionBarColor: "#abcdef",
              actionBarTitle: "Gallery",
              allViewTitle: "All Photos",
              useDetailsView: false,
              selectCircleStrokeColor: "#000000"));
    } catch (e) {
      print(e.toString());
    }

    /// O if abaixo , segundo comentarios stackoverflow
    /// Se o widget não estiver montado,volte.Faça isso antes do método setState
    if (!mounted) return;

    ///setState atualiza a variavel images
    setState(() {
      images = resultList;
    });
  }

  ///Método para salvar as  imagens
  /// Abaixo envio nome,caminho e image para API
  _saveImage() async {
    ///If verifica se a lista de asset , está vazia
    if (images.isNotEmpty) {
      ///For percorre a lista para fazer upload das imagens encontradas na lista.
      for (var i = 0; i < images.length; i++) {
        //ByteData byteData = await images[i].getByteData();
        //List<int> imageData = byteData.buffer.asUint8List();

        /// Url base definida no arquivo .env
        final url = dotenv.env['URLBASE'].toString();

        /// Variavel path recebe o caminho da imagen
        /// É necessario fazer uma conversão de asset para File para pegar o path da imagen
        /// * Não esquecer de passar o asset
        var path = await getImageFileFromAssets(images[i]);

        /// Response recebe o resultado da request
        /// http.MultipartRequest é responsavel por montar a requesição e enviar os dados corretamente
        var response = http.MultipartRequest(
            "POST", Uri.parse("$url" + "upload_image.php"));

        /// fields[] usados para key comuns (Texto,Número ..etc).
        response.fields['name'] = images[i].name.toString();

        /// files.add para enviar arquivos
        /// Sempre informar a : KEY, PATH e CONTENTTYPE
        response.files.add(await http.MultipartFile.fromPath(
          'image',
          path.path,
          contentType: new MediaType('aplication', 'x-tar'),
        ));

        ///Envia a request e aguarda uma resposta
        response.send().then((value) {
          setState(() {
            isLoading = true;
          });

          ///Verifica retorno
          if (value.statusCode == 200) {
            print("ok");
            setState(() {
              isLoading = false;
            });
          } else {
            print("error");
            setState(() {
              isLoading = false;
            });
          }
        });
      }
    }
  }

  /// Método para converter um Asset em um File
  /// Recebe um Asset
  Future<File> getImageFileFromAssets(Asset asset) async {
    /// Variavel byteData recebe o byteData do asset
    final byteData = await asset.getByteData();

    /// Variavel abaixo recebe o a junção do caminho temporario + nome da imagen
    final tempFile =
        File("${(await getTemporaryDirectory()).path}/${asset.name}");

    final file = await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    /// return o file
    return file;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: const Text('Upload Image'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Rendenizando button
              _buildButtonPickedImage(_loadAssets),

              /// Rendenizando o GridView
              buildGridView(),

              /// Rendenizando button
              _buildButtonSalveImage(_saveImage),
            ]),
      ),
    );
  }

  /// Contruindo o button para pegar imagens da galeria do device
  /// Este widget recebe uma function
  _buildButtonPickedImage(Function function) {
    return Container(
      margin: EdgeInsets.all(16.0),
      width: double.infinity,
      height: 60.0,
      color: Colors.grey[500],
      child: OutlinedButton(
          onPressed: () {
            function();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.upload,
                color: Colors.white,
              ),
              SizedBox(width: 16.0),
              Text(
                "Picked Image",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0,
                    color: Colors.white),
              )
            ],
          )),
    );
  }

  /// Construindo button salvar
  /// Este widget recebe uma function
  _buildButtonSalveImage(Function function) {
    return Container(
      margin: EdgeInsets.all(16.0),
      width: double.infinity,
      height: 60.0,
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ElevatedButton(
          onPressed: () {
            function();
          },
          child: Center(
            child: (isLoading == false
                ? Text(
                    "Salvar",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                  )
                : Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.white),
                  )),
          )),
    );
  }
}
