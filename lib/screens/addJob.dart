import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
<<<<<<< HEAD

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'home.dart';

=======
<<<<<<< HEAD

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'home.dart';

=======
import 'package:flutter_application_1/screens/homepage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

>>>>>>> c3c95183268dd9ed59de5a81e8de26854e32d8fd
>>>>>>> 506770de86e18721f5ecba7a55d9dc2f4fca08c2
class AddJobPage extends StatefulWidget {
  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _jobRequirementsController =
      TextEditingController();
  final TextEditingController _posterNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Job'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _jobTitleController,
                  decoration: InputDecoration(
                    labelText: 'Job Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                  ),
<<<<<<< HEAD
                  validator: (String? value) {
                    if (value!.isEmpty) {
=======
<<<<<<< HEAD
                  validator: (String? value) {
                    if (value!.isEmpty) {
=======
                  validator: (String value) {
                    if (value.isEmpty) {
>>>>>>> c3c95183268dd9ed59de5a81e8de26854e32d8fd
>>>>>>> 506770de86e18721f5ecba7a55d9dc2f4fca08c2
                      return 'Please enter a job title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                TextFormField(
                  controller: _jobRequirementsController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Job Requirements',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                  ),
<<<<<<< HEAD
                  validator: (String? value) {
                    if (value!.isEmpty) {
=======
<<<<<<< HEAD
                  validator: (String? value) {
                    if (value!.isEmpty) {
=======
                  validator: (String value) {
                    if (value.isEmpty) {
>>>>>>> c3c95183268dd9ed59de5a81e8de26854e32d8fd
>>>>>>> 506770de86e18721f5ecba7a55d9dc2f4fca08c2
                      return 'Please enter job requirements';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                TextFormField(
                  controller: _posterNameController,
                  decoration: InputDecoration(
                    labelText: 'Poster Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                  ),
<<<<<<< HEAD
                  validator: (String? value) {
                    if (value!.isEmpty) {
=======
<<<<<<< HEAD
                  validator: (String? value) {
                    if (value!.isEmpty) {
=======
                  validator: (String value) {
                    if (value.isEmpty) {
>>>>>>> c3c95183268dd9ed59de5a81e8de26854e32d8fd
>>>>>>> 506770de86e18721f5ecba7a55d9dc2f4fca08c2
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
<<<<<<< HEAD
                      if (_formKey.currentState!.validate()) {
=======
<<<<<<< HEAD
                      if (_formKey.currentState!.validate()) {
=======
                      if (_formKey.currentState.validate()) {
>>>>>>> c3c95183268dd9ed59de5a81e8de26854e32d8fd
>>>>>>> 506770de86e18721f5ecba7a55d9dc2f4fca08c2
                        EasyLoading.show(
                            status: "Loading...",
                            maskType: EasyLoadingMaskType.clear);
                        await addJob();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Submit', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addJob() async {
    final job = ParseObject('Jobs')
      ..set('title', _jobTitleController.text)
      ..set('requirements', _jobRequirementsController.text)
      ..set('posterName', _posterNameController.text);
    var res = await job.save();
    if (res.success) {
      EasyLoading.dismiss();
      Navigator.push(context, MaterialPageRoute(builder: (c) => HomePage()));
    }
  }
}
