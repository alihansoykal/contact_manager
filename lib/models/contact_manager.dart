String id(dynamic contact) {
  return contact['id'];
}

String name(dynamic contact) {
  return contact['first_name'] + " " + contact['last_name'];
}

String firstName(dynamic contact) {
  return contact['first_name'];
}

String lastName(dynamic contact) {
  return contact['last_name'];
}
String gender(dynamic contact) {
  return contact['gender'];
}

String email(dynamic contact) {
  return contact['email'];
}

String DOB(dynamic contact) {
  //return contact['date_of_birth'].toString().substring(0,2)+"/"+contact['date_of_birth'].toString().substring(2,4)+"/"+contact['date_of_birth'].toString().substring(4);
  //now it causes some errors, in the future it can be used.
  return contact['date_of_birth'].toString();
}

String phone(dynamic contact) {
  return "+" + contact['phone_no'];
}

String phoneNumber(dynamic contact) {
  return contact['phone_no'];
}

String initials(dynamic contact) {
  return contact['first_name'].toString().toUpperCase()[0] +
      contact['last_name'].toString().toUpperCase()[0];
}

String isFavorite(dynamic contact) {
  return contact["isFavorite"].toString();
}

