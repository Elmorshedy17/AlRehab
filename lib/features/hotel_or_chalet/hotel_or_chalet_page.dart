import 'package:rehab/app_core/app_core.dart';
import 'package:rehab/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:rehab/app_core/resources/app_style/app_style.dart';
import 'package:rehab/features/booking/booking_manager.dart';
import 'package:rehab/features/booking/booking_request.dart';
import 'package:rehab/features/hotel_or_chalet/hotel_or_chalet_manager.dart';
import 'package:rehab/features/hotel_or_chalet/hotel_or_chalet_response.dart';
import 'package:rehab/features/hotel_or_chalet/widgets/select_date.dart';
import 'package:rehab/shared/main_app_bar/main_app_bar.dart';
import 'package:rehab/shared/check_box/check_box.dart';
import 'package:rehab/shared/counter_widget/counter_widget.dart';
import 'package:rehab/shared/main_button/main_button_widget.dart';
import 'package:rehab/shared/network_app_image/network_app_image.dart';
import 'package:rehab/shared/remove_focus/remove_focus.dart';
import 'package:rehab/shared/show_zoomable_enum/show_zoomable_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

class HotelOrChaletArgs {
  final int hotelOrChaletId;
  final String? hotelOrChaletTitle;

  HotelOrChaletArgs({required this.hotelOrChaletId, this.hotelOrChaletTitle});
}

class HotelOrChaletPage extends StatefulWidget {
  const HotelOrChaletPage({Key? key}) : super(key: key);

  @override
  State<HotelOrChaletPage> createState() => _HotelOrChaletPageState();
}

