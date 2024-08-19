import "package:j1_logger/logger.dart";
import "package:logger/logger.dart";

class LocalLogger extends J1Logger {
  final Logger logger;
  final Map<String, Object> _defaultParams;

  LocalLogger({Logger? logger})
      : logger = logger ?? Logger(),
        _defaultParams = {};

  @override
  void setDefaultParams({required Map<String, Object> params}) {
    _defaultParams.clear();
    _defaultParams.addAll(params);
  }

  @override
  void log({required String name, Map<String, Object>? params}) {
    logger.i({..._defaultParams, ...params ?? {}, "name": name});
  }
}
