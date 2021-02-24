import 'package:clean_week_mobx/modules/search/domain/entities/result_search.dart';
import 'package:clean_week_mobx/modules/search/domain/errors/errors.dart';
import 'package:clean_week_mobx/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_week_mobx/modules/search/domain/usecases/search_by_text.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchRepositoryMock extends Mock implements SearchRespository {}

main() {
  final repository = SearchRepositoryMock();

  final usecase = SearchByTextImpl(repository);

  test("deve retornar uma lista de ResultSearch", () async {
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));

    final result = await usecase.call("Rychard");
    expect(result | null, isA<List<ResultSearch>>());
  });


  test("deve retornar uma exception caso o texto seja invalido", () async {
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));

    var result = await usecase.call(null);
    expect(result.fold(id, id), isA<InvalidTextError>());

    result = await usecase.call("");
    expect(result.fold(id, id), isA<InvalidTextError>());

  });

}
