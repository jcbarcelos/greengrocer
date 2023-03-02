import 'package:get/get.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/tabs/home/repository/home_repository.dart';
import 'package:greengrocer/src/pages/tabs/home/result/home_result.dart';
import 'package:greengrocer/src/services/util_services.dart';

class HomeController extends GetxController {
  final HomeRespository homeRespository = HomeRespository();
  final UtilServices utilServices = UtilServices();
  int itemsPerPage = 6;
  int pagination = 0;
  bool isCategoryLoading = false;
  bool isProductLoading = true;

  List<CategoryModel> allCategories = [];
  List<ItemModel> get allProducts => currentCategory?.items ?? [];

  RxString searchTitle = ''.obs;

  CategoryModel? currentCategory;

  bool get isLastPage {
    if (currentCategory!.items.length < itemsPerPage) return true;
    return currentCategory!.pagination * itemsPerPage > allProducts.length;
  }

  void setIsLoading(bool value, {bool isProdut = false}) {
    if (!isProdut) {
      isCategoryLoading = value;
    } else {
      isProductLoading = value;
    }

    update();
  }

  void selectCategory(CategoryModel categoryModel) {
    currentCategory = categoryModel;
    update();
    if (currentCategory!.items.isNotEmpty) return;
    getAllProducts();
  }

  @override
  void onInit() {
    super.onInit();
    debounce(
      searchTitle,
      (_) {
        filterByTitle();
      },
      time: const Duration(
        milliseconds: 600,
      ),
    );

    getAllCategories();
  }

  Future<void> filterByTitle() async {
    for (var category in allCategories) {
      category.items.clear();
      category.pagination = 0;
    }

    if (searchTitle.value.isEmpty) {
      allCategories.removeAt(0);
    } else {
      CategoryModel? categoryModel = allCategories.firstWhereOrNull(
        (category) => category.id == '',
      );
      print('searchTitle.value ${searchTitle.value}');
      print('categoryModel $categoryModel');
      if (categoryModel == null) {
        final allProductCategory = CategoryModel(
          title: 'Pesquisa...',
          id: '',
          items: [],
          pagination: 0,
        );
        allCategories.insert(0, allProductCategory);
      } else {
        categoryModel.items.clear();
        categoryModel.pagination = 0;
      }
    }
    currentCategory = allCategories.first;
    update();
    getAllProducts();
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

  Future<void> getAllProducts({bool canLoad = true}) async {
    if (canLoad) setIsLoading(true, isProdut: true);

    Map<String, dynamic> body = {
      "page": currentCategory!.pagination,
      "categoryId": currentCategory!.id,
      "itemsPerPage": itemsPerPage
    };
    if (searchTitle.value.isNotEmpty) {
      body['title'] = searchTitle.value;

      if (currentCategory!.id == '') {
        body.remove('categoryId');
      }
    }
    HomeResult<ItemModel> homeResult =
        await homeRespository.getAllProducts(body);
    setIsLoading(false, isProdut: true);

    homeResult.when(
      success: (data) {
        currentCategory!.items.addAll(data);

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

  Future<void> loadMoreProducts() async {
    currentCategory!.pagination++;
    await getAllProducts(canLoad: false);
  }
}
