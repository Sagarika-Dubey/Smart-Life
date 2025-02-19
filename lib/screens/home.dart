import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My Home .."),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.meeting_room), label: "Room"),
          BottomNavigationBarItem(icon: Icon(Icons.check_box), label: "Scene"),
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: "Smart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.lightbulb, color: Colors.blue),
                title: Text("Learn about the new DIY homepage"),
                subtitle: Text("Don't show again"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Column(
                      children: [
                        Image.asset('assets/images/sun.jpg', height: 50),
                        Text("--°C"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.flash_on, color: Colors.orange),
                          title: Text("Energy Saving"),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.grid_view, color: Colors.blue),
                          title: Text("All Devices"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Edit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
