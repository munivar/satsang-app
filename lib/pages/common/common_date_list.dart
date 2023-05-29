import 'dart:convert';

List<CommonDateList> languageListFromJson(String str) =>
    List<CommonDateList>.from(
        json.decode(str).map((x) => CommonDateList.fromJson(x)));

String languageListToJson(List<CommonDateList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommonDateList {
  String id;
  String date;
  String count;

  CommonDateList({
    required this.id,
    required this.date,
    required this.count,
  });

  factory CommonDateList.fromJson(Map<String, dynamic> json) => CommonDateList(
        id: json["id"],
        date: json["date"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "count": count,
      };
}
