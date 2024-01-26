import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:synapsis_mobile_engineer_challenge/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/options.dart' as Opt;
import 'package:synapsis_mobile_engineer_challenge/core/exceptions/failure.dart';

abstract class AssessmentDataSource {
  factory AssessmentDataSource(Dio dio) = AssessmentDataSourceImpl;
  Future<dynamic> getAssessments({
    required String? page,
  });
}

class AssessmentDataSourceImpl implements AssessmentDataSource {
  AssessmentDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<dynamic> getAssessments({String? page}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _cookie = prefs.getString('cookie');

    try {
      final response = await _dio.get(
        '$assessmentBaseUrl/assessments',
        queryParameters: {'page': page},
        options: Opt.Options(
          headers: {'Cookie': _cookie},
        ),
      );
      if (response.statusCode == 200) {
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
