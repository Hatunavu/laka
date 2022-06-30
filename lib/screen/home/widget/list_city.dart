import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/auth/create_vendor/location/province_response/province_data.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListCity extends StatefulWidget {
  ListCity(
      {Key? key,
      required this.onBack,
      required this.listProvince,
      required this.selectedProvince})
      : super(key: key);
  final Function(
    ProvinceData selectedAttribute,
  )? onBack;
  final List<ProvinceData> listProvince;
  final ProvinceData selectedProvince;
  @override
  State<ListCity> createState() => _ListCityState();
}

class _ListCityState extends State<ListCity> {
  ProvinceData selectedProvinceData = ProvinceData();
  List<ProvinceData> listProvince = [];
  @override
  void initState() {
    setState(() {
      selectedProvinceData = widget.selectedProvince;
      listProvince = widget.listProvince;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * .7,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: listProvince.length,
        itemBuilder: (ctx, index) {
          return InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            // highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                selectedProvinceData = listProvince[index];
              });
            },
            child: Container(
                margin: EdgeInsets.symmetric(vertical: defaultPaddingItem.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      child: Text(
                        listProvince[index].name ?? "",
                        style:
                            titleStyle.copyWith(fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      width: 18.w,
                      height: 18.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.r),
                          border: Border.all(
                              width: 0.6.w,
                              color: listProvince[index] != selectedProvinceData
                                  ? Colors.grey
                                  : ThemeServices().isDarkMode
                                      ? kColorPrimaryDark
                                      : kColorPrimaryLight)),
                      child: selectedProvinceData == listProvince[index]
                          ? Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  color: ThemeServices().isDarkMode
                                      ? kColorPrimaryDark
                                      : kColorPrimaryLight),
                            )
                          : Container(),
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}
