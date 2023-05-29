import 'dart:convert';

List<UserList> languageListFromJson(String str) =>
    List<UserList>.from(json.decode(str).map((x) => UserList.fromJson(x)));

String languageListToJson(List<UserList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserList {
  String id;
  String name;
  String contactNo;
  String count;

  UserList({
    required this.id,
    required this.name,
    required this.contactNo,
    required this.count,
  });

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        id: json["id"],
        name: json["name"],
        contactNo: json["contactNo"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "contactNo": contactNo,
        "count": count,
      };
}
