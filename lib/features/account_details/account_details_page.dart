// import 'package:rehab/app_core/app_core.dart';
// import 'package:rehab/app_core/resources/app_font_styles/app_font_styles.dart';
// import 'package:rehab/features/account_details/account_details_manager.dart';
// import 'package:rehab/features/account_details/account_details_response.dart';
// import 'package:rehab/features/account_details/account_request.dart';
// import 'package:rehab/features/check_box_agreement/check_box_agreement_manager.dart';
// import 'package:rehab/features/check_box_agreement/check_box_agreement_widget.dart';
// import 'package:rehab/shared/custom_text_field/custom_text_field.dart';
// import 'package:rehab/shared/main_app_bar/main_app_bar.dart';
// import 'package:rehab/shared/main_button/main_button_widget.dart';
// import 'package:rehab/shared/remove_focus/remove_focus.dart';
// import 'package:rehab/shared/text_field_obsecure/text_field_obsecure.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class AccountDetailsPage extends StatefulWidget {
//   const AccountDetailsPage({Key? key}) : super(key: key);
//
//   @override
//   State<AccountDetailsPage> createState() => _AccountDetailsPageState();
// }
//
// class _AccountDetailsPageState extends State<AccountDetailsPage> {
//   final TextEditingController _passwordController = TextEditingController();
//
//   final passwordFocus = FocusNode();
//
//   final phoneFocus = FocusNode();
//
//   final nameFocus = FocusNode();
//
//   final emailFocus = FocusNode();
//
//   final boxFocus = FocusNode();
//
//   final civilIdFocus = FocusNode();
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
//
//   @override
//   initState() {
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       locator<AccountDetailsManager>().execute();
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final accountDetailsManager = context.use<AccountDetailsManager>();
//     final checkBoxManager = context.use<CheckBoxManager>();
//
//     return GestureDetector(
//       onTap: () {
//         removeFocus(context);
//       },
//       child: Scaffold(
//         // extendBodyBehindAppBar: true,
//         // resizeToAvoidBottomInset: true,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(60.h),
//           // child: SafeArea(
//           child: const MainAppBar(
//             showNotification: false,
//             showBack: true,
//             showSearch: true,
//             title: "تفاصيل الحساب",
//           ),
//           // ),
//         ),
//         body: Observer<AccountDetailsResponse>(
//             stream: accountDetailsManager.accountDetails$,
//             onRetryClicked: () {
//               locator<AccountDetailsManager>().execute();
//             },
//             onSuccess: (context, festivalDetailsSnapshot) {
//               return StreamBuilder<ManagerState>(
//                   initialData: ManagerState.idle,
//                   stream: accountDetailsManager.state$,
//                   builder:
//                       (context, AsyncSnapshot<ManagerState> stateSnapshot) {
//                     return FormsStateHandling(
//                       managerState: stateSnapshot.data,
//                       errorMsg: accountDetailsManager.errorDescription,
//                       onClickCloseErrorBtn: () {
//                         accountDetailsManager.inState.add(ManagerState.idle);
//                       },
//                       child: Column(
//                         children: [
//                           Expanded(
//                               child: ListView(
//                             children: [
//                               Column(
//                                 children: [
//                                   Form(
//                                     key: _formKey,
//                                     autovalidateMode: _autoValidateMode,
//                                     child: Container(
//                                       color: Colors.white,
//                                       padding: const EdgeInsets.all(15),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           SizedBox(
//                                             height: 50.h,
//                                           ),
//                                           FadeInLeftBig(
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   "اسم المستخدم",
//                                                   style: AppFontStyle
//                                                       .darkGreyLabel,
//                                                 ),
//                                                 const SizedBox(
//                                                   height: 15,
//                                                 ),
//                                                 CustomTextFiled(
//                                                   currentFocus: nameFocus,
//                                                   controller:
//                                                       accountDetailsManager
//                                                           .nameController,
//                                                   keyboardType:
//                                                       TextInputType.text,
//                                                   hintText: 'اسم المستخدم',
//                                                   maxLines: 1,
//                                                   onFieldSubmitted: (v) {
//                                                     FocusScope.of(context)
//                                                         .requestFocus(
//                                                             emailFocus);
//                                                   },
//                                                   validationBool: (v) {
//                                                     return (v.length < 3);
//                                                   },
//                                                   validationErrorMessage:
//                                                       'يجب ان لا يقل عدد الاحرف عن ٣',
//                                                 ),
//
//                                                 const SizedBox(
//                                                   height: 35,
//                                                 ),
//                                                 Text(
//                                                   "البريد الالكتروني",
//                                                   style: AppFontStyle
//                                                       .darkGreyLabel,
//                                                 ),
//                                                 const SizedBox(
//                                                   height: 15,
//                                                 ),
//                                                 CustomTextFiled(
//                                                   currentFocus: emailFocus,
//                                                   controller:
//                                                       accountDetailsManager
//                                                           .emailController,
//                                                   keyboardType:
//                                                       TextInputType.text,
//                                                   hintText: 'البريد الالكتروني',
//                                                   maxLines: 1,
//                                                   onFieldSubmitted: (v) {
//                                                     FocusScope.of(context)
//                                                         .requestFocus(
//                                                             phoneFocus);
//                                                   },
//                                                   validationBool: (v) {
//                                                     if (v.isEmpty) {
//                                                       return false;
//                                                     } else {
//                                                       if (EmailValidator
//                                                           .validate(v)) {
//                                                         return false;
//                                                       } else {
//                                                         return false;
//                                                       }
//                                                     }
//                                                   },
//                                                   validationErrorMessage:
//                                                       'يرجى ادخال بريد الكتروني صحيح',
//                                                 ),
//                                                 const SizedBox(
//                                                   height: 35,
//                                                 ),
//                                                 Text(
//                                                   "رقم الهاتف",
//                                                   style: AppFontStyle
//                                                       .darkGreyLabel,
//                                                 ),
//                                                 const SizedBox(
//                                                   height: 15,
//                                                 ),
//                                                 CustomTextFiled(
//                                                   currentFocus: phoneFocus,
//                                                   controller:
//                                                       accountDetailsManager
//                                                           .phoneController,
//                                                   keyboardType:
//                                                       TextInputType.phone,
//                                                   hintText: 'رقم الهاتف',
//                                                   maxLines: 1,
//                                                   onFieldSubmitted: (v) {
//                                                     FocusScope.of(context)
//                                                         .requestFocus(boxFocus);
//                                                   },
//                                                   validationBool: (v) {
//                                                     return (v.length < 8);
//                                                   },
//                                                   validationErrorMessage:
//                                                       'يجب ان لا يقل عدد الارقام عن ٨',
//                                                 ),
//
//                                                 /////////
//
//                                                 const SizedBox(
//                                                   height: 35,
//                                                 ),
//                                                 Text(
//                                                   "رقم الصندوق",
//                                                   style: AppFontStyle
//                                                       .darkGreyLabel,
//                                                 ),
//                                                 const SizedBox(
//                                                   height: 15,
//                                                 ),
//                                                 CustomTextFiled(
//                                                   currentFocus: boxFocus,
//                                                   controller:
//                                                       accountDetailsManager
//                                                           .boxController,
//                                                   keyboardType:
//                                                       TextInputType.number,
//                                                   hintText: 'رقم الصندوق',
//                                                   maxLines: 1,
//                                                   onFieldSubmitted: (v) {
//                                                     FocusScope.of(context)
//                                                         .requestFocus(
//                                                             civilIdFocus);
//                                                   },
//                                                   validationBool: (v) {
//                                                     return (v.length < 1);
//                                                   },
//                                                   validationErrorMessage:
//                                                       'لا يمكن ان يترك هذا الحقل فارغا',
//                                                 ),
//                                                 ////////
//
//                                                 /////////
//
//                                                 const SizedBox(
//                                                   height: 35,
//                                                 ),
//                                                 Text(
//                                                   "الرقم المدني",
//                                                   style: AppFontStyle
//                                                       .darkGreyLabel,
//                                                 ),
//                                                 const SizedBox(
//                                                   height: 15,
//                                                 ),
//                                                 CustomTextFiled(
//                                                   currentFocus: civilIdFocus,
//                                                   controller:
//                                                       accountDetailsManager
//                                                           .civilIdController,
//                                                   keyboardType:
//                                                       TextInputType.number,
//                                                   hintText: 'الرقم المدني',
//                                                   maxLines: 1,
//                                                   onFieldSubmitted: (v) {
//                                                     FocusScope.of(context)
//                                                         .requestFocus(
//                                                             passwordFocus);
//                                                   },
//                                                   validationBool: (v) {
//                                                     return (v.length < 1);
//                                                   },
//                                                   validationErrorMessage:
//                                                       'لا يمكن ان يترك هذا الحقل فارغا',
//                                                 ),
//                                                 ////////
//
//                                                 const SizedBox(
//                                                   height: 35,
//                                                 ),
//                                                 Text(
//                                                   "كلمة المرور",
//                                                   style: AppFontStyle
//                                                       .darkGreyLabel,
//                                                 ),
//                                                 const SizedBox(
//                                                   height: 15,
//                                                 ),
//                                                 CustomTextFiledObscureText(
//                                                   currentFocus: passwordFocus,
//                                                   controller:
//                                                       _passwordController,
//                                                   // obscureText: obscureText,
//                                                   keyboardType: TextInputType
//                                                       .visiblePassword,
//                                                   hintText: '*********',
//                                                   // prefixIcon: Padding(
//                                                   //   padding: const EdgeInsets.all(15.0),
//                                                   //   child: SvgPicture.asset(
//                                                   //     AppAssets.lock,
//                                                   //     // color: Colors.brown,
//                                                   //     height: 15,
//                                                   //   ),
//                                                   // ),
//                                                   maxLines: 1,
//                                                   onFieldSubmitted: (v) {
//                                                     removeFocus(context);
//                                                   },
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           const CheckBoxAgreement(),
//                                           SizedBox(
//                                             height: 50.h,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           )),
//                           Container(
//                             color: Colors.white,
//                             padding: const EdgeInsets.all(15),
//                             child: FadeInRightBig(
//                               child: Column(
//                                 // crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   MainButtonWidget(
//                                     title: 'حفظ',
//                                     onClick: () async {
//                                       removeFocus(context);
//                                       if (!checkBoxManager.currentCheckBox) {
//                                         locator<ToastTemplate>().show(
//                                             "برجاء التعهد بصحة البيانات اولا");
//                                         return;
//                                       }
//                                       if (_formKey.currentState!.validate()) {
//                                         _formKey.currentState!.save();
//                                       } else {
//                                         setState(() {
//                                           _autoValidateMode =
//                                               AutovalidateMode.always;
//                                         });
//                                         return;
//                                       }
//
//                                       await accountDetailsManager.editProfile(
//                                         request: AccountRequest(
//                                             phone: accountDetailsManager
//                                                 .phoneController.text,
//                                             password: _passwordController.text,
//                                             email: accountDetailsManager
//                                                 .emailController.text,
//                                             name: accountDetailsManager
//                                                 .nameController.text,
//                                             box: accountDetailsManager
//                                                 .boxController.text,
//                                             civilId: accountDetailsManager
//                                                 .civilIdController.text),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   });
//             }),
//       ),
//     );
//   }
// }