class _HotelOrChaletPageState extends State<HotelOrChaletPage> {
  String selectedImage = '';
  HotelOrChaletArgs? args;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      args = ModalRoute.of(context)!.settings.arguments as HotelOrChaletArgs;
      if (args != null) {
        locator<HotelOrChaletManager>()
            .execute(hotelOrChaletId: args!.hotelOrChaletId);
        locator<HotelOrChaletManager>().counterSubject.sink.add(1);
      }
      locator<HotelOrChaletManager>().resetDate();
    });
    locator<HotelOrChaletManager>().showZoomable = ShowZoomable.hide;
  }

  @override
  Widget build(BuildContext context) {
    final hotelOrChaletManager = context.use<HotelOrChaletManager>();
    final bookingManager = context.use<BookingManager>();
    final prefs = context.use<PrefsService>();
    int maxCount = 0;

    if (args == null) {
      args = ModalRoute.of(context)!.settings.arguments as HotelOrChaletArgs;
      locator<HotelOrChaletManager>()
          .execute(hotelOrChaletId: args!.hotelOrChaletId);
    }

    return GestureDetector(
      onTap: () {
        removeFocus(context);
      },
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        // backgroundColor: Colors.red,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          // child: SafeArea(
          child: MainAppBar(
            showNotification: false,
            showBack: true,
            showSearch: true,
            title: "${args?.hotelOrChaletTitle}",
          ),
          // ),
        ),
        body: Observer<HotelOrChaletResponse>(
            stream: hotelOrChaletManager.hotelOrChaletDetails$,
            onRetryClicked: () {
              hotelOrChaletManager.execute(
                  hotelOrChaletId: args!.hotelOrChaletId);
            },
            onSuccess: (context, hotelOrChaletSnapshot) {
              return ValueListenableBuilder<ShowZoomable>(
                  valueListenable: hotelOrChaletManager.showZoomableNotifier,
                  builder: (context, value, _) {
                    return Stack(
                      children: [
                        StreamBuilder<ManagerState>(
                            initialData: ManagerState.idle,
                            stream: bookingManager.state$,
                            builder: (context,
                                AsyncSnapshot<ManagerState> stateSnapshot) {
                              return FormsStateHandling(
                                managerState: stateSnapshot.data,
                                errorMsg: bookingManager.errorDescription,
                                onClickCloseErrorBtn: () {
                                  bookingManager.inState.add(ManagerState.idle);
                                },
                                child: ListView(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        selectedImage =
                                            '${hotelOrChaletSnapshot.data!.hotel!.image}';
                                        hotelOrChaletManager.showZoomable =
                                            ShowZoomable.show;
                                      },
                                      child: NetworkAppImage(
                                        height: 300.h,
                                        width: double.infinity,
                                        boxFit: BoxFit.fill,
                                        imageUrl:
                                            '${hotelOrChaletSnapshot.data!.hotel!.image}',
                                        // imageUrl: '${e}',
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          Text(
                                            '${hotelOrChaletSnapshot.data!.hotel?.name}',
                                            style: AppFontStyle.biggerBlueLabel,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'التاريخ : ${hotelOrChaletSnapshot.data!.hotel?.date}',
                                            style: AppFontStyle.descFont
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 13),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${hotelOrChaletSnapshot.data?.hotel?.price}',
                                                style: AppFontStyle
                                                    .darkGreyLabel
                                                    .copyWith(
                                                        color: Colors.black),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'بدلا من',
                                                style: AppFontStyle
                                                    .darkGreyLabel
                                                    .copyWith(
                                                        color: Colors.black),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '${hotelOrChaletSnapshot.data?.hotel?.oldPrice}',
                                                style: AppFontStyle
                                                    .darkGreyLabel
                                                    .copyWith(
                                                  color: Colors.black
                                                      .withOpacity(.6),
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Text(
                                          //   '${hotelOrChaletSnapshot.data!.hotel?.price}',
                                          //   style: AppFontStyle.darkGreyLabel,
                                          // ),
                                          const Divider(
                                            height: 30,
                                          ),
                                          Html(
                                            data:
                                                '${hotelOrChaletSnapshot.data!.hotel?.desc}',
                                          ),
                                          if (hotelOrChaletSnapshot
                                                  .data!.hotel?.card ==
                                              "yes")
                                            // Padding(
                                            //   padding: const EdgeInsets.only(
                                            //       top: 15),
                                            //   child: Text(
                                            //     "رقم كارت العائلة : ${prefs.userObj?.box}",
                                            //     style: AppFontStyle.descFont
                                            //         .copyWith(
                                            //             color: AppStyle
                                            //                 .darkOrange
                                            //                 .withOpacity(.5)),
                                            //   ),
                                            // ),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          if (hotelOrChaletSnapshot
                                              .data!.hotel!.options!.isNotEmpty)
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                  color: AppStyle.darkGrey
                                                      .withOpacity(.3),
                                                ),
                                              ),
                                              child: ValueListenableBuilder<
                                                      int>(
                                                  valueListenable:
                                                      hotelOrChaletManager
                                                          .optionNotifier,
                                                  builder: (context, value, _) {
                                                    return ListView.separated(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          hotelOrChaletSnapshot
                                                              .data!
                                                              .hotel!
                                                              .options!
                                                              .length,
                                                      separatorBuilder:
                                                          (context, index) {
                                                        return Divider(
                                                          height: 25,
                                                          color: AppStyle
                                                              .darkGrey
                                                              .withOpacity(.6),
                                                        );
                                                      },
                                                      itemBuilder:
                                                          (context, index) {
                                                        Options option =
                                                            hotelOrChaletSnapshot
                                                                    .data!
                                                                    .hotel!
                                                                    .options![
                                                                index];

                                                        return InkWell(
                                                          onTap: () {
                                                            hotelOrChaletManager
                                                                    .optionNotifier
                                                                    .value =
                                                                hotelOrChaletSnapshot
                                                                    .data!
                                                                    .hotel!
                                                                    .options![
                                                                        index]
                                                                    .id!;
                                                            maxCount =
                                                                hotelOrChaletSnapshot
                                                                    .data!
                                                                    .hotel!
                                                                    .options![
                                                                        index]
                                                                    .count!;
                                                            hotelOrChaletManager
                                                                .maxSubject.sink
                                                                .add(hotelOrChaletSnapshot
                                                                    .data!
                                                                    .hotel!
                                                                    .options![
                                                                        index]
                                                                    .count!);
                                                            // hotelOrChaletManager.maxSubject.sink.add(hotelOrChaletSnapshot.data!.hotel!.options![index]!.count!);
                                                            if (hotelOrChaletSnapshot
                                                                    .data!
                                                                    .hotel!
                                                                    .options![
                                                                        index]
                                                                    .count! ==
                                                                0) {
                                                              hotelOrChaletManager
                                                                  .counterSubject
                                                                  .sink
                                                                  .add(0);
                                                            } else {
                                                              hotelOrChaletManager
                                                                  .counterSubject
                                                                  .sink
                                                                  .add(1);
                                                            }
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CustomCheckBox(
                                                                  isChecked: option
                                                                          .id ==
                                                                      hotelOrChaletManager
                                                                          .optionNotifier
                                                                          .value),
                                                              const SizedBox(
                                                                width: 15,
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "${option.name}",
                                                                    style: AppFontStyle
                                                                        .blueLabel,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 12,
                                                                  ),
                                                                  Text(
                                                                    "${option.price}",
                                                                    style: AppFontStyle
                                                                        .darkGreyLabel,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  }),
                                            ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          DateTimeWidget(),
                                          const SizedBox(
                                            height: 35,
                                          ),
                                          StreamBuilder<int>(
                                              stream: hotelOrChaletManager
                                                  .maxSubject.stream,
                                              builder: (context, snapshot) {
                                                return Column(
                                                  children: [
                                                    ValueListenableBuilder<int>(
                                                        valueListenable:
                                                            hotelOrChaletManager
                                                                .optionNotifier,
                                                        builder: (context,
                                                            value, _) {
                                                          return hotelOrChaletManager
                                                                      .optionNotifier
                                                                      .value ==
                                                                  0
                                                              ? Container()
                                                              : Container(
                                                                  child: snapshot
                                                                              .data ==
                                                                          0
                                                                      ? Text(
                                                                          "الحجز غير متاح",
                                                                          style:
                                                                              AppFontStyle.descFont,
                                                                        )
                                                                      : CounterWidget(
                                                                          stream:
                                                                              hotelOrChaletManager.selectedCount$,
                                                                          maxCount:
                                                                              maxCount,
                                                                          onDecrement:
                                                                              () {
                                                                            hotelOrChaletManager.counterSubject.sink.add(hotelOrChaletManager.counterSubject.value -
                                                                                1);
                                                                          },
                                                                          onIncrement:
                                                                              () {
                                                                            hotelOrChaletManager.counterSubject.sink.add(hotelOrChaletManager.counterSubject.value +
                                                                                1);
                                                                          },
                                                                        ),
                                                                );
                                                        }),
                                                    const SizedBox(
                                                      height: 35,
                                                    ),
                                                    Center(
                                                        child: MainButtonWidget(
                                                            title: "حجز",
                                                            onClick:
                                                                snapshot.data ==
                                                                        0
                                                                    ? null
                                                                    : () {
                                                                        if (hotelOrChaletManager.optionNotifier.value ==
                                                                            0) {
                                                                          locator<ToastTemplate>()
                                                                              .show("برجاء تحديد الاختيار اولا");
                                                                        } else {
                                                                          // if (prefs.userObj !=
                                                                          //     null) {
                                                                            bookingManager.booking(
                                                                                request: BookingRequest(
                                                                              id: args!.hotelOrChaletId,
                                                                              // cardId: hotelOrChaletSnapshot.data?.hotel?.card != 'no' ? prefs.userObj?.box : '',
                                                                              count: locator<HotelOrChaletManager>().counterSubject.value,
                                                                              date: HotelOrChaletManager.getFormattedDate(hotelOrChaletManager.selectedDate),
                                                                              optionId: hotelOrChaletManager.optionNotifier.value,
                                                                              time: '',
                                                                              type: BookingType.hotel.name,
                                                                            ));
                                                                          // } else {
                                                                          //   locator<ToastTemplate>().show("برجاء تسجيل الدخول اولا");
                                                                          // }
                                                                        }
                                                                      },
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .85))
                                                  ],
                                                );
                                              }),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                        if (value == ShowZoomable.show)
                          Positioned.fill(
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: PhotoView(
                                    backgroundDecoration: const BoxDecoration(
                                        color: Colors.black38),
                                    minScale:
                                        PhotoViewComputedScale.contained * 0.3,
                                    initialScale:
                                        PhotoViewComputedScale.contained * 0.8,
                                    imageProvider:
                                        NetworkImage(selectedImage, scale: 1),
                                  ),
                                ),
                                Positioned(
                                  bottom: 30,
                                  left: 30,
                                  child: FloatingActionButton(
                                    // mini: true,
                                    onPressed: () {
                                      hotelOrChaletManager.showZoomable =
                                          ShowZoomable.hide;
                                    },
                                    child: const Icon(Icons.close),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  });
            }),
      ),
    );
  }
}
