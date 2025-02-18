class User {
  String fName;
  String lName;
  int age;
  double salary;
  String email;

  User({
    required this.fName,
    required this.lName,
    required this.age,
    required this.salary,
    required this.email,
  });

  // factory constructor
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fName: json['firstName'],
      lName: json['lastName'],
      age: json['age'],
      salary: json['salary'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': fName,
      'lastName': lName,
      'age': age,
      'email': email,
      'salary': salary,
    };
  }
}
