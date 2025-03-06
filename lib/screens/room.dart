import 'package:flutter/material.dart';
import './room_settings.dart';

class RoomPage extends StatefulWidget {
  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  List<String> rooms = [];

  void _addRoom() {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Room"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter room name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  rooms.add(controller.text);
                });
              }
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rooms"),
      ),
      body: rooms.isEmpty
          ? const Center(child: Text("No rooms available"))
          : ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(rooms[index]),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RoomScreen()));
                }, // Empty onPressed
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRoom,
        child: const Icon(Icons.add),
      ),
    );
  }
}
