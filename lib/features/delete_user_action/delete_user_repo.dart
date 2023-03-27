import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rehab/app_core/app_core.dart';
import 'package:rehab/features/delete_user_action/delete_response.dart';

class DeleteUserRepo {
  final prefs = locator<PrefsService>();

  Future<DeleteResponse> deleteUser() async {
    // FormData formData = FormData.fromMap(request.toJson());
    // log('${formData.fields}');
    try {
      final Response response = await locator<ApiService>().dioClient.post(
            '${locator<ApiService>().dioClient.options.baseUrl}delete_account',
            // data: formData,
          );
      return DeleteResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return DeleteResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        log('xXx xc ${error.error}');
        return DeleteResponse.makeError(
            error: error,
            errorMsg: prefs.appLanguage == 'en'
                ? 'No Internet Connection'
                : 'لا يوجد إتصال بالشبكة');
      } else {
        log('xXx xc ${error.error}');
        String errorDescription = prefs.appLanguage == 'en'
            ? "Unexpected error occurred"
            : 'حدث خظأ غير متوقع';

        return DeleteResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
