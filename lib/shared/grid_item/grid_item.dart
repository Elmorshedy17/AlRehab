import 'package:rehab/app_core/resources/app_style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridItem extends StatelessWidget {
  final String title, imagePath;
  final VoidCallback onClick;
  final Color itemColor;
  const GridItem(
      {Key? key,
      required this.title,
      required this.imagePath,
      required this.onClick,
      required this.itemColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              // padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffbcdbe5), Color(0xff9ba3a7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                    stops: [0.0, 1.0],
                    // tileMode: TileMode.clamp
                ),
                // color: itemColor,
                color: AppStyle.primaryLightRed,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      imagePath,
                      fit: BoxFit.fill,
                      color: AppStyle.darkOrange,
                      height: 45.w,
                      width: 45.w,
                      // color: Colors.red,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(6),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        // color: itemColor,
                        color: Color(0xffdbf2fe),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: AppStyle.darkOrange,
                            fontSize: 10.sp,
                            overflow: TextOverflow.ellipsis,
                            // fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 12.h,
          // ),

        ],
      ),
    );
  }
}
