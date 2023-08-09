import 'dart:io';
import 'package:flutter/material.dart';
import '../pages/pdf_screen.dart';
class PDFTile extends StatelessWidget {
  final String name;
  final File file;

  PDFTile({required this.name, required this.file});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.cyan.shade200,
      child: ListTile(
        leading: Icon(Icons.picture_as_pdf),
        title: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PDFScreen(record: file),
            ),
          );
        },
      ),
    );
  }
}