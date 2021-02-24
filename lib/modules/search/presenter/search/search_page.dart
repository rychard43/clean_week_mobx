import 'package:clean_week_mobx/modules/search/domain/entities/result_search.dart';
import 'package:clean_week_mobx/modules/search/domain/errors/errors.dart';
import 'package:clean_week_mobx/modules/search/presenter/search/states/state.dart';
import 'package:clean_week_mobx/modules/search/presenter/search/stores/search_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ModularState<SearchPage, SearchStore> {
  Widget _buildList(List<ResultSearch> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, index) {
        var item = list[index];
        print(item.title);
        return ListTile(
          leading: item.img == null
              ? Container(width: 1,)
              : CircleAvatar(
                  backgroundImage: NetworkImage(item.img),
                ),
          title: Text(item.title ?? ""),
        );
      },
    );
  }

  Widget _buildError(FailureSearch error) {
    if (error is EmptyList) {
      return Center(
        child: Text('Nada encontrado'),
      );
    } else if (error is ErrorSearch) {
      return Center(
        child: Text('Erro no github'),
      );
    } else {
      return Center(
        child: Text('Erro interno'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Github Search"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
            child: TextField(
              onChanged: controller.setSearchText,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Search...",
              ),
            ),
          ),
          Expanded(
            child: Observer(builder: (_) {
              var state = controller.state;

              if (state is SearchError) {
                return _buildError(state.error);
              }

              if (state is SearchStart) {
                return Center(
                  child: Text('Digita alguma coisa...'),
                );
              } else if (state is SearchLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchSuccess) {
                return _buildList(state.list);
              } else {
                return Container();
              }
            }),
          ),
        ],
      ),
    );
  }
}
