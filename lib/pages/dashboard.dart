import 'package:flutter/material.dart';
import 'package:medical_reminder/pages/PillTrackerPage.dart';
import 'package:medical_reminder/pages/medicinerem.dart';
import 'package:medical_reminder/pages/records.dart';
import 'appointment.dart';
import 'scanner.dart';
import 'loginpage.dart';
import 'package:medical_reminder/drawer.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String firstName = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double
                .infinity, // Set the width to occupy the entire screen width
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan[800]!, Colors.cyan[900]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Icon(
                  Icons.home_filled,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 40),
                Text(
                  'Welcome, $firstName!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                _buildDashboardTile(
                  icon: Icons.access_alarm,
                  title: 'Routines',
                  onTap: () {
                    // Add your routine logic here
                    username(firstName);
                    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => const MedicineRem()));
                  },
                ),
                _buildDashboardTile(
                  icon: Icons.calendar_today,
                  title: 'Appointments',
                  onTap: () {
                    // Add your appointments logic here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentsPage()),
                    );
                  },
                ),
                _buildDashboardTile(
                  icon: Icons.scanner,
                  title: 'Prescription Scanner',
                  onTap: () {
                    // Add your prescription scanner logic here
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScannerPage()),
                    );
                  },
                ),
                
                _buildDashboardTile(
                  icon: Icons.folder,
                  title: 'Files',
                  onTap: () {
                    // Add your files logic here
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecordsPage()),
                    );
                  },
                ),
                _buildDashboardTile(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {
                    // Add your logout logic here
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.cyan[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}