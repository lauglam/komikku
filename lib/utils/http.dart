import 'package:dio/dio.dart';
import 'package:komikku/database/hive.dart';
import 'package:komikku/dex/apis/auth_api.dart';
import 'package:komikku/dex/models/refresh_token.dart';
import 'package:komikku/utils/app_settings.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;

  Dio? dio;
  CancelToken? cancelToken = CancelToken();

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: serverUrl,
      connectTimeout: 8000,
      receiveTimeout: 8000,
      headers: {},
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );

    dio = Dio(options);

    dio?.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      return handler.next(options); //continue
      // 如果你想完成请求并返回一些自定义数据，你可以resolve一个Response对象 `handler.resolve(response)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`handler.reject(error)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onResponse: (response, handler) {
      // Do something with response data
      return handler.next(response); // continue
      // 如果你想终止请求并触发一个错误,你可以 reject 一个`DioError`对象,如`handler.reject(error)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onError: (DioError e, handler) async {
      // Do something with response error
      return handler.next(e); //continue
      // 如果你想完成请求并返回一些自定义数据，可以resolve 一个`Response`,如`handler.resolve(response)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
    }));
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel('cancelled');
  }

  /// 读取本地配置
  Future<Options> getLocalOptions() async {
    Options options = Options();

    // 查看是否登录
    if (HiveDatabase.userLoginState) {
      if (HiveDatabase.sessionToken == null) {
        final response = await AuthApi.refreshAsync(RefreshToken(token: HiveDatabase.refreshToken!));
        HiveDatabase.sessionToken = response.token.session;
      }

      options = Options(headers: {
        'Authorization': 'Bearer ${HiveDatabase.sessionToken}',
      });
    }
    return options;
  }

  /// restful get 操作
  Future get(String path, {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {
      var tokenOptions = options ?? await getLocalOptions();
      final response = await dio?.get(path,
          queryParameters: params, options: tokenOptions, cancelToken: cancelToken);
      return response?.data;
    } on DioError catch (e) {
      throw createException(e);
    }
  }

  /// restful post 操作
  Future post(String path, {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {
      var tokenOptions = options ?? await getLocalOptions();
      final response =
          await dio?.post(path, data: params, options: tokenOptions, cancelToken: cancelToken);
      return response?.data;
    } on DioError catch (e) {
      throw createException(e);
    }
  }

  /// restful put 操作
  Future put(String path, {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {
      var tokenOptions = options ?? await getLocalOptions();
      final response =
          await dio?.put(path, data: params, options: tokenOptions, cancelToken: cancelToken);
      return response?.data;
    } on DioError catch (e) {
      throw createException(e);
    }
  }

  /// restful patch 操作
  Future patch(String path, {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {
      var tokenOptions = options ?? await getLocalOptions();
      final response =
          await dio?.patch(path, data: params, options: tokenOptions, cancelToken: cancelToken);
      return response?.data;
    } on DioError catch (e) {
      throw createException(e);
    }
  }

  /// restful delete 操作
  Future delete(String path, {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {
      var tokenOptions = options ?? await getLocalOptions();
      final response =
          await dio?.delete(path, data: params, options: tokenOptions, cancelToken: cancelToken);
      return response?.data;
    } on DioError catch (e) {
      throw createException(e);
    }
  }

  /// restful post form 表单提交操作
  Future postForm(String path, {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {
      var tokenOptions = options ?? await getLocalOptions();
      final response = await dio?.post(path,
          data: FormData.fromMap(params), options: tokenOptions, cancelToken: cancelToken);
      return response?.data;
    } on DioError catch (e) {
      throw createException(e);
    }
  }

  /// 异常处理
  HttpException createException(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        {
          return HttpException(code: -1, message: '请求取消');
        }
      case DioErrorType.connectTimeout:
        {
          return HttpException(code: -1, message: '连接超时');
        }

      case DioErrorType.sendTimeout:
        {
          return HttpException(code: -1, message: '请求超时');
        }

      case DioErrorType.receiveTimeout:
        {
          return HttpException(code: -1, message: '响应超时');
        }

      case DioErrorType.response:
        {
          try {
            int? errCode = error.response?.statusCode ?? 000;
            switch (errCode) {
              case 400:
                {
                  return HttpException(code: errCode, message: '请求语法错误');
                }
              case 401:
                {
                  return HttpException(code: errCode, message: '没有权限');
                }
              case 403:
                {
                  return HttpException(code: errCode, message: '服务器拒绝执行');
                }
              case 404:
                {
                  return HttpException(code: errCode, message: '无法找到数据');
                }
              case 405:
                {
                  return HttpException(code: errCode, message: '请求方法被禁止');
                }
              case 409:
                {
                  return HttpException(code: errCode, message: '请求次数过多');
                }
              case 412:
                {
                  return HttpException(code: errCode, message: '需要验证码');
                }
              case 500:
                {
                  return HttpException(code: errCode, message: '服务器内部错误');
                }
              case 502:
                {
                  return HttpException(code: errCode, message: '无效的请求');
                }
              case 503:
                {
                  return HttpException(code: errCode, message: '服务器挂了');
                }
              case 505:
                {
                  return HttpException(code: errCode, message: '不支持HTTP协议请求');
                }
              default:
                {
                  return HttpException(
                      code: errCode, message: error.response?.statusMessage ?? '网络错误');
                }
            }
          } on Exception catch (_) {
            return HttpException(code: -1, message: '未知错误');
          }
        }
      default:
        {
          return HttpException(code: -1, message: error.message);
        }
    }
  }
}

/// Http异常
class HttpException implements Exception {
  int code;
  String message;

  HttpException({
    required this.code,
    required this.message,
  });

  @override
  String toString() => 'Exception: code $code, $message';
}
