import 'package:clean_week_mobx/modules/search/domain/usecases/search_by_text.dart';
import 'package:clean_week_mobx/modules/search/presenter/search/states/state.dart';
import 'package:mobx/mobx.dart';
import 'package:async/async.dart';

part 'search_store.g.dart';

class SearchStore = SearchStoreBase with _$SearchStore;

abstract class SearchStoreBase with Store {
  final SearchByText usecase;
  CancelableOperation cancellableOperation;

  SearchStoreBase(this.usecase) {
    reaction((_) => searchText, (text) async {
      stateReaction(text, cancellableOperation);
    }, delay: 500);
  }

  Future stateReaction(String text,
      [CancelableOperation cancellableOperation]) async {
    await cancellableOperation?.cancel();
    cancellableOperation =
        CancelableOperation<SearchState>.fromFuture(makeSearch(text));
    if (text.isEmpty) {
      setState(SearchStart());
      return;
    }

    setState(SearchLoading());

    setState(await cancellableOperation.valueOrCancellation(SearchLoading()));
  }

  Future<SearchState> makeSearch(String text) async {
    var result = await usecase(text);
    return result.fold((l) => SearchError(l), (r) => SearchSuccess(r));
  }

  @observable
  String searchText = "";

  @observable
  SearchState state = SearchStart();

  @action
  setSearchText(String value) => searchText = value;

  @action
  setState(SearchState value) => state = value;
}
