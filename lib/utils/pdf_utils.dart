import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfUtils {
  static Future<File?> pickPDF() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final pdfFile = await convertImageToPDF(File(pickedFile.path));
      return pdfFile;
    }
    return null;
  }

  static Future<File> convertImageToPDF(File imageFile) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final String fileName = path.basenameWithoutExtension(imageFile.path);
    final pdfFilePath = '$appDocPath/$fileName.pdf';

    final pdf = pw.Document();
    final image = pw.MemoryImage(File(imageFile.path).readAsBytesSync());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Image(image),
      ),
    );

    final File pdfFile = File(pdfFilePath);
    await pdfFile.writeAsBytes(await pdf.save());

    return pdfFile;
  }
}

