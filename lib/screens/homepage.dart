import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/addJob.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class HomePage extends StatelessWidget {
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
                          //   backgroundImage: AssetImage('assets/profile_pic.jpg'),
                          child: Icon(
                            Icons.account_circle,
                            size: 50,
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
                Card(
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
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.white),
                  title: Text(
                    'Logout',
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  onTap: () {},
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
                          return Card(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
}
