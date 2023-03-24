import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

<<<<<<< HEAD
import '../functions/uoloadAndPridict.dart';

=======
>>>>>>> c3c95183268dd9ed59de5a81e8de26854e32d8fd
class JobDetails extends StatefulWidget {
  final String jobTitle;
  final String jobDescription;
  final String posterName;
  final String date;
  final String jobId;

  const JobDetails(
<<<<<<< HEAD
      {required this.jobTitle,
      required this.jobDescription,
      required this.posterName,
      required this.date,
      required this.jobId});
=======
      {Key key,
      this.jobTitle,
      this.jobDescription,
      this.posterName,
      this.date,
      this.jobId})
      : super(key: key);
>>>>>>> c3c95183268dd9ed59de5a81e8de26854e32d8fd

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
<<<<<<< HEAD
  // File? file;
  // String? prediction;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
=======
  File file;
  String prediction;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Job Details'),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
>>>>>>> c3c95183268dd9ed59de5a81e8de26854e32d8fd
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.jobTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.jobDescription,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.date,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.posterName,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
<<<<<<< HEAD
          UploadAndPredict()
        ],
      ),
    );
=======
          TextButton(
              onPressed: () {
                uploadPDF(file);
              },
              child: Text("f")),
          Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        FilePickerResult result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          setState(() {
                            file = File(result.files.single.path.toString());
                          });
                          uploadPDF(file);

                          print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                          print(file);
                        } else {
                          print("noooooooooooooooooooooooooooooo");
                          // User canceled the picker
                        }
                      },
                      child: const Icon(Icons.add),
                    ), // This trailing comma makes auto-formatting nicer for build methods.
                  )))
        ]));
  }

  Future<void> uploadPDF(File file) async {
    // Create a multipart request for the PDF file
    final uri = Uri.parse("http://192.168.43.242:5000/predict");
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
>>>>>>> c3c95183268dd9ed59de5a81e8de26854e32d8fd
  }
}
