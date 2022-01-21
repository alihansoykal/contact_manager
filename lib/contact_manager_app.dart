import 'package:contact_manager/navigation/nav_bar.dart';
import 'package:flutter/material.dart';

class ContactManagerApp extends StatelessWidget {
  const ContactManagerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: "Contact Manager",
        debugShowCheckedModeBanner: false,
        home: BottomNavigation(),
    );
  }
}
