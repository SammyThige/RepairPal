import 'package:flutter/material.dart';
import 'package:repair_pal/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

enum FilterStatus { upcoming, completed, cancelled }

class Appointment {
  final String bookingId; // Add bookingId field
  final String day;
  final DateTime date;
  late final TimeOfDay time;
  final String workerEmail;
  final String customerEmail;
  late FilterStatus status;
  final String workerFirstName;
  final String workerLastName;
  final String designation;

  Appointment({
    required this.bookingId, // Initialize bookingId
    required this.day,
    required this.date,
    required String time,
    required this.workerEmail,
    required this.customerEmail,
    required this.status,
    required this.workerFirstName,
    required this.workerLastName,
    required this.designation,
  }) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    this.time = TimeOfDay(hour: hour, minute: minute);
  }

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      bookingId: json['booking_id'], // Parse bookingId from JSON
      day: json['Day'],
      date: DateTime.parse(json['Date']),
      time: json['Time'], // Pass the time string from JSON
      workerEmail: json['Worker_email'],
      customerEmail: json['Customer_email'],
      status: _mapStatus(json['Status']),
      workerFirstName: json['Worker_fname'],
      workerLastName: json['Worker_lname'],
      designation: json['designation'],
    );
  }

  static FilterStatus _mapStatus(String status) {
    switch (status) {
      case 'upcoming':
        return FilterStatus.upcoming;
      case 'completed':
        return FilterStatus.completed;
      case 'cancelled':
        return FilterStatus.cancelled;
      default:
        return FilterStatus.cancelled;
    }
  }
}

class _AppointmentPageState extends State<AppointmentPage> {
  FilterStatus status = FilterStatus.upcoming;
  Alignment _alignment = Alignment.centerLeft;
  List<Appointment> appointments = [];

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final customerEmail = prefs.getString('email');

      if (customerEmail != null) {
        final response = await http.get(
          Uri.parse(
              'https://sam-thige.000webhostapp.com//RepairPal/scripts/fetch_appointments.php?email=$customerEmail'),
        );

        if (response.statusCode == 200) {
          final responseBody = response.body.trim();

          final jsonResponse = json.decode(responseBody) as List<dynamic>;
          appointments.clear();

          jsonResponse.forEach((appointmentData) {
            final appointment = Appointment.fromJson(appointmentData);
            appointments.add(appointment);
          });

          setState(() {});
        } else {
          print(
              'Failed to fetch appointments. Status code: ${response.statusCode}');
        }
      } else {
        print('Customer email is null.');
      }
    } catch (e) {
      print('Error fetching appointments: $e');
    }
  }

  void _markAppointmentComplete(Appointment appointment) async {
    try {
      final url = Uri.parse(
          'https://sam-thige.000webhostapp.com/RepairPal/scripts/update_appointment_status.php');
      final response = await http.post(url, body: {
        'appointment_id': appointment.bookingId, // Send the bookingId
        'status': 'completed', // Set the status to 'completed'
      });

      if (response.statusCode == 200) {
        String responseBody = response.body;
        print("$responseBody");
        Map<String, dynamic> data = json.decode(responseBody);

        if (data['success'] == true) {
          // Successfully marked as completed
          setState(() {
            appointment.status = FilterStatus.completed;
          });
        } else {
          // Handle error if not successful
          print("Error marking appointment as completed.");
        }
      } else {
        // HTTP request failed
        print(
            "Failed to mark appointment as completed. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error marking appointment as completed: $e");
    }
  }

  Future<void> _showCancelConfirmationDialog(Appointment appointment) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Cancel'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to cancel this appointment?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                /* setState(() {
                  // Update the appointment status to "cancelled"
                  appointment.status = FilterStatus.cancelled;
                }); */
                _cancelAppointment(appointment);
                // Implement additional logic here, such as updating the database or performing other actions.

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _cancelAppointment(Appointment appointment) async {
    try {
      final url = Uri.parse(
          'https://sam-thige.000webhostapp.com/RepairPal/scripts/update_appointment_status.php');
      final response = await http.post(url, body: {
        'appointment_id': appointment.bookingId, // Send the bookingId
        'status': 'cancelled', // Set the status to 'cancelled'
      });

      if (response.statusCode == 200) {
        String responseBody = response.body;
        Map<String, dynamic> data = json.decode(responseBody);

        if (data['success'] == true) {
          // Successfully marked as cancelled
          setState(() {
            appointment.status = FilterStatus.cancelled;
          });
        } else {
          // Handle error if not successful
          print("Error marking appointment as cancelled.");
        }
      } else {
        // HTTP request failed
        print(
            "Failed to mark appointment as cancelled. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error marking appointment as cancelled: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Appointment> filteredAppointments = appointments.where((appointment) {
      return appointment.status == status;
    }).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Appointment Schedule',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Config.spaceSmall,
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                status = filterStatus;
                                if (filterStatus == FilterStatus.upcoming) {
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus ==
                                    FilterStatus.completed) {
                                  _alignment = Alignment.center;
                                } else if (filterStatus ==
                                    FilterStatus.cancelled) {
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(
                              child:
                                  Text(filterStatus.toString().split('.').last),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  alignment: _alignment,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        status.toString().split('.').last,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Config.spaceSmall,
            Expanded(
              child: ListView.builder(
                itemCount: filteredAppointments.length,
                itemBuilder: ((context, index) {
                  var appointment = filteredAppointments[index];
                  bool isLastElement = filteredAppointments.length + 1 == index;

                  return Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: !isLastElement
                        ? const EdgeInsets.only(bottom: 20)
                        : EdgeInsets.zero,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              Config.spaceSmall,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${appointment.workerFirstName} ${appointment.workerLastName}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    appointment.designation,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ScheduleCard(
                            day: appointment.day,
                            date: appointment.date,
                            time: appointment.time,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          if (status == FilterStatus.upcoming)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      _showCancelConfirmationDialog(
                                          appointment);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _markAppointmentComplete(appointment);
                                    },
                                    child: const Text(
                                      'Complete',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.green),
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final String day;
  final DateTime date;
  final TimeOfDay time;

  const ScheduleCard({
    Key? key,
    required this.day,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Icon(
            Icons.calendar_today,
            color: Colors.orange,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '$day  ${DateFormat('yyyy-MM-dd').format(date)}', // Format date as desired
            style: const TextStyle(
              color: Colors.orange,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.access_alarm,
            color: Colors.orange,
            size: 17,
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text(
              '${time.hour}:${time.minute}', // Format time as desired
              style: const TextStyle(
                color: Colors.orange,
              ),
            ),
          )
        ],
      ),
    );
  }
}
