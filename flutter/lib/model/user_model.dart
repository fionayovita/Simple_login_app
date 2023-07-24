// ignore_for_file: prefer_single_quotes

import 'dart:convert';

List<ListUser> userModelFromJson(str) =>
    List<ListUser>.from(str.map((str) => ListUser.fromJson(str)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListUser {
  ListUser({
    required this.name,
    required this.fields,
  });

  String name;
  User fields;

  factory ListUser.fromJson(Map<String, dynamic> json) => ListUser(
        name: json['name'],
        fields: User.fromJson(json['fields']),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['fields'] = fields;

    return data;
  }
}

class User {
  User({
    required this.password,
    required this.nama,
    required this.email,
    required this.isverified,
  });

  Value password;
  Value nama;
  Value email;
  IsVerified isverified;

  factory User.fromJson(Map<String, dynamic> json) => User(
        password: Value.fromJson(json['password']),
        nama: Value.fromJson(json['nama']),
        email: Value.fromJson(json['email']),
        isverified: IsVerified.fromJson(json['isVerified']),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = password;
    data['nama'] = nama;
    data['email'] = email;
    data['isVerified'] = isverified;

    return data;
  }
}

class Value {
  Value({
    required this.value,
  });

  String? value;

  Value.fromJson(Map<String, dynamic> json) {
    value = json['stringValue'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stringValue'] = value;

    return data;
  }
}

class IsVerified {
  bool? booleanValue;

  IsVerified({this.booleanValue});

  IsVerified.fromJson(Map<String, dynamic> json) {
    booleanValue = json['booleanValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booleanValue'] = booleanValue;
    return data;
  }
}
