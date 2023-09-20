import 'package:flutter/material.dart';
import 'package:repair_pal/HomePage/workers/worker_profile/components/appointment_success.dart';
import 'package:repair_pal/constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'dart:convert';

class BookingPage extends StatefulWidget {
  final String workerEmail;
  final String workerFname;
  final String workerLname;

  BookingPage(
      {super.key,
      required this.workerEmail,
      required this.workerFname,
      required this.workerLname});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  String? token;

  // Define the selected date and time variables
  String? selectedDate;
  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 15),
                _tableCalendar(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: Center(
                    child: Text(
                      "Set Repair Time",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _isWeekend
              ? SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 30,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Weekend is not available, select another day",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                )
              : _sliverTimeSelectionGrid(), // Display time selection grid
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
              child: Button(
                width: double.infinity,
                title: 'Book Appointment',
                onPressed: () async {
                  // Check if date and time are selected
                  if (_dateSelected && _timeSelected) {
                    // Convert the selected time format
                    DateTime selectedDateTime =
                        DateFormat('h:mm a').parse(selectedTime ?? '');
                    String formattedTime =
                        DateFormat('HH:mm:ss').format(selectedDateTime);

                    final availability = await checkAvailability(
                      selectedDate ?? '',
                      formattedTime,
                    );

                    if (availability == "available") {
                      // If available, proceed to book the appointment
                      final bookingResult = await bookAppointment(
                        selectedDate ?? '',
                        formattedTime,
                        // usermail ?? '',
                      );

                      print("Booking Result is: $bookingResult");

                      if (bookingResult == "success") {
                        // Booking was successful
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BookedAppointment(),
                          ),
                        );
                      } else {
                        // Handle other response cases
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Booking Error"),
                            content: Text(
                                "Failed to book the appointment. Please try again."),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      // Handle availability error
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Availability Error"),
                          content: Text(
                              "The selected date and time are not available. Please choose another time."),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  } else {
                    // Show a message to select date and time
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Date and Time Not Selected"),
                        content: Text("Please select both date and time."),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      ),
                    );
                  }
                },
                disable: _timeSelected && _dateSelected ? false : true,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _tableCalendar() {
    return TableCalendar(
      firstDay: DateTime(2023, 1, 1),
      focusedDay: DateTime.now(),
      lastDay: DateTime(2023, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: const CalendarStyle(
        todayDecoration:
            BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          selectedDate = DateFormat('yyyy-MM-dd').format(selectedDay);
          _focusDay = focusedDay;
          _dateSelected = true;

          if (selectedDay.weekday == DateTime.saturday ||
              selectedDay.weekday == DateTime.sunday) {
            _isWeekend = true;
            _timeSelected = false;
            _currentIndex = null;
          } else {
            _isWeekend = false;
          }
        });
      },
    );
  }

  Widget _sliverTimeSelectionGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final hour = index + 9;
          final amOrPm = hour < 12 ? 'AM' : 'PM';
          final formattedHour = hour > 12 ? hour - 12 : hour;
          return InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                _currentIndex = index;
                _timeSelected = true;
                selectedTime = '$formattedHour:00 $amOrPm';
              });
            },
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: _currentIndex == index ? Colors.white : Colors.black,
                ),
                borderRadius: BorderRadius.circular(15),
                color: _currentIndex == index ? Colors.blue : null,
              ),
              alignment: Alignment.center,
              child: Text(
                '$formattedHour:00 $amOrPm',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _currentIndex == index ? Colors.white : null,
                ),
              ),
            ),
          );
        },
        childCount: 8,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.5,
      ),
    );
  }

  Future<String> checkAvailability(String date, String time) async {
    final url = Uri.parse(
      'https://sam-thige.000webhostapp.com/RepairPal/scripts/check_availability.php',
    );

    final response = await http.post(
      url,
      body: {
        'selectedDate': date,
        'selectedTime': time,
        'workerEmail': widget.workerEmail,
      },
    );

    if (response.statusCode == 200) {
      String responseBody = response.body;

      if (responseBody == "available") {
        print("The selected date and time are available.");
        return "available";
      } else if (responseBody == "not_available") {
        print("The selected date and time are not available.");
        return "not_available";
      } else {
        print("Unknown response from server: $responseBody");
        return "error";
      }
    } else {
      print(
          "Failed to check availability. Status code: ${response.statusCode}");
      return "error";
    }
  }

  Future<String> bookAppointment(
    String date,
    String time,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? custemail = prefs.getString('email');
    final url = Uri.parse(
        'https://sam-thige.000webhostapp.com/RepairPal/scripts/add_booking.php');
    final response = await http.post(url, body: {
      'selectedDate': date,
      'selectedTime': time,
      'workerEmail': widget.workerEmail,
      'workerFname': widget.workerFname,
      'workerLname': widget.workerLname,
      'customerEmail': custemail,
    });

    if (response.statusCode == 200) {
      String responseBody = response.body;
      print("$responseBody");

      if (responseBody.trim() == "success") {
        // Booking was successful
        return "success";
      } else {
        // Booking failed
        return "error";
      }
    } else {
      // HTTP request failed
      print("Failed to book appointment. Status code: ${response.statusCode}");
      return "error";
    }
  }
}

class Button extends StatelessWidget {
  const Button(
      {Key? key,
      required this.width,
      required this.title,
      required this.onPressed,
      required this.disable})
      : super(key: key);

  final double width;
  final String title;
  final bool disable;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
        ),
        onPressed: disable ? null : onPressed,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
