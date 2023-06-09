import 'package:rehab/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:rehab/shared/network_app_image/network_app_image.dart';
import 'package:flutter/material.dart';

class GalleryItem extends StatelessWidget {
  final String? imageUrl, title;
  final VoidCallback? onTap;

  const GalleryItem({
    Key? key,
    this.title,
    this.imageUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(.2), width: 1),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: InkWell(
          onTap: onTap ?? () {},
          child: SizedBox(
            // width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: NetworkAppImage(
                    // height: 140.h,
                    width: double.infinity,
                    boxFit: BoxFit.fill,
                    // imageColor: Colors.red,
                    imageUrl: '$imageUrl',
                    // imageUrl: '${e}',
                  ),
                ),
                // const SizedBox(
                //   height: 12,
                // ),
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, right: 10, bottom: 18, left: 10),
                    child: Text(
                      "$title",
                      style: AppFontStyle.biggerBlueLabel
                          .copyWith(fontWeight: FontWeight.w500),
                      maxLines: 1,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
