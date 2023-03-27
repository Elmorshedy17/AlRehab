import 'package:rehab/app_core/fcm/FcmTokenManager.dart';
import 'package:rehab/app_core/fcm/localNotificationService.dart';
import 'package:rehab/app_core/fcm/pushNotification_service.dart';
import 'package:rehab/features/account_details/account_details_manager.dart';
import 'package:rehab/features/activities/activities_manager.dart';
import 'package:rehab/features/activities_details/activities_details_manager.dart';
import 'package:rehab/features/app_settings/app_settings_manager.dart';
import 'package:rehab/features/barcode/barcode_manager.dart';
import 'package:rehab/features/booking/booking_manager.dart';
import 'package:rehab/features/booking_history/booking_history_manager.dart';
import 'package:rehab/features/bottom_navigation/pages/family_card/family_manager.dart';
import 'package:rehab/features/bottom_navigation/pages/home/home_manager.dart';
import 'package:rehab/features/bottom_navigation/pages/playgrounds/playgrounds_manager.dart';
import 'package:rehab/features/branches/branches_manager.dart';
import 'package:rehab/features/check_box_agreement/check_box_agreement_manager.dart';
import 'package:rehab/features/contact_us/contact_us_manager.dart';
import 'package:rehab/features/course_details/course_details_manager.dart';
import 'package:rehab/features/courses/courses_manager.dart';
import 'package:rehab/features/delete_user_action/delete_user_manager.dart';
import 'package:rehab/features/faq/faq_manager.dart';
import 'package:rehab/features/festival_details/festival_details_manager.dart';
import 'package:rehab/features/festivals/festivals_manager.dart';
import 'package:rehab/features/forgot_password/forgot_password_manager.dart';
import 'package:rehab/features/gallery/gallery_manager.dart';
import 'package:rehab/features/gallery_details/gallery_details_manager.dart';
import 'package:rehab/features/hotel_or_chalet/hotel_or_chalet_manager.dart';
import 'package:rehab/features/hotels_and_chalets/hotels_and_chalets_manager.dart';
import 'package:rehab/features/login/login_manager.dart';
import 'package:rehab/features/management/management_manager.dart';
import 'package:rehab/features/news/news_manager.dart';
import 'package:rehab/features/news_details/news_details_manager.dart';
import 'package:rehab/features/notifications/notifications_manager.dart';
import 'package:rehab/features/offer_or_discount/offer_or_discount_manager.dart';
import 'package:rehab/features/offers_and_discounts/offers_and_discounts_manager.dart';
import 'package:rehab/features/pages/pages_manager.dart';
import 'package:rehab/features/playground_details/playground_details_manager.dart';
import 'package:rehab/features/profits/profits_manager.dart';
import 'package:rehab/features/register/register_manager.dart';
import 'package:rehab/features/report_product/report_product_manager.dart';
import 'package:rehab/features/search/search_manager.dart';
import 'package:rehab/features/settings_page/settings_manager.dart';
import 'package:get_it/get_it.dart';

