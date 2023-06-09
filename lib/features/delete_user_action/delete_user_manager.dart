import 'dart:io';

import 'package:rehab/app_core/app_core.dart';
import 'package:rehab/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:rehab/features/delete_user_action/delete_user_repo.dart';
import 'package:rehab/features/login/auth_response.dart';
import 'package:rxdart/rxdart.dart';

class DeleteUserManager extends Manager<AuthResponse> {
  final DeleteUserRepo _deleteUserRepo = DeleteUserRepo();
  final _prefs = locator<PrefsService>();
  String? errorDescription;

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  Future<ManagerState> deleteUser() async {
    var managerState = ManagerState.loading;
    inState.add(ManagerState.loading);
    await _deleteUserRepo.deleteUser().then((result) {
      if (result.status == 1) {
        inState.add(ManagerState.success);

        // locator<NavigationService>()
        //     .pushReplacementNamedTo(AppRoutesNames.MainPageWithDrawer);
        _prefs.removeUserObj();

        // locator<NavigationService>()
        //     .pushNamedAndRemoveUntil(AppRoutesNames.loginPage);

        managerState = ManagerState.success;
      } else if (result.status == 0) {
        inState.add(ManagerState.error);
        errorDescription = result.message;
        managerState = ManagerState.error;
      } else if (result.error.error is SocketException) {
        inState.add(ManagerState.socketError);
        errorDescription = _prefs.appLanguage == 'en'
            ? 'No Internet Connection'
            : 'لا يوجد إتصال بالشبكة';
        managerState = ManagerState.socketError;
      } else {
        inState.add(ManagerState.unknownError);
        errorDescription = _prefs.appLanguage == 'en'
            ? "Unexpected error occurred"
            : 'حدث خظأ غير متوقع';
        managerState = ManagerState.unknownError;
      }

      // locator<NavigationService>()
      //     .pushNamedAndRemoveUntil(AppRoutesNames.loginPage);
    });
    return managerState;
  }

  @override
  void dispose() {
    _stateSubject.close();
  }
}
