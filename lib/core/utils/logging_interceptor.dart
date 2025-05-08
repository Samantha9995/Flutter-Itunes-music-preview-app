import 'package:dio/dio.dart';
import 'package:get/get.dart' as getX;
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/web.dart';

// Copyright (c) 2025 SADev. All rights reserved.

class LoggingInterceptor extends Interceptor {
  final logger = Get.find<Logger>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.e('--> ${options.method} ${options.uri}'); // Print request info
    logger.e('Headers:');
    options.headers.forEach((k, v) => logger.e('$k: $v'));
    logger.e('queryParameters: ${options.queryParameters}');
    if (options.data != null) {
      logger.e('Body: ${options.data}');
    }
    logger.e('--> END ${options.method}');

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.e('<-- ${response.statusCode} ${response.requestOptions.uri}');
    logger.e('Headers:');
    response.headers.forEach((k, list) => logger.e('$k: $list'));
    logger.e('Response: ${response.data}');
    logger.e('<-- END HTTP');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e('<-- Error -->');
    logger.e(
        'DioErrorType: ${err.type}, Message: ${err.message}, Response: ${err.response}');
    return super.onError(err, handler);
  }
}
