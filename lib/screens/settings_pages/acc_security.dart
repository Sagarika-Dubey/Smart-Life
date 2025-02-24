import 'package:flutter/material.dart';

class AccountSecurityScreen extends StatelessWidget {
  const AccountSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account and Security'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          _buildListTile(title: 'Region', subtitle: 'India'),
          _buildListTile(
            title: 'Email Address',
            trailing: Text('Linked', style: TextStyle(color: Colors.grey[600])),
          ),
          _buildListTile(
              title: 'Change Login Password', hasTrailingArrow: true),
          _buildListTile(
            title: 'Fingerprint ID',
            subtitle: 'Out of Sync',
            hasTrailingArrow: true,
          ),
          _buildListTile(
              title: 'Pattern Lock',
              subtitle: 'Not Set',
              hasTrailingArrow: true),
          _buildListTile(title: 'User Code', subtitle: 'DaeS7RT'),
          _buildListTile(
            title: 'Delete Account',
            hasTrailingArrow: true,
            titleColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    String? subtitle,
    Widget? trailing,
    bool hasTrailingArrow = false,
    Color? titleColor,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: titleColor ?? Colors.black),
          ),
          subtitle: subtitle != null
              ? Text(subtitle, style: const TextStyle(color: Colors.grey))
              : null,
          trailing: hasTrailingArrow
              ? const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.grey)
              : trailing,
        ),
        const Divider(height: 1, thickness: 0.5),
      ],
    );
  }
}
