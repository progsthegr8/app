import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/newbr.conf');
  }

  Future<String> readData(filePath) async {
    try {
      final file = await File(filePath);

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "";
    }
  }

  Future<File> writeData(Map data) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(jsonEncode(data));
  }
}