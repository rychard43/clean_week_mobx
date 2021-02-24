import 'dart:convert';

import 'package:clean_week_mobx/modules/search/domain/errors/errors.dart';
import 'package:clean_week_mobx/modules/search/external/datasources/github_datasource.dart';
import 'package:clean_week_mobx/modules/search/utils/github_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();

  final datasource = GithubDatasource(dio);

  test("deve retornar uma lista de ResultSearchHModel", () async {
    when(dio.get(any)).thenAnswer(
        (_) async => Response(data: jsonDecode(githubResult), statusCode: 200));

    final future = datasource.getSearch("Rychard");
    expect(future, completes);
  });

  test("deve retornar um erro se o codigo n for 200", () async {
    when(dio.get(any))
        .thenAnswer((_) async => Response(data: null, statusCode: 401));

    final future = datasource.getSearch("Rychard");
    expect(future, throwsA(isA<DatasourceError>()));
  });
}
