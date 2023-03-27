import 'package:rehab/app_core/app_core.dart';
import 'package:rehab/app_core/resources/app_assets/app_assets.dart';
import 'package:rehab/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:rehab/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:rehab/app_core/resources/app_style/app_style.dart';
import 'package:rehab/features/app_settings/app_settings_manager.dart';
import 'package:rehab/features/bottom_navigation/pages/family_card/family_manager.dart';
import 'package:rehab/features/bottom_navigation/pages/family_card/family_request.dart';
import 'package:rehab/features/profits/profits_manager.dart';
import 'package:rehab/features/profits/profits_request.dart';
import 'package:rehab/shared/main_app_bar/main_app_bar.dart';
import 'package:rehab/shared/custom_text_field/custom_text_field.dart';
import 'package:rehab/shared/main_button/main_button_widget.dart';
import 'package:rehab/shared/not_available_widget/not_available_widget.dart';
import 'package:rehab/shared/remove_focus/remove_focus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ProfitsPage extends StatefulWidget {
  const ProfitsPage({Key? key}) : super(key: key);

  @override
  State<ProfitsPage> createState() => _ProfitsPageState();
}

class _ProfitsPageState extends State<ProfitsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final TextEditingController _familyCardController = TextEditingController();
  final TextEditingController _socialIdController = TextEditingController();


  final familyCardFocus = FocusNode();

  final socialIdFocus = FocusNode();


  @override
  Widget build(BuildContext context) {
    final profitsManager = context.use<ProfitsManager>();

    // if(locator<PrefsService>().userObj != null){
    //   profitsManager.execute();
    // }



    return GestureDetector(
      onTap: () {
        removeFocus(context);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          // child: SafeArea(
          child:const MainAppBar(
            showNotification: false,
            showBack: true,
            showSearch: false,
            title: "ارباح المساهمين",
          ),
          // ),
        ),
        body:
        StreamBuilder<ManagerState>(
            initialData: ManagerState.idle,
            stream: profitsManager.state$,
            builder: (context, AsyncSnapshot<ManagerState> stateSnapshot) {
              return FormsStateHandling(
                managerState: stateSnapshot.data,
                errorMsg: profitsManager.errorDescription,
                onClickCloseErrorBtn: () {
                  profitsManager.inState.add(ManagerState.idle);
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autoValidateMode,
                    child: Center(
                      child: ListView(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 25,
                          ),

                          Center(
                            child: Image.asset(
                              AppAssets.home_6,height: 75.h,fit: BoxFit.fill,
                              color: AppStyle.darkOrange,
                            ),
                          ),
                          // Center(child: Image.asset(,)),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .085,
                          ),

                          Text("للاستعلام عن الأرباح , يرجى ادخال رقم الصندوق و الرقم المدني",style: AppFontStyle.descFont,textAlign: TextAlign.center,),
                          const SizedBox(
                            height: 45,
                          ),

                          // if(locator<PrefsService>().userObj == null || locator<PrefsService>().userObj!.box == "")
                          CustomTextFiled(
                            currentFocus: familyCardFocus,
                            controller: _familyCardController,
                            keyboardType: TextInputType.text,
                            hintText: 'رقم الصندوق',
                            maxLines: 1,
                            onFieldSubmitted: (v) {
                           FocusScope.of(context).requestFocus(socialIdFocus);
                            },
                            validationBool: (v) {
                              return (v.length < 1);
                            },
                            validationErrorMessage:
                            'لا يمكن ان يترك هذا الحقل فارغا',
                          ),
                          const SizedBox(
                            height: 25,
                          ),

                          CustomTextFiled(
                            currentFocus: socialIdFocus,
                            controller: _socialIdController,
                            keyboardType: TextInputType.text,
                            hintText: 'الرقم المدني',
                            maxLines: 1,
                            onFieldSubmitted: (v) {
                              removeFocus(context);
                            },
                            validationBool: (v) {
                              return (v.length < 1);
                            },
                            validationErrorMessage:
                            'لا يمكن ان يترك هذا الحقل فارغا',
                          ),
                          // if(locator<PrefsService>().userObj != null && locator<PrefsService>().userObj!.box != "")
                          //   Text("رقم الصندوق الخاص بك هو ${locator<PrefsService>().userObj!.box}"),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .15,
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                AppAssets.info,
                                color: Colors.red,
                                // height: 8,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(child: Text(locator<AppSettingsManager>().profitText,style: AppFontStyle.descFont,)),
                            ],
                          ),

                          const SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: MainButtonWidget(
                              title: "بحث",
                              // width: 150,
                              onClick: () async {
                                removeFocus(context);
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                } else {
                                  setState(() {
                                    _autoValidateMode = AutovalidateMode.always;
                                  });
                                  return;
                                }

                                await profitsManager.profits(
                                    request: ProfitsRequest(
                                        cardId: "${_familyCardController.text}",
                                        civilId: "${_socialIdController.text}")
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
