import 'package:clean_week_mobx/modules/search/domain/entities/result_search.dart';
import 'package:clean_week_mobx/modules/search/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRespository{

  Future<Either<FailureSearch, List<ResultSearch>>> search(String searchText);

}