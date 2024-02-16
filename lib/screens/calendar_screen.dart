import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';

import '../model/termin.dart';

class CalendarScreen extends StatefulWidget {
  final List<Termin> termini;

  const CalendarScreen({super.key, required this.termini});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<Event> _makeEvents() {
    List<Event> events = [];
    for (int i = 0; i < widget.termini.length; i++) {
      Termin termin = widget.termini[i];
      String text = termin.name + " " + termin.time;
      int year =int.parse(termin.date.substring(6, 10)) ; //02.02.2023
      int month =int.parse( termin.date.substring(3, 5));
      int day =int.parse( termin.date.substring(0, 2));
      Event event = Event(
          child: Text(text),
          dateTime: CalendarDateTime(
              year: year,
              month: month,
              day: day,
              calendarType: CalendarType.GREGORIAN));
      events.add(event);
    }
    return events;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar "),
        actions: [], //buttons
      ),
      body: EventCalendar(
        calendarType: CalendarType.GREGORIAN,
        // calendarLanguage: 'fa',
        events: _makeEvents()
      ),
    );
  }
}
