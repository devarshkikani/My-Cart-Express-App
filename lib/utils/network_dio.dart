// ignore_for_file: use_build_context_synchronously, prefer_adjacent_string_concatenation

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/storage_key.dart';
import 'package:my_cart_express/utils/internet_error.dart';
import 'package:my_cart_express/utils/progress_indicator.dart';

class NetworkDio {
  static late Dio _dio;
  static GetStorage box = GetStorage();
  static Circle processIndicator = Circle();
  // static late DioCacheManager _dioCacheManager;
  static final Options cacheOptions =
      buildCacheOptions(const Duration(seconds: 1), forceRefresh: true);

  static Future<void> setDynamicHeader() async {
    BaseOptions options =
        BaseOptions(receiveTimeout: 50000, connectTimeout: 50000);
    // _dioCacheManager = DioCacheManager(CacheConfig());
    final token = await _getHeaders();
    options.headers.addAll(token);
    _dio = Dio(options);
    // _dio.interceptors.add(_dioCacheManager.interceptor);

    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult event) async {});
  }

  static Future<Map<String, String>> _getHeaders() async {
    String? apiToken = box.read(StorageKey.apiToken);
    if (kDebugMode) {
      print('~~~~~~~~~~~~~~~~~~~~ X-API-KEY : $apiToken ~~~~~~~~~~~~~~~~~~~');
      print('AUTH KEY : $apiToken ');
    }
    if (apiToken != null) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-API-KEY': apiToken,
        'X-AUTH-KEY': ApiEndPoints.authKey,
      };
    } else {
      return {
        'X-AUTH-KEY': ApiEndPoints.authKey,
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
    }
  }

  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static Future<Map<String, dynamic>?> postDioHttpMethod({
    BuildContext? context,
    required String url,
    required data,
  }) async {
    var internet = await check();
    if (internet) {
      if (context != null) processIndicator.show(context);
      try {
        if (kDebugMode) {
          print('+++URL : $url');
          print('+++Data: $data');
        }
        var response = await _dio.post(
          url,
          data: data,
          options: cacheOptions,
        );
        if (kDebugMode) {
          print('+++Response: ' + '$response');
        }
        Map<String, dynamic> responseBody = {};
        if (context != null) processIndicator.hide(context);

        if (response.statusCode == 200) {
          try {
            responseBody = json.decode(response.data);
          } catch (e) {
            responseBody = response.data;
          }
          if (responseBody['status'] == 200) {
            return responseBody;
          } else {
            showError(
              title: 'Error',
              errorMessage: responseBody['message'],
            );
            return null;
          }
        } else {
          showError(
            title: 'Error',
            errorMessage: response.statusMessage.toString(),
          );
          return null;
        }
      } on DioError catch (e) {
        if (kDebugMode) {
          print('DioError +++ $e');
        }
        if (context != null) processIndicator.hide(context);
        showError(title: 'Error', errorMessage: e.toString());
        return null;
      } catch (e) {
        if (kDebugMode) {
          print('Catch +++ $e');
        }
        if (context != null) processIndicator.hide(context);
        showError(title: 'Error', errorMessage: e.toString());
        return null;
      }
    } else {
      if (context != null) InternetError.addOverlayEntry(context);
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getDioHttpMethod({
    BuildContext? context,
    required String url,
  }) async {
    var internet = await check();
    if (internet) {
      if (context != null) processIndicator.show(context);
      try {
        if (kDebugMode) {
          print('+++URL : $url');
        }
        var response = await _dio.get(
          url,
          options: cacheOptions,
        );
        if (kDebugMode) {
          print('+++Response: ' + '$response');
        }
        Map<String, dynamic> responseBody = {};
        if (context != null) processIndicator.hide(context);

        if (response.statusCode == 200) {
          try {
            responseBody = json.decode(response.data);
          } catch (e) {
            responseBody = response.data;
          }
          if (responseBody['status'] == 200) {
            return responseBody;
          } else {
            showError(
              title: 'Error',
              errorMessage: responseBody['message'],
            );
            return null;
          }
        } else {
          showError(
            title: 'Error',
            errorMessage: response.statusMessage.toString(),
          );
          return null;
        }
      } on DioError catch (e) {
        if (kDebugMode) {
          print('DioError +++ $e');
        }
        if (context != null) processIndicator.hide(context);
        showError(title: 'Error', errorMessage: e.toString());
        return null;
      } catch (e) {
        if (kDebugMode) {
          print('Catch +++ $e');
        }
        if (context != null) processIndicator.hide(context);
        showError(title: 'Error', errorMessage: e.toString());
        return null;
      }
    } else {
      if (context != null) InternetError.addOverlayEntry(context);
      return null;
    }
  }

  static void showSuccess({
    required String title,
    required String sucessMessage,
  }) {
    Get.snackbar(
      title,
      sucessMessage,
      margin: const EdgeInsets.all(15),
      backgroundColor: Colors.greenAccent.withOpacity(0.5),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static void showError({
    required String title,
    required String errorMessage,
  }) {
    Get.snackbar(
      title,
      errorMessage,
      backgroundColor: Colors.redAccent.withOpacity(0.5),
      margin: const EdgeInsets.all(15),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
