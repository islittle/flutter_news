// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/common/consts/index.dart';
import 'package:flutter_news/components/index.dart';
import 'package:flutter_news/utils/index.dart';
import 'package:flutter_news/global.dart';

// 异常处理
class ErrorEntity implements Exception {
  int? code;
  String message;
  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == null) return "Exception";
    return "Exception: code $code, $message";
  }
}

class Request {
  static final Request _instance = Request._internal();
  factory Request() => _instance;
  var dio = Dio();
  CancelToken cancelToken = CancelToken();

  Request._internal() {
    BaseOptions options = BaseOptions(
      // 请求基地址,可以包含子路径
      baseUrl: SERVER_API_URL,

      // baseUrl: storage.read(key: STORAGE_KEY_APIURL) ?? SERVICE_API_BASEURL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,

      // 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 5000,

      // Http请求头.
      headers: {},

      /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
      /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
      /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
      /// 就会自动编码请求体.
      contentType: 'application/json; charset=utf-8',

      /// [responseType] 表示期望以那种格式(方式)接受响应数据。
      /// 目前 [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`.
      ///
      /// 默认值是 `JSON`, 当响应头中content-type为"application/json"时，dio 会自动将响应内容转化为json对象。
      /// 如果想以二进制方式接受响应数据，如下载一个二进制文件，那么可以使用 `STREAM`.
      ///
      /// 如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
      responseType: ResponseType.json,
    );

    dio = Dio(options);

    var cookieJar = CookieJar();

    dio.interceptors.add(CookieManager(cookieJar));

    // 添加拦截器
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      handler.next(options);
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      handler.next(response);
    }, onError: (DioError err, ErrorInterceptorHandler handler) {
      ErrorEntity errorInfo = createErrorEntity(err);

      // 错误提示
      toastInfo(message: errorInfo.message);
      // 错误交互处理
      var context = err.requestOptions.extra["context"];
      if (context != null) {
        switch (errorInfo.code) {
          case 401: // 没有权限 重新登录
            goLoginPage(context);
            break;
          default:
        }
      }

      handler
          .next(DioError(requestOptions: err.requestOptions, error: errorInfo));
    }));

    /// 加内存缓存
    dio.interceptors.add(NetCache());

    /// 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    if (!Global.isRelease && PROXY_ENABLE) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY $PROXY_IP:$PROXY_PORT";
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

// error 统一处理，错误信息
  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return ErrorEntity(code: -1, message: "请求取消");
      case DioErrorType.connectTimeout:
        return ErrorEntity(code: -1, message: "连接超时");
      case DioErrorType.sendTimeout:
        return ErrorEntity(code: -1, message: "请求超时");
      case DioErrorType.receiveTimeout:
        return ErrorEntity(code: -1, message: "响应超时");
      case DioErrorType.response:
        try {
          int? errCode = error.response?.statusCode;
          String statusMessage = error.response?.statusMessage ?? '';
          switch (errCode) {
            case 400:
              return ErrorEntity(code: errCode, message: "请求语法错误");
            case 401:
              return ErrorEntity(code: errCode, message: "没有权限");
            case 403:
              return ErrorEntity(code: errCode, message: "服务器拒绝执行");
            case 404:
              return ErrorEntity(code: errCode, message: "无法连接服务器");
            case 405:
              return ErrorEntity(code: errCode, message: "请求方法被禁止");
            case 500:
              return ErrorEntity(code: errCode, message: "服务器内部错误");
            case 502:
              return ErrorEntity(code: errCode, message: "无效的请求");
            case 503:
              return ErrorEntity(code: errCode, message: "服务器挂了");
            case 505:
              return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
            default:
              return ErrorEntity(code: errCode, message: statusMessage);
          }
        } on Exception catch (_) {
          return ErrorEntity(code: -1, message: "未知错误");
        }
      default:
        return ErrorEntity(code: -1, message: error.message);
    }
  }

/*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  /// 读取本地配置
  Map<String, dynamic>? getAuthorizationHeader() {
    Map<String, String>? headers;
    String accessToken = Global.profile.accessToken;
    if (accessToken != '') {
      headers = {
        'Authorization': 'Bearer $accessToken',
      };
    }
    return headers;
  }

  /// restful get 操作
  /// refresh 是否下拉刷新 默认 false
  /// noCache 是否不缓存 默认 true
  /// list 是否列表 默认 false
  /// cacheKey 缓存key
  Future get(
    String path, {
    required BuildContext context,
    dynamic params,
    Options? options,
    bool refresh = false,
    bool noCache = !CACHE_ENABLE,
    bool list = false,
    String? cacheKey,
    bool cacheDisk = false,
  }) async {
    try {
      Options requestOptions = options ?? Options();
      requestOptions = requestOptions.copyWith(extra: {
        "context": context,
        "refresh": refresh,
        "noCache": noCache,
        "list": list,
        "cacheKey": cacheKey,
      });
      Map<String, dynamic>? _authorization = getAuthorizationHeader();
      if (_authorization != null) {
        requestOptions = requestOptions.copyWith(headers: _authorization);
      }

      var response = await dio.get(path,
          queryParameters: params,
          options: requestOptions,
          cancelToken: cancelToken);
      return response.data;
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }

  /// restful post 操作
  Future post(String path,
      {dynamic params, Options? options, required BuildContext context}) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(extra: {
      "context": context,
    });
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.post(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  /// restful put 操作
  Future put(String path,
      {required BuildContext context, dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(extra: {
      "context": context,
    });
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.put(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  /// restful patch 操作
  Future patch(String path,
      {required BuildContext context, dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(extra: {
      "context": context,
    });
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.patch(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  /// restful delete 操作
  Future delete(String path,
      {required BuildContext context, dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(extra: {
      "context": context,
    });
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.delete(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  /// restful post form 表单提交操作
  Future postForm(String path,
      {required BuildContext context, dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(extra: {
      "context": context,
    });
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.post(path,
        data: FormData.fromMap(params),
        options: requestOptions,
        cancelToken: cancelToken);
    return response.data;
  }
}

final R = Request();
