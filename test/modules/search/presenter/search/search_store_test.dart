import 'dart:convert';

import 'package:clean_week_mobx/app_module.dart';

import 'package:clean_week_mobx/modules/search/presenter/search/states/state.dart';
import 'package:clean_week_mobx/modules/search/presenter/search/stores/search_store.dart';
import 'package:clean_week_mobx/modules/search/utils/github_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class DioMock extends Mock implements Dio {}

main(){

  var dio = DioMock();

  initModule(AppModule(), changeBinds: [
    Bind<Dio>((i) => dio),
  ]); //inicializar o modulo para fazer os testes(deu erro sem o generics

  when(dio.get(any)).thenAnswer(
          (_) async => Response(data: jsonDecode(jsonResponse), statusCode: 200));


  test('deve retorna um SuccessState', () async {
    var store = Modular.get<SearchStore>();
    var result = await store.makeSearch("text");
    expect(result, isA<SearchSuccess>());
  });

  test('deve trocar o estado para SuccessState', () async {
    var store = Modular.get<SearchStore>();
    await store.stateReaction("text");
    expect(store.state, isA<SearchSuccess>());
  });
}