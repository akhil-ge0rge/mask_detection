import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //============================================================================
  bool _loading = true;
  late File _image;
  final imagepicker = ImagePicker();
  List _predictions = [];
  @override
  void initState() {
    super.initState();
    loadModel();
  }

//============================================================================

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  detect_image(File image) async {
    var prediction = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _loading = false;
      _predictions = prediction!;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  _loadimage_gallery() async {
    var image = await imagepicker.pickImage(source: ImageSource.gallery);
    if (Image == null) {
      return null;
    } else {
      _image = File(image!.path);
    }
    detect_image(_image);
  }

  _loadimage_camera() async {
    var image = await imagepicker.pickImage(source: ImageSource.camera);
    if (Image == null) {
      return null;
    } else {
      _image = File(image!.path);
    }
    detect_image(_image);
  }

  //============================================================================
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x303030),
        elevation: 0,
        title: Text(
          "Mask Detection",
          style: GoogleFonts.roboto(),
        ),
      ),
      body: Container(
        width: width,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              height: 200,
              width: 200,
              child: Image.asset('assets/mask.png'),
            ),
            Text(
              "Mask Detection",
              style:
                  GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.camera,
                color: Color.fromARGB(255, 37, 37, 37),
              ),
              onPressed: () {
                _loadimage_camera();
              },
              label: const Text(
                "Capture",
                style: TextStyle(
                  color: Color.fromARGB(255, 37, 37, 37),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[400],
                fixedSize: Size(225, 30),
                textStyle: TextStyle(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.upload_file,
                color: Color.fromARGB(255, 37, 37, 37),
              ),
              onPressed: () {
                _loadimage_gallery();
              },
              label: const Text(
                "Upload",
                style: TextStyle(
                  color: Color.fromARGB(255, 37, 37, 37),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[400],
                fixedSize: const Size(225, 30),
                textStyle: const TextStyle(),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            _loading == false
                ? Container(
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: 180,
                          child: Image.file(_image),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          _predictions[0]['label']
                              .toString()
                              .substring(2)
                              .toUpperCase(),
                          style:
                              GoogleFonts.roboto(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
