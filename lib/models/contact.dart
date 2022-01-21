class Contact {
  final String first_name;
  final String last_name;
  final String email;
  final String gender;
  final String date_of_birth;
  final String phone_no;
  final String isFavorite;

  Contact(this.first_name, this.last_name, this.email, this.gender,this.date_of_birth,this.phone_no,this.isFavorite);

  Map toJson() => {
    'first_name': first_name,
    'last_name': last_name,
    "email":email,
    "gender": gender,
    "date_of_birth":date_of_birth,
    "phone_no":phone_no,
    "isFavorite":"false",
  };
}