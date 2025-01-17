import 'dart:convert';

class UserModel {
  final String firstname;
  final String id;
  final String lastname;
  final String dob;
  final String email;

  UserModel(
      {required this.firstname,
      required this.lastname,
      required this.id,
      required this.dob,
      required this.email});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'firstname': firstname});
    result.addAll({'lastname': lastname});
    result.addAll({'dob': dob});
    result.addAll({'email': email});
    result.addAll({'_id': id});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstname: map['firstname'] ?? '',
      id: map['_id'] ?? '',
      lastname: map['lastname'] ?? '',
      dob: map['dob'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.dob == dob &&
        other.id == id &&
        other.email == email;
  }

  @override
  int get hashCode {
    return firstname.hashCode ^
        lastname.hashCode ^
        id.hashCode ^
        dob.hashCode ^
        email.hashCode;
  }
}
