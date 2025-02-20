import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _nickname = "Tap to Set Nickname";
  String _selectedAvatar = "assets/images/avtar1.png";

  void _changeNickname() {
    TextEditingController nicknameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Change Nickname"),
          content: TextField(
            controller: nicknameController,
            decoration: const InputDecoration(hintText: "Enter new nickname"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (nicknameController.text.isNotEmpty) {
                  setState(() {
                    _nickname = nicknameController.text;
                  });
                }
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _selectAvatar() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AvatarSelectionPage(
          onAvatarSelected: (String avatarPath) {
            setState(() {
              _selectedAvatar = avatarPath;
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Information',
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildListItem(
              title: 'Profile Photo',
              trailing: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(_selectedAvatar),
              ),
              onTap: _selectAvatar, // Fixed function call
            ),
            _buildListItem(
              title: 'Nickname',
              subtitle: _nickname, // Now updates with user input
              onTap: _changeNickname, // Fixed function call
            ),
            _buildListItem(
              title: 'Time Zone',
              subtitle: 'Kolkata',
              onTap: () {
                // Implement time zone selection functionality
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem({
    required String title,
    String? subtitle,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
              ],
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }
}

class AvatarSelectionPage extends StatelessWidget {
  final Function(String) onAvatarSelected;
  AvatarSelectionPage({super.key, required this.onAvatarSelected});

  final List<String> avatarPaths = [
    "assets/images/avtar1.png",
    "assets/images/avtar2.webp",
    "assets/images/avtar3.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Avatar")),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: avatarPaths.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onAvatarSelected(avatarPaths[index]),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(avatarPaths[index]),
            ),
          );
        },
      ),
    );
  }
}
