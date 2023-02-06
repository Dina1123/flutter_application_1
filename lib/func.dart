
import 'dart:convert';

import 'package:http/http.dart' as http;

fetchdata(String url) async {
  print("first");
  http.Response response = await http.get(Uri.parse(url));

  print("Second");
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