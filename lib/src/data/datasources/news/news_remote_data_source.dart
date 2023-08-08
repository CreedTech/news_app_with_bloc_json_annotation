import 'package:dio/dio.dart';
import '../../../core/core.dart';
import '../../models/news_model.dart';

abstract class NewsRemoteDataSource {
  Future<NewsModel> getNewGlobal({
    required bool isHeadlines,
    String? category,
    String? query,
    int? limit,
    int? page,
  });

  Future<NewsModel> searchNewGlobal({
    // required bool isHeadlines,
    required String query,
    int? limit,
    int? page,
  });
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final NetworkContainer http;

  NewsRemoteDataSourceImpl({
    required this.http,
  });

  @override
  Future<NewsModel> getNewGlobal({
    required bool isHeadlines,
    String? category,
    String? query,
    int? limit,
    int? page,
  }) async {
    limit ??= 1;
    page ??= 1;
    category ??= "";
    query ??= "";
    if (isHeadlines) {
      final response = await http.method(
        path:
        "posts?_embed&per_page=$limit&page=$page&order=desc",
        methodType: MethodType.get,
      );

      if (response.statusCode == 200) {
        return NewsModel.fromJson(response.data);
      } else {
        throw DioError;
      }
    } else {
      final response = await http.method(
        path:
        "posts?_embed&per_page=$limit&page=$page",
        methodType: MethodType.get,
      );

      if (response.statusCode == 200) {
        // print(response.data);
        return NewsModel.fromJson(response.data);
      } else {
        throw DioError;
      }
    }
  }

  @override
  Future<NewsModel> searchNewGlobal({required String query, int? limit, int? page}) async {
    // final NewsModel articles = [];
    final response = await http.method(
      path:
      "posts?_embed&search=$query",
      methodType: MethodType.get,
    );

    if (response.statusCode == 200) {
      return NewsModel.fromJson(response.data);
    } else {
      throw DioError;
    }
  }
}
