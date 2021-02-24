import 'package:clean_week_mobx/modules/search/domain/errors/errors.dart';
import 'package:clean_week_mobx/modules/search/infra/datasource/search_datasource.dart';
import 'package:clean_week_mobx/modules/search/infra/models/result_search_model.dart';
import 'package:clean_week_mobx/modules/search/utils/github_response.dart';
import 'package:dio/dio.dart';

extension on String {
  normalize() {
    return this.replaceAll(" ", "+");
  }
}

class GithubDatasource implements SearchDatasource {
  final Dio dio;

  GithubDatasource(this.dio);

  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) async {
    final response = await dio.get(URL + searchText.normalize());
    if (response.statusCode == 200) {
      final list = (response.data['items'] as List)
          .map((e) => ResultSearchModel.fromMap(e)).toList();

      return list;
    }else{
      throw DatasourceError();
    }
  }
}
