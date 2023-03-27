import 'dart:developer';
import 'dart:io';

import 'package:rehab/app_core/app_core.dart';
import 'package:rehab/app_core/resources/app_assets/app_assets.dart';
import 'package:rehab/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:rehab/app_core/resources/app_style/app_style.dart';
import 'package:rehab/features/booking/booking_manager.dart';
import 'package:rehab/features/booking/booking_payment/payment_gatway_response.dart';
import 'package:rehab/shared/main_app_bar/main_app_bar.dart';
import 'package:rehab/shared/main_button/main_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookingWebViewArgs {
  final String paymentUrl;

  BookingWebViewArgs({
    required this.paymentUrl,
  });
}

class BookingWebViewPage extends StatefulWidget {
  const BookingWebViewPage({
    Key? key,
  }) : super(key: key);

  @override
  State<BookingWebViewPage> createState() => _BookingWebViewPageState();
}

class _BookingWebViewPageState extends State<BookingWebViewPage> {
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  // Completer<WebViewController> _controller = Completer<WebViewController>();
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final BookingWebViewArgs args =
        ModalRoute.of(context)!.settings.arguments as BookingWebViewArgs;
    final bookingManager = context.use<BookingManager>();

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 1,
        //   backgroundColor: Colors.grey[100],
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back_ios),
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //   ),
        //   centerTitle: true,
        // ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          // child: SafeArea(
          child: const MainAppBar(
            showNotification: false,
            showBack: true,
            // showSearch: true,
            title: "الدفع",
          ),
          // ),
        ),
        body:
            // SingleChildScrollView(
            //   child:
            ValueListenableBuilder<bool>(
                valueListenable: isLoading,
                builder: (context, value, __) {
                  if (value) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: SpinKitWave(
                          color: AppStyle.red,
                          itemCount: 5,
                          size: 50.0,
                        ),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: WebView(
                        onWebViewCreated: (controller) async {
                          // _controller.complete(controller);
                          _controller = controller;
                          log('XXxXX${await _controller.currentUrl()}');
                        },
                        navigationDelegate:
                            (NavigationRequest navigation) async {
                          // print('XXxXX${await _controller.currentUrl()}');
                          NavigationDecision _n = NavigationDecision.navigate;
                          log('XXxXX${navigation.url}');
                          // success
                          // payment_fail

                          return _n;
                        },
                        initialUrl: args.paymentUrl,
                        javascriptMode: JavascriptMode.unrestricted,
                        onPageFinished: (url) async {
                          log('OOoOO $url');
                          if (url.startsWith('http://alrahabcoop-kw.com/')) {
                            isLoading.value = true;
                            await PaymentGatWay.paymentResponse(url)
                                .then((result) {
                              if (result.status == 1) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) {
                                      return WillPopScope(
                                        onWillPop: () async {
                                          int count = 0;
                                          Navigator.popUntil(context, (route) {
                                            return count++ == 2;
                                          });
                                          return false;
                                        },
                                        child: Dialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25))),
                                          child: Container(
                                            // width: 50,
                                            padding: const EdgeInsets.all(35.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                                Image.asset(
                                                  AppAssets.success,
                                                  height: 120.h,
                                                ),
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                                Text(
                                                  "${result.message}",
                                                  style: AppFontStyle
                                                      .darkGreyLabel
                                                      .copyWith(height: 1.6),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(
                                                  height: 35,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 30),
                                                  child: MainButtonWidget(
                                                      title: "تم",
                                                      onClick: () {
                                                        int count = 0;
                                                        Navigator.popUntil(
                                                            context, (route) {
                                                          return count++ == 2;
                                                        });
                                                        // Navigator.of(context)
                                                        //     .pop();
                                                        // Navigator.of(context)
                                                        //     .pop();
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });

                                // locator<ToastTemplate>()
                                //     .show("${result.message}");
                              } else {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) {
                                      return WillPopScope(
                                        onWillPop: () async {
                                          int count = 0;
                                          Navigator.popUntil(context, (route) {
                                            return count++ == 2;
                                          });
                                          return false;
                                        },
                                        child: Dialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25))),
                                          child: Container(
                                            // width: 50,
                                            padding: const EdgeInsets.all(35.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                                FaIcon(
                                                    FontAwesomeIcons
                                                        .squareXmark,
                                                    size: 120.sp),
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                                Text(
                                                  result.message ??
                                                      'حدث خطأ يرجى المحاولة في وقت لاحق',
                                                  style: AppFontStyle
                                                      .darkGreyLabel
                                                      .copyWith(height: 1.6),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(
                                                  height: 35,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 30),
                                                  child: MainButtonWidget(
                                                      title: "تم",
                                                      onClick: () {
                                                        int count = 0;
                                                        Navigator.popUntil(
                                                            context, (route) {
                                                          return count++ == 2;
                                                        });
                                                        // Navigator.of(context)
                                                        //     .pop();
                                                        // Navigator.of(context)
                                                        //     .pop();
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                // locator<ToastTemplate>().show(result.message ??
                                //     'حدث خطأ يرجى المحاولة في وقت لاحق');
                              }
                            });
                          }
                        },
                      ),
                    );
                  }
                }),
        // ),
      ),
    );
  }
}
