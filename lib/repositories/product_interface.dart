import '../models/product.dart';

///Interface for Product repositories
abstract class IProductRepository {
  ///Converts the read csv string to a list
  List<List<dynamic>> csvConvert(String content);

  ///Gets a max of 20 id and converts it to a List<Product>
  Future<List<Product>> getTempProductList(List<int> ids);

  ///Given the id list, returns the full product list
  Future<List<Product>> getProductList(List<int> ids);

  ///Removes the list heading and
  List<List<dynamic>> resizeList(List<List<dynamic>> readList);

  ///Returns the list of the ids from the given list
  List<int> getIds(List<List<dynamic>> csvList);

  ///Given products and corresponding quantities, it returns a string
  ///ready to be written on a csv file
  String getCsvProducts(List<Product> productList, List<List<dynamic>> csvList);

  ///Adds the csv heading to a list
  List<List<List<dynamic>>> addHeading(List<List<List<dynamic>>> writableList);

  ///Matches the sku and the relative total quantity
  void assignQty(List<List<dynamic>> csvList, List<List<dynamic>> qtyList);

  ///Returns the indexes of the elements to insert in the list
  int getRightIndexes(List<List<dynamic>> arr, int n);

  ///Returns the list without duplicate elements
  List<List<dynamic>> getList(List<List<dynamic>> list, int indexes);

  ///Given the list, it returns a list with the skus and the quantities paired
  List<List<dynamic>> getQty(List<List<dynamic>> list);

  ///Returns the right list to use
  List<List<dynamic>> getRightList(List<List<dynamic>> csvList);
}
