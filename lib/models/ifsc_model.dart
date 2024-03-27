// To parse this JSON data, do
//
//     final ifscModel = ifscModelFromJson(jsonString);

import 'dart:convert';

IfscModel ifscModelFromJson(String str) => IfscModel.fromJson(json.decode(str));

String ifscModelToJson(IfscModel data) => json.encode(data.toJson());

class IfscModel {
    String branch;
    String city;
    String bank;
    String ifsc;

    IfscModel({
        required this.branch,
        required this.city,
        required this.bank,
        required this.ifsc,
       });

    factory IfscModel.fromJson(Map<String, dynamic> json) => IfscModel(
        //micr: json["MICR"],
        branch: json["BRANCH"],
        city: json["CITY"],
        bank: json["BANK"],
        ifsc: json["IFSC"],
    );

    Map<String, dynamic> toJson() => {
        //"MICR": micr,
        "BRANCH": branch,
        "CITY": city,
        "BANK": bank,
        "IFSC": ifsc,
    };
}
