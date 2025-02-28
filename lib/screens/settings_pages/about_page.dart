import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildListItem(context, "Rate Us"),
            _buildListItem(context, "Open Source Component License"),
            _buildListItem(context, "Upload Log"),
            _buildVersionItem("Current Version", "6.2.3 (international)"),
            _buildListItem(context, "Check for Updates"),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, String title) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
          trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: () {},
        ),
        Divider(height: 1),
      ],
    );
  }

  Widget _buildVersionItem(String title, String version) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
          trailing: Text(version, style: TextStyle(color: Colors.grey)),
        ),
        Divider(height: 1),
      ],
    );
  }
}
