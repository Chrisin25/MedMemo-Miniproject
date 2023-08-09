import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notification.dart';

class Event {
  final String title;
  final String description;
  final TimeOfDay time;
  

  Event({
    required this.title,
    required this.description,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'time': DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, time.hour, time.minute).toString(),
    };
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      description: json['description'],
      time: TimeOfDay.fromDateTime(DateTime.parse(json['time'])),
    );
  }
}

class AppointmentsPage extends StatefulWidget {
  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Event> _selectedEvents = [];
  TextEditingController _eventTitleController = TextEditingController();
  TextEditingController _eventDescriptionController = TextEditingController();
  TimeOfDay? _eventTime;
  Map<DateTime, List<Event>> _events = {};
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    prefsData();
  }

  void prefsData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<Event>>.from(
        decodeMap(json.decode(_prefs!.getString("events") ?? "{}")),
      );
    });
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    return map.map(
      (key, value) => MapEntry(DateTime.parse(key), List<Event>.from(value.map((e) => Event.fromJson(e)))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MedMemo'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 20),
            lastDay: DateTime.utc(2040, 10, 20),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedEvents = _events[selectedDay] ?? [];
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Appointments',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedEvents.length,
              itemBuilder: (context, index) {
                final event = _selectedEvents[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    title: Text(event.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event.description),
                        Text('Time: ${event.time.format(context)}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _selectedEvents.removeAt(index);
                          _events[_selectedDay!] = _selectedEvents;
                          _prefs!.setString("events", json.encode(encodeMap(_events)));
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddDialog(context);
        },
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    TimeOfDay t=TimeOfDay.now();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Event"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _eventTitleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _eventDescriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              child: Text(_eventTime == null ? 'Select Time' : _eventTime!.format(context)),
              onPressed: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((value) {
                  setState(() {
                    _eventTime = value;
                    t=value??TimeOfDay.now();
                  });
                });
              },
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () async{
              if (_eventTitleController.text.isNotEmpty && _eventDescriptionController.text.isNotEmpty && _eventTime != null) {
                final event = Event(
                  title: _eventTitleController.text,
                  description: _eventDescriptionController.text,
                  time: _eventTime!,
                );
                setState((){
                  _selectedEvents.add(event);
                  _events[_selectedDay!] = _selectedEvents;
                  _prefs!.setString("events", json.encode(encodeMap(_events)));
                });
                
                await scheduleappnotification(t);
                _eventTitleController.clear();
                _eventDescriptionController.clear();
                _eventTime = null;
                
                Navigator.pop(context);
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> encodeMap(Map<DateTime, List<Event>> map) {
    return map.map(
      (key, value) => MapEntry(key.toString(), value.map((e) => e.toJson()).toList()),
    );
  }
}
