import 'dart:developer';
import 'dart:io';

import 'package:client_tggt/model/activity_detail/activity_detail_screen_response.dart';
import 'package:client_tggt/model/activity_detail/get_bill_by_qr_request.dart';
import 'package:client_tggt/model/admin_page/admin_get_list_orders_response.dart';
import 'package:client_tggt/model/admin_page/orders/order_detail/admin_update_order_request.dart';
import 'package:client_tggt/model/admin_page/orders/order_detail/admin_update_order_response.dart';
import 'package:client_tggt/model/affiliate/list_affiliate_response.dart';
import 'package:client_tggt/model/apply_vendor/apply_vendors_request.dart';
import 'package:client_tggt/model/apply_vendor/apply_vendors_response.dart';
import 'package:client_tggt/model/auth/add_deceive_token_request.dart';
import 'package:client_tggt/model/auth/add_decive_token_response.dart';
import 'package:client_tggt/model/auth/create_vendor/create_vendor_request.dart';
import 'package:client_tggt/model/auth/create_vendor/create_vendor_response.dart';
import 'package:client_tggt/model/auth/create_vendor/location/district_response/district_response.dart';
import 'package:client_tggt/model/auth/create_vendor/location/province_response/province_response.dart';
import 'package:client_tggt/model/auth/create_vendor/location/ward_response/ward_response.dart';
import 'package:client_tggt/model/auth/forgot_password/forgot_password_request.dart';
import 'package:client_tggt/model/auth/forgot_password/forgot_password_response.dart';
import 'package:client_tggt/model/auth/forgot_password/update_password/forgot_password_update_request.dart';
import 'package:client_tggt/model/auth/forgot_password/update_password/forgot_password_update_response.dart';
import 'package:client_tggt/model/auth/forgot_password/verify/forgot_password_verify_request.dart';
import 'package:client_tggt/model/auth/forgot_password/verify/fotgot_password_verify_response.dart';
import 'package:client_tggt/model/auth/logout_account_response.dart';
import 'package:client_tggt/model/auth/signin_checkphone_request.dart';
import 'package:client_tggt/model/auth/signin_checkphone_response.dart';
import 'package:client_tggt/model/auth/signin_reponse.dart';
import 'package:client_tggt/model/auth/signin_request.dart';
import 'package:client_tggt/model/auth/signin_telephone_request.dart';
import 'package:client_tggt/model/auth/signup_customer/check_telephone_request.dart';
import 'package:client_tggt/model/auth/signup_customer/check_telephone_response.dart';
import 'package:client_tggt/model/auth/signup_customer/complete_register_request.dart';
import 'package:client_tggt/model/auth/signup_customer/complete_register_response.dart';
import 'package:client_tggt/model/auth/signup_request.dart';
import 'package:client_tggt/model/auth/signup_response.dart';
import 'package:client_tggt/model/auth/verify_request.dart';
import 'package:client_tggt/model/auth/verify_response.dart';
import 'package:client_tggt/model/aws_image/aws_image.dart';
import 'package:client_tggt/model/detail_option/detail_option_response.dart';
import 'package:client_tggt/model/message/add_message_item_request.dart';
import 'package:client_tggt/model/message/add_message_item_response.dart';
import 'package:client_tggt/model/message/get_chat_room_vendor_response.dart';
import 'package:client_tggt/model/message/get_list_message_detail_response.dart';
import 'package:client_tggt/model/message/get_list_message_response.dart';
import 'package:client_tggt/model/newfeed/comment/add_comment_request.dart';
import 'package:client_tggt/model/newfeed/comment/add_comment_response.dart';
import 'package:client_tggt/model/newfeed/comment/get_more_comment_response.dart';
import 'package:client_tggt/model/newfeed/post/create_new_post_reponse.dart';
import 'package:client_tggt/model/newfeed/post/create_new_post_request.dart';
import 'package:client_tggt/model/newfeed/post/delete_post_by_id.dart';
import 'package:client_tggt/model/newfeed/post/get_list_post_response.dart';
import 'package:client_tggt/model/newfeed/post/get_post_by_id_reponse.dart';
import 'package:client_tggt/model/newfeed/reaction/update_reaction_request.dart';
import 'package:client_tggt/model/newfeed/reaction/update_reaction_response.dart';
import 'package:client_tggt/model/no_data/no_data_response.dart';
import 'package:client_tggt/model/notification/get_notification_response.dart';
import 'package:client_tggt/model/notification/update_read_notification_response.dart';
import 'package:client_tggt/model/order/cancel_order_response/cancel_order_response.dart';
import 'package:client_tggt/model/order/order_request/order_request.dart';
import 'package:client_tggt/model/order/order_response/order_response.dart';
import 'package:client_tggt/model/order/pre_calculate/pre_calculate_response/pre_calculate_response.dart';
import 'package:client_tggt/model/order/staff/customer_get_list_staff_response.dart';
import 'package:client_tggt/model/order/update_order/update_staff_order_request.dart';
import 'package:client_tggt/model/order/update_order/update_staff_order_response.dart';
import 'package:client_tggt/model/review/create/create_review_request/create_review_request.dart';
import 'package:client_tggt/model/review/create/create_review_response/create_review_response.dart';
import 'package:client_tggt/model/review/list_review_response/list_review_response.dart';
import 'package:client_tggt/model/review/vendors/vendors_reply_review_request.dart';
import 'package:client_tggt/model/review/vendors/vendors_reply_review_response.dart';
import 'package:client_tggt/model/rewards/get_customer_rewards_response.dart';
import 'package:client_tggt/model/rewards/get_rewards_history_response.dart';
import 'package:client_tggt/model/rewards/reward_screen_response.dart';
import 'package:client_tggt/model/search/filter/get_filter_vendor_response.dart';
import 'package:client_tggt/model/search/filter/get_list_attribute_response.dart';
import 'package:client_tggt/model/search/history/history_search_response.dart';
import 'package:client_tggt/model/search/list_tagline_response.dart';
import 'package:client_tggt/model/search/list_variant_response.dart';
import 'package:client_tggt/model/search/search_location_response.dart';
import 'package:client_tggt/model/user/get_customer_profile.response.dart';
import 'package:client_tggt/model/user/get_profile_response.dart';
import 'package:client_tggt/model/user/get_vendor_profile_response.dart';
import 'package:client_tggt/model/user/update_account_information_request.dart';
import 'package:client_tggt/model/user/update_account_information_response.dart';
import 'package:client_tggt/model/user/update_account_request.dart';
import 'package:client_tggt/model/user/update_account_response.dart';
import 'package:client_tggt/model/vendor/app_version/get_app_version_response.dart';
import 'package:client_tggt/model/vendor/home_screen_response.dart';
import 'package:client_tggt/model/vendor/vendor_detail_response.dart';
import 'package:client_tggt/model/vendor_page/account/staff/create_staff_request.dart';
import 'package:client_tggt/model/vendor_page/account/staff/create_staff_response.dart';
import 'package:client_tggt/model/vendor_page/account/update_vendor_profile_request.dart';
import 'package:client_tggt/model/vendor_page/account/update_vendor_profile_response.dart';
import 'package:client_tggt/model/vendor_page/account/update_vendors_thubnail_response.dart';
import 'package:client_tggt/model/vendor_page/account/update_vendors_thumbnail_request.dart';
import 'package:client_tggt/model/vendor_page/add_services/add_services_response.dart';
import 'package:client_tggt/model/vendor_page/add_services/vendor_add_services_attribute_response.dart';
import 'package:client_tggt/model/vendor_page/add_services/vendor_add_services_request.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_detail_response.dart';
import 'package:client_tggt/model/vendor_page/booking/get_list_booking_response.dart';
import 'package:client_tggt/model/vendor_page/booking/menu/create_menu_request.dart';
import 'package:client_tggt/model/vendor_page/booking/menu/create_menu_response.dart';
import 'package:client_tggt/model/vendor_page/booking/menu/get_list_menu_response.dart';
import 'package:client_tggt/model/vendor_page/booking/menu/update_menu_order_request.dart';
import 'package:client_tggt/model/vendor_page/booking/menu/update_menu_order_response.dart';
import 'package:client_tggt/model/vendor_page/booking/staff/vendor_get_list_staff_response.dart';
import 'package:client_tggt/model/vendor_page/booking/sub_fee/add_subfee_order_request.dart';
import 'package:client_tggt/model/vendor_page/booking/sub_fee/add_subfee_order_response.dart';
import 'package:client_tggt/model/vendor_page/booking/update_booking_request.dart';
import 'package:client_tggt/model/vendor_page/booking/update_booking_response.dart';
import 'package:client_tggt/model/vendor_page/booking/vendors_create_order_response.dart';
import 'package:client_tggt/model/vendor_page/dashboard/vendor_dashboard_response.dart';
import 'package:client_tggt/model/vendor_page/manager_services/edit_service_item_gallery_request.dart';
import 'package:client_tggt/model/vendor_page/manager_services/edit_service_item_gallery_response.dart';
import 'package:client_tggt/model/vendor_page/manager_services/edit_service_item_request.dart';
import 'package:client_tggt/model/vendor_page/manager_services/edit_service_item_response.dart';
import 'package:client_tggt/model/vendor_page/manager_services/edit_service_item_thumbnail_request.dart';
import 'package:client_tggt/model/vendor_page/manager_services/edit_service_item_thumbnail_response.dart';
import 'package:client_tggt/model/vendor_page/manager_services/get_list_services_response.dart';
import 'package:client_tggt/model/vendor_page/manager_services/service_detail_response.dart';
import 'package:client_tggt/model/vendor_page/reviews/vendors_get_list_review_response.dart';
import 'package:client_tggt/model/vendors/vendors_poster_response.dart';
import 'package:client_tggt/model/vendors/vendors_screen_response.dart';
import 'package:client_tggt/model/vendor/vendors_category_response.dart';
import 'package:client_tggt/model/activity/activity_screen_response.dart';
import 'package:client_tggt/model/voucher/get_list_voucher_response.dart';
import 'package:client_tggt/screen/activity/widget/pull_to_refresh_list.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:client_tggt/api/endpoint.dart' as endpoint;
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(
    Dio dio, {
    String baseUrl,
  }) = _ApiClient;

  @GET(endpoint.getAppVersion)
  Future<GetAppVersionResponse> getAppVersion();

  @GET(endpoint.getHotAndSuggestVendor)
  Future<HomeScreenResponse> getHotAndSuggestVendor(
      @Path('lat') String lat, @Path("lng") String lng);

  @POST(endpoint.postSignin)
  Future<SigninResponse> login(@Body() SigninRequest request);

  @POST(endpoint.postCreateAccount)
  Future<SignupResponse> create(@Body() SignupRequest request);

  @POST(endpoint.checkTelephoneSignupCustomer)
  Future<CheckTelephoneResponse> checkTelephoneSignupCustomer(
      @Body() CheckTelephoneRequest request);

  @POST(endpoint.postVerifyOTP)
  Future<VerifyResponse> postVerifyOpt(@Body() VerifyRequest request);

  // @GET(endpoint.getMe)
  // Future<GetProfileResponse> getMyAccount();

  @GET(endpoint.getMe)
  Future<GetProfileResponse> getMyAccount(
      @Header("Authorization") String token);

  @GET(endpoint.getMe)
  Future<GetVendorProfileResponse> getVendorInfor();

  @GET(endpoint.getMe)
  Future<GetCustomerProfileResponse> getCustomerInfor();

  @GET(endpoint.getRewards)
  Future<GetCustomerRewardsResponse> getCustomerRewards();

  @GET(endpoint.getListRewardsHistory)
  Future<GetListRewardsHistoryResponse> getListRewardsHistory(
    @Path('type') String? type,
    @Path('limit') int? limit,
    @Path('page') int? page,
  );
  @GET(endpoint.getVendorByLocation)
  Future<SearchLocationResponse> getVendorByLocation(
      @Path('latt') String latt, @Path("lng") String lng);

  @GET(endpoint.getVendorByText)
  Future<SearchLocationResponse> getVendorByText(
      @Path('textSearch') String textSearch);

  @GET(endpoint.getVendorDetail)
  Future<VendorDetailResponse> getVendorDetail(
      @Path('vendor_id') String vendorId);

  @GET(endpoint.getListVendors)
  Future<VendorsScreenResponse> getListVendors(
      @Path('category') String category);

  @GET(endpoint.getSeachVendor)
  Future<SearchLocationResponse> getSearchVendors(
    @Path('category') String? category,
    @Path('listAttributeId') String? listAttributeId,
    @Path('textSearch') String? textSearch,
    @Path('lng') String? lng,
    @Path('lat') String? lat,
  );

  @GET(endpoint.getSearchHistory)
  Future<HistorySearchResponse> getSearchHistory();

  @GET(endpoint.getListVendorsByCategory)
  Future<VendorListCategoryResponse> getListVendorsByCategory(
      @Path('category') String category);

  @GET(endpoint.getListOrders)
  Future<ActivityScreenResponse> getListOrders(
      @Path('limit') int limit,
      @Path('page') int page,
      @Path('cats') String cats,
      @Path('status') String status);

  @GET(endpoint.getDetailOrder)
  Future<ActivityDetailScreenResponse> getDetailOrder(@Path('id') String id);

  @POST(endpoint.getBillByQr)
  Future<ActivityDetailScreenResponse> getBillByQr(
      @Body() GetBillByQrRequest request);
  @POST(endpoint.confirmBillQr)
  Future<ActivityDetailScreenResponse> confirmBillQr(
      @Body() GetBillByQrRequest request);

  @POST(endpoint.postOrder)
  Future<OrderResponse> postOrder(@Body() OrderRequest request);

  @GET(endpoint.getCancelOrder)
  Future<CancelOrderResponse> getCancelOrder(@Path('id') String id);

  @GET(endpoint.getListAttributeByCategory)
  Future<VendorAddServicesAttributeResponse> getListAttributeByCategory();

  @POST(endpoint.postCreateNewServices)
  Future<AddServiceResponse> postCreateNewServices(
      @Body() VendorAddServicesRequest request);

  @POST(endpoint.getVendorsDetail)
  Future<CreateVendorResponse> postCreateVendor(
      @Body() CreateVendorRequest request);

  @GET(endpoint.getProvinces)
  Future<ProvinceResponse> getProvinces();
  @GET(endpoint.getDistrictsByProvince)
  Future<DistrictResponse> getDistrictsByProvince(@Path('id') String id);
  @GET(endpoint.getWardsByDistrict)
  Future<WardResponse> getWardsByDistrict(@Path('id') String id);

  @GET(endpoint.getListServices)
  Future<GetListServicesResponse> getListServices(
    @Path('limit') int limit,
    @Path('page') int page,
    @Path('active') String active,
    @Path('status') String status,
  );

  @PUT(endpoint.putEditServiceItem)
  Future<EditServiceItemResponse> putUpdateServiceItem(
      @Path('service_id') String serviceId,
      @Body() EditServiceItemRequest request);

  @GET(endpoint.getListBooking)
  Future<GetListBookingResponse> getListBooking(
    @Path('status') String? status,
    @Path('text') String? text,
    @Path('startDate') String? startDate,
    @Path('endDate') String? endDate,
    @Path('limit') int? limit,
    @Path('page') int? page,
  );

  @GET(endpoint.getBookingDetail)
  Future<GetBookingDetailResponse> getBookingDetail(
    @Path('bookingId') String? bookingId,
  );
  @GET(endpoint.getListAffiliate)
  Future<GetListAffiliateResponse> getListAffiliate();
  @PUT(endpoint.putVendorUpdateBooking)
  Future<UpdateBookingResponse> putVendorUpdateBooking(
      @Path('bookingId') String bookingId,
      @Body() UpdateBookingRequest request);

  @POST(endpoint.updateMenuOrders)
  Future<UpdateMenuOrderResponse> updateMenuOrders(
      @Path('bookingId') String bookingId,
      @Body() UpdateMenuInOrderRequest request);

  @POST(endpoint.updateSubfeeOrders)
  Future<UpdateSubFeeOrderResponse> updateSubfeeOrders(
      @Path('bookingId') String bookingId,
      @Body() UpdateSubFeeOrderRequest request);

  @POST(endpoint.putVendorCompleteBooking)
  Future<UpdateBookingResponse> putVendorCompleteBooking(
      @Path('bookingId') String bookingId,
      @Body() CompleteBookingRequest request);
  @POST(endpoint.updateBillOrder)
  Future<UpdateBookingResponse> updateBillOrder(
      @Path('bookingId') String bookingId,
      @Body() UpdateBillOrderRequest request);

  @GET(endpoint.getServiceDetail)
  Future<ServiceDetailResponse> getServiceDetail(
    @Path('serviceId') String? serviceId,
  );

  @GET(endpoint.getListVendorByType)
  Future<SearchLocationResponse> getListVendorByType();

  @POST(endpoint.generateImageUrl)
  Future<GenerateAwsImageResponse> generateImageUrl(
      @Body() GenerateAwsImageRequest request);

  @POST(endpoint.updateAvatar)
  Future<UpdateAccountResponse> updateAvatar(
      @Body() UpdateAccountRequest request);

  @GET(endpoint.getDetailOption)
  Future<DetailOptionResponse> getDetailOption(
    @Path('productId') String? productId,
  );
  @POST(endpoint.updateServiceThumbnail)
  Future<UpdateServiceItemThumbnailResponse> updateServiceThumbnail(
      @Path('serviceId') String serviceId,
      @Body() UpdateServiceItemThumbnailRequest request);

  @POST(endpoint.updateServiceGallery)
  Future<UpdateServiceItemGalleryResponse> updateServiceGallery(
      @Path('serviceId') String serviceId,
      @Body() UpdateServiceItemGalleryRequest request);

  @GET(endpoint.getListReview)
  Future<ListReviewResponse> getListReview(
    @Path('vendorId') String? vendorId,
    @Path('limit') int? limit,
    @Path('page') int? page,
  );

  @POST(endpoint.postCreateReview)
  Future<CreateReviewResponse> postCreateReview(
      @Body() CreateReviewRequest request);

  @POST(endpoint.postCreateReviewForOrder)
  Future<CreateReviewResponse> postCreateReviewForOrder(
      @Path('id') String orderID, @Body() CreateReviewRequest request);

  @POST(endpoint.postPreOrderCalculate)
  Future<PreCalculateResponse> postPreOrderCalculate(
      @Body() OrderRequest request);
  @GET(endpoint.getNotifications)
  Future<GetListNotificationResponse> getListNotification(
    @Path('limit') int? limit,
    @Path('page') int? page,
  );

  @GET(endpoint.updateReadNotification)
  Future<UpdateReadNotificationResponse> updateReadNotification(
    @Path('readStatus') String? readAllStatus,
    @Path('refId') String? refId,
  );

  @POST(endpoint.generateImagePost)
  Future<GenerateAwsImageResponse> generatePostImageUrl(
      @Body() GenerateAwsImageRequest request);

  @POST(endpoint.generateImageOrderComplete)
  Future<GenerateAwsImageResponse> generateImageOrderComplete(
      @Body() GenerateAwsImageRequest request);

  @POST(endpoint.createNewPost)
  Future<CreateNewPostResponse> createNewPost(
      @Body() CreateNewPostRequest request);

  @GET(endpoint.getListPost)
  Future<GetListPostResponse> getListPost(
    @Path('limit') int? limit,
    @Path('page') int? page,
    @Path('tag') String? vendorId,
  );

  @GET(endpoint.getListUserPost)
  Future<GetListPostResponse> getListUserPost(
    @Path('limit') int? limit,
    @Path('page') int? page,
    @Path('tag') String? vendorId,
  );
  @POST(endpoint.updateInformation)
  Future<UpdateAccountInformationResponse> updateProfileInformation(
      @Body() UpdateAccountInformationRequest request);

  @GET(endpoint.getPostById)
  Future<GetPostByIdResponse> getPostById(
    @Path('postId') String? postId,
    @Path('parentCommentCount') int? parentCommentCount,
    @Path('childCommentCount') int? childCommentCount,
  );

  @DELETE(endpoint.deletePostById)
  Future<DeletePostByIdResponse> deletePostById(
    @Path('postId') String? postId,
  );

  @POST(endpoint.postAddComment)
  Future<AddCommentResponse> postAddComment(
      @Path('postId') String? postId, @Body() AddCommentRequest request);

  @GET(endpoint.getMoreComment)
  Future<GetMoreCommentResponse> getMoreComment(
    @Path('commentParentId') String? commentParentId,
    @Path('postId') String? postId,
    @Path('parentCommentCount') int? parentCommentCount,
    @Path('commentPage') int? commentPage,
    @Path('childCommentCount') int? childCommentCount,
    @Path('skip') int? skip,
  );

  @GET(endpoint.getListMessageDetail)
  Future<GetListMessageDetailResponse> getListMessageDetail(
    @Path('chatRoomId') String? chatRoomId,
    @Path('limit') int? limit,
    @Path('page') int? page,
  );

  @POST(endpoint.createChatWithVendor)
  Future<GetListMessageDetailResponse> createChatWithVendor(
      @Path('vendorId') String? vendorId,
      @Body() AddMessageItemRequest request);

  @POST(endpoint.postAddMessageItem)
  Future<AddMessageItemResponse> postAddMessageItem(
      @Path('messageId') String? messageId,
      @Body() AddMessageItemRequest request);

  @GET(endpoint.getListMessage)
  Future<GetListMessageResponse> getListMessage(
    @Path('limit') int? limit,
    @Path('page') int? page,
  );

  @POST(endpoint.updateReaction)
  Future<UpdateReactionResponse> updateReaction(
      @Path('postId') String? postId, @Body() UpdateReactionRequest request);

  @POST(endpoint.updateDeceiveToken)
  Future<AddDeceiveTokenResponse> updateDeceiveToken(
      @Body() AddDeceiveTokenRequest request);

  @GET(endpoint.logoutAccount)
  Future<LogoutAccountResponse> logoutAccount();

  @POST(endpoint.signInCheckPhone)
  Future<SigninCheckPhoneResponse> signInCheckPhone(
      @Body() SigninCheckPhoneRequest request);

  @POST(endpoint.forgotPassword)
  Future<ForgotPasswordReponse> forgotPassword(
      @Body() ForgotPasswordRequest request);

  @POST(endpoint.verifyForgotPassword)
  Future<ForgotPasswordVerifyResponse> verifyForgotPassword(
      @Body() ForgotPasswordVerifyRequest request);
  @PUT(endpoint.changePassword)
  Future<ForgotPasswordUpdateReponse> changePassword(
      @Body() ForgotPasswordUpdateRequest request);

  @PUT(endpoint.completeRegister)
  Future<CompleteRegisterResponse> completeRegister(
      @Body() CompleteRegisterRequest request);

  @POST(endpoint.signInTelephone)
  Future<SigninResponse> signInTelephone(
      @Body() SigninTelephoneRequest request);

  @POST(endpoint.updateVendorProfile)
  Future<UpdateVendorProfileResponse> updateVendorProfile(
      @Body() UpdateVendorProfileRequest request);
  @GET(endpoint.customerGetListAttribute)
  Future<GetListAttributeResponse> customerGetListAttribute();

  @GET(endpoint.getFilterVendor)
  Future<GetFilterVendorReponse> getFilterVendor(
    @Path('attributes') String? attributes,
    @Path('text') String? text,
    @Path('lng') String? lng,
    @Path('lat') String? lat,
    @Path('limit') int? limit,
    @Path('page') int? page,
    @Path('minPrice') String? minPrice,
    @Path('maxPrice') String? maxPrice,
    @Path('cats') String? cats,
    @Path('province') String? province,
    @Path('district') String? district,
    @Path('taglines') String? taglines,
    @Path('variant') String? variant,
  );
  @GET(endpoint.getPosterByCategory)
  Future<VendorsPosterResponse> getVendorsPoster(
    @Path('category') String category,
    @Path('page') int page,
    @Path('lng') String? lng,
    @Path('lat') String? lat,
  );

  @POST(endpoint.applyVendor)
  Future<CreateVendorResponse> applyVendor(@Body() CreateVendorRequest request);

  @GET(endpoint.getVendorDashboard)
  Future<VendorDashboardResponse> getVendorDashboard(
    @Path('startDate') String? startDate,
    @Path('endDate') String? endDate,
  );

  @GET(endpoint.vendorsGetListReviews)
  Future<VendorsGetListReviewsResponse> vendorsGetListReviews(
      @Path('limit') int? limit,
      @Path('page') int? page,
      @Path('type') String type);

  @POST(endpoint.generateUpdateThumbnail)
  Future<GenerateAwsImageResponse> generateUpdateThumbnail(
      @Body() GenerateAwsImageRequest request);

  @POST(endpoint.updateVendorsThumbnail)
  Future<UpdateVendorsThumbnailResponse> updateVendorsThumbnail(
      @Body() UpdateVendorsThumnailRequest request);
  @POST(endpoint.vendorsReplyComment)
  Future<VendorsReplyReviewResponse> vendorsReplyComment(
      @Path("reviewId") String reviewId,
      @Body() VendorsReplyReviewRequest request);

  @POST(endpoint.applicationsVendor)
  Future<ApplyVendorResponse> applicationVendor(
      @Body() ApplyVendorsRequest request);

  @GET(endpoint.getListVoucher)
  Future<GetListVoucherResponse> getListVoucher(
      @Path('limit') int? limit,
      @Path('page') int? page,
      @Path('type') String type,
      @Path('vendorId') String vendorId);

  @POST(endpoint.updateStaffForOrder)
  Future<UpdateStaffOrderResponse> updateStaffForOrder(
      @Body() UpdateStaffOrderRequest request, @Path('orderId') String orderId);

  @POST(endpoint.vendorCreateStaff)
  Future<CreateStaffResponse> createStaff(@Body() CreateStaffRequest request);

  @GET(endpoint.customerGetListStaff)
  Future<CustomerGetListStaffResponse> customerGetListStaff(
      @Path('vendorId') String vendorId);

  @POST(endpoint.vendorCreateMenu)
  Future<CreateMenuResponse> vendorCreateMenu(
      @Body() CreateMenuRequest request);

  @GET(endpoint.vendorGetListMenu)
  Future<VendorGetListMenuResponse> vendorGetListMenu();

  @GET(endpoint.vendorGetListStaffs)
  Future<VendorsGetListStaffResponse> vendorGetListStaffs();

  @GET(endpoint.getTaglineByCategory)
  Future<ListTagLinesResponse> getListTaglinesByCategory(
      @Path('category') String category);

  @GET(endpoint.getVariantsByCategory)
  Future<ListVariantResponse> getVariantsByCategory(
      @Path('category') String category);

  @GET(endpoint.getListSubCategory)
  Future<ListVariantResponse> getListSubCategory(
      @Path('category') String category);

  @GET(endpoint.getChatRoomByVendorId)
  Future<GetChatRoomVendorResponse> getChatRoomWithVendor(
      @Path('vendorId') String vendorId);

  @GET(endpoint.vendorGetVoucher)
  Future<GetListVoucherResponse> vendorGetVoucher(@Path('limit') int? limit,
      @Path('page') int? page, @Path('type') String type);

  @POST(endpoint.vendorsCreateBill)
  Future<VendorsCreateOrderResponse> vendorsCreateBill(
      @Body() VendorCreateOrderRequest request);

  @GET(endpoint.getRewardScreen)
  Future<RewardScreenResponse> getRewardScreen();

  @GET(endpoint.adminGetListOrders)
  Future<AdminGetListOrdersReponse> adminGetListOrders(
    @Path('page') int page,
    @Path('status') String? status,
    @Path('text') String? text,
    @Path('vendorStatus') String? vendorStatus,
    @Path('province') String? province,
    @Path('district') String? district,
    @Path('cat') String? cat,
    @Path('startDate') String? startDate,
    @Path('endDate') String? endDate,
  );

  @GET(endpoint.adminGetOrderDetail)
  Future<GetBookingDetailResponse> adminGetOrderDetail(
    @Path('orderId') String? orderId,
  );

  @PUT(endpoint.adminUpdateOrder)
  Future<AdminUpdateOrdersResponse> adminUpdateOrder(
    @Body() AdminUpdateOrdersRequest request,
    @Path('orderId') String? orderId,
  );

  @POST(endpoint.adminCompleteOrder)
  Future<UpdateBookingResponse> adminCompleteOrder(
      @Path('orderId') String orderId, @Body() CompleteBookingRequest request);

  // GetFilterVendorReponse
  @GET(endpoint.getMoreHotVendor)
  Future<GetFilterVendorReponse> getMoreHotVendor(
    @Path('page') String? page,
    @Path('lng') String? lng,
    @Path('lat') String? lat,
  );
}

