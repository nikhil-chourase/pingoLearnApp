import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pingolearnapp/model/product/product.dart';
import 'package:pingolearnapp/utils/res/app_url.dart';

class ApiService {
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(AppUrl.productUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> productsJson = jsonResponse['products'];
        return productsJson.map((product) => Product.fromJson(product)).toList();
      } else {
        throw ApiException(
          'Failed to load products',
          statusCode: response.statusCode,
          responseBody: response.body,
        );
      }
    } on http.ClientException catch (e) {
      throw ApiException('Network error: ${e.message}');
    } on FormatException catch (e) {
      throw ApiException('Invalid response format: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }
}



class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? responseBody;

  ApiException(this.message, {this.statusCode, this.responseBody});

  @override
  String toString() {
    return 'ApiException: $message${statusCode != null ? ', Status code: $statusCode' : ''}${responseBody != null ? ', Response body: $responseBody' : ''}';
  }
}