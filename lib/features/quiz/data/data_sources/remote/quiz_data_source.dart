import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/src/options.dart' as Opt;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synapsis_mobile_engineer_challenge/core/constants/api_constants.dart';
import 'package:synapsis_mobile_engineer_challenge/core/dto/params.dart';
import 'package:synapsis_mobile_engineer_challenge/core/exceptions/failure.dart';

abstract class QuizDataSource {
  factory QuizDataSource(Dio dio) = QuizDataSourceImpl;
  Future<dynamic> getQuestions({required String? assessmentId});
  Future<dynamic> finishQuiz({required SubmitQuiz? quizParams});
}

class QuizDataSourceImpl implements QuizDataSource {
  QuizDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future getQuestions({required String? assessmentId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _cookie = prefs.getString('cookie');

    try {
      Response response = await _dio.get(
        '$assessmentBaseUrl/assessments/question/$assessmentId',
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

  @override
  Future finishQuiz({required SubmitQuiz? quizParams}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _cookie = prefs.getString('cookie');

    try {
      final response =
          await _dio.post('$assessmentBaseUrl/assessments/send-answer',
              options: Opt.Options(
                headers: {'Cookie': _cookie},
              ),
              data: quizParams!.toJson());
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
