import 'package:flutter/material.dart';
import 'package:flutter_push_notification/src/app/screens/activity/activity_logs.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      themeMode: ThemeMode.system,

      debugShowCheckedModeBanner: false,
      home: ActivityScreen(),
    );
  }
}
