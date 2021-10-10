class People{
  final String firstname;
  final String lastname;
  final String email;

  People( this.firstname, this.lastname, this.email);

  People.fromJson(Map<dynamic, dynamic> json)
      :
        firstname = json['firstname'] as String,
  lastname = json['lastname'] as String,
  email = json['email'] as String;


  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'firstname': firstname,
    'lastname': lastname,
    'email': email,
  };


}