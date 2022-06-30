import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeBlockSlider extends StatelessWidget {
  const TimeBlockSlider({
    Key? key,
    required this.timeList,
    required this.itemsSelectedValue,
    required this.selectItem,
  }) : super(key: key);

  final List<String> timeList;
  final int itemsSelectedValue;
  final Function(int) selectItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: timeList.length,
        itemBuilder: (context, index) {
          bool isCurrentIndexSelected = itemsSelectedValue == index;
          return GestureDetector(
            onTap: () {
              selectItem(index);
            },
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                // height: 50.h,
                width: 50.w,
                margin: EdgeInsets.only(top: 4.h, bottom: 4.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: isCurrentIndexSelected
                        ? Theme.of(context).primaryColor
                        : null,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(timeList[index],
                    textAlign: TextAlign.center,
                    style: isCurrentIndexSelected
                        ? Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Theme.of(context).backgroundColor,
                            fontWeight: FontWeight.bold)
                        : null),
              ),
            ),
          );
        },
      ),
    );
  }
}
