import "package:firebase_analytics/firebase_analytics.dart";
import "package:get_it/get_it.dart";
import "package:j1_logger/j1_logger.dart";
import "package:mocktail/mocktail.dart";
import "package:test/test.dart";

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

final _locator = GetIt.instance;

void main() {
  final analytics = MockFirebaseAnalytics();
  final logger = FirebaseLogger(analytics: analytics);

  setUpAll(() {
    _locator.registerSingleton<J1Logger>(logger);
  });

  setUp(() {
    reset(analytics);
  });

  group("Firebase Logger", () {
    test("sets default params and handles all three log types", () {
      when(() => analytics.setDefaultEventParameters(any())).thenAnswer((_) => Future.value());
      when(() => analytics.logEvent(name: any(named: "name"), parameters: any(named: "parameters")))
          .thenAnswer((_) => Future.value());

      J1Logger.setParams(params: {"test": "testValue"});
      verify(() => analytics.setDefaultEventParameters({"test": "testValue"})).called(1);

      J1Logger.log(name: "testEvent", params: {"testParam": "testParamValue"});
      verify(() => analytics.logEvent(name: "testEvent", parameters: {"testParam": "testParamValue"})).called(1);

      J1Logger.repository(name: "event", repository: "testRepository", params: {"testParam": "testParamValue"});
      verify(
        () => analytics.logEvent(
          name: "testRepository-repository-event",
          parameters: {"testParam": "testParamValue", "repository": "testRepository"},
        ),
      ).called(1);

      J1Logger.bloc(name: "event", bloc: "testBloc", params: {"testParam": "testParamValue"});
      verify(
        () => analytics.logEvent(
          name: "testBloc-bloc-event",
          parameters: {"testParam": "testParamValue", "bloc": "testBloc"},
        ),
      ).called(1);

      J1Logger.ui(name: "event", page: "testPage", params: {"testParam": "testParamValue"});
      verify(
        () => analytics.logEvent(
          name: "testPage-page-event",
          parameters: {"testParam": "testParamValue", "page": "testPage"},
        ),
      ).called(1);
    });
  });
}
