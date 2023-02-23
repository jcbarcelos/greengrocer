import 'package:get/get.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/tabs/home/repository/home_repository.dart';
import 'package:greengrocer/src/pages/tabs/home/result/home_result.dart';
import 'package:greengrocer/src/services/util_services.dart';

class HomeController extends GetxController {
  final HomeRespository homeRespository = HomeRespository();
  final UtilServices utilServices = UtilServices();

  List<CategoryModel> allCategories = [];
  List<ItemModel> allProducts = [];
  bool isLoading = false;
  CategoryModel? currentCategory;

  void setIsLoading(bool value) {
    isLoading = value;
    update();
  }

  void selectCategory(CategoryModel categoryModel) {
    currentCategory = categoryModel;
    update();
    getAllProducts();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getAllCategories();
  }

  Future<void> getAllCategories() async {
    setIsLoading(true);
    HomeResult<CategoryModel> homeResult =
        await homeRespository.getAllCategories();
    setIsLoading(false);

    homeResult.when(
      success: (data) {
        allCategories.assignAll(data);
        if (allCategories.isEmpty) return;
        selectCategory(allCategories.first);
      },
      error: (error) {
        utilServices.showToast(
          message: error,
          isError: true,
        );
      },
    );
  }

  Future<void> getAllProducts() async {
    setIsLoading(true);

    Map<String, dynamic> body = {
      "page": 0,
      "title": null,
      "categoryId": "2XHRuUOXoC",
      "itemsPerPage": 6
    };

    HomeResult<ItemModel> homeResult =
        await homeRespository.getAllProducts(body);
    setIsLoading(false);
    print('homeResult $homeResult');
    homeResult.when(
      success: (data) {
        allProducts.assignAll(data);
        update();
      },
      error: (error) {
        utilServices.showToast(
          message: error,
          isError: true,
        );
      },
    );
  }
}
