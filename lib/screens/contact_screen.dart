import 'package:contact_manager/constants/colors.dart';
import 'package:contact_manager/models/contact_manager.dart';
import 'package:contact_manager/screens/edit_contact_screen.dart';
import 'package:contact_manager/services/contact_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:lottie/lottie.dart';


class ProfilePage extends StatelessWidget {
  ProfilePage({
    required this.uid,
  });

  final String uid;

  TextStyle _style() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.fade,
    );
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.8;

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          uid: this.uid,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder<List<dynamic>>(
              future: getContact(this.uid),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var contact = snapshot.data[0];
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Name",
                          style: _style(),
                        ),
                        subtitle: Text(name(contact)),
                      ),
                      ListTile(
                        title: Text(
                          "Email",
                          style: _style(),
                        ),
                        subtitle: Text(email(contact)),
                      ),
                      ListTile(
                        title: Text(
                          "Gender",
                          style: _style(),
                        ),
                        subtitle: Text(gender(contact)),
                      ),
                      ListTile(
                        title: Text(
                          "Date of Birth",
                          style: _style(),
                        ),
                        subtitle: Text(DOB(contact)),
                      ),
                      ListTile(
                        title: Text(
                          "Phone number",
                          style: _style(),
                        ),
                        subtitle: Text(phone(contact)),
                      ),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  CustomAppBar({
    required this.uid,
  });

  final String uid;
  @override
  Size get preferredSize => Size(double.infinity, 320);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: FutureBuilder<List<dynamic>>(
          future: getContact(this.uid),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var contact = snapshot.data[0];
              return Container(
                padding: EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: kSecondaryColor,
                          blurRadius: 20,
                          offset: Offset(0, 0))
                    ]),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: kSecondaryColor,
                              maxRadius: 50,
                              child: Text(
                                initials(contact),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 40),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              name(contact),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 24),
                            )
                          ],
                        ),
                       isFavorite(contact)=="true"?Container(width:120,child: Lottie.asset("assets/lottie.json")):Container(width:120,child: Lottie.asset("assets/lottie2.json")),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return EditContactScreen(uid: id(contact));
                              //  return TextFormFieldExample();
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 24, 30, 0),
                          child: Transform.rotate(
                            angle: (math.pi * 0.06),
                            child: Container(
                              width: 110,
                              height: 32,
                              child: const Center(
                                child: Text("Edit Profile"),
                              ),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12, blurRadius: 20)
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(child: const CircularProgressIndicator());
            }
          }),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();

    p.lineTo(0, size.height - 70);
    p.lineTo(size.width, size.height);

    p.lineTo(size.width, 0);

    p.close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
