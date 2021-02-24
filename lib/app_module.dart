import 'package:clean_week_mobx/app_widget.dart';
import 'package:clean_week_mobx/modules/search/domain/usecases/search_by_text.dart';
import 'package:clean_week_mobx/modules/search/external/datasources/github_datasource.dart';
import 'package:clean_week_mobx/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:clean_week_mobx/modules/search/presenter/search/search_page.dart';
import 'package:clean_week_mobx/modules/search/presenter/search/stores/search_store.dart';
import 'package:dio/dio.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends MainModule{

  @override
  List<Bind> get binds => [
    Bind((i) => Dio()),
    Bind((i) => GithubDatasource(i())),
    Bind((i) => SearchRepositoryImpl(i())),
    Bind((i) => SearchByTextImpl(i())),
    Bind((i) => SearchStore(i())),
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter("/", child: (_,__) => SearchPage()),
  ];

  @override
  Widget get bootstrap => AppWidget();

}