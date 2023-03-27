// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../functions/uoloadAndPridict.dart';

// import '../functions/uoloadAndPridict.dart';

// class JobDetails extends StatefulWidget {
//   final String jobTitle;
//   final String jobDescription;
//   final String posterName;
//   final String date;
//   final String jobId;

//   const JobDetails(
//       { this.jobTitle,
//        this.jobDescription,
//        this.posterName,
//        this.date,
//        this.jobId});

//   @override
//   State<JobDetails> createState() => _JobDetailsState();
// }

// class _JobDetailsState extends State<JobDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Job Details'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//   // File? file;
//   // String? prediction;

//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               widget.jobTitle,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               widget.jobDescription,
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               widget.date,
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               widget.posterName,
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//           ),

//           UploadAndPredict()
//         ],
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobDetails extends StatefulWidget {
  final String jobTitle;
  final String jobDescription;
  final String posterName;
  final String date;
  final String jobId;

  const JobDetails(
      {Key key,
      this.jobTitle,
      this.jobDescription,
      this.posterName,
      this.date,
      this.jobId})
      : super(key: key);

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  File file;
  String prediction;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.jobTitle,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.description),
                  SizedBox(width: 8),
                  Text(
                    widget.jobDescription,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.calendar_today),
                  SizedBox(width: 8),
                  Text(
                    widget.date,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 8),
                  Text(
                    widget.posterName,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {
                  FilePickerResult result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    setState(() {
                      file = File(result.files.single.path);
                    });
                    EasyLoading.show(status: 'Loading');

                    uploadPDF(file);
                  } else {
                    print("User canceled the picker");
                  }
                },
                child: Text("Apply Now"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
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
    final responseStringWithoutQuotes =
        responseString.replaceAll('"', '').replaceAll("'", "");
    print(responseStringWithoutQuotes);
    if (response.statusCode == 200) {
      EasyLoading.showSuccess('Success!');
      print("sucessssssssssssssssssssssssssssssssssssssssss");
      setState(() {
        prediction = responseStringWithoutQuotes;
      });
      await saveCvAndPrediction();
    } else {
      print("faileeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeed");
      print(response.statusCode);
    }
  }

  saveCvAndPrediction() async {
    ParseFileBase fileBase = ParseFile(file);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var application = ParseObject('Applications')
      ..set('category', prediction)
      ..set('jobId', widget.jobId)
      ..set('jobTitle', widget.jobTitle)
      ..set("userName", prefs.getString("userName"))
      ..set('cvFile', fileBase);
    await application.save();
  }
}
