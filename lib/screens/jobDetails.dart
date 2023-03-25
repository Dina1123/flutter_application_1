import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../functions/uoloadAndPridict.dart';

import '../functions/uoloadAndPridict.dart';


class JobDetails extends StatefulWidget {
  final String jobTitle;
  final String jobDescription;
  final String posterName;
  final String date;
  final String jobId;

  const JobDetails(
      { this.jobTitle,
       this.jobDescription,
       this.posterName,
       this.date,
       this.jobId});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
  // File? file;
  // String? prediction;

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


          UploadAndPredict()
        ],
      ),
    );
  }
}
