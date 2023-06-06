import 'package:flutter/material.dart';
import 'package:repair_pal/constants.dart';

class WorkerList extends StatefulWidget {
  const WorkerList({super.key});

  @override
  State<WorkerList> createState() => _WorkerListState();
}

class _WorkerListState extends State<WorkerList> {
  final List _posts = [
    'post 1',
    'post 2',
    'post 3',
    'post 4',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("AppBAr"),
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
        body: /*  ListView(
          children: [
            ListContainer(),
            ListContainer(),
            ListContainer(),
          ],
        ) */ //ListContainer(),
            ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  return ListContainer(/* name: _posts[index] */);
                }));
  }
}
