import 'package:flutter/material.dart';
import 'package:repair_pal/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

enum FilterStatus { upcoming, completed, cancelled }

class _AppointmentPageState extends State<AppointmentPage> {
  FilterStatus status = FilterStatus.upcoming; //default filter status
  Alignment _alignment = Alignment.centerLeft;
  List<Map<String, dynamic>> appointments = [];

  List<Map<String, dynamic>> schedules = [
    {
      "worker_name": "Sam Thige",
      "designation": "Cardiologist",
      "status": FilterStatus.upcoming,
      "day": "Monday",
      "date": "02/03/2023",
      "time": "2:00 PM",
    },
    {
      "worker_name": "Daniel Thige",
      "designation": "Radiology",
      "status": FilterStatus.completed,
      "day": "Tuesday",
      "date": "02/04/2023",
      "time": "3:30 PM",
    },
    {
      "worker_name": "Lucy Thige",
      "designation": "Dental",
      "status": FilterStatus.completed,
      "day": "Wednesday",
      "date": "02/05/2023",
      "time": "10:00 AM",
    },
    {
      "worker_name": "Victor Thige",
      "designation": "Oncologist",
      "status": FilterStatus.cancelled,
      "day": "Thursday",
      "date": "02/06/2023",
      "time": "1:15 PM",
    },
  ];

  void _markAppointmentComplete(Map<String, dynamic> schedule) {
    setState(() {
      schedule['status'] = FilterStatus.completed;
    });
  }

  Future<void> _showCancelConfirmationDialog(
      Map<String, dynamic> schedule) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to close dialog!
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
                setState(() {
                  schedule['status'] = FilterStatus.cancelled;
                });
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

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredSchedules = schedules.where((schedule) {
      return schedule['status'] == status;
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
                                if (filterStatus == FilterStatus.upcoming) {
                                  status = FilterStatus.upcoming;
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus ==
                                    FilterStatus.completed) {
                                  status = FilterStatus.completed;
                                  _alignment = Alignment.center;
                                } else if (filterStatus ==
                                    FilterStatus.cancelled) {
                                  status = FilterStatus.cancelled;
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
                itemCount: filteredSchedules.length,
                itemBuilder: ((context, index) {
                  var _schedule = filteredSchedules[index];
                  bool isLastElement = filteredSchedules.length - 1 == index;

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
                              /* CircleAvatar(
                                backgroundImage:
                                    AssetImage(_schedule['doctor_profile']),
                              ), */
                              const SizedBox(
                                width: 15,
                              ),
                              Config.spaceSmall,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _schedule['worker_name'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _schedule['designation'],
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
                            day: _schedule['day'],
                            date: _schedule['date'],
                            time: _schedule['time'],
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
                                      _showCancelConfirmationDialog(_schedule);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10), // Add some spacing
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _markAppointmentComplete(_schedule);
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
  final String date;
  final String time;

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
            color: Color.fromRGBO(255, 152, 0, 1),
            size: 13,
          ),
          const SizedBox(
            width: 3,
          ),
          Text(
            '$day  $date',
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
            width: 3,
          ),
          Flexible(
            child: Text(
              time,
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
