import 'package:contact_manager/constants/colors.dart';
import 'package:contact_manager/models/contact.dart';
import 'package:contact_manager/models/contact_manager.dart';
import 'package:contact_manager/screens/contact_list.dart';
import 'package:contact_manager/services/contact_services.dart';
import 'package:flutter/material.dart';

class EditContactScreen extends StatelessWidget {
  EditContactScreen({
    required this.uid,
  });

  final String uid;
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();
  TextEditingController _controller6 = TextEditingController();
  late String _firstName, _lastName, _email, _gender, _DOB, _phone;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text("Personal Information"),
        ),
        body: FutureBuilder<Object>(
            future: getContact(this.uid),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var contact = snapshot.data[0];
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                              labelText: name(contact).split(" ")[0],
                              hintText: "New first name *"),
                          onChanged: (value) {
                            _firstName = value;
                          },
                        ),
                        SizedBox(height: 30),
                        TextField(
                          controller: _controller2,
                          decoration: InputDecoration(
                            labelText: name(contact).split(" ")[1],
                            hintText: "new last name *",
                          ),
                          onChanged: (value) {
                            _lastName = value;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _controller3,
                          decoration: InputDecoration(
                              labelText: email(contact),
                              hintText: "new email *"),
                          onChanged: (value) {
                            _email = value;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          keyboardType: TextInputType.phone,
                          controller: _controller4,
                          decoration: InputDecoration(
                              labelText: phone(contact),
                              hintText: "new phone number *"),
                          onChanged: (value) {
                            _phone = value;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          controller: _controller5,
                          decoration: InputDecoration(
                              labelText: gender(contact),
                              hintText: "new gender *"),
                          onChanged: (value) {
                            _gender = value;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: _controller6,
                          decoration: InputDecoration(
                              labelText: DOB(contact),
                              hintText: "new date of birth "),
                          onChanged: (value) {
                            if( value.isEmpty){_DOB=DOB(contact);}else{_DOB = value;}

                          },
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kSecondaryColor,
                          ),
                          onPressed: () {
                            if (_controller.text.isEmpty ||
                                _controller2.text.isEmpty ||
                                _controller3.text.isEmpty ||
                                _controller4.text.isEmpty ||
                                _controller5.text.isEmpty ||
                                _controller6.text.isEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (_) => const AlertDialog(
                                    title: Text('Error'),
                                    content: Text(
                                        'All the blanks must be filled!'),
                                  ));
                            } else {
                              updateContact(this.uid, _firstName, _lastName,
                                  _email, _gender, _DOB, _phone)
                                  .whenComplete(() {
                                _controller.clear();
                                _controller2.clear();
                                _controller3.clear();
                                _controller4.clear();
                                _controller5.clear();
                                _controller6.clear();
                                FocusScope.of(context).requestFocus(FocusNode());
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      Future.delayed(Duration(milliseconds: 1100), () {
                                        Navigator.of(context).pop(true);
                                      });
                                      return const AlertDialog(
                                        title: Text('Done'),
                                        content: Text('Editing contact is successful!'),

                                      );
                                    });
                              });
                            }

                          },
                          child: Text("Submit"),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
