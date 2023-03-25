import 'package:flutter/material.dart';
import 'package:flutter_application_1/Auth/login.dart';
import 'package:flutter_application_1/screens/addJob.dart';
import 'package:flutter_application_1/screens/jobDetails.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';

class Applications extends StatefulWidget {
  final String jobId;

  const Applications({this.jobId});
  @override
  State<Applications> createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: FutureBuilder(
            future: getApplications(), // A Future<String> to resolve
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Center(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(color: Colors.grey.shade300),
                              ),
                              child: ListTile(
                                title: Text(
                                  snapshot.data[index]['objectId'],
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    color: Colors.blue[900],
                                  ),
                                ),
                                subtitle: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey[200],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }));
              }
            }));
  }

  Future<List<ParseObject>> getApplications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    QueryBuilder<ParseObject> queryJobs =
        QueryBuilder<ParseObject>(ParseObject('Applications'))
          ..whereEqualTo("jobId", widget.jobId);
    final ParseResponse apiResponse = await queryJobs.query();

    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results as List<ParseObject>;
    } else {
      return [];
    }
  }
}
