import 'package:flutter/material.dart';
import 'package:flutter_application_1/Auth/login.dart';
import 'package:flutter_application_1/screens/addJob.dart';
import 'package:flutter_application_1/screens/jobDetails.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => AddJobPage()));
            },
            label: Text('Add job')),
        drawer: Drawer(
          child: Container(
            //  color: Colors.blue[900],
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: 200,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          //   backgroundImage: AssetImage('assets/profile_pic.jpg'),
                          child: Icon(
                            Icons.account_circle,
                            color: Colors.blue[900],
                            size: 100,
                          ),
                        ),
                        Text(
                          'John Doe',
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          'johndoe@example.com',
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                                color: Colors.black,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.home, color: Colors.black),
                      title: Text(
                        'Home',
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.account_circle, color: Colors.black),
                    title: Text(
                      'Profile',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    onTap: () {},
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.settings, color: Colors.black),
                    title: Text(
                      'Settings',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    onTap: () {},
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.logout, color: Colors.black),
                    title: Text(
                      'Logout',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    onTap: () {
                      EasyLoading.show(status: "Logging out");
                      doUserLogout();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
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
                                      builder: (c) => JobDetails(
                                          jobTitle: snapshot.data[index]
                                              ['title'],
                                          jobDescription: snapshot.data[index]
                                              ['requirements'],
                                          posterName: snapshot.data[index]
                                              ['posterName'],
                                          date: snapshot.data[index]
                                                  ['createdAt']
                                              .toString(),
                                          jobId: snapshot.data[index]
                                              ['objectId'])));
                            },
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(color: Colors.grey[300]),
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
    QueryBuilder<ParseObject> queryJobs =
        QueryBuilder<ParseObject>(ParseObject('Jobs'));
    final ParseResponse apiResponse = await queryJobs.query();

    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results as List<ParseObject>;
    } else {
      return [];
    }
  }

  void doUserLogout() async {
    final user = await ParseUser.currentUser() as ParseUser;
    var response = await user.logout();

    if (response.success) {
      EasyLoading.dismiss();
      showSuccess("User was successfully logout!");
      Navigator.push(context, MaterialPageRoute(builder: (C) => Login()));
      setState(() {
        isLoggedIn = false;
      });
    } else {
      showError(response.error.message);
    }
  }

  void showSuccess(
    String message,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: Text(message),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
