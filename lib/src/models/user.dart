import 'dart:convert';

class User {
  final String? uuid, gender, firstName, lastName, street, city, email, picture;

  factory User.empty() {
    return User(
        uuid: "",
        firstName: "",
        lastName: "",
        gender: "",
        street: "",
        city: "",
        email: "",
        picture: "https://randomuser.me/api/portraits/women/83.jpg");
  }

  User({
    this.uuid,
    required this.firstName,
    required this.lastName,
    required this.gender,
    this.email,
    this.picture,
    this.street,
    this.city,
  });

  User copyWith({
    String? uuid,
    String? firstName,
    String? lastName,
    String? gender,
    String? picture,
    String? email,
    String? street,
    String? city,
  }) {
    return User(
      uuid: uuid ?? this.uuid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      street: street ?? this.street,
      city: city ?? this.city,
      picture: picture ?? this.picture,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'firstname': firstName,
      'lastname': lastName,
      'gender': gender,
      'email': email,
      'street': street,
      'city': city,
      'picture': picture
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        uuid: map['login']['uuid'] as String?,
        firstName: map['name']['first'] as String?,
        lastName: map['name']['last'] as String?,
        gender: map['gender'] as String?,
        email: map['email'] as String?,
        city: map['location']['city'] as String?,
        street: map['location']['street']['name'] as String?,
        picture: map['picture']['large'] as String?);
  }

  factory User.fromMapDatabase(Map<String, dynamic> map) {
    return User(
        uuid: map['uuid'] as String?,
        firstName: map['firstname'] as String?,
        lastName: map['lastname'] as String?,
        gender: map['gender'] as String?,
        email: map['email'] as String?,
        city: map['city'] as String?,
        street: map['street'] as String?,
        picture: map['picture'] as String?);
  }

  factory User.fromJsonDatabase(String source) {
    return User.fromMapDatabase(json.decode(source) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) {
    return User.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  @override
  String toString() =>
      'User(uuid:$uuid, firstName: $firstName, lastName: $lastName, street: $street, email: $email, gender: $gender, city: $city, picture: $picture)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.uuid == uuid &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.gender == gender &&
        other.city == city &&
        other.email == email &&
        other.picture == picture &&
        other.street == street;
  }

  @override
  int get hashCode =>
      firstName.hashCode ^
      lastName.hashCode ^
      gender.hashCode ^
      email.hashCode ^
      city.hashCode ^
      street.hashCode ^
      uuid.hashCode ^
      picture.hashCode;
}
