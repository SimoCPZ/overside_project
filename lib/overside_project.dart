import 'controllers/main_controller.dart';
import 'models/product.dart';

void runProject() async {
  try {
    MainController homeController = MainController();
    List<List<dynamic>> csvList = [];

    print('\nLettura del file csv...');

    csvList = await homeController.readCsvFile();

    if (csvList.length < 2) {
      throw '\n\nLa lista non ha elementi da importare.\n\n';
    }

    homeController.resizeList(csvList);

    csvList = homeController.getPairedList(csvList);

    List<int> ids = homeController.getIds(csvList);

    print('\nAcquisizione prodotti...');

    List<Product> productList = await homeController.getProductList(ids);

    String writableCsv = homeController.getCsvProducts(productList, csvList);

    print('\nScrittura csv in corso...');

    homeController.writeCsvOutput(writableCsv);

    print(
        '\nFile scritto correttamente, visualizzabile in: assets/csvOutput . \n');
  } catch (e) {
    print('\nSi è verificato un errore: $e');
  }
}
