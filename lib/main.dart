import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Auth/login.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:path_provider/path_provider.dart';

import 'Auth/signup.dart';

const String PARSE_APP_ID = 'rdJNq21nzykjAUl7JaWiT7mHpklnT82ylnNnUniL';
const String PARSE_APP_URL = 'https://parseapi.back4app.com';
const String MASTER_KEY = 'vxUkG7awLZkQ1LOu60gcw89x0VUr9DklOJFbTWcE';

void main() async {
  // Directory appDocDir = await getApplicationDocumentsDirectory();
  //String appDocPath = appDocDir.path;
  Parse().initialize(
    PARSE_APP_ID,
    PARSE_APP_URL,
    masterKey: MASTER_KEY,
    autoSendSessionId: true,
    debug: true,
    // coreStore: await CoreStoreSembastImp.getInstance(appDocPath + '/data'),
  );

  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskType = EasyLoadingMaskType.clear
    ..userInteractions = true
    ..dismissOnTap = false;

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        child = EasyLoading.init()(context, child);
        child = MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        ); // assuming this is returning a widget

        return child;
      },
      theme: myTheme,
      home: Login(),
    );
  }
}
