import 'package:rehab/app_core/app_core.dart';
import 'package:rehab/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:rehab/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:rehab/app_core/resources/app_style/app_style.dart';
import 'package:rehab/features/activities/activities_manager.dart';
import 'package:rehab/features/activities/activities_response.dart';
import 'package:rehab/features/activities_details/activities_details_page.dart';
import 'package:rehab/shared/activity_widget/activity_item.dart';
import 'package:rehab/shared/main_app_bar/main_app_bar.dart';
import 'package:rehab/shared/not_available_widget/not_available_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  late final ActivitiesManager activitiesManager;

  bool hasInitialDependencies = false;

  @override
  void didChangeDependencies() {
    if (!hasInitialDependencies) {
      hasInitialDependencies = true;
      activitiesManager = context.use<ActivitiesManager>();
      activitiesManager.resetManager();
      activitiesManager.reCallManager();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        // child: SafeArea(
        child: const MainAppBar(
          showNotification: false,
          showBack: true,
          showSearch: true,
          title: "النوادي",
        ),
        // ),
      ),
      body: SafeArea(
        top: false,
        child: Observer<ActivitiesResponse>(
            onRetryClicked: activitiesManager.reCallManager,
            stream: activitiesManager.response$,
            onSuccess: (context, activitiesSnapshot) {
              activitiesManager.updateActivitiesList(
                  totalItemsCount: activitiesSnapshot.data?.info?.total ?? 0,
                  snapshotActivities:
                      activitiesSnapshot.data?.activities ?? []);
              return ListView(
                controller: activitiesManager.scrollController,
                children: [
                  activitiesManager.activities.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(
                              top: 24, bottom: 15, right: 15, left: 15),
                          itemCount: activitiesManager.activities.length,
                          itemBuilder: (_, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: ActivityItem(
                              imageUrl:
                                  activitiesManager.activities[index].image!,
                              title: activitiesManager.activities[index].name!,
                              date: activitiesManager.activities[index].desc!,
                              price: activitiesManager.activities[index].price!,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutesNames.activitiesDetailsPage,
                                  arguments: ActivitiesDetailsArgs(
                                      activityId:
                                          activitiesManager.activities[index].id!,
                                      activityTitle: activitiesManager
                                          .activities[index].name),
                                );
                              },
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 150.h,
                            ),
                            NotAvailableComponent(
                              view: const FaIcon(
                                FontAwesomeIcons.squarePollHorizontal,
                                color: AppStyle.darkOrange,
                                size: 100,
                              ),
                              title: 'لا توجد دورات متاحة',
                              titleTextStyle: AppFontStyle.biggerBlueLabel
                                  .copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w900),
                              // ('no News'),
                            ),
                          ],
                        ),
                  StreamBuilder<PaginationState>(
                      initialData: PaginationState.idle,
                      stream: activitiesManager.paginationState$,
                      builder: (context, paginationStateSnapshot) {
                        if (paginationStateSnapshot.data ==
                            PaginationState.loading) {
                          return const ListTile(
                              title: Center(
                            child: SpinKitWave(
                              color: AppStyle.darkOrange,
                              itemCount: 5,
                              size: 30.0,
                            ),
                          ));
                        }
                        if (paginationStateSnapshot.data ==
                            PaginationState.error) {
                          return ListTile(
                            leading: const Icon(Icons.error),
                            title: Text(
                              locator<PrefsService>().appLanguage == 'en'
                                  ? 'Something Went Wrong Try Again Later'
                                  : 'حدث خطأ ما حاول مرة أخرى لاحقاً',
                              style: const TextStyle(color: Colors.white),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () async {
                                await activitiesManager.onErrorLoadMore();
                              },
                              child: Text(
                                  locator<PrefsService>().appLanguage == 'en'
                                      ? 'Retry'
                                      : 'أعد المحاولة'),
                            ),
                          );
                        }
                        return const SizedBox(
                          width: 0,
                          height: 0,
                        );
                      }),
                ],
              );
            }),
      ),
    );
  }
}
