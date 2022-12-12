// To parse this JSON data, do
//
//     final meetingModel = meetingModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/animation.dart';

List<MeetingModel> meetingModelFromJson(String str) => List<MeetingModel>.from(
    json.decode(str).map((x) => MeetingModel.fromJson(x)));

String meetingModelToJson(List<MeetingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MeetingModel {
  MeetingModel({
    this.id,
    required this.eventName,
    this.from,
    this.to,
    this.background = const Color(0xFF89CFF0),
    this.isAllDay = false,
  });

  String? id;
  String? eventName;
  DateTime? from;
  DateTime? to;
  Color? background;
  bool? isAllDay;

  factory MeetingModel.fromJson(Map<String, dynamic> json) => MeetingModel(
        id: json["id"],
        eventName: json["eventName"],
        from: DateTime.parse(json["from"]),
        to: DateTime.parse(json["to"]),
        background: json["background"],
        isAllDay: json["isAllDay"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "eventName": eventName,
        "from": from?.toIso8601String(),
        "to": to?.toIso8601String(),
        "background": background,
        "isAllDay": isAllDay,
      };
}
