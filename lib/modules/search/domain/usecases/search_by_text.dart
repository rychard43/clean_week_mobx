import 'package:clean_week_mobx/modules/search/domain/entities/result_search.dart';
import 'package:clean_week_mobx/modules/search/domain/errors/errors.dart';
import 'package:clean_week_mobx/modules/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

abstract class SearchByText {
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchText);
}

class SearchByTextImpl implements SearchByText {
  final SearchRespository respository;


  SearchByTextImpl(this.respository);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> call(
      String searchText) async {

    if(searchText == null || searchText.isEmpty){
      return Left(InvalidTextError());
    }
    return respository.search(searchText);

  }
}
