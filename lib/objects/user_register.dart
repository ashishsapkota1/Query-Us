class User {
  int id;
  String firstName;
  String lastName;
  String middleName;
  String email;
  String password;
  String confirmPassword;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      this.middleName = '',
      required this.email,
      required this.password,
      required this.confirmPassword});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        middleName: json['middleName'],
        email: json['email'],
        password: json['password'],
        confirmPassword: json['confirmPassword']);
  }

  Map<String,dynamic> toJson() => {
    'firstName' : firstName,
    'lastName' : lastName,
    'middleName' : middleName,
    'email' : email,
    'password' : password,
    "confirmPassword" : confirmPassword,
  };
}


