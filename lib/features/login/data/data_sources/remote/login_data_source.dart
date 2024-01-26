import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synapsis_mobile_engineer_challenge/core/constants/api_constants.dart';
import 'package:synapsis_mobile_engineer_challenge/core/exceptions/failure.dart';

abstract class LoginDataSource {
  factory LoginDataSource(Dio dio) = LoginDataSourceImpl;
  Future<dynamic> login(
      {required String? email,
      required String? password,
      required bool? isSaved});
}

class LoginDataSourceImpl implements LoginDataSource {
  LoginDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future login(
      {required String? email,
      required String? password,
      required bool? isSaved}) async {
    var json = {"nik": email, "password": password};
    try {
      final response = await _dio.post(
        '$assessmentBaseUrl/login',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(json),
      );
      if (response.statusCode == 200) {
        String cookie = response.headers.map['set-cookie']![0];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('cookie', cookie);
        if (isSaved == true) {
          prefs.setString('email', email!);
          prefs.setString('password', password!);
        }
        return response;
      } else {
        throw DioException(
            error: response.statusMessage,
            response: response,
            type: DioExceptionType.badResponse,
            requestOptions: response.requestOptions);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('data catch login dsource tereksekusi ${e.response!.data}');
        throw ServerFailure(errorMessage: e.response!.data['message']);
      } else if (e.isNoConnectionError) {
        throw ServerFailure(errorMessage: 'Koneksi internet Anda terputus.');
      } else {
        rethrow;
      }
    }
  }
}

extension DioErrorX on DioException {
  bool get isNoConnectionError =>
      type == DioExceptionType.connectionError && error is SocketException;
}
