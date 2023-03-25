// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class MainFunction extends StatefulWidget {
//   const MainFunction({Key key,  this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MainFunction> createState() => _MainFunctionState();
// }

// class _MainFunctionState extends State<MainFunction> {
//   File file;
//   String prediction;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           children: [
//             Text(
//               prediction.toString(),
//               style: TextStyle(fontSize: 40),
//             ),
//             ElevatedButton(
//                 onPressed: () async {
//                   await uploadPDF(file);
//                 },
//                 child: const Text("Upload")),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           FilePickerResult result = await FilePicker.platform.pickFiles();

//           if (result != null) {
//             setState(() {
//               file = File(result.files.single.path.toString());
//             });
//             print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
//             print(file);
//           } else {
//             print("noooooooooooooooooooooooooooooo");
//             // User canceled the picker
//           }
//         },
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }

//   Future<void> uploadPDF(File file) async {
//     // Create a multipart request for the PDF file
//     print('k');
//     final uri = Uri.parse("http://10.0.2.2:5000/predict");

//     //10.0.2.2
//     print('enter');
//     final request = http.MultipartRequest("POST", uri);
//     final fileStream = http.ByteStream(file.openRead());
//     final length = await file.length();
//     final multipartFile = http.MultipartFile('file', fileStream, length,
//         filename: file.path.split("/").last);
//     request.files.add(multipartFile);

//     // Send the request
//     final response = await request.send();

//     // Parse the response
//     final responseData = await response.stream.toBytes();
//     final responseString = String.fromCharCodes(responseData);
//     print(responseString);
//     if (response.statusCode == 200) {
//       print("sucessssssssssssssssssssssssssssssssssssssssss");
//       setState(() {
//         prediction = responseString.toString();
//       });
//     } else {
//       print("faileeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeed");
//     }
//   }
// }



// // import 'dart:convert';
// // import 'package:http/http.dart' as http;

// // import 'package:flutter/material.dart';
// // import 'package:flutter/src/widgets/container.dart';
// // import 'package:flutter/src/widgets/framework.dart';
// // import 'package:flutter_application_1/func.dart';

// // class Home extends StatefulWidget {
// //   const Home({super.key});

// //   @override
// //   State<Home> createState() => _HomeState();
// // }

// // class _HomeState extends State<Home> {
// //   String url = '';
// //   var data;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           TextButton(
// //             onPressed: () async {
// //               url = 'http://10.0.2.2:5000/predict';
// //               data = await (fetchdata(url));
// //               print(data);
// //               print("Third");
// //             },
// //             child: const Center(child: Text('Predict')),
// //           ),
// //           Text(data.toString())
// //         ],
// //       ),
// //     );
// //   }
// // }
