import 'dart:convert';
import 'package:delayed_display/delayed_display.dart';

import 'package:contact_manager/constants/colors.dart';
import 'package:contact_manager/models/contact_manager.dart';
import 'package:contact_manager/screens/contact_list.dart';
import 'package:contact_manager/services/contact_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'contact_screen.dart';

final Uri restAPIURL =
    Uri.parse("https://mock-rest-api-server.herokuapp.com/api/v1/user/");

class FavoriteContacts extends StatefulWidget {
  @override
  _FavoriteContactsState createState() => _FavoriteContactsState();
}

class _FavoriteContactsState extends State<FavoriteContacts> {
  List favorites = [];
  Future<List<dynamic>> getFavorites() async {
    var result = await http.get(restAPIURL);
    var x = json.decode(result.body)['data'];
    favorites.clear();
    for (int i = 0; i < x.length; i++) {
      if (x[i]["isFavorite"] == "true") {
        favorites.add(x[i]["first_name"]);
      }
      ;
    }
    return favorites;
  }

  @override
  void initState() {
    super.initState();
    getFavorites();
    print(favorites);
  }

  void reorderData(int oldindex, int newindex) {
    setState(() {
      if (newindex > oldindex) {
        newindex -= 1;
      }
      final items = favorites.removeAt(oldindex);
      favorites.insert(newindex, items);
    });
  }

  void sorting() {
    setState(() {
      favorites.sort();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: const Text(
          "Favorite Contacts",
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Object>(
          future: getFavorites(),
          builder: (context, snapshot)  {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                  favorites.isNotEmpty
                    ? ReorderableListView(
                        children: <Widget>[
                          for (final items in favorites)
                            Card(
                              key: GlobalKey(),
                              elevation: 1,
                              child: ListTile(
                                title: Text(items),
                                leading: const Icon(
                                  Icons.favorite,
                                  color: kSecondaryColor,
                                ),
                              ),
                            ),
                        ],
                        onReorder: reorderData,
                      )
                    : DelayedDisplay(
                    delay: Duration(milliseconds: 1500),
                      child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "No favorite contacts are listed because no favorite contacts have been added yet.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Lottie.asset("assets/lottie2.json"),
                            const Text(
                              "You can add/remove them on the homepage.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                    ));
          }),
    );
  }
}


