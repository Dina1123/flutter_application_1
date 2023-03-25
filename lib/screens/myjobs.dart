import 'package:flutter/material.dart';
import 'package:flutter_application_1/Auth/login.dart';
import 'package:flutter_application_1/screens/addJob.dart';
import 'package:flutter_application_1/screens/jobDetails.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'applicatios.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';

class MyJobs extends StatefulWidget {
  @override
  State<MyJobs> createState() => _MyJobsState();
}

class _MyJobsState extends State<MyJobs> {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: FutureBuilder(
            future: getJobs(), // A Future<String> to resolve
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
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => Applications(
                                          jobId: snapshot.data[index]
                                              ['objectId'])));
                            },
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(color: Colors.grey.shade300),
                              ),
                              child: ListTile(
                                title: Text(
                                  snapshot.data[index]['title'],
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data[index]['requirements'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Open Sans',
                                          color: Colors.blueGrey[800],
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Posted by: ${snapshot.data[index]['posterName']}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Roboto',
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          Text(
                                            snapshot.data[index]['createdAt']
                                                .toString()
                                                .substring(0, 10),
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Roboto',
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }));
              }
            }));
  }

  Future<List<ParseObject>> getJobs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    QueryBuilder<ParseObject> queryJobs =
        QueryBuilder<ParseObject>(ParseObject('Jobs'))
          ..whereEqualTo("posterId", prefs.getString("userId"));
    final ParseResponse apiResponse = await queryJobs.query();

    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results as List<ParseObject>;
    } else {
      return [];
    }
  }
}
