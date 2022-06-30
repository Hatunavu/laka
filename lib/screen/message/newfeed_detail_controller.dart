import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/newfeed/comment/add_comment_request.dart';
import 'package:client_tggt/model/newfeed/comment/comment.dart';
import 'package:client_tggt/model/newfeed/post/post.dart';
import 'package:client_tggt/model/newfeed/reaction/update_reaction_request.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NewfeedDetailController extends GetxController {
  final String title = "newfeedDetail";
  List<CommentItem> listComment = <CommentItem>[].obs;

  final limitComment = 5.obs;
  final limitReplyComment = 2.obs;
  final totalComment = 0.obs;
  final commentPage = 1.obs;
  final isLoadingMore = false.obs;
  final isLoadMoreReply = false.obs;

  final isLoadingComment = false.obs;
  final isLoading = false.obs;
  final isLoadingUpdateReaction = false.obs;
  NewfeedDetailController(this._apiClient);
  final isReply = false.obs;
  final ApiClient _apiClient;

  final postDetail =
      PostModel(id: '', by: AccountModel(), active: true, totalComments: 0).obs;
  final contentComment = TextEditingController(text: "").obs;
  final selectedComment = CommentItem(by: AccountModel()).obs;
  final replyFor = "".obs;
  final replyForId = "".obs;
  final focusNode = FocusNode();
  ScrollController listCommentController = ScrollController();

  @override
  void onReady() async {
    focusNode.addListener(() {
      if (focusNode.hasFocus == false) {
        replyFor.value = "";
        replyForId.value = "";
        isReply.value = false;
      }
    });
    super.onReady();
  }

  @override
  void onInit() {
    listCommentController.addListener(listenLoadMoreComment);
    super.onInit();
  }

  handleUpdateShowKeyboard(bool status) {
    isReply.value = status;
  }

  getPostById(String id) async {
    try {
      isLoading.value = true;
      final res = await _apiClient.getPostById(
          id, limitComment.value, limitReplyComment.value);
      if (res.status == 200) {
        postDetail.value = res.data;
        if (res.data.comments != null) {
          listComment = res.data.comments!.parents ?? [];
          totalComment.value = res.data.comments!.metadata!.totalDocs ?? 0;
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading.value = false;
    }
  }

  listenLoadMoreComment() {
    if (listCommentController.offset ==
        listCommentController.position.maxScrollExtent) {
      if (listComment.length < totalComment.value) {
        getMoreListComment();
      }
    }
  }

  getMoreReplyComment(String commentId, int replyMore) async {
    try {
      isLoadMoreReply.value = true;
      final response = await _apiClient.getMoreComment(commentId,
          postDetail.value.id, replyMore, 1, 0, limitReplyComment.value);
      if (response.status == 200) {
        int index =
            listComment.indexWhere((element) => element.id == commentId);
        listComment[index].replies!.docs = [
          ...listComment[index].replies!.docs,
          ...response.data.docs
        ];
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoadMoreReply.value = false;
    }
  }

  getMoreListComment() async {
    try {
      isLoadingMore.value = true;
      final response = await _apiClient.getMoreComment(
          "",
          postDetail.value.id,
          limitComment.value,
          commentPage.value + 1,
          limitReplyComment.value,
          0);
      if (response.status == 200) {
        commentPage.value = commentPage.value + 1;
        listComment = [...listComment, ...response.data.docs];
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoadingMore.value = false;
    }
  }

  handleUpdatePostReaction(String postId, String type) async {
    try {
      isLoadingUpdateReaction.value = true;
      final request = UpdateReactionRequest(type: type);
      final response = await _apiClient.updateReaction(postId, request);
      if (response.status == 200) {
        postDetail.value.reacted = response.data.reacted;
        postDetail.value.totalReactions = response.data.totalReactions;
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoadingUpdateReaction.value = false;
    }
  }

  handlePostComment() async {
    if (contentComment.value.text == "") return;
    if (isReply.value == false) {
      try {
        isLoadingComment.value = true;
        final request = AddCommentRequest(content: contentComment.value.text);
        final res =
            await _apiClient.postAddComment(postDetail.value.id, request);
        if (res.status == 200) {
          final comment = res.data.comment;
          contentComment.value.text = "";
          listComment.add(comment);
          focusNode.unfocus();
        }
      } on Exception catch (err) {
        log("err $err");
      } finally {
        isLoadingComment.value = false;
      }
    } else {
      try {
        isLoadingComment.value = true;
        final request = AddCommentRequest(
            content: contentComment.value.text, parent: replyForId.value);
        final res =
            await _apiClient.postAddComment(postDetail.value.id, request);
        if (res.status == 200) {
          final comment = res.data.comment;
          final newComment = listComment.map((item) {
            if (item.id == replyForId.value) {
              if (item.replies != null) {
                item.replies!.docs.add(comment);
              } else {
                item.repliesObject = ReplyModel(docs: []);
                item.replies!.docs.add(comment);
              }
              return item;
            } else {
              return item;
            }
          }).toList();
          listComment = newComment;
          replyFor.value = "";
          replyForId.value = "";
          contentComment.value.text = "";
          isReply.value = false;
          focusNode.unfocus();
        }
      } on Exception catch (err) {
        log("err $err");
      } finally {
        isLoadingComment.value = false;
      }
    }
  }

  hanleSelectComment(CommentItem item) {
    isReply.value = true;
    replyFor.value = item.displayName;
    replyForId.value = item.id ?? "";
    focusNode.requestFocus();
  }
}
