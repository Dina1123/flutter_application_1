import 'package:flutter/material.dart';
import 'package:flutter_application_1/Auth/login.dart';
import 'package:flutter_application_1/screens/addJob.dart';
import 'package:flutter_application_1/screens/jobDetails.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';

class Applications extends StatefulWidget {
  final String jobId;
  final String jobTitle;
  final String userName;

  Applications({this.jobId, this.jobTitle, this.userName});
  @override
  State<Applications> createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications>
    with TickerProviderStateMixin {
  bool isLoggedIn = false;
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'All Applications'),
            Tab(text: 'Best Matches'),
          ],
        )),
        body: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: TabBarView(
            controller: _tabController,
            children: [
              FutureBuilder(
                  future: getAllApplications(
                      widget.jobId), // A Future<String> to resolve
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data.length == 0) {
                      return Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image.asset(
                              //   'images/logo.png',
                              //   width: 150,
                              //   height: 150,
                              // ),
                              Text(
                                'Empty',
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      print('gggggggggggggggg' '${snapshot.data}');
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
                                      side: BorderSide(color: Colors.grey[300]),
                                    ),
                                    child: ListTile(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.userName.toString() == null
                                                ? "snapshot.data[index]['userName'].toString()"
                                                : snapshot.data[index]
                                                        ['userName']
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Roboto',
                                              color: Colors.blue[900],
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Column(
                                        children: [
                                          Text(
                                            snapshot.data[index]['category']
                                                        .toString() ==
                                                    null
                                                ? "snapshot.data[index]['userName'].toString()"
                                                : "This Cv is classified as :" +
                                                    snapshot.data[index]
                                                            ['category']
                                                        .toString(),
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Roboto',
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data[index]['createdAt']
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'Roboto',
                                              color: Colors.black,
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              viewCVFile(snapshot.data[index]
                                                      ['objectId']
                                                  .toString());
                                            },
                                            child: Text("See Cv"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }));
                    }
                  }),
              FutureBuilder(
                  future: getBestApplications(
                      widget.jobId.toString(),
                      widget.jobTitle
                          .toString()), // A Future<String> to resolve
                  builder: (BuildContext context, AsyncSnapshot bestsnapshot) {
                    if (bestsnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (bestsnapshot.hasError) {
                      return Center(
                          child: Text('Error: ${bestsnapshot.error}'));
                    } else if (!bestsnapshot.hasData ||
                        bestsnapshot.data.length == 0) {
                      print('lllll${bestsnapshot.data}');
                      return Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image.asset(
                              //   'images/logo.png',
                              //   width: 150,
                              //   height: 150,
                              // ),
                              Text(
                                'Empty',
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      print(bestsnapshot.data);
                      return Center(
                          child: ListView.builder(
                              itemCount: bestsnapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      side: BorderSide(color: Colors.grey[300]),
                                    ),
                                    child: ListTile(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            bestsnapshot.data[index]['userName']
                                                        .toString() ==
                                                    null
                                                ? "bestsnapshot.data[index]['userName'].toString()"
                                                : bestsnapshot.data[index]
                                                        ['userName']
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Roboto',
                                              color: Colors.blue[900],
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Column(
                                        children: [
                                          Text(
                                            "This Cv is classified as : " +
                                                        bestsnapshot.data[index]
                                                                ['category']
                                                            .toString() ==
                                                    null
                                                ? "bestsnapshot.data[index]['userName'].toString()"
                                                : bestsnapshot.data[index]
                                                        ['category']
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Roboto',
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            bestsnapshot.data[index]
                                                    ['createdAt']
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'Roboto',
                                              color: Colors.black,
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              viewCVFile(bestsnapshot
                                                  .data[index]['objectId']
                                                  .toString());
                                            },
                                            child: Text("See Cv"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }));
                    }
                  }),
            ],
          ),
        ));
  }

  Future<List<ParseObject>> getAllApplications(String jobId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ParseResponse apiResponse;

    try {
      QueryBuilder<ParseObject> queryJobs =
          QueryBuilder<ParseObject>(ParseObject('Applications'))
            ..whereEqualTo("jobId", jobId);
      apiResponse = await queryJobs.query();
    } catch (e) {
      print('Error while querying applications: $e');
      return [];
    }

    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results.cast<ParseObject>();
    } else {
      return [];
    }
  }

  Future<List<ParseObject>> getBestApplications(
      String JobId, String JobTitle) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Create a query to get applications with the job ID and category
    final applicationsTable = ParseObject('Applications');

    // Build query to retrieve applications for specified job and category
    final query = QueryBuilder<ParseObject>(applicationsTable)
      ..whereEqualTo('jobId', JobId)
      ..whereEqualTo('category', JobTitle);

    // Execute query and handle results
    final apiResponse = await query.query();
    if (apiResponse.success && apiResponse.results != null) {
      print('Results found: ${apiResponse.results.length}');
      return apiResponse.results;
    } else {
      print('No results found');
      print('jobId $JobId');
      print(JobTitle);

      if (apiResponse.error != null) {
        print('Error: ${apiResponse.error.message}');
      }
      return [];
    }
  }

  Future<void> viewCVFile(String objectId) async {
    final query = QueryBuilder<ParseObject>(ParseObject('Applications'))
      ..whereEqualTo('objectId', objectId)
      ..includeObject(['cvFile']);
    final apiResponse = await query.query();
    if (apiResponse.success && apiResponse.results != null) {
      final application = apiResponse.results.first;
      final cvFile = application.get<ParseFile>('cvFile');
      print('vvvvvvvvvvvvvvvvvvvvv$cvFile');
      final url = cvFile['url'];
      print('jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj$url');
      final response = await http.get(Uri.parse(url));
      final bytes = response.bodyBytes;
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/cv.pdf');
      await file.writeAsBytes(bytes);
      final pdfViewer = PDFView(
        filePath: file.path,
        autoSpacing: true,
        pageSnap: true,
        swipeHorizontal: true,
        onError: (error) => print('Error loading PDF: $error'),
      );
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => pdfViewer),
      );
    } else {
      print('Error retrieving application: ${apiResponse.error.message}');
    }
  }
}
