import "package:j1_logger/logger.dart";
import "package:logger/logger.dart";
import "package:mocktail/mocktail.dart";
import "package:test/test.dart";

class MockLogger extends Mock implements Logger {}

void main() {
  final logger = MockLogger();
  final localLogger = LocalLogger(logger: logger);

  setUp(() {
    reset(logger);
  });

  group("Local Logger", () {
    test("sets default params and handles all three log types", () {
      when(() => logger.i(any())).thenReturn(null);

      localLogger.setDefaultParams(params: {"test": "testValue"});

      localLogger.log(name: "testEvent", params: {"testParam": "testParamValue"});
      verify(
        () => logger.i({
          "test": "testValue",
          "testParam": "testParamValue",
          "name": "testEvent",
        }),
      ).called(1);

      localLogger.logRepository(name: "event", repository: "testRepository", params: {"testParam": "testParamValue"});
      verify(
        () => logger.i({
          "test": "testValue",
          "testParam": "testParamValue",
          "repository": "testRepository",
          "name": "testRepository-repository-event",
        }),
      ).called(1);

      localLogger.logBloc(name: "event", bloc: "testBloc", params: {"testParam": "testParamValue"});
      verify(
        () => logger.i({
          "test": "testValue",
          "testParam": "testParamValue",
          "bloc": "testBloc",
          "name": "testBloc-bloc-event",
        }),
      ).called(1);

      localLogger.logUi(name: "event", page: "testPage", params: {"testParam": "testParamValue"});
      verify(
        () => logger.i({
          "test": "testValue",
          "testParam": "testParamValue",
          "page": "testPage",
          "name": "testPage-page-event",
        }),
      ).called(1);

      final defaultLocalLogger = LocalLogger();
      expect(Logger().runtimeType, defaultLocalLogger.logger.runtimeType);
    });
  });
}
