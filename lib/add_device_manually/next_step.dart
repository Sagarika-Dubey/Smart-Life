import 'package:flutter/material.dart';

class MultiPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Pages in One Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPage1(),
            _buildPage2(),
            _buildPage3(),
            _buildPage4(),
          ],
        ),
      ),
    );
  }

  Widget _buildPage1() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.blue.shade100,
      child: Column(
        children: [
          Text('Page 1 Content',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('This is where the first design will be implemented.')
        ],
      ),
    );
  }

  Widget _buildPage2() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.green.shade100,
      child: Column(
        children: [
          Text('Page 2 Content',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('This is where the second design will be implemented.')
        ],
      ),
    );
  }

  Widget _buildPage3() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.orange.shade100,
      child: Column(
        children: [
          Text('Page 3 Content',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('This is where the third design will be implemented.')
        ],
      ),
    );
  }

  Widget _buildPage4() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.purple.shade100,
      child: Column(
        children: [
          Text('Page 4 Content',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('This is where the fourth design will be implemented.')
        ],
      ),
    );
  }
}
