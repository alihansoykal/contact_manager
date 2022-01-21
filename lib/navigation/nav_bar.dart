import 'package:contact_manager/constants/colors.dart';
import 'package:contact_manager/screens/add_contact_screen.dart';
import 'package:contact_manager/screens/contact_list.dart';
import 'package:contact_manager/screens/favorite_contacts.dart';
import 'package:contact_manager/screens/search_contact_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

const _kPages = <String, IconData>{
  'home': Icons.home,
  'search': Icons.search,
  'people': Icons.people,
};

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedPage = 0;
  final _pageOptions = [
    ContactList(),
    SearchContactScreen(),
    AddContactScreen(),
    FavoriteContacts(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[selectedPage],
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icon(Icons.home,color: Colors.white,)),
          TabItem(
            icon: Icon(Icons.search,color: Colors.white,),
          ),
          TabItem(
            icon: Icon(Icons.add,color: Colors.white,),
          ),

          TabItem(
            icon: Icon(Icons.people,color: Colors.white,),
          ),
        ],
        activeColor: kSecondaryColor,
        backgroundColor: kPrimaryColor,
        onTap: (int i) {
          setState(() {
            selectedPage = i;
          });
        },
      ),
    );
  }
}
