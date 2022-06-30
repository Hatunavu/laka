import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VendorsGalleryController extends GetxController {
  var listImage = <GalleryModel>[].obs;
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  setImage(List<GalleryModel> imageList) {
    if (imageList.isNotEmpty) {
      listImage.value = imageList;
    }
  }
}
