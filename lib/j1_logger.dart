library j1_logger;

export "firebase_logger.dart";
export "j1_logger.dart";
export "local_logger.dart";

import "package:get_it/get_it.dart";

final _locator = GetIt.instance;

/// A class that handles event logging.
abstract class J1Logger {
  /// Sets the default parameters that should be passed with every logged event.
  static void setParams({required Map<String, Object> params}) {
    _locator.get<J1Logger>().setDefaultParams(params: params);
  }

  /// Logs an event with the given [name], and [params].
  static void log({
    required String name,
    Map<String, Object>? params,
  }) {
    _locator.get<J1Logger>().logDefault(name: name, params: params);
  }

  /// Logs an event with the given [name], [page], and [params].
  ///
  /// The [page] argument will be added to the [params] map with the key 'page'.
  static void ui({
    required String name,
    required String page,
    Map<String, Object> params = const {},
  }) {
    _locator.get<J1Logger>().logUi(name: name, page: page, params: params);
  }

  /// Logs an event with the given [name], [bloc], and [params].
  ///
  /// The [bloc] argument will be added to the [params] map with the key 'bloc'.
  static void bloc({
    required String name,
    required String bloc,
    Map<String, Object> params = const {},
  }) {
    _locator.get<J1Logger>().logBloc(name: name, bloc: bloc, params: params);
  }

  /// Logs an event with the given [name], [repository], and [params].
  ///
  /// The [repository] argument will be added to the [params] map with the key 'bloc'.
  static void repository({
    required String name,
    required String repository,
    Map<String, Object> params = const {},
  }) {
    _locator.get<J1Logger>().logRepository(name: name, repository: repository, params: params);
  }

  const J1Logger();

  /// Sets the default parameters that should be passed with every logged event.
  void setDefaultParams({required Map<String, Object> params});

  void logUi({
    required String name,
    required String page,
    Map<String, Object> params = const {},
  }) {
    params["page"] = page;
    logDefault(name: "$page-page-$name", params: params);
  }

  void logBloc({
    required String name,
    required String bloc,
    Map<String, Object> params = const {},
  }) {
    params["bloc"] = bloc;
    logDefault(name: "$bloc-bloc-$name", params: params);
  }

  void logRepository({
    required String name,
    required String repository,
    Map<String, Object> params = const {},
  }) {
    params["repository"] = repository;
    logDefault(name: "$repository-repository-$name", params: params);
  }

  void logDefault({
    required String name,
    Map<String, Object>? params,
  });
}
