import 'dart:convert';

List<UserList> languageListFromJson(String str) =>
    List<UserList>.from(json.decode(str).map((x) => UserList.fromJson(x)));

String languageListToJson(List<UserList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserList {
  String id;
  String name;
  String contactNo;

  UserList({
    required this.id,
    required this.name,
    required this.contactNo,
  });

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        id: json["id"],
        name: json["name"],
        contactNo: json["contactNo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "contactNo": contactNo,
      };
}
