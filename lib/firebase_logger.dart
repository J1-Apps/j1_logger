import "package:firebase_analytics/firebase_analytics.dart";
import "package:j1_logger/logger.dart";

class FirebaseLogger extends J1Logger {
  final FirebaseAnalytics _analytics;

  FirebaseLogger({FirebaseAnalytics? analytics}) : _analytics = analytics ?? FirebaseAnalytics.instance;

  @override
  void setDefaultParams({required Map<String, Object> params}) {
    _analytics.setDefaultEventParameters(params).onError((error, stackTrace) {});
  }

  @override
  void log({required String name, Map<String, Object>? params}) {
    _analytics.logEvent(name: name, parameters: params).onError((error, stackTrace) {});
  }
}
