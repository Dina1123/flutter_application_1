// import 'dart:convert';

// import 'package:http/http.dart' as http;

// Future<dynamic> fetchdata(String url) async {
//   print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
//   http.Response response = await http.get(Uri.parse(url));

//   print("hhhhhhhhhhhhhhhhhfffffffffffffffffffffffffffhhhhhhhhhhhh");
//   print(response.body);

//   try {
//     if (response.statusCode == 200) {
//       // var new_output = json.decode(response.body);
//       // var data = jsonDecode(response.body);
//       // print(data);
//       print(response.body);
//       return response.body;
//     } else {
//       print(response.body);
//       return 'failed';
//     }
//   } catch (e) {
//     print(response.body);
//     return 'failed';
//   }
//   // print("hhhhhhhhhhhhhhhhhfffffffffffffffffffffffffffhhhhhhhhhhhh");
//   // return response.body;
// }
