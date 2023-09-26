import 'package:flutter/material.dart';

class WorkerProfile extends StatelessWidget {
  final Worker worker;

  const WorkerProfile({Key? key, required this.worker}) : super(key: key);

  // Function to handle sending a message
  void sendMessage(BuildContext context, String phoneNumber, String message) {
    // Implement your logic to send the message here
    // You can use the phoneNumber and message to send the message via WhatsApp or any other messaging service
    // For now, we'll print the message
    print('Sending message to $phoneNumber: $message');

    // Optionally, you can show a confirmation dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Message Sent'),
          content: Text(
              'Your message has been sent to ${worker.firstName} ${worker.lastName}.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // ... Your existing code ...

        // Add a Chat button
        Positioned(
          bottom: 10,
          right: 10,
          child: FloatingActionButton(
            onPressed: () {
              // Show a dialog to enter a message
              showDialog(
                context: context,
                builder: (context) {
                  String message = ''; // Initialize an empty message

                  return AlertDialog(
                    title: Text('Enter Message'),
                    content: TextField(
                      onChanged: (value) {
                        // Update the message as the user types
                        message = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Type your message here...',
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          // Send the message and close the dialog
                          sendMessage(context, worker.phone, message);
                          Navigator.of(context).pop();
                        },
                        child: Text('Send'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Close the dialog without sending the message
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.message),
          ),
        ),
      ],
    );
  }
}

// Define your Worker class here
class Worker {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  Worker({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RepairPal App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WorkerProfile(
        worker: Worker(
          firstName: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          phone: '1234567890',
        ),
      ),
    );
  }
}
