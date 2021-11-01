import 'package:mais_malas/models/imageModel.dart';

import '../imports.dart';

class MeusUploads extends StatefulWidget {
  const MeusUploads({Key? key}) : super(key: key);

  @override
  _MeusUploadsState createState() => _MeusUploadsState();
}

class _MeusUploadsState extends State<MeusUploads> {
  final imageController = ImageController();
  final urlBase = dotenv.env['URLBASEIMAGEN'].toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Uploads'),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: imageController.getAllImagenUploads(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<ImageModel> imagens = snapshot.data;
              return GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                children: List.generate(imagens.length, (index) {
                  return Image.network(
                    urlBase + imagens[index].diretorioImagen.toString(),
                    width: 300,
                    height: 300,
                  );
                }),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(backgroundColor: Colors.white),
                  SizedBox(height: 30.0),
                  Text(
                    "A carregar..",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
