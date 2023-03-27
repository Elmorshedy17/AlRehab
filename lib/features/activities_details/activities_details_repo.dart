import 'dart:developer';
import 'dart:io';

import 'package:rehab/app_core/app_core.dart';
import 'package:rehab/features/activities_details/activities_details_response.dart';
import 'package:dio/dio.dart';

class ActivityDetailsRepo {
  static Future<ActivityDetailsResponse> activityDetails(
      {required int activityId}) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}activity/$activityId',
          );

      return ActivityDetailsResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return ActivityDetailsResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        log('xXx xc ${error.error}');
        return ActivityDetailsResponse.makeError(
            error: error,
            errorMsg: locator<PrefsService>().appLanguage == 'en'
                ? 'No Internet Connection'
                : 'لا يوجد إتصال بالشبكة');
      } else {
        log('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return ActivityDetailsResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
