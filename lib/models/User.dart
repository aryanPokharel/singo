class User {
  var id;
  var fullName;
  var email;
  var password;
  var phone;
  var dob;

  User(this.id, this.fullName, this.email, this.password, this.phone, this.dob);

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'email': email,
        'password': password,
        'phone': phone,
        'dob': dob,
      };
}
