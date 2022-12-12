import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ssip_hackathon_2022/ani_care_page.dart';
import 'package:ssip_hackathon_2022/models/CasesModel.dart';
import 'package:ssip_hackathon_2022/widgets/Calender/Meeting_data_Sourse.dart';
import 'package:ssip_hackathon_2022/widgets/Calender/meeting_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SyncfusionCalender extends StatefulWidget {
  const SyncfusionCalender({super.key});

  @override
  State<SyncfusionCalender> createState() => _SyncfusionCalenderState();
}

class _SyncfusionCalenderState extends State<SyncfusionCalender> {
  List<Case_model> eventfromfirebase = AniCarePage.allcases;
  bool isThereAnyEvent = false;
  //for geeting the datasourse of meeting model or getting the events to be added in the calender
  List<MeetingModel> _getDataSourse() {
    final List<MeetingModel> meetings = <MeetingModel>[];
    final DateTime today = DateTime.now();

    for (int i = 0; i < eventfromfirebase.length; i++) {
      final DateTime starttime1 = DateTime(
          int.parse(eventfromfirebase[i].year),
          int.parse(eventfromfirebase[i].month),
          int.parse(eventfromfirebase[i].date),
          09,
          00);
      final DateTime starttime2 = DateTime(2022, 11, 24, 09, 00);
      meetings.add(
        MeetingModel(
            eventName:
                "${eventfromfirebase[i].animal}(${eventfromfirebase[i].breed})-${eventfromfirebase[i].place}",
            from: DateTime(
                starttime1.year, starttime1.month, starttime1.day, 09, 00),
            to: DateTime(
                starttime1.year, starttime1.month, starttime1.day, 11, 00),
            background: Colors
                .primaries[Random().nextInt(eventfromfirebase.length)].shade100,
            isAllDay: false),
      );
    }

    setState(() {
      isThereAnyEvent = meetings.isEmpty ? false : true;
    });
    return meetings;
  }

  CalendarView calendarview = CalendarView.month;
  CalendarController calendarcontroller = CalendarController();
  bool backcolorwhennotpressed1 = true;
  bool backcolorwhennotpressed2 = false;
  bool backcolorwhennotpressed3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.teal,
        label: const Text("Event"),
        icon: const Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Calendar",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                        backgroundColor: backcolorwhennotpressed1
                            ? MaterialStateProperty.all(
                                Colors.red.shade100.withOpacity(0.5))
                            : MaterialStateProperty.all(Colors.white),
                        elevation: backcolorwhennotpressed1
                            ? MaterialStateProperty.all(5)
                            : MaterialStateProperty.all(0),
                        side: backcolorwhennotpressed1
                            ? MaterialStateProperty.all(const BorderSide(
                                color: Colors.black,
                              ))
                            : null),
                    onPressed: () {
                      setState(() {
                        calendarview = CalendarView.month;
                        calendarcontroller.view = calendarview;
                        backcolorwhennotpressed1 = !backcolorwhennotpressed1;
                        backcolorwhennotpressed2 = false;
                        backcolorwhennotpressed3 = false;
                      });
                    },
                    child: const Text("Month View"),
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                        backgroundColor: backcolorwhennotpressed2
                            ? MaterialStateProperty.all(
                                Colors.red.shade100.withOpacity(0.5))
                            : MaterialStateProperty.all(Colors.white),
                        elevation: backcolorwhennotpressed2
                            ? MaterialStateProperty.all(5)
                            : MaterialStateProperty.all(0),
                        side: backcolorwhennotpressed2
                            ? MaterialStateProperty.all(const BorderSide(
                                color: Colors.black,
                              ))
                            : null),
                    onPressed: () {
                      setState(() {
                        calendarview = CalendarView.week;
                        calendarcontroller.view = calendarview;
                        backcolorwhennotpressed2 = !backcolorwhennotpressed2;
                        backcolorwhennotpressed1 = false;
                        backcolorwhennotpressed3 = false;
                      });
                    },
                    child: const Text("week View"),
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                        backgroundColor: backcolorwhennotpressed3
                            ? MaterialStateProperty.all(
                                Colors.red.shade100.withOpacity(0.5))
                            : MaterialStateProperty.all(Colors.white),
                        elevation: backcolorwhennotpressed3
                            ? MaterialStateProperty.all(5)
                            : MaterialStateProperty.all(0),
                        side: backcolorwhennotpressed3
                            ? MaterialStateProperty.all(const BorderSide(
                                color: Colors.black,
                              ))
                            : null),
                    onPressed: () {
                      setState(() {
                        calendarview = CalendarView.day;
                        calendarcontroller.view = calendarview;
                        backcolorwhennotpressed3 = !backcolorwhennotpressed3;
                        backcolorwhennotpressed1 = false;
                        backcolorwhennotpressed2 = false;
                      });
                    },
                    child: const Text("Day View"),
                  ),
                ],
              ),
              Expanded(
                child: Material(
                  elevation: 10,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: SfCalendar(
                    view: calendarview,
                    controller: calendarcontroller,
                    allowDragAndDrop: true,
                    allowAppointmentResize: true,
                    monthViewSettings: const MonthViewSettings(
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.indicator,
                      showAgenda: true,
                    ),
                    dataSource: MeetingDataSourse(_getDataSourse()),
                    initialSelectedDate: DateTime.now(),
                    headerHeight: MediaQuery.of(context).size.height * .075 > 75
                        ? 75
                        : MediaQuery.of(context).size.height * .075,
                    cellBorderColor: Colors.blue,
                    showNavigationArrow: true,
                    showDatePickerButton: true,
                    selectionDecoration: BoxDecoration(
                      color: Colors.red.shade200.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    headerStyle: const CalendarHeaderStyle(
                      textStyle: TextStyle(color: Colors.red, fontSize: 30),
                      //backgroundColor: Color.fromARGB(255, 200, 222, 239),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !isThereAnyEvent,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(bottom: 2, top: 2),
                      child: Image.asset(
                        'Assets/Images/Calender_ideal.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    const Positioned(
                      top: 10,
                      left: 0,
                      child: Text("It's All Clear. No Events Today.",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
