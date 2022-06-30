import 'package:client_tggt/model/activity/doc.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/screen/activity/widget/activity_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullToRefreshList extends StatelessWidget {
  const PullToRefreshList({
    Key? key,
    required this.docs,
    required this.onRefresh,
    required this.onLoading,
    required this.refreshController,
    required this.callback,
    required this.isLoading,
  }) : super(key: key);

  final RefreshController refreshController;
  final Function() onRefresh;
  final Function() onLoading;
  final List<BookingItemModel>? docs;
  final VoidCallback callback;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: const ClassicHeader(
        completeText: '',
        completeIcon: null,
        releaseIcon: null,
        releaseText: '',
        refreshingIcon: null,
        refreshingText: '',
        idleIcon: null,
        idleText: '',
      ),
      footer: CustomFooter(builder: (context, mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text("pullToRefresh".tr);
        } else if (mode == LoadStatus.loading) {
          body = const CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = Text("failToRefresh".tr);
        } else if (mode == LoadStatus.canLoading) {
          body = Text("releaseToLoadmore".tr);
        } else {
          body = const Text(""); //const Text("Không còn dữ liệu");
        }
        return SizedBox(
          height: 55.0,
          child: Center(child: body),
        );
      }),
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: ListView.builder(
        itemCount: docs?.length ?? 0,
        itemBuilder: (c, i) => Column(
          children: [
            if (docs?[i] != null)
              ActivityCard(
                docData: docs![i],
                callback: callback,
              ),
          ],
        ),
      ),
    );
  }
}
