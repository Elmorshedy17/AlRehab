import 'package:rehab/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:rehab/features/account_details/account_details_page.dart';
import 'package:rehab/features/activities/activities_page.dart';
import 'package:rehab/features/activities_details/activities_details_page.dart';
import 'package:rehab/features/ads/ads_page.dart';
import 'package:rehab/features/app_settings/fix/fix_page.dart';
import 'package:rehab/features/barcode/barcode_page.dart';
import 'package:rehab/features/booking/booking_payment/booking_web_view.dart';
import 'package:rehab/features/booking_history/booking_history_page.dart';
import 'package:rehab/features/bottom_navigation/main_tabs_widget.dart';
import 'package:rehab/features/bottom_navigation/pages/family_card/family_card_page.dart';
import 'package:rehab/features/bottom_navigation/pages/family_card/family_card_result_page/family_card_result_page.dart';
import 'package:rehab/features/branches/branches_page.dart';
import 'package:rehab/features/contact_us/contact_us_page.dart';
import 'package:rehab/features/course_details/course_details_page.dart';
import 'package:rehab/features/courses/courses_page.dart';
import 'package:rehab/features/faq/faq_page.dart';
import 'package:rehab/features/festival_details/festival_details_page.dart';
import 'package:rehab/features/festivals/festivals_page.dart';
import 'package:rehab/features/forgot_password/forgot_password_page.dart';
import 'package:rehab/features/gallery/gallery_page.dart';
import 'package:rehab/features/gallery_details/gallery_details_page.dart';
import 'package:rehab/features/hotel_or_chalet/hotel_or_chalet_page.dart';
import 'package:rehab/features/hotels_and_chalets/hotels_and_chalets_page.dart';
import 'package:rehab/features/intro/intro_page.dart';
import 'package:rehab/features/login/login_page.dart';
import 'package:rehab/features/management/management_page.dart';
import 'package:rehab/features/news/news_page.dart';
import 'package:rehab/features/news_details/news_details_page.dart';
import 'package:rehab/features/notifications/notifications_page.dart';
import 'package:rehab/features/offer_or_discount/offer_or_discount_page.dart';
import 'package:rehab/features/offers_and_discounts/offers_and_discounts_page.dart';
import 'package:rehab/features/pages/pages_page.dart';
import 'package:rehab/features/playground_details/playground_details_page.dart';
import 'package:rehab/features/profits/profits_page.dart';
import 'package:rehab/features/profits/profits_result_page/profits_result_page.dart';
import 'package:rehab/features/register/register_page.dart';
import 'package:rehab/features/report_product/report_product_page.dart';
import 'package:rehab/features/search/search_page.dart';
import 'package:rehab/features/settings_page/settings_page.dart';
import 'package:flutter/material.dart';

import '../../../features/home/home_page.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    // AppRoutesNames.mainTabsWidget: (_) => const MainTabsWidget(),
    AppRoutesNames.newsPage: (_) => const NewsPage(),
    AppRoutesNames.newsDetailsPage: (_) => const NewsDetailsPage(),
    AppRoutesNames.activitiesPage: (_) => const ActivitiesPage(),
    AppRoutesNames.activitiesDetailsPage: (_) => const ActivitiesDetailsPage(),
    AppRoutesNames.managementPage: (_) => const ManagementPage(),
    AppRoutesNames.festivalsPage: (_) => const FestivalsPage(),
    AppRoutesNames.festivalDetailsPage: (_) => const FestivalDetailsPage(),
    AppRoutesNames.courseDetailsPage: (_) => const CourseDetailsPage(),
    AppRoutesNames.coursesPage: (_) => const CoursesPage(),
    AppRoutesNames.offersAndDiscountsPage: (_) =>
        const OffersAndDiscountsPage(),
    AppRoutesNames.offerOrDiscountPage: (_) => const OfferOrDiscountPage(),
    AppRoutesNames.hotelAndChaletsPage: (_) => const HotelAndChaletsPage(),
    AppRoutesNames.hotelOrChaletPage: (_) => const HotelOrChaletPage(),
    AppRoutesNames.playgroundDetailsPage: (_) => const PlaygroundDetailsPage(),
    // AppRoutesNames.loginPage: (_) => const LoginPage(),
    // AppRoutesNames.registerPage: (_) => const RegisterPage(),
    // AppRoutesNames.forgotPasswordPage: (_) => const ForgotPasswordPage(),
    AppRoutesNames.galleryPage: (_) => const GalleryPage(),
    AppRoutesNames.galleryDetailsPage: (_) => const GalleryDetailsPage(),
    AppRoutesNames.barcodePage: (_) => const BarcodePage(),
    AppRoutesNames.reportProductPage: (_) => const ReportProductPage(),
    // AppRoutesNames.accountDetailsPage: (_) => const AccountDetailsPage(),
    AppRoutesNames.branchesPage: (_) => const BranchesPage(),
    // AppRoutesNames.settingsPage: (_) => const SettingsPage(),
    AppRoutesNames.pagesPage: (_) => const PagesPage(),
    AppRoutesNames.faqPage: (_) => const FAQPage(),
    AppRoutesNames.contactUsPage: (_) => const ContactUsPage(),
    AppRoutesNames.notificationsPage: (_) => const NotificationsPage(),
    AppRoutesNames.familyCardPage: (_) => const FamilyCardPage(),
    AppRoutesNames.familyCardResultsPage: (_) => const FamilyCardResultsPage(),
    AppRoutesNames.searchPage: (_) => const SearchPage(),
    AppRoutesNames.adsPage: (_) => const AdsPage(),
    AppRoutesNames.introPage: (_) => const IntroPage(),
    AppRoutesNames.fixPage: (_) => const FixPage(),
    AppRoutesNames.profitsPage: (_) => const ProfitsPage(),
    AppRoutesNames.profitsResultsPage: (_) => const ProfitsResultsPage(),
    AppRoutesNames.bookingWebViewPage: (_) => const BookingWebViewPage(),
    AppRoutesNames.bookingHistoryPage: (_) => const BookingHistoryPage(),
    AppRoutesNames.HomePage: (_) => const HomePage(),
    // AppRoutesNames.ContactUsPage: (_) => const ContactUsPage(),
  };
}
