import 'package:overside_project/data_providers/client.dart';
import 'package:overside_project/data_providers/file_manager.dart';
import 'package:overside_project/repositories/product.dart';

import '../models/product.dart';

class MainController {
  final ProductRepository _productRepo = ProductRepository(ApiClient());
  final FileManager _fileManager = FileManager(ProductRepository(ApiClient()));

  ///Reads the content of a file and returns it as List<List<dynamic>>
  Future<List<List<dynamic>>> readCsvFile() async {
    return await _fileManager.readCsv(_fileManager.csvInput);
  }

  ///Removes the read heading and, if necessary, resizes the list
  List<List> resizeList(List<List<dynamic>> readList) {
    return _productRepo.resizeList(readList);
  }

  ///Returns the list of the ids from the given list
  List<int> getIds(List<List<dynamic>> csvList) {
    return _productRepo.getIds(csvList);
  }

  ///Gets the product list from the api and converts it
  Future<List<Product>> getProductList(List<int> ids) async {
    return await _productRepo.getProductList(ids);
  }

  ///Given products and corresponding quantities, it returns a string
  ///ready to be written on a csv file
  String getCsvProducts(
      List<Product> productList, List<List<dynamic>> csvList) {
    return _productRepo.getCsvProducts(productList, csvList);
  }

  ///Writes the csv file
  Future<void> writeCsvOutput(String csvText) async {
    return await _fileManager.writeCsv(csvText);
  }

  ///Returns the list without duplicates and with the right quantities
  List<List<dynamic>> getPairedList(List<List<dynamic>> csvList) {
    return _productRepo.getRightList(csvList);
  }
}
