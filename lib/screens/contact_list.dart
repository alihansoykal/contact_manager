import 'dart:async';

import 'package:contact_manager/constants/colors.dart';
import 'package:contact_manager/screens/contact_screen.dart';
import 'package:contact_manager/services/contact_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/contact_manager.dart';
import 'add_contact_screen.dart';

class ContactList extends StatefulWidget {
  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          title: const Text(
            "Contact List",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: getAllContacts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var contact = snapshot.data[index];
                    return Card(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Slidable(
                            key: ValueKey(index),
                            startActionPane: ActionPane(
                              motion: const StretchMotion(),
                              dismissible: DismissiblePane(onDismissed: () {
                                deleteContact(id(contact));
                              }),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {},
                                  backgroundColor: Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Swipe more to delete',
                                ),
                              ],
                            ),
                            endActionPane: ActionPane(
                              motion: StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ProfilePage(uid: id(contact));
                                        },
                                      ),
                                    );
                                  },
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: 'Edit contact',
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: IconButton(
                                onPressed: () {
                                  print(isFavorite(contact));

                                  if (isFavorite(contact) == "true") {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: Text('Add to Favorites'),
                                          content: const Text(
                                              'Do you want to remove him/her to your favorites?'),
                                          actions: [
                                            ElevatedButton(
                                              style:
                                              ElevatedButton.styleFrom(
                                                primary: kFourthColor,
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("No"),
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton
                                                    .styleFrom(
                                                  primary: kSecondaryColor,
                                                ),
                                                child: Text("Yes"),
                                                onPressed: () {
                                                  updateFavorite(
                                                      id(contact), "false");
                                                  Navigator.pop(context);
                                                  Timer(
                                                      Duration(seconds: 1),
                                                          () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (_) =>
                                                                    ProfilePage(
                                                                        uid: id(
                                                                            contact)))).then(
                                                                (_) => setState(
                                                                    () {}));
                                                      });
                                                })
                                          ],
                                        ));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              title: Text('Add to Favorites'),
                                              content: const Text(
                                                  'Do you want to add him/her to your favorites?'),
                                              actions: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: kFourthColor,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("No"),
                                                ),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: kSecondaryColor,
                                                    ),
                                                    child: Text("Yes"),
                                                    onPressed: () {
                                                      updateFavorite(
                                                          id(contact), "true");
                                                      Navigator.pop(context);
                                                      Timer(
                                                          Duration(seconds: 1),
                                                          () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (_) =>
                                                                    ProfilePage(
                                                                        uid: id(
                                                                            contact)))).then(
                                                            (_) => setState(
                                                                () {}));
                                                      });
                                                    })
                                              ],
                                            ));
                                  }
                                },
                                icon: Icon(isFavorite(contact) == "true"
                                    ? Icons.star
                                    : Icons.star_border_outlined),
                              ),
                              /* leading: IconButton(
                                icon: Icon(favorite(contact) == null ? Icons.check_circle_outline : Icons.check_circle),
                                onPressed: () {
                                  update(contact);
                                },
                              ),*/

                              /* leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(snapshot.data[index]['picture']['large'])),*/
                              title: Text(name(contact)),
                              subtitle: Text(gender(contact)),
                              trailing: Text(phone(contact)),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
