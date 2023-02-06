// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/home.dart';

// void main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Home(),
//     );
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? file;
  String? prediction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(
              prediction.toString(),
              style: TextStyle(fontSize: 40),
            ),
            ElevatedButton(
                onPressed: () async {
                  //   postPDF(file);
                  await uploadPDF(file!);
                },
                child: const Text("Upload")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();

          if (result != null) {
            setState(() {
              file = File(result.files.single.path.toString());
            });
            print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
            print(file);
          } else {
            print("noooooooooooooooooooooooooooooo");
            // User canceled the picker
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> uploadPDF(File file) async {
    // Create a multipart request for the PDF file
    final uri = Uri.parse("http://10.0.2.2:5000/predict");
    final request = http.MultipartRequest("POST", uri);
    final fileStream = http.ByteStream(file.openRead());
    final length = await file.length();
    final multipartFile = http.MultipartFile('file', fileStream, length,
        filename: file.path.split("/").last);
    request.files.add(multipartFile);

    // Send the request
    final response = await request.send();

    // Parse the response
    final responseData = await response.stream.toBytes();
    final responseString = String.fromCharCodes(responseData);
    print(responseString);
    if (response.statusCode == 200) {
      print("sucessssssssssssssssssssssssssssssssssssssssss");
      setState(() {
        prediction = responseString.toString();
      });
    } else {
      print("faileeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeed");
      print(response.statusCode);
    }
  }
}

  // Future postPDF(Uint8List filename) async {
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse("http://192.168.43.242:5000/predict"));
  //   var file = await http.MultipartFile.fromBytes('file', filename);
  //   request.files.add(file);
  //   var response = await request.send();
  //   return response;
  // }

  // Future<void> uploadImage(file) async {
  // setState(() {
  //   showSpinner = true ;
  // });

//     var stream = http.ByteStream(file!.openRead());
//     stream.cast();

//     var length = await file!.length();

//     var uri = Uri.parse("http://10.0.2.2:5000/predict");

//     var request = http.MultipartRequest('POST', uri);

//     request.fields['file'] = "file";

//     var multiport = http.MultipartFile('file', stream, length);

//     request.files.add(multiport);

//     var response = await request.send();

//     print(response.toString());
//     if (response.statusCode == 200) {
//       print("yeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeees");
//       // setState(() {
//       //   showSpinner = false ;
//       // });
//       print('image uploaded');
//     } else {
//       print('failed');
//       print(response.statusCode);
//     }
//   }
// }

//   postRequestWithFile(String url, File file) async {
//     var request = http.MultipartRequest("POST", Uri.parse(url));
//     print("1");
//     var length = await file.length();
//     var stream = http.ByteStream(file.openRead());
//     var multipartFile = http.MultipartFile("file", stream, length);
//     print("2");
//     //     filename: basename(file.path));
//     // request.headers.addAll(myheaders) ;
//     request.files.add(multipartFile);

//     var myrequest = await request.send();
//     print("3");

//     var response = await http.Response.fromStream(myrequest);
//     print("4");
//     if (myrequest.statusCode == 200) {
//       print("yeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeees");
//       return jsonDecode(response.body);
//     } else {
//       print("Error ${myrequest.statusCode}");
//     }
//   }
// }
