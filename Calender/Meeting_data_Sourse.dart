import 'dart:ui';

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'meeting_model.dart';

class MeetingDataSourse extends CalendarDataSource {
  MeetingDataSourse(List<MeetingModel> sourse) {
    appointments = sourse;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getendTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
