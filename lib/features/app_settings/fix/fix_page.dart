import 'package:rehab/app_core/resources/app_style/app_style.dart';
import 'package:rehab/shared/main_app_bar/main_app_bar.dart';
import 'package:rehab/shared/not_available_widget/not_available_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FixPage extends StatefulWidget {
  const FixPage({Key? key}) : super(key: key);

  @override
  State<FixPage> createState() => _FixPageState();
}

class _FixPageState extends State<FixPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: const MainAppBar(showBack: false),
        ),
        body: NotAvailableComponent(
          view: Icon(
            Icons.phonelink_erase_rounded,
            size: 100.sp,
            color: AppStyle.darkOrange,
          ),
          title: 'التطبيق قيد الصيانة',
        ));
  }
}
