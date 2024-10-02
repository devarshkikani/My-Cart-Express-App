// ignore_for_file: use_build_context_synchronously, prefer_adjacent_string_concatenation

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:my_cart_express/order_tracking_app/constant/storage_key.dart';
import 'package:my_cart_express/order_tracking_app/screens/authentication/welcome_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/home_screen/home_screen.dart';
import 'package:my_cart_express/order_tracking_app/utils/internet_error.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/utils/progress_indicator.dart';

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
    }
    if (apiToken != null) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'User-Access-Token': apiToken,
        'Mycart-Auth-Key': ApiEndPoints.authKey,
      };
    } else {
      return {
        'Mycart-Auth-Key': ApiEndPoints.authKey,
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

        if (response.statusCode == 200 || response.statusCode == 20) {
          try {
            responseBody = json.decode(response.data);
          } catch (e) {
            responseBody = response.data;
          }
          if (responseBody['status'] == 200 ||
              responseBody['status'] == 20 ||
              responseBody['success'] == 200) {
            return responseBody;
          } else if (responseBody['status'] == 409) {
            Map<String, dynamic>? res = await handleErrorRefreshToken(
              data: data,
              isPost: true,
              url: url,
              context: context,
            );
            return res;
          } else {
            print('+++Response: ' + '$response');
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
        print('+++Response: ' + '$e');
        var response = e.response;
        if (kDebugMode) {
          print('DioError +++ $e');
        }
        if (context != null) processIndicator.hide(context);
        if (response != null) {
          showError(
              title: 'Error',
              errorMessage: response.data == ''
                  ? response.statusMessage.toString()
                  : 'Some thing went wrong, please try again later.');
        } else {
          showError(
              title: 'Error',
              errorMessage: 'Some thing went wrong, please try again later.');
        }
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
          if (responseBody['status'] == 200 || responseBody['success'] == 200) {
            return responseBody;
          } else if (responseBody['status'] == 409) {
            Map<String, dynamic>? res = await handleErrorRefreshToken(
              isPost: false,
              url: url,
              context: context,
              data: null,
            );
            return res;
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
        var response = e.response;
        if (kDebugMode) {
          print('DioError +++ $e');
        }
        if (context != null) processIndicator.hide(context);
        if (response != null) {
          showError(
              title: 'Error',
              errorMessage: response.data == ''
                  ? response.statusMessage.toString()
                  : 'Some thing went wrong, please try again later.');
        } else {
          showError(
              title: 'Error',
              errorMessage: 'Some thing went wrong, please try again later.');
        }
        return null;
      } catch (e) {
        if (kDebugMode) {
          print('Catch +++ $e');
        }
        if (context != null) processIndicator.hide(context);
        showError(title: 'Error', errorMessage: 'Some thing went wrong');
        return null;
      }
    } else {
      if (context != null) InternetError.addOverlayEntry(context);
      return null;
    }
  }

  static Future<Map<String, dynamic>?> handleErrorRefreshToken({
    BuildContext? context,
    required String url,
    required Map<String, dynamic>? data,
    required bool isPost,
  }) async {
    String? token = await refreshToken(context);
    if (token != null) {
      Map<String, dynamic>? response = await reExecuteRequest(
        isPost,
        context,
        url,
        data,
      );
      return response;
    } else {
      box.erase();
      callInitState = false;
      Get.offAll(
        () => const WelcomeScreen(),
      );
      return null;
    }
  }

  static Future<Map<String, dynamic>?> reExecuteRequest(
      bool type, BuildContext? context, String url, data) async {
    Map<String, dynamic>? response = type
        ? await postDioHttpMethod(context: context, url: url, data: data)
        : await getDioHttpMethod(context: context, url: url);
    return response;
  }

  static Future<String?> refreshToken(BuildContext? context) async {
    String? token = await FirebaseMessaging.instance.getToken();
    final data = dio.FormData.fromMap({
      'firebase_token': token,
      'user_id': box.read(StorageKey.userId),
      'device': Platform.isAndroid ? 1 : 2,
    });
    if (token == null) {
      return null;
    }
    Map<String, dynamic>? response = await postDioHttpMethod(
      data: data,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.refreshToken,
      context: context,
    );
    if (response != null) {
      if (response['status'] == 200) {
        box.write(StorageKey.apiToken, response['token']);
        await setDynamicHeader();
        return token;
      } else {
        return null;
      }
    } else {
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
