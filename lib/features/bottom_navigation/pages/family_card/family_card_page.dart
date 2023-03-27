import 'package:rehab/app_core/app_core.dart';
import 'package:rehab/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:rehab/app_core/resources/app_style/app_style.dart';
import 'package:rehab/features/bottom_navigation/pages/family_card/family_manager.dart';
import 'package:rehab/features/bottom_navigation/pages/family_card/family_request.dart';
import 'package:rehab/shared/custom_text_field/custom_text_field.dart';
import 'package:rehab/shared/main_app_bar/main_app_bar.dart';
import 'package:rehab/shared/main_button/main_button_widget.dart';
import 'package:rehab/shared/not_available_widget/not_available_widget.dart';
import 'package:rehab/shared/remove_focus/remove_focus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class FamilyCardPage extends StatefulWidget {
  const FamilyCardPage({Key? key}) : super(key: key);

  @override
  State<FamilyCardPage> createState() => _FamilyCardPageState();
}

class _FamilyCardPageState extends State<FamilyCardPage> {
  final TextEditingController _familyCardController = TextEditingController();
  final TextEditingController _socialIdController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final familyCardFocus = FocusNode();

  final socialIdFocus = FocusNode();


  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  // TextEditingController cardController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final familyCartManager = context.use<FamilyCartManager>();

    if(locator<PrefsService>().userObj != null){
      familyCartManager.execute();
    }

    // return
    //   locator<PrefsService>().userObj == null ? InkWell(
    //   onTap:(){
    //     Navigator.of(context)
    //         .pushNamed(AppRoutesNames.loginPage);
    //   },
    //   child: NotAvailableComponent(
    //     title: "برجاء تسجيل الدخول اولا",
    //     desc: "اضغط هنا لتسجيل الدخول",
    //     view: Column(
    //       children: const [
    //           FaIcon(
    //           FontAwesomeIcons.doorOpen,
    //           color: AppStyle.darkOrange,
    //           size: 100,
    //         ),
    //       ],
    //     ),
    //
    //   ),
    // ):
    //   NotAvailableComponent(
    //   desc: familyCartManager.errorDescription??"",
    //   // desc: "اضغط هنا لتسجيل الدخول",
    //   view:const FaIcon(
    //     FontAwesomeIcons.bug,
    //     color: AppStyle.darkOrange,
    //     size: 100,
    //   ),
    //
    // );

    return GestureDetector(
      onTap: () {
        removeFocus(context);
      },
      child:Scaffold(
        // extendBodyBehindAppBar: true,
        // backgroundColor: Colors.red,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          // child: SafeArea(
          child: const MainAppBar(
            showNotification: false,
            showBack: true,
            showSearch: true,
            title: 'بطاقة العائلة',
          ),
          // ),
        ),
        body: StreamBuilder<ManagerState>(
            initialData: ManagerState.idle,
            stream: familyCartManager.state$,
            builder: (context, AsyncSnapshot<ManagerState> stateSnapshot) {
              return FormsStateHandling(
                managerState: stateSnapshot.data,
                errorMsg: familyCartManager.errorDescription,
                onClickCloseErrorBtn: () {
                  familyCartManager.inState.add(ManagerState.idle);
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autoValidateMode,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        // if(locator<PrefsService>().userObj == null || locator<PrefsService>().userObj!.card == "")
                        CustomTextFiled(
                          currentFocus: familyCardFocus,
                          controller: _familyCardController,
                          keyboardType: TextInputType.text,
                          hintText: 'بطاقة العائلة',
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
                        // if(locator<PrefsService>().userObj != null && locator<PrefsService>().userObj!.card != "")
                        //   Text("رقم الصندوق الخاص بك هو ${locator<PrefsService>().userObj!.card}"),
                        const SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: MainButtonWidget(
                            title: "بحث",
                            width: 150,
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
                              await familyCartManager.familyCart(
                                request: FamilyCartRequest(
                                    cardId: "${_familyCardController.text}",
                                    civilId: "${_socialIdController.text}"),

                                // cardId: "740",)
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}