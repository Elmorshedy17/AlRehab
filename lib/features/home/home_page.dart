import 'package:flutter/scheduler.dart';
import 'package:rehab/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:rehab/app_core/resources/app_style/app_style.dart';
import 'package:rehab/features/bottom_navigation/fixed_section/fixed_section.dart';
import 'package:rehab/features/bottom_navigation/pages/home/home_manager.dart';
import 'package:rehab/features/bottom_navigation/pages/home/home_response.dart';
import 'package:rehab/features/bottom_navigation/pages/home/widgets/home_slider.dart';
import 'package:rehab/shared/grid_item/grid_item.dart';
import 'package:rehab/shared/main_app_bar/main_app_bar.dart';
import 'package:rehab/shared/main_button/main_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_core/app_core.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.use<HomeManager>().execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeManager = context.use<HomeManager>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        // child: SafeArea(
        child: MainAppBar(
          showNotification: true,
          showSearch: true,
        ),
        // ),
      ),
      body: Observer<HomeResponse>(
          stream: homeManager.home$,
          onRetryClicked: homeManager.execute,
          onWaiting: (_) => const SizedBox.shrink(),
          onError: (_, __) => const SizedBox.shrink(),
          onSuccess: (context, homeSnapshot) {
          return SafeArea(
            top: false,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              physics: const BouncingScrollPhysics(),
              children: [
                homeSnapshot.data!.slider!.isNotEmpty ?   HomeSlider(
                  slider: homeSnapshot.data!.slider,
                  // sliderHeight: 150.h,
                  hasUrl: false,
                  isCard: false,
                ): const SizedBox(),
                const SizedBox(
                  height: 15,
                ),
                // MainButtonWidget(
                //   onClick: (){
                //     locator<NavigationService>()
                //         .pushNamedTo(AppRoutesNames.reportProductPage);
                //   },
                //   title: "بلغ عن سلعة",
                // ),
                //
                // MainButtonWidget(
                //   color: AppStyle.primaryLightRed,
                //   borderColor: AppStyle.primaryLightRed,
                //   textColor:AppStyle.darkOrange,
                //   onClick: (){
                //     locator<NavigationService>().pushNamedTo(AppRoutesNames.profitsPage);
                //   },
                //   title: "ارباح المساهمين",
                // ),


                SizedBox(
                  height: 100.h,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: FixedSection.homeSectionsSlider.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        FixedSection item = FixedSection.homeSectionsSlider[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: item.onClick,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(color: Colors.grey, spreadRadius: 1),
                                      ],
                                    ),
                                    child: Image.asset(
                                      item.image,
                                      fit: BoxFit.fill,
                                      color: AppStyle.darkOrange,
                                      height: 30.h,
                                      width: 30.h,
                                      // color: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    item.title,
                                    style: TextStyle(
                                      color: AppStyle.darkOrange,
                                      fontSize: 10.sp,
                                      overflow: TextOverflow.ellipsis,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),

                Padding(
                  padding:  EdgeInsets.only(right: 35,left: 35),
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      itemCount: FixedSection.homeSections.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 35,
                          mainAxisSpacing: 25),
                      itemBuilder: (BuildContext context, int index) {
                        return GridItem(
                          title: FixedSection.homeSections[index].title,
                          imagePath: FixedSection.homeSections[index].image,
                          itemColor: Colors.white,
                          // itemColor: FixedSection.homeSections[index].backgroundColor,
                          onClick: FixedSection.homeSections[index].onClick,
                        );
                      }),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
