import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('--> ${options.method} ${options.uri}'); // Print request info
    print('Headers:');
    options.headers.forEach((k, v) => print('$k: $v'));
    if (options.queryParameters != null) {
      print('queryParameters: ${options.queryParameters}');
    }
    if (options.data != null) {
      print('Body: ${options.data}');
    }
    print('--> END ${options.method}');

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('<-- ${response.statusCode} ${response.requestOptions.uri}');
    print('Headers:');
    response.headers.forEach((k, list) => print('$k: $list'));
    print('Response: ${response.data}');
    print('<-- END HTTP');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('<-- Error -->');
    print(
        'DioErrorType: ${err.type}, Message: ${err.message}, Response: ${err.response}');
    return super.onError(err, handler);
  }
}