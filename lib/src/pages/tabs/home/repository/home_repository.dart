import 'dart:async';

import 'package:greengrocer/src/config/api/apiHttp.dart';
import 'package:greengrocer/src/config/list_names_system/http_methods.dart';
import 'package:greengrocer/src/const/pages_routes/pages_routes.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/tabs/home/result/home_result.dart';

class HomeRespository {
  final HttpManager _httpMethods = HttpManager();

  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final resultCategory = await _httpMethods.restRequest(
      url: PagesRoutes.getAllCategories,
      method: HttpMethods.post,
    );

    if (resultCategory['result'] != null) {
      List<CategoryModel> dataCategories =
          (List<Map<String, dynamic>>.from(resultCategory['result']))
              .map(CategoryModel.fromJson)
              .toList();

      return HomeResult<CategoryModel>.success(dataCategories);
    } else {
      return HomeResult.error(
          'Ocorreu um erro inesperado ao recuperar as categorias');
    }
  }

  Future<HomeResult<ItemModel>> getAllProducts(
      Map<String, dynamic> body) async {
    final resultProducts = await _httpMethods.restRequest(
      url: PagesRoutes.getAllProducts,
      method: HttpMethods.post,
      body: body,
    );

    if (resultProducts['result'] != null) {
      List<ItemModel> dataProdutcs =
          List<Map<String, dynamic>>.from(resultProducts['result'])
              .map(ItemModel.fromJson)
              .toList();

      return HomeResult<ItemModel>.success(dataProdutcs);
    } else {
      return HomeResult.error(
          'Ocorreu um erro inesperado ao recuperar as produtos');
    }
  }
}
