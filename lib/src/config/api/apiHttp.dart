import 'package:dio/dio.dart';
import 'package:greengrocer/src/const/api_address.dart';

class HttpManager {
  Future restRequest({
    required String url,
    required String method,
    Map? headers,
    Map? body,
  }) async {
    // Headers
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'content-type': 'application/json',
        'accept': 'application/json',
        'X-Parse-Application-Id': 'wK7GcEjr2V4br5q5mlR1kybQ5dvxMFDX0qtE1d6Y',
        'X-Parse-REST-API-Key': '2kahi62fkWePLWAwC7k8aMrtQkobogcgkruMxbeB',
      });

    Dio dio = Dio();
    try {
      Response response = await dio.request(
        ApiAddress.baseUrl + url,
        data: body,
        options: Options(
          method: method,
          headers: defaultHeaders,
        ),
      );
      return response.data;
    } on DioError catch (error) {
      return error.response?.data ?? {};
    } catch (error) {
      return error;
    }
  }
}
