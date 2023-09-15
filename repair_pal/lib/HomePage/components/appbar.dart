import 'package:flutter/material.dart';
import 'package:repair_pal/HomePage/workers/worker_listview.dart';
import 'package:repair_pal/constants.dart';
import 'package:repair_pal/test_constant.dart';

class AppToolBar extends StatelessWidget implements PreferredSizeWidget {
  //final String userName;
  const AppToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        gradient: LinearGradient(
            colors: [kPrimaryColor, Colors.orangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello,\nGood Morning",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 20,
              mainAxisSpacing: 24,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final category = categoryList[index];
                final Map<String, VoidCallback> categoryActions = {
                  'Electrician': () {
                    // Perform Electrician-specific action here
                    // For example, navigate to Electrician screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => WorkerList(
                          category: category,
                        ),
                      ),
                    );
                  },
                  'Plumber': () {
                    // Perform Plumber-specific action here
                    // For example, navigate to Plumber screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => WorkerList(
                          category: category,
                        ),
                      ),
                    );
                  },
                  'Painter': () {
                    // Perform Painter-specific action here
                    // For example, navigate to Painter screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => WorkerList(
                          category: category,
                        ),
                      ),
                    );
                  },
                  'Roofer': () {
                    // Perform Roofer-specific action here
                    // For example, navigate to Roofer screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => WorkerList(
                          category: category,
                        ),
                      ),
                    );
                  },
                  'Carpenter': () {
                    // Perform Carpenter-specific action here
                    // For example, navigate to Carpenter screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => WorkerList(
                          category: category,
                        ),
                      ),
                    );
                  },
                  'Mason': () {
                    // Perform Mason-specific action here
                    // For example, navigate to Mason screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => WorkerList(
                          category: category,
                        ),
                      ),
                    );
                  },
                };
                final onTap = categoryActions[category.name] ??
                    () {
                      // Default action when no specific condition is met
                      print('Default action for ${category.name}');
                    };
                return CategoryCard(
                  category: category,
                  onTap: onTap,
                );
              },
              childCount: categoryList.length,
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;
  const CategoryCard({
    Key? key,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      /* () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => WorkerList()));
      }, */
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 4.0,
              spreadRadius: .05,
            ), //BoxShadow
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                category.thumbnail,
                height: kCategoryImageSize,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              category.name,
              style: TextStyle(color: Colors.orange),
            ),
            Text(
              category.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
