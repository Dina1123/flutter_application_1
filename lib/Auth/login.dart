import 'package:flutter/material.dart';
import 'package:flutter_application_1/Auth/signup.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Container(
              //   height: 200,
              //   child: Image.asset('images/logo.png'),
              // ),
              SizedBox(
                height: 32,
              ),
              Center(
                child: const Text('Login',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: controllerUsername,
                enabled: !isLoggedIn,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  labelText: 'UserName',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your username';
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
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
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your password';
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      EasyLoading.show(
                          status: "Loading...",
                          maskType: EasyLoadingMaskType.clear);

                      doUserLogin();
                    }
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userId", user.objectId.toString());
      prefs.setString("userName", user.username);
      print('here ${user.objectId})}');

      EasyLoading.dismiss();
      Navigator.push(context, MaterialPageRoute(builder: (c) => HomePage()));

      // showSuccess("User was successfully login!");
      setState(() {
        isLoggedIn = true;
      });
    } else {
      EasyLoading.dismiss();

      showError(response.error.message);
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
      showError(response.error.message);
    }
  }
}
