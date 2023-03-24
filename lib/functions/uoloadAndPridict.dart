import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

class UploadAndPredict extends StatefulWidget {
  @override
  State<UploadAndPredict> createState() => _UploadAndPredictState();
}

class _UploadAndPredictState extends State<UploadAndPredict> {
  @override
  Widget build(BuildContext context) {
    File? file;
    String? prediction;
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
        }
            // saveCvAndPrediction();

            );
      } else {
        print("faileeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeed");
        print(response.statusCode);

        child:
        Text('Apply');
      }
    }

    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                setState(() {
                  file = File(result.files.single.path.toString());
                });
                uploadPDF(file!);

                print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                print(file);
              } else {
                print("noooooooooooooooooooooooooooooo");
                // User canceled the picker
              }
            },
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}
