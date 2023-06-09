import 'dart:io';

import 'package:rehab/app_core/app_core.dart';
import 'package:rehab/features/festival_details/festival_details_response.dart';
import 'package:dio/dio.dart';

class FestivalDetailsRepo {
  static Future<FestivalDetailsResponse> festivalDetails(
      {required int festivalId}) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}offer/$festivalId',
          );

      return FestivalDetailsResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return FestivalDetailsResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return FestivalDetailsResponse.makeError(
            error: error,
            errorMsg: locator<PrefsService>().appLanguage == 'en'
                ? 'No Internet Connection'
                : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return FestivalDetailsResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
