import 'dart:convert';
import 'package:csv/csv.dart';
import '../models/variant.dart';
import 'package:overside_project/models/product.dart';
import 'package:overside_project/data_providers/client.dart';
import 'package:overside_project/repositories/product_interface.dart';

///Product repository, implements the interface IProductRepository
class ProductRepository implements IProductRepository {
  ApiClient client;

  ProductRepository(this.client);

  @override
  List<List<List>> addHeading(List<List<List>> writableList) {
    List<List<dynamic>> heading = [];
    heading.addAll([
      ['ID'],
      ['Variant-Sku'],
      ['Variant'],
      ['Quantity']
    ]);
    writableList.add(heading);
    return writableList;
  }

  @override
  List<List<dynamic>> csvConvert(String content) {
    List<List<dynamic>> csvContent =
        const CsvToListConverter().convert(content);

    return csvContent;
  }

  @override
  String getCsvProducts(List<Product> productList, List<List> csvList) {
    List<List<List<dynamic>>> bigList = [];

    bigList = addHeading(bigList);

    for (var i = 0; i < productList.length; i++) {
      for (Variant element in productList[i].variants) {
        String combo =
            '${productList[i].title} ${element.option1} ${element.option2}';
        List<List<dynamic>> listRow = [
          ['${productList[i].id}'],
          [element.sku],
          [combo],
          [csvList[i][2]]
        ];

        bigList.add(listRow);
      }
    }

    String csv = const ListToCsvConverter()
        .convert(bigList)
        .replaceAll('[', '')
        .replaceAll(']', '');

    String csvWritable = csv.replaceAll('[', '').replaceAll(']', '');

    return csvWritable;
  }

  @override
  List<int> getIds(List<List> csvList) {
    List<int> ids = [];
    int k = 0;

    for (var i = 0; i < csvList.length; i++) {
      ids.add(int.parse(csvList[i][k]));
    }

    return ids;
  }

  @override
  List<List<dynamic>> resizeList(List<List<dynamic>> readList) {
    List<List<dynamic>> resizedList = [];

    //remove the heading of the csv file
    readList.removeAt(0);

    //if there are more than 20 elements, return the resized list
    if (readList.length > 19) {
      print('\nTroppi elementi nel file, verranno utilizzati solo i primi 20.');
      for (var i = 0; i < 20; i++) {
        resizedList.add(readList[i]);
      }
      return resizedList;
    }
    //Element count is ok, return the list
    return readList;
  }

  @override
  Future<List<Product>> getProductList(List<int> ids) async {
    String response = await client.getProducts(ids);
    List<Product> productList =
        (jsonDecode(response) as List).map((p) => Product.fromJson(p)).toList();
    return productList;
  }

  @override
  void assignQty(List<List> csvList, List<List> qtyList) {
    for (var i = 0; i < csvList.length; i++) {
      for (var j = 0; j < qtyList.length; j++) {
        if ((csvList[i][1] == qtyList[j][0])) {
          csvList[i][2] = qtyList[j][1];
        }
      }
    }
  }

  @override
  List<List> getList(List<List> list, int indexes) {
    List<List<dynamic>> writableList = [];

    for (int i = 0; i < indexes; i++) {
      writableList.add(list[i]);
    }

    return writableList;
  }

  @override
  List<List> getQty(List<List> list) {
    List<List<dynamic>> qtyList = [];

    for (var i = 0; i < list.length; i++) {
      List<dynamic> skuQty = [];
      int qty = 0;

      for (var j = 0; j < list.length; j++) {
        if (list[i][1] == list[j][1]) {
          qty += int.parse(list[j][2]);
        }
      }
      skuQty.add(list[i][1]);
      skuQty.add(qty);

      qtyList.add(skuQty);
    }
    return qtyList;
  }

  @override
  int getRightIndexes(List<List> arr, int n) {
    if (n != 0 || n != 1) {
      int j = 0;

      for (int i = 0; i < n - 1; i++) {
        if (arr[i][1] != arr[i + 1][1]) {
          arr[j++] = arr[i];
        }
      }
      arr[j++] = arr[n - 1];
      return j;
    }
    return n;
  }

  @override
  List<List> getRightList(List<List> csvList) {
    int n = csvList.length;
    List<List<dynamic>> qtyList = getQty(csvList);

    n = getRightIndexes(csvList, n);

    csvList = getList(csvList, n);

    assignQty(csvList, qtyList);

    return csvList;
  }
}
