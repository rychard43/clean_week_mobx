import 'dart:convert';

import 'package:clean_week_mobx/app_module.dart';
import 'package:clean_week_mobx/modules/search/domain/entities/result_search.dart';
import 'package:clean_week_mobx/modules/search/domain/usecases/search_by_text.dart';
import 'package:clean_week_mobx/modules/search/utils/github_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();

  initModule(AppModule(), changeBinds: [
    Bind<Dio>((i) => dio),
  ]); //inicializar o modulo para fazer os testes

  test("Deve recuparar o usecase sem erro", () {
    final usecase = Modular.get<SearchByText>();
    expect(usecase, isA<SearchByTextImpl>());
  });

  test("Deve trazer uma lista de ResultSearch", () async {
    when(dio.get(any)).thenAnswer(
        (_) async => Response(data: jsonDecode(githubResult), statusCode: 200));

    final usecase = Modular.get<SearchByText>();
    final result = await usecase.call("Rychard");

    expect(result | null, isA<List<ResultSearch>>());
  });
}
