import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_crud_practice_project/internationalization/messages.dart';
import 'package:sqflite_crud_practice_project/screens/add_task.dart';
import 'package:sqflite_crud_practice_project/features/home/screen/home.dart';
import 'package:sqflite_crud_practice_project/screens/update_task.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.blue,      // White background
          onPrimary: Colors.black,    // Black text on white
          secondary: Colors.blueGrey, // Optional: other colors
        ),
      ),

      ///routing

      // initialRoute: '/home',
      defaultTransition: Transition.fadeIn,

      getPages: [
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/add_task', page: () => AddTask()),
        GetPage(name: '/update_task', page: () => UpdateTask()),
      ],


      ///Internationalization
      translations: Messages(),
      locale: Locale('en', 'Us'),
      fallbackLocale: Locale('en', 'US'),


      home: const HomePage(),

    );
  }
}

