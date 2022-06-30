import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/screen/vendors_detail/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingBar extends StatelessWidget {
  const RatingBar({
    Key? key,
    required this.ratings,
    required this.totalRating,
  }) : super(key: key);

  final List<ReviewStatisticsModel> ratings;
  final int totalRating;

  Map<int, int> createMapRating() {
    Map<int, int> rating = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (var star in ratings) {
      rating[star.rating ?? 0] = star.total ?? 0;
    }
    return rating;
  }

  @override
  Widget build(BuildContext context) {
    Map<int, int> rating = createMapRating();

    return Column(
      children: [
        ...List.from(rating.entries
            .map((e) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        flex: 1,
                        child: createStars(context, e.key),
                      ),
                      SizedBox(width: kDefaultPaddingItem.w),
                      Flexible(
                        flex: 4,
                        child: ProgressBar(
                            max: totalRating != 0 ? totalRating : 1,
                            current: e.value),
                      ),
                    ],
                  ),
                  SizedBox(height: kChipPadding.h - 3),
                ],
              );
            })
            .toList()
            .reversed),
      ],
    );
  }

  SizedBox createStars(BuildContext context, int e) {
    return SizedBox(
      height: 10.h,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: e,
        itemBuilder: (ctx, index) {
          return Container(
              padding: const EdgeInsets.all(0),
              child: Icon(Icons.star,
                  color: Theme.of(context).primaryColor, size: 10.sp));
        },
      ),
    );
  }
}
