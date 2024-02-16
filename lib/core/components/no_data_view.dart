import 'package:ecommerce_admin/core/constants/dimensions.dart';
import 'package:ecommerce_admin/core/extensions/image_path.dart';
import 'package:ecommerce_admin/core/extensions/style.dart';
import 'package:flutter/material.dart';

import 'custom_image.dart';

class NoDataView extends StatelessWidget {
  final String message;
  const NoDataView({super.key, this.message = 'No data found'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImage(
            height: 100,
            width: 100,
            fit: BoxFit.fitWidth,
            imagePath: Images.noDataImage,
          ),
          const SizedBox(height: Dimensions.paddingMedium),

          Text(message, style: const TextStyle().regular.copyWith(fontSize: Dimensions.fontSizeExtraSmall)),
        ],
      )
    );
  }
}
