import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/newfeed/post/post.dart';
import 'package:client_tggt/model/newfeed/reaction/update_reaction_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class NewfeedController extends GetxController {
  final String title = "newfeed";
  final isLoading = false.obs;
  final listPosts = <PostModel>[].obs;
  final isEmptyPosts = false.obs;
  final totalDocs = 0.obs;
  final limit = 10.obs;
  final page = 1.obs;
  final isLoadingUpdateReaction = false.obs;
  ScrollController listPostController = ScrollController();
  final loadingId = "".obs;
  NewfeedController(this._apiClient);
  final ApiClient _apiClient;
  @override
  void onReady() async {
    log("ready");
    super.onReady();
  }

  @override
  void onInit() {
    listPostController.addListener(listenLoadMoreList);
    super.onInit();
  }

  getListPost() async {
    try {
      isLoading(true);
      final response = await _apiClient.getListPost(10, 1, "");
      if (response.status == 200) {
        if (response.data.docs!.isEmpty) {
          isEmptyPosts.value = true;
        } else {
          final data = response.data.docs;
          listPosts.value = data ?? [];
        }
        totalDocs.value = response.data.totalDocs ?? 0;
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  listenLoadMoreList() {
    if (listPostController.offset ==
        listPostController.position.maxScrollExtent) {
      if (listPosts.length < totalDocs.value) {
        getMoreListPost();
      }
    }
  }

  getMoreListPost() async {
    try {
      final response =
          await _apiClient.getListPost(limit.value, page.value + 1, "");
      if (response.status == 200) {
        page.value = page.value + 1;
        listPosts.value = [...listPosts, ...response.data.docs ?? []];
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {}
  }

  handleUpdatePostReaction(String postId, String type) async {
    try {
      isLoadingUpdateReaction.value = true;
      final request = UpdateReactionRequest(type: type);
      final response = await _apiClient.updateReaction(postId, request);
      if (response.status == 200) {
        int index = listPosts.indexWhere((element) => element.id == postId);
        listPosts[index].reacted = response.data.reacted;
        listPosts[index].totalReactions = response.data.totalReactions;
        inspect(listPosts);
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoadingUpdateReaction.value = false;
    }
  }

  Future<bool> deletePostById(String postId) async {
    try {
      loadingId.value = postId;
      final response = await _apiClient.deletePostById(postId);
      if (response.status == 200) {
        listPosts.value =
            listPosts.where((element) => element.id != postId).toList();
        return true;
      } else {
        return false;
      }
    } on Exception catch (err) {
      log("err $err");
      return false;
    } finally {
      loadingId.value = "";
    }
  }
}
