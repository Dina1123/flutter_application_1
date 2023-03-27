import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

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
  String _chosenValue;

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
                DropdownButton<String>(
                  underline: Container(),
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 18,
                  ),
                  value: _chosenValue,
                  isExpanded: true,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  items: ['Data Science', 'DevOps Engineer', 'Web Designing']
                      .map<DropdownMenuItem<String>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          // fontSize: getFontSize(
                          //   15,
                          // ),
                          fontFamily: 'Circular Std',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    "Job Title",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      // fontSize: getFontSize(
                      //   15,
                      // ),
                      fontFamily: 'Circular Std',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _chosenValue = value;
                    });
                  },
                ),
                // TextFormField(
                //   controller: _jobTitleController,
                //   decoration: InputDecoration(
                //     labelText: 'Job Title',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //       borderSide: BorderSide(),
                //     ),
                //   ),
                //   validator: (String value) {
                //     if (value.isEmpty) {
                //       return 'Please enter a job title';
                //     }
                //     return null;
                //   },
                // ),
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
                  validator: (String value) {
                    if (value.isEmpty) {
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
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
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
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final job = ParseObject('Jobs')
      // ..set('title', _jobTitleController.text)
      ..set('title', _chosenValue)
      ..set('requirements', _jobRequirementsController.text)
      ..set('posterId', prefs.getString("userId"))
      ..set('posterName', _posterNameController.text);
    var res = await job.save();
    if (res.success) {
      print(prefs.getString('userId'));
      EasyLoading.dismiss();
      Navigator.push(context, MaterialPageRoute(builder: (c) => HomePage()));
    }
  }
}
