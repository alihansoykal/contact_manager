import 'package:contact_manager/constants/colors.dart';
import 'package:contact_manager/models/contact.dart';
import 'package:contact_manager/models/contact_manager.dart';
import 'package:contact_manager/services/contact_services.dart';
import 'package:flutter/material.dart';

class AddContactScreen extends StatelessWidget {
  const AddContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    TextEditingController _controller2 = TextEditingController();
    TextEditingController _controller3 = TextEditingController();
    TextEditingController _controller4 = TextEditingController();
    TextEditingController _controller5 = TextEditingController();
    TextEditingController _controller6 = TextEditingController();
    late String _firstName, _lastName, _email, _gender, _DOB, _phone;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          title: Text("Add a new Contact"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                TextField(
                  controller: _controller,
                  decoration: new InputDecoration(
                    hintText: "First Name",
                  ),
                  onChanged: (value) {
                    _firstName = value;
                  },
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _controller2,
                  decoration: new InputDecoration(
                    hintText: "Last Name",
                  ),
                  onChanged: (value) {
                    _lastName = value;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _controller3,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
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
                  decoration: const InputDecoration(
                    hintText: "Phone Number",
                  ),
                  onChanged: (value) {
                    _phone = value;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _controller5,
                  decoration: const InputDecoration(
                    hintText: "Gender",
                  ),
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
                  decoration: const InputDecoration(
                    hintText: "Date of Birth",
                  ),
                  onChanged: (value) {
                    _DOB = value;
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
                                content: Text('All the blanks must be filled!'),
                              ));
                    } else {
                      addContact(Contact(_firstName, _lastName, _email, _gender,
                          _DOB, _phone, "false"));
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
                              content: Text('Adding contact is successful!'),

                            );
                          });

                    }
                  },
                  child: Text("Submit"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
