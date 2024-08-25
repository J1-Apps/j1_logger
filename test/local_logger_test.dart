import "package:get_it/get_it.dart";
import "package:j1_logger/j1_logger.dart";
import "package:logger/logger.dart";
import "package:mocktail/mocktail.dart";
import "package:test/test.dart";

class MockLogger extends Mock implements Logger {}

final _locator = GetIt.instance;

void main() {
  final logger = MockLogger();
  final localLogger = LocalLogger(logger: logger);

  setUpAll(() {
    _locator.registerSingleton<J1Logger>(localLogger);
  });

  setUp(() {
    reset(logger);
  });

  group("Local Logger", () {
    test("sets default params and handles all three log types", () {
      when(() => logger.i(any())).thenReturn(null);

      J1Logger.setParams(params: {"test": "testValue"});

      J1Logger.log(name: "testEvent", params: {"testParam": "testParamValue"});
      verify(
        () => logger.i({
          "test": "testValue",
          "testParam": "testParamValue",
          "name": "testEvent",
        }),
      ).called(1);

      J1Logger.repository(name: "event", repository: "testRepository", params: {"testParam": "testParamValue"});
      verify(
        () => logger.i({
          "test": "testValue",
          "testParam": "testParamValue",
          "repository": "testRepository",
          "name": "testRepository-repository-event",
        }),
      ).called(1);

      J1Logger.bloc(name: "event", bloc: "testBloc", params: {"testParam": "testParamValue"});
      verify(
        () => logger.i({
          "test": "testValue",
          "testParam": "testParamValue",
          "bloc": "testBloc",
          "name": "testBloc-bloc-event",
        }),
      ).called(1);

      J1Logger.ui(name: "event", page: "testPage", params: {"testParam": "testParamValue"});
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
