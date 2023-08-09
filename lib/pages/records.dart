import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medical_reminder/utils/pdf_tile.dart';
import 'package:medical_reminder/utils/pdf_utils.dart';

class RecordsPage extends StatefulWidget {
  @override
  _RecordsPageState createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  List<MedicalRecord> medicalRecords = [];

  Future<void> saveRecord() async {
    File? recordFile = await PdfUtils.pickPDF();
    if (recordFile != null) {
      String? recordName = await showDialog(
        context: context,
        builder: (context) => _RecordNameDialog(),
      );
      if (recordName != null && recordName.isNotEmpty) {
        setState(() {
          medicalRecords.add(MedicalRecord(name: recordName, file: recordFile));
        });
      }
    }
  }

  Future<void> deleteRecord(MedicalRecord record) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Record'),
        content: Text('Are you sure you want to delete this record?'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                medicalRecords.remove(record);
              });
              Navigator.pop(context);
            },
            child: Text('Delete'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MedMemo'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(36),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
                      child: Container(
            alignment: Alignment.center,
            child: Text(
              'Medical Records',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
          
          Expanded(
            child: ListView(
              children: medicalRecords.map((record) {
                return PDFTile(name: record.name, file: record.file);
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveRecord,
        tooltip: 'Add Record',
        child: Icon(Icons.add),
      ),
    );
  }
}

class _RecordNameDialog extends StatefulWidget {
  @override
  _RecordNameDialogState createState() => _RecordNameDialogState();
}

class _RecordNameDialogState extends State<_RecordNameDialog> {
  TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Record Name'),
      content: TextField(
        controller: _nameController,
        decoration: InputDecoration(
          hintText: 'Please specify name of file',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, _nameController.text);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}

class MedicalRecord {
  final String name;
  final File file;

  MedicalRecord({required this.name, required this.file});
}
