import 'dart:io';
import 'dart:async';
import 'package:overside_project/repositories/product.dart';

///Class used to work work with files
class FileManager {
  ProductRepository productRepo;

  FileManager(this.productRepo);

  ///Returns the csvInput file
  Future<File> get csvInput async {
    return File('assets/csvInput.csv');
  }

  ///Returns the csvOutput file
  Future<File> get csvOutput async {
    return File('assets/csvOutput.csv');
  }

  ///Reads the content of a file and returns it as List<List<dynamic>>
  Future<List<List<dynamic>>> readCsv(Future<File> fileToRead) async {
    final file = await fileToRead;
    String content = await file.readAsString();
    return productRepo.csvConvert(content);
  }

  ///Writes the csv file
  Future<void> writeCsv(String csvText) async {
    final file = await csvOutput;
    file.writeAsString(csvText);
  }
}
