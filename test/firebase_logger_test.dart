import "package:firebase_analytics/firebase_analytics.dart";
import "package:j1_logger/logger.dart";
import "package:mocktail/mocktail.dart";
import "package:test/test.dart";

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

void main() {
  final analytics = MockFirebaseAnalytics();
  final logger = FirebaseLogger(analytics: analytics);

  setUp(() {
    reset(analytics);
  });

  group("Firebase Logger", () {
    test("sets default params and handles all three log types", () {
      when(() => analytics.setDefaultEventParameters(any())).thenAnswer((_) => Future.value());
      when(() => analytics.logEvent(name: any(named: "name"), parameters: any(named: "parameters")))
          .thenAnswer((_) => Future.value());

      logger.setDefaultParams(params: {"test": "testValue"});
      verify(() => analytics.setDefaultEventParameters({"test": "testValue"})).called(1);

      logger.log(name: "testEvent", params: {"testParam": "testParamValue"});
      verify(() => analytics.logEvent(name: "testEvent", parameters: {"testParam": "testParamValue"})).called(1);

      logger.logRepository(name: "event", repository: "testRepository", params: {"testParam": "testParamValue"});
      verify(
        () => analytics.logEvent(
          name: "testRepository-repository-event",
          parameters: {"testParam": "testParamValue", "repository": "testRepository"},
        ),
      ).called(1);

      logger.logBloc(name: "event", bloc: "testBloc", params: {"testParam": "testParamValue"});
      verify(
        () => analytics.logEvent(
          name: "testBloc-bloc-event",
          parameters: {"testParam": "testParamValue", "bloc": "testBloc"},
        ),
      ).called(1);

      logger.logUi(name: "event", page: "testPage", params: {"testParam": "testParamValue"});
      verify(
        () => analytics.logEvent(
          name: "testPage-page-event",
          parameters: {"testParam": "testParamValue", "page": "testPage"},
        ),
      ).called(1);
    });
  });
}