import 'app_core.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Setup PrefsService.
  var instance = await PrefsService.getInstance();
  locator.registerSingleton<PrefsService>(instance!);

  /// AppLanguageManager
  locator.registerLazySingleton<AppLanguageManager>(() => AppLanguageManager());

  /// NavigationService
  locator.registerLazySingleton<NavigationService>(() => NavigationService());

  /// ToastTemplate
  locator.registerLazySingleton<ToastTemplate>(() => ToastTemplate());

  /// ApiService
  locator.registerLazySingleton<ApiService>(() => ApiService());

  /// NewsManager
  locator.registerLazySingleton<NewsManager>(() => NewsManager());

  /// HomeManager
  locator.registerLazySingleton<HomeManager>(() => HomeManager());

  /// NewsDetailsManager
  locator.registerLazySingleton<NewsDetailsManager>(() => NewsDetailsManager());

  /// ActivitiesManager
  locator.registerLazySingleton<ActivitiesManager>(() => ActivitiesManager());

  /// ActivityDetailsManager
  locator.registerLazySingleton<ActivityDetailsManager>(
      () => ActivityDetailsManager());

  /// ManagementManager
  locator.registerLazySingleton<ManagementManager>(() => ManagementManager());

  /// FestivalsManager
  locator.registerLazySingleton<FestivalsManager>(() => FestivalsManager());

  /// FestivalDetailsManager
  locator.registerLazySingleton<FestivalDetailsManager>(
      () => FestivalDetailsManager());

  /// CoursesManager
  locator.registerLazySingleton<CoursesManager>(() => CoursesManager());

  /// CourseDetailsManager
  locator.registerLazySingleton<CourseDetailsManager>(
      () => CourseDetailsManager());

  /// OffersAndDiscountsManager
  locator.registerLazySingleton<OffersAndDiscountsManager>(
      () => OffersAndDiscountsManager());

  /// OfferOrDiscountManager
  locator.registerLazySingleton<OfferOrDiscountManager>(
      () => OfferOrDiscountManager());

  /// HotelAndChaletsManager
  locator.registerLazySingleton<HotelAndChaletsManager>(
      () => HotelAndChaletsManager());

  /// HotelOrChaletManager
  locator.registerLazySingleton<HotelOrChaletManager>(
      () => HotelOrChaletManager());

  /// PlaygroundsManager
  locator.registerLazySingleton<PlaygroundsManager>(() => PlaygroundsManager());

  /// PlaygroundDetailsManager
  locator.registerLazySingleton<PlaygroundDetailsManager>(
      () => PlaygroundDetailsManager());

  /// LoginManager
  locator.registerLazySingleton<LoginManager>(() => LoginManager());

  /// RegisterManager
  locator.registerLazySingleton<RegisterManager>(() => RegisterManager());

  /// GalleryManager
  locator.registerLazySingleton<GalleryManager>(() => GalleryManager());

  /// GalleryDetailsManager
  locator.registerLazySingleton<GalleryDetailsManager>(
      () => GalleryDetailsManager());

  /// ReportProductManager
  locator.registerLazySingleton<ReportProductManager>(
      () => ReportProductManager());

  /// AccountDetailsManager
  locator.registerLazySingleton<AccountDetailsManager>(
      () => AccountDetailsManager());

  /// BarcodeManager
  locator.registerLazySingleton<BarcodeManager>(() => BarcodeManager());

  /// BranchesManager
  locator.registerLazySingleton<BranchesManager>(() => BranchesManager());

  /// PagesManager
  locator.registerLazySingleton<PagesManager>(() => PagesManager());

  /// FAQManager
  locator.registerLazySingleton<FAQManager>(() => FAQManager());

  /// ContactUsManager
  locator.registerLazySingleton<ContactUsManager>(() => ContactUsManager());

  /// SettingsManager
  locator.registerLazySingleton<SettingsManager>(() => SettingsManager());

  /// AppSettingsManager
  locator.registerLazySingleton<AppSettingsManager>(() => AppSettingsManager());

  /// FcmTokenManager
  locator.registerLazySingleton<FcmTokenManager>(() => FcmTokenManager());

  /// LocalNotificationService
  locator.registerLazySingleton<LocalNotificationService>(
      () => LocalNotificationService());

  /// PushNotificationService
  locator.registerLazySingleton<PushNotificationService>(
      () => PushNotificationService());

  /// NotificationsManager
  locator.registerLazySingleton<NotificationsManager>(
      () => NotificationsManager());

  /// FamilyCartManager
  locator.registerLazySingleton<FamilyCartManager>(() => FamilyCartManager());

  /// SearchManager
  locator.registerLazySingleton<SearchManager>(() => SearchManager());

  /// ForgotPasswordManager
  locator.registerLazySingleton<ForgotPasswordManager>(
      () => ForgotPasswordManager());

  /// ProfitsManager
  locator.registerLazySingleton<ProfitsManager>(() => ProfitsManager());

  /// CheckBoxManager
  locator.registerLazySingleton<CheckBoxManager>(() => CheckBoxManager());

  /// BookingManager
  locator.registerLazySingleton<BookingManager>(() => BookingManager());

  /// BookingHistoryManager
  locator.registerLazySingleton<BookingHistoryManager>(() => BookingHistoryManager());

  /// DeleteUserManager
  locator.registerLazySingleton<DeleteUserManager>(() => DeleteUserManager());
}
