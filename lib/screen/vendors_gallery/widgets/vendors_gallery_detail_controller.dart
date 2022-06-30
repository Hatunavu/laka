import 'package:carousel_slider/carousel_controller.dart';
import 'package:chewie/chewie.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VendorsGalleryDetailController extends GetxController {
  final startPoint = 0.0.obs;
  final backgroundOpacity = 1.0.obs;
  final imageWidth = 0.0.obs;

  var carouselController = CarouselController().obs;
  var index = 0.obs;
  var listImage = <GalleryModel>[].obs;
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  final isPlayVideo = false.obs;
  @override
  void onClose() {
    // videoPlayerController.dispose();
    // chewieController?.dispose();
    super.onClose();
  }

  updateStartPoint(double point) {
    startPoint.value = point;
  }

  Future<bool> initializedPlayer(String url) async {
    isPlayVideo.value = true;
    videoPlayerController = VideoPlayerController.network(url);
    await Future.wait([videoPlayerController.initialize()]);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
    );
    return chewieController != null &&
        chewieController!.videoPlayerController.value.isInitialized;

    //update();
  }

  setImage(List<GalleryModel> imageList) {
    if (imageList.isNotEmpty) {
      listImage.value = imageList;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
