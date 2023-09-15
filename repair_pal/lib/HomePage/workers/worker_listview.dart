import 'package:flutter/material.dart';
import 'package:repair_pal/HomePage/workers/profile_icon.dart';
import 'package:repair_pal/HomePage/workers/worker_profile/worker_profile.dart';
import 'package:repair_pal/test_constant.dart';

class WorkerList extends StatefulWidget {
  final Category category;

  const WorkerList({super.key, required this.category});

  @override
  State<WorkerList> createState() => _WorkerListState();
}

class _WorkerListState extends State<WorkerList> {
  @override
  Widget build(BuildContext context) {
    final List<Worker> filteredWorkers = widget.category.workers.map((worker) {
      return Worker(
        firstName: worker.firstName,
        lastName: worker.lastName,
        location: worker.location,
        phone: worker.phone,
        pictureUrl: worker.pictureUrl,
        email: worker.email,
      );
    }).toList();

    return Scaffold(
        appBar: AppBar(
          title: const Text("AppBar"),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color.fromRGBO(111, 31, 148, 1),
                    Color.fromRGBO(218, 144, 33, 0.98)
                  ]),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: filteredWorkers.length,
          itemBuilder: (context, index) {
            final worker = filteredWorkers[index];
            return ListContainer(
              worker: worker,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        WorkerProfile(worker: worker),
                  ),
                );
              },
            );
          },
        ));
  }
}

class ListContainer extends StatelessWidget {
  final Worker worker;
  final VoidCallback onTap;

  const ListContainer({
    Key? key,
    required this.worker,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 2, color: Colors.orange),
          ),
          child: Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Profile(
                      icon: AssetImage(worker.pictureUrl),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.orange,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${worker.firstName} ${worker.lastName}',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.orange,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            worker.location,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
