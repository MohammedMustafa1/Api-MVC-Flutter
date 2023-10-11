import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SeventhApi extends StatefulWidget {
  const SeventhApi({super.key});

  @override
  State<SeventhApi> createState() => _SeventhApiState();
}

class _SeventhApiState extends State<SeventhApi> {

  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  Future getImage()async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if(pickedFile!= null){
      image = File(pickedFile.path);
      setState(() {

      });
    }else{
      print('No image selected');
    }
  }

  Future<void> uploadImage()async{
    setState(() {
      showSpinner= true;
    });

    var stream = new http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');
    var request = new http.MultipartRequest('POST', uri);
    request.fields['title'] = "Static title";
    var multiport = new http.MultipartFile('image', stream, length);
    request.files.add(multiport);
    var response = await request.send();

    print(response.stream.toString());
    if(response.statusCode==200){
      print('image uploaded');
      setState(() {
        showSpinner= false;
      });
    }else{
      print('failed');
      setState(() {
        showSpinner= false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seventh Api'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              getImage();
            },
            child: Container(
              child: image == null ? const Center(child: Text('Pick Image'),)
              : Center(child: Image.file(File(image!.path).absolute,height: 100,width: 100,fit: BoxFit.cover,),)
            ),
          ),
          const SizedBox(height: 20,),
          GestureDetector(
            onTap: (){
              uploadImage();
            },
            child: Container(
              height: 50,
              width: 200,
              color: Colors.green,
              child: const Center(child: Text('Upload')),
            ),
          ),
        ],
      ),
    );
  }
}
