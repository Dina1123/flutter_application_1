import 'package:flutter/cupertino.dart'
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Auth/signUp.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../screens/home.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Auth/signUp.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../screens/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              //  child: Image.asset('assets/images/logo.png'),
            ),
            SizedBox(
              height: 32,
            ),
            Center(
              child: const Text('Login',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: controllerUsername,
              enabled: !isLoggedIn,
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  labelText: 'Email'),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: controllerPassword,
              enabled: !isLoggedIn,
              obscureText: true,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  labelText: 'Password'),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  EasyLoading.show(
                      status: "Loading...",
                      maskType: EasyLoadingMaskType.clear);

<<<<<<< HEAD
                  doUserLogin();
=======
<<<<<<< HEAD
                  doUserLogin();
=======
                  await doUserLogin();
>>>>>>> c3c95183268dd9ed59de5a81e8de26854e32d8fd
>>>>>>> 506770de86e18721f5ecba7a55d9dc2f4fca08c2
                },
                child: Text('LOGIN'),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 50,
              child: TextButton(
                  child: const Text('Don\'t have an account? Sign up now'),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (C) => SignUp()));
                  }),
            ),
          ],
        ),
      ),
    ));
  }

  void showSuccess(String message) {
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

  void doUserLogin() async {
    final username = controllerUsername.text.trim();
    final password = controllerPassword.text.trim();

    final user = ParseUser(username, password, null);

    var response = await user.login();

    if (response.success) {
      EasyLoading.dismiss();
      Navigator.push(context, MaterialPageRoute(builder: (c) => HomePage()));

<<<<<<< HEAD
      showSuccess("User was successfully login!");
=======
<<<<<<< HEAD
      showSuccess("User was successfully login!");
=======
      // showSuccess("User was successfully login!");
>>>>>>> c3c95183268dd9ed59de5a81e8de26854e32d8fd
>>>>>>> 506770de86e18721f5ecba7a55d9dc2f4fca08c2
      setState(() {
        isLoggedIn = true;
      });
    } else {
      EasyLoading.dismiss();

<<<<<<< HEAD
      showError(response.error!.message);
=======
<<<<<<< HEAD
      showError(response.error!.message);
=======
      showError(response.error.message);
>>>>>>> c3c95183268dd9ed59de5a81e8de26854e32d8fd
>>>>>>> 506770de86e18721f5ecba7a55d9dc2f4fca08c2
    }
  }

  void doUserLogout() async {
    final user = await ParseUser.currentUser() as ParseUser;
    var response = await user.logout();

    if (response.success) {
      showSuccess("User was successfully logout!");
      setState(() {
        isLoggedIn = false;
      });
    } else {
<<<<<<< HEAD
      showError(response.error!.message);
=======
<<<<<<< HEAD
      showError(response.error!.message);
=======
      showError(response.error.message);
>>>>>>> c3c95183268dd9ed59de5a81e8de26854e32d8fd
>>>>>>> 506770de86e18721f5ecba7a55d9dc2f4fca08c2
    }
  }
}
