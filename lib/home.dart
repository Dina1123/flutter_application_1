import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/func.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String url = '';
  var data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
              url = 'http://10.0.2.2:5000/predict';
              data = await (fetchdata(url));
              print(data);
              print("0000000000000000000");
            },
            child: Text('Predict'),
          ),
          Text(data.toString())
        ],
      ),
    );
  }
}

fetchdata(String url) async {
  print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
  http.Response response = await http.get(Uri.parse(url));

  print("hhhhhhhhhhhhhhhhhfffffffffffffffffffffffffffhhhhhhhhhhhh");
  print(response.body);

  try {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
      // var new_output = json.decode(response.body);
      // var data = jsonDecode(response.body);
      // print(data);
    } else {
      print(response.body);
      return 'failed';
    }
  } catch (e) {
    print(response.body);
    return 'failed';
  }
  // print("hhhhhhhhhhhhhhhhhfffffffffffffffffffffffffffhhhhhhhhhhhh");
  // return response.body;
}
