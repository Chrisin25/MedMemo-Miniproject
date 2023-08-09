import 'package:flutter/material.dart';

class PillTrackerPage extends StatefulWidget {
  @override
  _PillTrackerPageState createState() => _PillTrackerPageState();
}

class _PillTrackerPageState extends State<PillTrackerPage> {
  int pillsRemaining = 0;

  void decrementPills() {
    if (pillsRemaining > 0) {
      setState(() {
        pillsRemaining--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pill Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pills Remaining: $pillsRemaining',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: decrementPills,
              child: Text('Take One Pill'),
            ),
          ],
        ),
      ),
    );
  }
}