extension ApiClientAWSS3 on ApiClient {
  Future<bool> uploadImage(String url, File image) async {
    try {
      final uri = Uri.parse(url);
      // resize before upload file
      final decodedImage = img.decodeImage(image.readAsBytesSync());
      if (decodedImage != null) {
        img.Image resizedImage = decodedImage;
        if (decodedImage.width > 800) {
          resizedImage = img.copyResize(decodedImage, width: 800);
        }

        Map<String, String> header = {};

        uri.queryParameters.forEach((k, v) {
          header[k] = v;
        });
        var response = await http.put(uri,
            body: img.encodeJpg(resizedImage), headers: header);
        log(response.body);
        if (response.statusCode == 200) {
          return true;
        }
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> uploadVideo(String url, File video) async {
    try {
      final uri = Uri.parse(url);
      // resize before upload file

      Map<String, String> header = {};

      uri.queryParameters.forEach((k, v) {
        header[k] = v;
      });
      var response =
          await http.put(uri, body: video.readAsBytesSync(), headers: header);
      log(response.body);
      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}

extension ApiClientHandleError on ApiClient {
  String mapDioErrorToMessage(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return 'Connection timeout';
      case DioErrorType.response:
        // Parsing error response to string error
        if (error.response != null) {
          final res = error.response;
          if (res?.data != null) {
            try {
              final response = NoDataResponse.fromJson(res?.data);
              return response.message;
            } catch (e) {
              return 'Common error (${res?.statusCode ?? ''})';
            }
          }
          return 'Common error (${res?.statusCode ?? ''})';
        }
        return 'Common error (${error.toString()})';
      case DioErrorType.cancel:
        return 'Request was cancelled unexpectedly';
      case DioErrorType.other:
        return error.message;
    }
  }
}
