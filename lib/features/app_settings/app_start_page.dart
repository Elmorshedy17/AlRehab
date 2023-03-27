import 'package:animate_do/animate_do.dart';
import 'package:rehab/app_core/app_core.dart';
import 'package:rehab/app_core/resources/app_assets/app_assets.dart';
import 'package:rehab/app_core/resources/app_style/app_style.dart';
// import 'package:rehab/app_core/fcm/dynamic_link_service.dart';
// import 'package:rehab/app_core/fcm/pushNotification_service.dart';
import 'package:rehab/features/app_settings/app_settings_manager.dart';
import 'package:rehab/features/app_settings/app_settings_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStartPage extends StatefulWidget {
  const AppStartPage({Key? key}) : super(key: key);

  @override
  State<AppStartPage> createState() => _AppStartPageState();
}

class _AppStartPageState extends State<AppStartPage> {
  @override
  void initState() {
    super.initState();
    // locator<DynamicLinkService>().handleDynamicLinks();
    // setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    final appSettingsManager = context.use<AppSettingsManager>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: AppBar(
          elevation: 0,
        ),
      ),
      body: Observer<AppSettingsResponse>(
          stream: appSettingsManager.settings$,
          onWaiting: (context) => Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: AppStyle.darkOrange,
                child: Center(
                  child: Bounce(
                    child: SizedBox(
                      width: 200.w,
                      height: 200.w,
                      child: Image.asset(
                        AppAssets.logo,
                        fit: BoxFit.fill,
                        // color: Colors.white,
                      ),
                    ),

                    // child:SvgPicture.asset(
                    //   AppAssets.APP_BAR_LOGO,
                    //   semanticsLabel: 'rehab Logo',
                    //   color: Colors.white,
                    //   // fit: BoxFit.contain,
                    // ),
                  ),
                ),
              ),
          onSuccess: (context, snapshot) {
            return const SizedBox.shrink();
          }),
    );
  }
}
