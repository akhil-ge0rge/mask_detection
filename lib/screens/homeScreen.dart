import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              onPressed: () {},
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
              onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
