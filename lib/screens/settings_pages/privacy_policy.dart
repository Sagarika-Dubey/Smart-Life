import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy Management"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildListTile("Privacy Policy"),
            _buildListTile("User Agreement"),
            _buildListTile("Children's Privacy Statement"),
            SizedBox(height: 16),
            _buildButton("Export Personal Information"),
            SizedBox(height: 10),
            _buildButton("Revoke", isPrimary: false),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(String title) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        trailing: Icon(Icons.arrow_forward_ios, size: 18),
        onTap: () {},
      ),
    );
  }

  Widget _buildButton(String title, {bool isPrimary = true}) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? Colors.white : Colors.redAccent,
        foregroundColor: isPrimary ? Colors.black : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        padding: EdgeInsets.symmetric(vertical: 14),
      ),
      child: Text(title, style: TextStyle(fontSize: 16)),
    );
  }
}
