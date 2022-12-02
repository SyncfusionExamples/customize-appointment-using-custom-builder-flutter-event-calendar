import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(const AppointmentBuilder());

class AppointmentBuilder extends StatelessWidget{
  const AppointmentBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
            child: SfCalendar(
              view: CalendarView.week,
              allowedViews: const <CalendarView>[
                CalendarView.day,
                CalendarView.workWeek,
                CalendarView.week,
                CalendarView.month,
                CalendarView.timelineDay,
                CalendarView.timelineWeek,
                CalendarView.timelineWorkWeek,
                CalendarView.timelineMonth,
                CalendarView.schedule
              ],
              dataSource: _getCalendarDataSource(),
              monthViewSettings: const MonthViewSettings(showAgenda: true),
              timeSlotViewSettings:
              const TimeSlotViewSettings(timelineAppointmentHeight: 100),
              appointmentBuilder: appointmentBuilder,
            )),
      ),
    );
  }

  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];

    DateTime date = DateTime.now();

    appointments.add(Appointment(
      startTime: DateTime(
        date.year,
        date.month,
        date.day,
        7,
        0,
        0,
      ),
      endTime: DateTime(date.year, date.month, date.day, 11, 0, 0),
      subject: 'Meeting',
      color: Colors.pink,
    ));
    return _AppointmentDataSource(appointments);
  }

  Widget appointmentBuilder(BuildContext context,
      CalendarAppointmentDetails calendarAppointmentDetails) {
    final Appointment appointment =
        calendarAppointmentDetails.appointments.first;
    return Column(
      children: [
        Container(
            width: calendarAppointmentDetails.bounds.width,
            height: calendarAppointmentDetails.bounds.height / 2,
            color: appointment.color,
            child: const Center(
              child: Icon(
                Icons.group,
                color: Colors.black,
              ),
            )),
        Container(
          width: calendarAppointmentDetails.bounds.width,
          height: calendarAppointmentDetails.bounds.height / 2,
          color: appointment.color,
          child: Text(
            '${appointment.subject}${DateFormat(' (hh:mm a').format(appointment.startTime)}-${DateFormat('hh:mm a)').format(appointment.endTime)}',
            textAlign: TextAlign.center,style: const TextStyle(fontSize: 10),
          ),
        )
      ],
    );
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}