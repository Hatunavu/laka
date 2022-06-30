// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i83;
import 'package:flutter/material.dart' as _i84;

import '../model/category/enum_category.dart' as _i90;
import '../model/order/staff/staff_model.dart' as _i93;
import '../model/user/account_model.dart' as _i86;
import '../model/vendor/services_model.dart' as _i91;
import '../model/vendor/variant_model.dart' as _i89;
import '../model/vendor/vendor_info_model.dart' as _i92;
import '../model/vendor_page/booking/booking_item_model.dart' as _i87;
import '../model/vendor_page/booking/menu/menu_model.dart' as _i94;
import '../model/voucher/voucher_model.dart' as _i88;
import '../screen/activity/detail/activity_detail_screen.dart' as _i40;
import '../screen/activity/maps_derection/maps_derection_screen.dart' as _i41;
import '../screen/activity/qr_screen/order_qr_screen.dart' as _i42;
import '../screen/admin_page/admin_main/admin_main_screen.dart' as _i19;
import '../screen/admin_page/admin_orders/detail/admin_orders_detail_screen.dart'
    as _i77;
import '../screen/auth/address/vendor_add_address_screen.dart' as _i13;
import '../screen/auth/forgot_password/forgot_password_screen.dart' as _i20;
import '../screen/auth/forgot_password/forgot_password_update_screen.dart'
    as _i22;
import '../screen/auth/forgot_password/forgotpassword_verify_screen.dart'
    as _i21;
import '../screen/auth/signin/signin_screen.dart' as _i15;
import '../screen/auth/signin/signin_telephone_screen.dart' as _i3;
import '../screen/auth/signin/signin_verify_screen.dart' as _i4;
import '../screen/auth/signup/apply_vendor/apply_vendor_information.dart'
    as _i8;
import '../screen/auth/signup/complete_register_screen.dart' as _i5;
import '../screen/auth/signup/signup_screen.dart' as _i16;
import '../screen/auth/signup/signup_vendor/signup_vendor_fifth.dart' as _i12;
import '../screen/auth/signup/signup_vendor/signup_vendor_first.dart' as _i7;
import '../screen/auth/signup/signup_vendor/signup_vendor_fourth.dart' as _i11;
import '../screen/auth/signup/signup_vendor/signup_vendor_second.dart' as _i9;
import '../screen/auth/signup/signup_vendor/signup_vendor_success.dart' as _i14;
import '../screen/auth/signup/signup_vendor/signup_vendor_third.dart' as _i10;
import '../screen/auth/signup/signup_vendor_screen.dart' as _i6;
import '../screen/auth/verify/verify_screen.dart' as _i17;
import '../screen/filter_vendors/filter_vendors_screen.dart' as _i24;
import '../screen/history/history_screen.dart' as _i39;
import '../screen/home/widget/customer_qr_screen.dart' as _i67;
import '../screen/main/main_screen.dart' as _i2;
import '../screen/message/create_post_screen.dart' as _i68;
import '../screen/message/list_local_image_screen.dart' as _i60;
import '../screen/message/newfeed_detail_screen.dart' as _i29;
import '../screen/message/tags/add_tags_screen.dart' as _i69;
import '../screen/message/widget/newfeed_gallery.dart' as _i65;
import '../screen/message/widget/play_video_screen.dart' as _i61;
import '../screen/notification/notification_screen.dart' as _i55;
import '../screen/profile/affiliate/affiliate_screen.dart' as _i49;
import '../screen/profile/affiliate/history/affiliate_history_screen.dart'
    as _i50;
import '../screen/profile/help_and_support/help_and_support_screen.dart'
    as _i59;
import '../screen/profile/language/language_screen.dart' as _i43;
import '../screen/profile/message/message_detail_screen.dart' as _i52;
import '../screen/profile/message/message_screen.dart' as _i54;
import '../screen/profile/message/staff/staff_screen.dart' as _i53;
import '../screen/profile/newfeed/user_newfeed_screen.dart' as _i30;
import '../screen/profile/profile_information/profile_information.dart' as _i57;
import '../screen/profile/term_of_service/term_of_service_screen.dart' as _i58;
import '../screen/profile/theme/theme_screen.dart' as _i56;
import '../screen/review/review_screen.dart' as _i44;
import '../screen/rewards/detail/rewards_detail_screen.dart' as _i45;
import '../screen/rewards/rewards_guide/rewards_guide_screen.dart' as _i47;
import '../screen/rewards/rewards_history/rewards_history_screen.dart' as _i46;
import '../screen/rewards/tier_benefits/tier_benefits_screen.dart' as _i51;
import '../screen/rewards/voucher/voucher_detail_screen.dart' as _i48;
import '../screen/rewards/voucher/voucher_screen.dart' as _i82;
import '../screen/search/search_screen.dart' as _i66;
import '../screen/search_vendors/search_vendors_screen.dart' as _i23;
import '../screen/splash/splash_creen.dart' as _i1;
import '../screen/vendors/booking/confirm_complete/comfirm_complete.dart'
    as _i70;
import '../screen/vendors/booking/create_order/vendor_screate_order_screen.dart'
    as _i25;
import '../screen/vendors/booking/create_order/widget/vendor_list_product_screen.dart'
    as _i26;
import '../screen/vendors/booking/detail/booking_detail_screen.dart' as _i27;
import '../screen/vendors/booking/sub_fee/sub_fee_screen.dart' as _i80;
import '../screen/vendors/booking/upload_bill/upload_bill_screen.dart' as _i71;
import '../screen/vendors/main/vendors_main_screen.dart' as _i18;
import '../screen/vendors/product/add_product/vendor_add_product_screen.dart'
    as _i34;
import '../screen/vendors/product/product_detail/gallery/carousel_gallery_screen.dart'
    as _i62;
import '../screen/vendors/product/product_detail/gallery/gallery_screen.dart'
    as _i63;
import '../screen/vendors/product/product_detail/list_attribute/service_item_list_attribute_screen.dart'
    as _i36;
import '../screen/vendors/product/product_detail/service_item_detail_screen.dart'
    as _i37;
import '../screen/vendors/profile/menu/add_menu/add_menu_screen.dart' as _i81;
import '../screen/vendors/profile/menu/list_menu_screen.dart' as _i78;
import '../screen/vendors/profile/menu/select_menu/select_menu_screen.dart'
    as _i79;
import '../screen/vendors/profile/vendor_profile_information.dart/vendor_profile_address_screen.dart'
    as _i72;
import '../screen/vendors/profile/vendor_profile_information.dart/vendor_profile_information_screen.dart'
    as _i73;
import '../screen/vendors/profile/vendor_reviews/vendor_reviews_screen.dart'
    as _i74;
import '../screen/vendors/profile/waitress/add_waitress_screen.dart' as _i76;
import '../screen/vendors/profile/waitress/waitress_manager_screen.dart'
    as _i75;
import '../screen/vendors/qrcode/qrcode_screen.dart' as _i35;
import '../screen/vendors_detail/vendors_detail_screen.dart' as _i32;
import '../screen/vendors_detail/widgets/list_product_of_varient.dart' as _i33;
import '../screen/vendors_gallery/vendors_gallery_screen.dart' as _i38;
import '../screen/vendors_gallery/widgets/vendors_gallery_detail.dart' as _i64;
import '../screen/vendors_list/vendors_screen.dart' as _i31;
import '../shared/widget/errorpage/something_went_wrong.dart' as _i28;
import 'router.dart' as _i85;

class AppRouter extends _i83.RootStackRouter {
  AppRouter([_i84.GlobalKey<_i84.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i83.PageFactory> pagesMap = {
    SplashPage.name: (routeData) {
      final args = routeData.argsAs<SplashPageArgs>(
          orElse: () => const SplashPageArgs());
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i1.SplashScreen(key: args.key, isFristLoad: args.isFristLoad));
    },
    MainPage.name: (routeData) {
      final args =
          routeData.argsAs<MainPageArgs>(orElse: () => const MainPageArgs());
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.MainScreen(
              key: args.key,
              account: args.account,
              countPendingOrders: args.countPendingOrders,
              countUnreadNotifications: args.countUnreadNotifications,
              currentOrders: args.currentOrders));
    },
    SigninTelephonePage.name: (routeData) {
      return _i83.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i3.SigninTelephoneScreen(),
          fullscreenDialog: true,
          transitionsBuilder: _i85.slideBottomToTop,
          opaque: false,
          barrierDismissible: false);
    },
    SignInVerifyPage.name: (routeData) {
      final args = routeData.argsAs<SignInVerifyPageArgs>(
          orElse: () => const SignInVerifyPageArgs());
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i4.SignInVerifyScreen(key: args.key, telePhone: args.telePhone));
    },
    CompleteRegisterPage.name: (routeData) {
      final args = routeData.argsAs<CompleteRegisterPageArgs>();
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i5.CompleteRegisterScreen(key: args.key, account: args.account));
    },
    SignupVendorPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.SignupVendorScreen());
    },
    SignUpVendorFirstPage.name: (routeData) {
      final args = routeData.argsAs<SignUpVendorFirstPageArgs>();
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.SignUpVendorFirst(key: args.key, account: args.account));
    },
    ApplyVendorInformationPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.ApplyVendorInformation());
    },
    SignupVendorSecondPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.SignupVendorSecond());
    },
    SignupVendorThirdPage.name: (routeData) {
      final args = routeData.argsAs<SignupVendorThirdPageArgs>(
          orElse: () => const SignupVendorThirdPageArgs());
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i10.SignupVendorThirdScreen(key: args.key, onBack: args.onBack));
    },
    SignupVendorFourthPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.SignupVendorFourth());
    },
    SignupVendorFifthPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.SignupVendorFifth());
    },
    VendorAddAdressPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i13.VendorAddAdressScreen());
    },
    SignupVendorSuccessPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i14.SignupVendorSuccess());
    },
    SigninPage.name: (routeData) {
      return _i83.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i15.SigninScreen(),
          fullscreenDialog: true,
          transitionsBuilder: _i85.slideBottomToTop,
          opaque: false,
          barrierDismissible: false);
    },
    SignupPage.name: (routeData) {
      return _i83.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i16.SignupScreen(),
          fullscreenDialog: true,
          transitionsBuilder: _i85.slideBottomToTop,
          opaque: false,
          barrierDismissible: false);
    },
    VerifyPage.name: (routeData) {
      final args = routeData.argsAs<VerifyPageArgs>(
          orElse: () => const VerifyPageArgs());
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i17.VerifyScreen(key: args.key, telePhone: args.telePhone));
    },
    VendorMainPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i18.VendorMainScreen());
    },
    AdminMainPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i19.AdminMainScreen());
    },
    ForgotPasswordPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i20.ForgotPasswordScreen());
    },
    ForgotPasswordVerifyPage.name: (routeData) {
      final args = routeData.argsAs<ForgotPasswordVerifyPageArgs>();
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i21.ForgotPasswordVerifyScreen(
              key: args.key, telePhone: args.telePhone));
    },
    ForgotPasswordUpdatePage.name: (routeData) {
      final args = routeData.argsAs<ForgotPasswordUpdatePageArgs>();
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i22.ForgotPasswordUpdateScreen(
              key: args.key, token: args.token));
    },
    SearchVendorPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i23.SearchVendorScreen());
    },
    FilterVendorsPage.name: (routeData) {
      final args = routeData.argsAs<FilterVendorsPageArgs>();
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i24.FilterVendorsScreen(
              key: args.key,
              type: args.type,
              isFilterByCity: args.isFilterByCity,
              cityCode: args.cityCode,
              voucher: args.voucher,
              varient: args.varient,
              category: args.category));
    },
    VendorsCreateOrderPage.name: (routeData) {
      final args = routeData.argsAs<VendorsCreateOrderPageArgs>(
          orElse: () => const VendorsCreateOrderPageArgs());
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i25.VendorsCreateOrderScreen(
              key: args.key, onBack: args.onBack));
    },
    VendorListProductPage.name: (routeData) {
      final args = routeData.argsAs<VendorListProductPageArgs>();
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i26.VendorListProductScreen(
              key: args.key,
              listProduct: args.listProduct,
              selectedProduct: args.selectedProduct,
              onBack: args.onBack));
    },
    BookingDetailPage.name: (routeData) {
      final args = routeData.argsAs<BookingDetailPageArgs>(
          orElse: () => const BookingDetailPageArgs());
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i27.BookingDetailScreen(
              key: args.key,
              bookingId: args.bookingId,
              parentPage: args.parentPage,
              onBack: args.onBack));
    },
    SomethingWentWrongPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i28.SomethingWentWrongScreen());
    },
    NewfeedDetailPage.name: (routeData) {
      final args = routeData.argsAs<NewfeedDetailPageArgs>();
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i29.NewfeedDetailScreen(
              key: args.key, postId: args.postId, isFocus: args.isFocus));
    },
    UserNewfeedPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i30.UserNewfeedScreen());
    },
    VendorsPage.name: (routeData) {
      final args = routeData.argsAs<VendorsPageArgs>(
          orElse: () => const VendorsPageArgs());
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i31.VendorsScreen(key: args.key, category: args.category));
    },
    VendorsDetailPage.name: (routeData) {
      final args = routeData.argsAs<VendorsDetailPageArgs>();
      return _i83.CustomPage<dynamic>(
          routeData: routeData,
          child: _i32.VendorsDetailScreen(
              key: args.key,
              first: args.first,
              last: args.last,
              tagId: args.tagId,
              imageUrl: args.imageUrl,
              vendorTitle: args.vendorTitle,
              vendorsInfo: args.vendorsInfo,
              voucher: args.voucher),
          transitionsBuilder: _i83.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    ProductsOfVarientPage.name: (routeData) {
      final args = routeData.argsAs<ProductsOfVarientPageArgs>();
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i33.ProductsOfVarientScreen(
              key: args.key,
              variant: args.variant,
              onBack: args.onBack,
              isVendors: args.isVendors));
    },
    VendorAddProductPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i34.VendorAddProductScreen());
    },
    ScanQRScreenPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i35.ScanQRPage());
    },
    AttributeListPage.name: (routeData) {
      final args = routeData.argsAs<AttributeListPageArgs>(
          orElse: () => const AttributeListPageArgs());
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i36.ServiceItemListAttributeScreen(
              key: args.key, type: args.type));
    },
    ServiceItemDetailPage.name: (routeData) {
      final args = routeData.argsAs<ServiceItemDetailPageArgs>(
          orElse: () => const ServiceItemDetailPageArgs());
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i37.ServiceItemDetailScreen(
              key: args.key, serviceItemId: args.serviceItemId));
    },
    VendorsGalleryPage.name: (routeData) {
      final args = routeData.argsAs<VendorsGalleryPageArgs>(
          orElse: () => const VendorsGalleryPageArgs());
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i38.VendorsGalleryScreen(
              key: args.key, listImage: args.listImage));
    },
    HistoryPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i39.HistoryScreen());
    },
    ActivityDetailPage.name: (routeData) {
      final args = routeData.argsAs<ActivityDetailPageArgs>();
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i40.ActivityDetailScreen(
              key: args.key,
              id: args.id,
              orderId: args.orderId,
              isFromQr: args.isFromQr));
    },
    MapsDerectionPage.name: (routeData) {
      final args = routeData.argsAs<MapsDerectionPageArgs>();
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i41.MapsDerectionScreen(
              key: args.key, vendorInfo: args.vendorInfo));
    },
    OrderQrPage.name: (routeData) {
      final args = routeData.argsAs<OrderQrPageArgs>();
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i42.OrderQrScreen(key: args.key, orderId: args.orderId));
    },
    LanguagePage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i43.LanguageScreen());
    },
    ReviewPage.name: (routeData) {
      final args = routeData.argsAs<ReviewPageArgs>(
          orElse: () => const ReviewPageArgs());
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i44.ReviewScreen(key: args.key, vendorID: args.vendorID));
    },
    RewardsDetailPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i45.RewardsDetailScreen());
    },
    RewardsHistoryPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i46.RewardsHistoryScreen());
    },
    RewardsGuidePage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i47.RewardsGuideScreen());
    },
    VoucherDetailPage.name: (routeData) {
      final args = routeData.argsAs<VoucherDetailPageArgs>();
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i48.VoucherDetailScreen(
              key: args.key, voucherDetail: args.voucherDetail));
    },
    AffiliatePage.name: (routeData) {
      final args = routeData.argsAs<AffiliatePageArgs>();
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i49.AffiliateScreen(key: args.key, account: args.account));
    },
    AffiliateHistoryPage.name: (routeData) {
      final args = routeData.argsAs<AffiliateHistoryPageArgs>();
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i50.AffiliateHistoryScreen(
              key: args.key,
              firstLevel: args.firstLevel,
              secondLevel: args.secondLevel));
    },
    TierBenefitsPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i51.TierBenefitsScreen());
    },
    MessageDetailPage.name: (routeData) {
      final args = routeData.argsAs<MessageDetailPageArgs>();
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i52.MessageDetailScreen(
              key: args.key,
              roomId: args.roomId,
              onBack: args.onBack,
              vendorId: args.vendorId,
              vendorInfo: args.vendorInfo));
    },
    CustomerStaffPage.name: (routeData) {
      final args = routeData.argsAs<CustomerStaffPageArgs>();
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i53.StaffScreen(
              key: args.key,
              vendorId: args.vendorId,
              orderId: args.orderId,
              onBack: args.onBack));
    },
    MessagePage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i54.MessageScreen());
    },
    NotificationPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i55.NotificationScreen());
    },
    ThemePage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i56.ThemeScreen());
    },
    ProfileInformationPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i57.ProfileInformation());
    },
    TermOfServicePage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i58.TermOfServiceScreen());
    },
    HelpAndSupportPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i59.HelpAndSupportScreen());
    },
    ListLocalImagePage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i60.ListLocalImageScreen());
    },
    PlayVideoPage.name: (routeData) {
      final args = routeData.argsAs<PlayVideoPageArgs>();
      return _i83.CustomPage<dynamic>(
          routeData: routeData,
          child: _i61.PlayVideoScreen(
              key: args.key, path: args.path, index: args.index),
          fullscreenDialog: true,
          transitionsBuilder: _i85.slideBottomToTop,
          opaque: false,
          barrierDismissible: false);
    },
    VendorCarouselGalleryPage.name: (routeData) {
      final args = routeData.argsAs<VendorCarouselGalleryPageArgs>(
          orElse: () => const VendorCarouselGalleryPageArgs());
      return _i83.CustomPage<dynamic>(
          routeData: routeData,
          child: _i62.CarouselGalleryScreen(
              key: args.key,
              listImage: args.listImage,
              indexImage: args.indexImage),
          fullscreenDialog: true,
          opaque: false,
          barrierDismissible: true);
    },
    ServiceItemGalleryPage.name: (routeData) {
      final args = routeData.argsAs<ServiceItemGalleryPageArgs>(
          orElse: () => const ServiceItemGalleryPageArgs());
      return _i83.CustomPage<dynamic>(
          routeData: routeData,
          child: _i63.ServiceItemGalleryScreen(
              key: args.key,
              listGallery: args.listGallery,
              serviceId: args.serviceId),
          fullscreenDialog: true,
          transitionsBuilder: _i85.slideBottomToTop,
          opaque: false,
          barrierDismissible: false);
    },
    VendorsGalleryDetailPage.name: (routeData) {
      final args = routeData.argsAs<VendorsGalleryDetailPageArgs>();
      return _i83.CustomPage<dynamic>(
          routeData: routeData,
          child: _i64.VendorsGalleryDetail(
              key: args.key, index: args.index, listImage: args.listImage),
          fullscreenDialog: true,
          opaque: false,
          barrierDismissible: true);
    },
    NewFeddGalleryPage.name: (routeData) {
      final args = routeData.argsAs<NewFeddGalleryPageArgs>();
      return _i83.CustomPage<dynamic>(
          routeData: routeData,
          child: _i65.NewFeddGallery(
              key: args.key,
              index: args.index,
              listImage: args.listImage,
              id: args.id),
          fullscreenDialog: true,
          opaque: false,
          barrierDismissible: true);
    },
    SearchPage.name: (routeData) {
      final args = routeData.argsAs<SearchPageArgs>(
          orElse: () => const SearchPageArgs());
      return _i83.CustomPage<dynamic>(
          routeData: routeData,
          child: _i66.SearchScreen(key: args.key, category: args.category),
          fullscreenDialog: true,
          transitionsBuilder: _i85.slideBottomToTop,
          opaque: false,
          barrierDismissible: false);
    },
    CustomerQrPage.name: (routeData) {
      return _i83.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i67.CustomerQrScreen(),
          fullscreenDialog: true,
          transitionsBuilder: _i85.slideBottomToTop,
          opaque: false,
          barrierDismissible: false);
    },
    CreatPostPage.name: (routeData) {
      final args = routeData.argsAs<CreatPostPageArgs>(
          orElse: () => const CreatPostPageArgs());
      return _i83.CustomPage<dynamic>(
          routeData: routeData,
          child: _i68.CreatePostScreen(key: args.key),
          fullscreenDialog: true,
          transitionsBuilder: _i85.slideBottomToTop,
          opaque: false,
          barrierDismissible: false);
    },
    AddTagsPage.name: (routeData) {
      final args = routeData.argsAs<AddTagsPageArgs>();
      return _i83.CustomPage<dynamic>(
          routeData: routeData,
          child: _i69.AddTagsScreen(
              key: args.key, onBack: args.onBack, vendors: args.vendors),
          fullscreenDialog: true,
          transitionsBuilder: _i85.slideBottomToTop,
          opaque: false,
          barrierDismissible: false);
    },
    ConfirmCompletePage.name: (routeData) {
      final args = routeData.argsAs<ConfirmCompletePageArgs>();
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i70.ConfirmCompleteScreen(
              key: args.key,
              onBack: args.onBack,
              defaultPrice: args.defaultPrice));
    },
    UploadBillPage.name: (routeData) {
      final args = routeData.argsAs<UploadBillPageArgs>();
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i71.UploadBillScreen(key: args.key, onBack: args.onBack));
    },
    VendorProfileAddressPage.name: (routeData) {
      final args = routeData.argsAs<VendorProfileAddressPageArgs>(
          orElse: () => const VendorProfileAddressPageArgs());
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i72.VendorProfileAddressScreen(
              key: args.key, onBack: args.onBack));
    },
    VendorProfileInformationPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i73.VendorProfileInformation());
    },
    VendorsReviewsPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i74.VendorsReviewsScreen());
    },
    WaitressManagerPage.name: (routeData) {
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i75.WaitressManagerScreen());
    },
    AddWaitressPage.name: (routeData) {
      final args = routeData.argsAs<AddWaitressPageArgs>(
          orElse: () => const AddWaitressPageArgs());
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i76.AddWaitressScreen(key: args.key, onBack: args.onBack));
    },
    AdminOrdersDetailPage.name: (routeData) {
      final args = routeData.argsAs<AdminOrdersDetailPageArgs>(
          orElse: () => const AdminOrdersDetailPageArgs());
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i77.AdminOrdersDetailScreen(
              key: args.key,
              orderId: args.orderId,
              isFromList: args.isFromList,
              onBack: args.onBack));
    },
    ListMenuPage.name: (routeData) {
      final args = routeData.argsAs<ListMenuPageArgs>(
          orElse: () => const ListMenuPageArgs());
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData, child: _i78.ListMenuScreen(key: args.key));
    },
    SelectMenuPage.name: (routeData) {
      final args = routeData.argsAs<SelectMenuPageArgs>(
          orElse: () => const SelectMenuPageArgs());
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i79.SelectMenuScreen(
              key: args.key,
              onBack: args.onBack,
              selectedMenu: args.selectedMenu));
    },
    AddSubFeePage.name: (routeData) {
      final args = routeData.argsAs<AddSubFeePageArgs>(
          orElse: () => const AddSubFeePageArgs());
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i80.AddSubFeeScreen(key: args.key, onBack: args.onBack));
    },
    AddMenuPage.name: (routeData) {
      final args = routeData.argsAs<AddMenuPageArgs>(
          orElse: () => const AddMenuPageArgs());
      return _i83.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i81.AddMenuScreen(key: args.key, onBack: args.onBack));
    },
    VoucherPage.name: (routeData) {
      final args = routeData.argsAs<VoucherPageArgs>();
      return _i83.CustomPage<dynamic>(
          routeData: routeData,
          child: _i82.VoucherScreen(
              key: args.key,
              onBack: args.onBack,
              vendorId: args.vendorId,
              vendorInfo: args.vendorInfo,
              selectedVoucher: args.selectedVoucher,
              isSelectedVoucher: args.isSelectedVoucher),
          fullscreenDialog: true,
          transitionsBuilder: _i85.slideBottomToTop,
          opaque: false,
          barrierDismissible: false);
    }
  };

  @override
  List<_i83.RouteConfig> get routes => [
        _i83.RouteConfig(SplashPage.name, path: '/'),
        _i83.RouteConfig(MainPage.name, path: '/main'),
        _i83.RouteConfig(SigninTelephonePage.name, path: '/login_telephone'),
        _i83.RouteConfig(SignInVerifyPage.name, path: '/login_verify'),
        _i83.RouteConfig(CompleteRegisterPage.name, path: '/complete_register'),
        _i83.RouteConfig(SignupVendorPage.name, path: 'signup_vendor'),
        _i83.RouteConfig(SignUpVendorFirstPage.name,
            path: '/SignUpVendorFirstPage'),
        _i83.RouteConfig(ApplyVendorInformationPage.name,
            path: '/ApplyVendorInformationPage'),
        _i83.RouteConfig(SignupVendorSecondPage.name,
            path: '/SignupVendorSecondPage'),
        _i83.RouteConfig(SignupVendorThirdPage.name,
            path: '/SignupVendorThirdPage'),
        _i83.RouteConfig(SignupVendorFourthPage.name,
            path: '/SignupVendorFourthPage'),
        _i83.RouteConfig(SignupVendorFifthPage.name,
            path: '/SignupVendorFifthPage'),
        _i83.RouteConfig(VendorAddAdressPage.name,
            path: '/VendorAddAdressPage'),
        _i83.RouteConfig(SignupVendorSuccessPage.name,
            path: '/SignupVendorSuccessPage'),
        _i83.RouteConfig(SigninPage.name, path: '/login'),
        _i83.RouteConfig(SignupPage.name, path: '/signup'),
        _i83.RouteConfig(VerifyPage.name, path: '/verify'),
        _i83.RouteConfig(VendorMainPage.name, path: '/vendor_list_screen'),
        _i83.RouteConfig(AdminMainPage.name, path: '/AdminMainScreen'),
        _i83.RouteConfig(ForgotPasswordPage.name, path: '/forgot_password'),
        _i83.RouteConfig(ForgotPasswordVerifyPage.name,
            path: '/ForgotPasswordVerifyScreen'),
        _i83.RouteConfig(ForgotPasswordUpdatePage.name,
            path: '/ForgotPasswordUpdateScreen'),
        _i83.RouteConfig(SearchVendorPage.name, path: '/search_vendor'),
        _i83.RouteConfig(FilterVendorsPage.name, path: '/filter_vendors'),
        _i83.RouteConfig(VendorsCreateOrderPage.name,
            path: '/VendorsCreateOrderPage'),
        _i83.RouteConfig(VendorListProductPage.name,
            path: '/VendorListProductPage'),
        _i83.RouteConfig(BookingDetailPage.name, path: '/booking_detail'),
        _i83.RouteConfig(SomethingWentWrongPage.name,
            path: '/error_404_screen'),
        _i83.RouteConfig(NewfeedDetailPage.name, path: '/newfeedDetail'),
        _i83.RouteConfig(UserNewfeedPage.name, path: '/UserNewfeedPage'),
        _i83.RouteConfig(VendorsPage.name, path: '/vendor_screen'),
        _i83.RouteConfig(VendorsDetailPage.name, path: '/vendor_detail'),
        _i83.RouteConfig(ProductsOfVarientPage.name,
            path: '/ProductsOfVarientPage'),
        _i83.RouteConfig(VendorAddProductPage.name,
            path: '/vendor_add_product'),
        _i83.RouteConfig(ScanQRScreenPage.name, path: '/qrCodeScan'),
        _i83.RouteConfig(AttributeListPage.name,
            path: '/listItemAttributeScreen'),
        _i83.RouteConfig(ServiceItemDetailPage.name,
            path: '/serviceItemDetailScreen'),
        _i83.RouteConfig(VendorsGalleryPage.name, path: '/vendorGalleryScreen'),
        _i83.RouteConfig(HistoryPage.name, path: '/history'),
        _i83.RouteConfig(ActivityDetailPage.name, path: '/activityDetail'),
        _i83.RouteConfig(MapsDerectionPage.name, path: '/MapsDerectionPage'),
        _i83.RouteConfig(OrderQrPage.name, path: '/OrderQrPage'),
        _i83.RouteConfig(LanguagePage.name, path: '/languageScreen'),
        _i83.RouteConfig(ReviewPage.name, path: '/review'),
        _i83.RouteConfig(RewardsDetailPage.name, path: '/rewards'),
        _i83.RouteConfig(RewardsHistoryPage.name,
            path: '/RewardsHistoryScreen'),
        _i83.RouteConfig(RewardsGuidePage.name, path: '/RewardsGuidePage'),
        _i83.RouteConfig(VoucherDetailPage.name, path: '/VoucherDetailPage'),
        _i83.RouteConfig(AffiliatePage.name, path: '/AffiliatePage'),
        _i83.RouteConfig(AffiliateHistoryPage.name,
            path: '/AffiliateHistoryPage'),
        _i83.RouteConfig(TierBenefitsPage.name, path: '/tierBenefits'),
        _i83.RouteConfig(MessageDetailPage.name, path: '/messageDetail'),
        _i83.RouteConfig(CustomerStaffPage.name, path: '/CustomerStaffPage'),
        _i83.RouteConfig(MessagePage.name, path: '/messageScreen'),
        _i83.RouteConfig(NotificationPage.name, path: '/notification_screen'),
        _i83.RouteConfig(ThemePage.name, path: '/messageScreen'),
        _i83.RouteConfig(ProfileInformationPage.name,
            path: '/profileInformation'),
        _i83.RouteConfig(TermOfServicePage.name, path: '/termOfService'),
        _i83.RouteConfig(HelpAndSupportPage.name, path: '/helpAndSupport'),
        _i83.RouteConfig(ListLocalImagePage.name,
            path: '/listLocalImageScreen'),
        _i83.RouteConfig(PlayVideoPage.name, path: '/play_video'),
        _i83.RouteConfig(VendorCarouselGalleryPage.name,
            path: '/vendorCarouselGallery'),
        _i83.RouteConfig(ServiceItemGalleryPage.name,
            path: '/vendorsGalleryDetail'),
        _i83.RouteConfig(VendorsGalleryDetailPage.name,
            path: '/vendorsGalleryDetail'),
        _i83.RouteConfig(NewFeddGalleryPage.name, path: '/newfeed_gallery'),
        _i83.RouteConfig(SearchPage.name, path: '/main_search'),
        _i83.RouteConfig(CustomerQrPage.name, path: '/CustomerQrPage'),
        _i83.RouteConfig(CreatPostPage.name, path: '/create_page'),
        _i83.RouteConfig(AddTagsPage.name, path: '/add_tag_screen'),
        _i83.RouteConfig(ConfirmCompletePage.name,
            path: '/ConfirmCompletePage'),
        _i83.RouteConfig(UploadBillPage.name, path: '/UploadBillPage'),
        _i83.RouteConfig(VendorProfileAddressPage.name,
            path: '/VendorProfileAddressScreen'),
        _i83.RouteConfig(VendorProfileInformationPage.name,
            path: '/VendorProfileInformation'),
        _i83.RouteConfig(VendorsReviewsPage.name,
            path: '/VendorsReviewsScreen'),
        _i83.RouteConfig(WaitressManagerPage.name,
            path: '/WaitressManagerPage'),
        _i83.RouteConfig(AddWaitressPage.name, path: '/AddWaitressPage'),
        _i83.RouteConfig(AdminOrdersDetailPage.name,
            path: '/AdminOrdersDetailPage'),
        _i83.RouteConfig(ListMenuPage.name, path: '/ListMenuPage'),
        _i83.RouteConfig(SelectMenuPage.name, path: '/SelectMenuPage'),
        _i83.RouteConfig(AddSubFeePage.name, path: '/AddSubFeePage'),
        _i83.RouteConfig(AddMenuPage.name, path: '/AddMenuPage'),
        _i83.RouteConfig(VoucherPage.name, path: '/voucher_screen')
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashPage extends _i83.PageRouteInfo<SplashPageArgs> {
  SplashPage({_i84.Key? key, bool? isFristLoad = true})
      : super(SplashPage.name,
            path: '/',
            args: SplashPageArgs(key: key, isFristLoad: isFristLoad));

  static const String name = 'SplashPage';
}

class SplashPageArgs {
  const SplashPageArgs({this.key, this.isFristLoad = true});

  final _i84.Key? key;

  final bool? isFristLoad;

  @override
  String toString() {
    return 'SplashPageArgs{key: $key, isFristLoad: $isFristLoad}';
  }
}

/// generated route for
/// [_i2.MainScreen]
class MainPage extends _i83.PageRouteInfo<MainPageArgs> {
  MainPage(
      {_i84.Key? key,
      _i86.AccountModel? account,
      int? countPendingOrders,
      int? countUnreadNotifications,
      _i87.BookingItemModel? currentOrders})
      : super(MainPage.name,
            path: '/main',
            args: MainPageArgs(
                key: key,
                account: account,
                countPendingOrders: countPendingOrders,
                countUnreadNotifications: countUnreadNotifications,
                currentOrders: currentOrders));

  static const String name = 'MainPage';
}

class MainPageArgs {
  const MainPageArgs(
      {this.key,
      this.account,
      this.countPendingOrders,
      this.countUnreadNotifications,
      this.currentOrders});

  final _i84.Key? key;

  final _i86.AccountModel? account;

  final int? countPendingOrders;

  final int? countUnreadNotifications;

  final _i87.BookingItemModel? currentOrders;

  @override
  String toString() {
    return 'MainPageArgs{key: $key, account: $account, countPendingOrders: $countPendingOrders, countUnreadNotifications: $countUnreadNotifications, currentOrders: $currentOrders}';
  }
}

/// generated route for
/// [_i3.SigninTelephoneScreen]
class SigninTelephonePage extends _i83.PageRouteInfo<void> {
  const SigninTelephonePage()
      : super(SigninTelephonePage.name, path: '/login_telephone');

  static const String name = 'SigninTelephonePage';
}

/// generated route for
/// [_i4.SignInVerifyScreen]
class SignInVerifyPage extends _i83.PageRouteInfo<SignInVerifyPageArgs> {
  SignInVerifyPage({_i84.Key? key, String? telePhone})
      : super(SignInVerifyPage.name,
            path: '/login_verify',
            args: SignInVerifyPageArgs(key: key, telePhone: telePhone));

  static const String name = 'SignInVerifyPage';
}

class SignInVerifyPageArgs {
  const SignInVerifyPageArgs({this.key, this.telePhone});

  final _i84.Key? key;

  final String? telePhone;

  @override
  String toString() {
    return 'SignInVerifyPageArgs{key: $key, telePhone: $telePhone}';
  }
}

/// generated route for
/// [_i5.CompleteRegisterScreen]
class CompleteRegisterPage
    extends _i83.PageRouteInfo<CompleteRegisterPageArgs> {
  CompleteRegisterPage({_i84.Key? key, required _i86.AccountModel account})
      : super(CompleteRegisterPage.name,
            path: '/complete_register',
            args: CompleteRegisterPageArgs(key: key, account: account));

  static const String name = 'CompleteRegisterPage';
}

class CompleteRegisterPageArgs {
  const CompleteRegisterPageArgs({this.key, required this.account});

  final _i84.Key? key;

  final _i86.AccountModel account;

  @override
  String toString() {
    return 'CompleteRegisterPageArgs{key: $key, account: $account}';
  }
}

/// generated route for
/// [_i6.SignupVendorScreen]
class SignupVendorPage extends _i83.PageRouteInfo<void> {
  const SignupVendorPage()
      : super(SignupVendorPage.name, path: 'signup_vendor');

  static const String name = 'SignupVendorPage';
}

/// generated route for
/// [_i7.SignUpVendorFirst]
class SignUpVendorFirstPage
    extends _i83.PageRouteInfo<SignUpVendorFirstPageArgs> {
  SignUpVendorFirstPage({_i84.Key? key, required _i86.AccountModel account})
      : super(SignUpVendorFirstPage.name,
            path: '/SignUpVendorFirstPage',
            args: SignUpVendorFirstPageArgs(key: key, account: account));

  static const String name = 'SignUpVendorFirstPage';
}

class SignUpVendorFirstPageArgs {
  const SignUpVendorFirstPageArgs({this.key, required this.account});

  final _i84.Key? key;

  final _i86.AccountModel account;

  @override
  String toString() {
    return 'SignUpVendorFirstPageArgs{key: $key, account: $account}';
  }
}

/// generated route for
/// [_i8.ApplyVendorInformation]
class ApplyVendorInformationPage extends _i83.PageRouteInfo<void> {
  const ApplyVendorInformationPage()
      : super(ApplyVendorInformationPage.name,
            path: '/ApplyVendorInformationPage');

  static const String name = 'ApplyVendorInformationPage';
}

/// generated route for
/// [_i9.SignupVendorSecond]
class SignupVendorSecondPage extends _i83.PageRouteInfo<void> {
  const SignupVendorSecondPage()
      : super(SignupVendorSecondPage.name, path: '/SignupVendorSecondPage');

  static const String name = 'SignupVendorSecondPage';
}

/// generated route for
/// [_i10.SignupVendorThirdScreen]
class SignupVendorThirdPage
    extends _i83.PageRouteInfo<SignupVendorThirdPageArgs> {
  SignupVendorThirdPage(
      {_i84.Key? key, dynamic Function(double, double, String, bool)? onBack})
      : super(SignupVendorThirdPage.name,
            path: '/SignupVendorThirdPage',
            args: SignupVendorThirdPageArgs(key: key, onBack: onBack));

  static const String name = 'SignupVendorThirdPage';
}

class SignupVendorThirdPageArgs {
  const SignupVendorThirdPageArgs({this.key, this.onBack});

  final _i84.Key? key;

  final dynamic Function(double, double, String, bool)? onBack;

  @override
  String toString() {
    return 'SignupVendorThirdPageArgs{key: $key, onBack: $onBack}';
  }
}

/// generated route for
/// [_i11.SignupVendorFourth]
class SignupVendorFourthPage extends _i83.PageRouteInfo<void> {
  const SignupVendorFourthPage()
      : super(SignupVendorFourthPage.name, path: '/SignupVendorFourthPage');

  static const String name = 'SignupVendorFourthPage';
}

/// generated route for
/// [_i12.SignupVendorFifth]
class SignupVendorFifthPage extends _i83.PageRouteInfo<void> {
  const SignupVendorFifthPage()
      : super(SignupVendorFifthPage.name, path: '/SignupVendorFifthPage');

  static const String name = 'SignupVendorFifthPage';
}

/// generated route for
/// [_i13.VendorAddAdressScreen]
class VendorAddAdressPage extends _i83.PageRouteInfo<void> {
  const VendorAddAdressPage()
      : super(VendorAddAdressPage.name, path: '/VendorAddAdressPage');

  static const String name = 'VendorAddAdressPage';
}

/// generated route for
/// [_i14.SignupVendorSuccess]
class SignupVendorSuccessPage extends _i83.PageRouteInfo<void> {
  const SignupVendorSuccessPage()
      : super(SignupVendorSuccessPage.name, path: '/SignupVendorSuccessPage');

  static const String name = 'SignupVendorSuccessPage';
}

/// generated route for
/// [_i15.SigninScreen]
class SigninPage extends _i83.PageRouteInfo<void> {
  const SigninPage() : super(SigninPage.name, path: '/login');

  static const String name = 'SigninPage';
}

/// generated route for
/// [_i16.SignupScreen]
class SignupPage extends _i83.PageRouteInfo<void> {
  const SignupPage() : super(SignupPage.name, path: '/signup');

  static const String name = 'SignupPage';
}

/// generated route for
/// [_i17.VerifyScreen]
class VerifyPage extends _i83.PageRouteInfo<VerifyPageArgs> {
  VerifyPage({_i84.Key? key, String? telePhone})
      : super(VerifyPage.name,
            path: '/verify',
            args: VerifyPageArgs(key: key, telePhone: telePhone));

  static const String name = 'VerifyPage';
}

class VerifyPageArgs {
  const VerifyPageArgs({this.key, this.telePhone});

  final _i84.Key? key;

  final String? telePhone;

  @override
  String toString() {
    return 'VerifyPageArgs{key: $key, telePhone: $telePhone}';
  }
}

/// generated route for
/// [_i18.VendorMainScreen]
class VendorMainPage extends _i83.PageRouteInfo<void> {
  const VendorMainPage()
      : super(VendorMainPage.name, path: '/vendor_list_screen');

  static const String name = 'VendorMainPage';
}

/// generated route for
/// [_i19.AdminMainScreen]
class AdminMainPage extends _i83.PageRouteInfo<void> {
  const AdminMainPage() : super(AdminMainPage.name, path: '/AdminMainScreen');

  static const String name = 'AdminMainPage';
}

/// generated route for
/// [_i20.ForgotPasswordScreen]
class ForgotPasswordPage extends _i83.PageRouteInfo<void> {
  const ForgotPasswordPage()
      : super(ForgotPasswordPage.name, path: '/forgot_password');

  static const String name = 'ForgotPasswordPage';
}

/// generated route for
/// [_i21.ForgotPasswordVerifyScreen]
class ForgotPasswordVerifyPage
    extends _i83.PageRouteInfo<ForgotPasswordVerifyPageArgs> {
  ForgotPasswordVerifyPage({_i84.Key? key, required String telePhone})
      : super(ForgotPasswordVerifyPage.name,
            path: '/ForgotPasswordVerifyScreen',
            args: ForgotPasswordVerifyPageArgs(key: key, telePhone: telePhone));

  static const String name = 'ForgotPasswordVerifyPage';
}

class ForgotPasswordVerifyPageArgs {
  const ForgotPasswordVerifyPageArgs({this.key, required this.telePhone});

  final _i84.Key? key;

  final String telePhone;

  @override
  String toString() {
    return 'ForgotPasswordVerifyPageArgs{key: $key, telePhone: $telePhone}';
  }
}

/// generated route for
/// [_i22.ForgotPasswordUpdateScreen]
class ForgotPasswordUpdatePage
    extends _i83.PageRouteInfo<ForgotPasswordUpdatePageArgs> {
  ForgotPasswordUpdatePage({_i84.Key? key, required String token})
      : super(ForgotPasswordUpdatePage.name,
            path: '/ForgotPasswordUpdateScreen',
            args: ForgotPasswordUpdatePageArgs(key: key, token: token));

  static const String name = 'ForgotPasswordUpdatePage';
}

class ForgotPasswordUpdatePageArgs {
  const ForgotPasswordUpdatePageArgs({this.key, required this.token});

  final _i84.Key? key;

  final String token;

  @override
  String toString() {
    return 'ForgotPasswordUpdatePageArgs{key: $key, token: $token}';
  }
}

/// generated route for
/// [_i23.SearchVendorScreen]
class SearchVendorPage extends _i83.PageRouteInfo<void> {
  const SearchVendorPage()
      : super(SearchVendorPage.name, path: '/search_vendor');

  static const String name = 'SearchVendorPage';
}

/// generated route for
/// [_i24.FilterVendorsScreen]
class FilterVendorsPage extends _i83.PageRouteInfo<FilterVendorsPageArgs> {
  FilterVendorsPage(
      {_i84.Key? key,
      String? type,
      required bool isFilterByCity,
      String? cityCode,
      _i88.VoucherModel? voucher,
      _i89.VariantModel? varient,
      _i90.CategoryType? category})
      : super(FilterVendorsPage.name,
            path: '/filter_vendors',
            args: FilterVendorsPageArgs(
                key: key,
                type: type,
                isFilterByCity: isFilterByCity,
                cityCode: cityCode,
                voucher: voucher,
                varient: varient,
                category: category));

  static const String name = 'FilterVendorsPage';
}

class FilterVendorsPageArgs {
  const FilterVendorsPageArgs(
      {this.key,
      this.type,
      required this.isFilterByCity,
      this.cityCode,
      this.voucher,
      this.varient,
      this.category});

  final _i84.Key? key;

  final String? type;

  final bool isFilterByCity;

  final String? cityCode;

  final _i88.VoucherModel? voucher;

  final _i89.VariantModel? varient;

  final _i90.CategoryType? category;

  @override
  String toString() {
    return 'FilterVendorsPageArgs{key: $key, type: $type, isFilterByCity: $isFilterByCity, cityCode: $cityCode, voucher: $voucher, varient: $varient, category: $category}';
  }
}

/// generated route for
/// [_i25.VendorsCreateOrderScreen]
class VendorsCreateOrderPage
    extends _i83.PageRouteInfo<VendorsCreateOrderPageArgs> {
  VendorsCreateOrderPage({_i84.Key? key, dynamic Function()? onBack})
      : super(VendorsCreateOrderPage.name,
            path: '/VendorsCreateOrderPage',
            args: VendorsCreateOrderPageArgs(key: key, onBack: onBack));

  static const String name = 'VendorsCreateOrderPage';
}

class VendorsCreateOrderPageArgs {
  const VendorsCreateOrderPageArgs({this.key, this.onBack});

  final _i84.Key? key;

  final dynamic Function()? onBack;

  @override
  String toString() {
    return 'VendorsCreateOrderPageArgs{key: $key, onBack: $onBack}';
  }
}

/// generated route for
/// [_i26.VendorListProductScreen]
class VendorListProductPage
    extends _i83.PageRouteInfo<VendorListProductPageArgs> {
  VendorListProductPage(
      {_i84.Key? key,
      required List<_i91.ServicesModel> listProduct,
      _i91.ServicesModel? selectedProduct,
      dynamic Function(_i91.ServicesModel)? onBack})
      : super(VendorListProductPage.name,
            path: '/VendorListProductPage',
            args: VendorListProductPageArgs(
                key: key,
                listProduct: listProduct,
                selectedProduct: selectedProduct,
                onBack: onBack));

  static const String name = 'VendorListProductPage';
}

class VendorListProductPageArgs {
  const VendorListProductPageArgs(
      {this.key, required this.listProduct, this.selectedProduct, this.onBack});

  final _i84.Key? key;

  final List<_i91.ServicesModel> listProduct;

  final _i91.ServicesModel? selectedProduct;

  final dynamic Function(_i91.ServicesModel)? onBack;

  @override
  String toString() {
    return 'VendorListProductPageArgs{key: $key, listProduct: $listProduct, selectedProduct: $selectedProduct, onBack: $onBack}';
  }
}

/// generated route for
/// [_i27.BookingDetailScreen]
class BookingDetailPage extends _i83.PageRouteInfo<BookingDetailPageArgs> {
  BookingDetailPage(
      {_i84.Key? key,
      String? bookingId,
      String? parentPage,
      dynamic Function(_i87.BookingItemModel)? onBack})
      : super(BookingDetailPage.name,
            path: '/booking_detail',
            args: BookingDetailPageArgs(
                key: key,
                bookingId: bookingId,
                parentPage: parentPage,
                onBack: onBack));

  static const String name = 'BookingDetailPage';
}

class BookingDetailPageArgs {
  const BookingDetailPageArgs(
      {this.key, this.bookingId, this.parentPage, this.onBack});

  final _i84.Key? key;

  final String? bookingId;

  final String? parentPage;

  final dynamic Function(_i87.BookingItemModel)? onBack;

  @override
  String toString() {
    return 'BookingDetailPageArgs{key: $key, bookingId: $bookingId, parentPage: $parentPage, onBack: $onBack}';
  }
}

/// generated route for
/// [_i28.SomethingWentWrongScreen]
class SomethingWentWrongPage extends _i83.PageRouteInfo<void> {
  const SomethingWentWrongPage()
      : super(SomethingWentWrongPage.name, path: '/error_404_screen');

  static const String name = 'SomethingWentWrongPage';
}

/// generated route for
/// [_i29.NewfeedDetailScreen]
class NewfeedDetailPage extends _i83.PageRouteInfo<NewfeedDetailPageArgs> {
  NewfeedDetailPage(
      {_i84.Key? key, required String postId, required bool isFocus})
      : super(NewfeedDetailPage.name,
            path: '/newfeedDetail',
            args: NewfeedDetailPageArgs(
                key: key, postId: postId, isFocus: isFocus));

  static const String name = 'NewfeedDetailPage';
}

class NewfeedDetailPageArgs {
  const NewfeedDetailPageArgs(
      {this.key, required this.postId, required this.isFocus});

  final _i84.Key? key;

  final String postId;

  final bool isFocus;

  @override
  String toString() {
    return 'NewfeedDetailPageArgs{key: $key, postId: $postId, isFocus: $isFocus}';
  }
}

/// generated route for
/// [_i30.UserNewfeedScreen]
class UserNewfeedPage extends _i83.PageRouteInfo<void> {
  const UserNewfeedPage()
      : super(UserNewfeedPage.name, path: '/UserNewfeedPage');

  static const String name = 'UserNewfeedPage';
}

/// generated route for
/// [_i31.VendorsScreen]
class VendorsPage extends _i83.PageRouteInfo<VendorsPageArgs> {
  VendorsPage({_i84.Key? key, _i90.CategoryType? category})
      : super(VendorsPage.name,
            path: '/vendor_screen',
            args: VendorsPageArgs(key: key, category: category));

  static const String name = 'VendorsPage';
}

class VendorsPageArgs {
  const VendorsPageArgs({this.key, this.category});

  final _i84.Key? key;

  final _i90.CategoryType? category;

  @override
  String toString() {
    return 'VendorsPageArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [_i32.VendorsDetailScreen]
class VendorsDetailPage extends _i83.PageRouteInfo<VendorsDetailPageArgs> {
  VendorsDetailPage(
      {_i84.Key? key,
      String? first,
      String? last,
      String? tagId,
      String? imageUrl,
      String? vendorTitle,
      required _i92.VendorModel vendorsInfo,
      _i88.VoucherModel? voucher})
      : super(VendorsDetailPage.name,
            path: '/vendor_detail',
            args: VendorsDetailPageArgs(
                key: key,
                first: first,
                last: last,
                tagId: tagId,
                imageUrl: imageUrl,
                vendorTitle: vendorTitle,
                vendorsInfo: vendorsInfo,
                voucher: voucher));

  static const String name = 'VendorsDetailPage';
}

class VendorsDetailPageArgs {
  const VendorsDetailPageArgs(
      {this.key,
      this.first,
      this.last,
      this.tagId,
      this.imageUrl,
      this.vendorTitle,
      required this.vendorsInfo,
      this.voucher});

  final _i84.Key? key;

  final String? first;

  final String? last;

  final String? tagId;

  final String? imageUrl;

  final String? vendorTitle;

  final _i92.VendorModel vendorsInfo;

  final _i88.VoucherModel? voucher;

  @override
  String toString() {
    return 'VendorsDetailPageArgs{key: $key, first: $first, last: $last, tagId: $tagId, imageUrl: $imageUrl, vendorTitle: $vendorTitle, vendorsInfo: $vendorsInfo, voucher: $voucher}';
  }
}

/// generated route for
/// [_i33.ProductsOfVarientScreen]
class ProductsOfVarientPage
    extends _i83.PageRouteInfo<ProductsOfVarientPageArgs> {
  ProductsOfVarientPage(
      {_i84.Key? key,
      required _i89.VariantModel variant,
      dynamic Function(_i91.ServicesModel)? onBack,
      bool? isVendors})
      : super(ProductsOfVarientPage.name,
            path: '/ProductsOfVarientPage',
            args: ProductsOfVarientPageArgs(
                key: key,
                variant: variant,
                onBack: onBack,
                isVendors: isVendors));

  static const String name = 'ProductsOfVarientPage';
}

class ProductsOfVarientPageArgs {
  const ProductsOfVarientPageArgs(
      {this.key, required this.variant, this.onBack, this.isVendors});

  final _i84.Key? key;

  final _i89.VariantModel variant;

  final dynamic Function(_i91.ServicesModel)? onBack;

  final bool? isVendors;

  @override
  String toString() {
    return 'ProductsOfVarientPageArgs{key: $key, variant: $variant, onBack: $onBack, isVendors: $isVendors}';
  }
}

/// generated route for
/// [_i34.VendorAddProductScreen]
class VendorAddProductPage extends _i83.PageRouteInfo<void> {
  const VendorAddProductPage()
      : super(VendorAddProductPage.name, path: '/vendor_add_product');

  static const String name = 'VendorAddProductPage';
}

/// generated route for
/// [_i35.ScanQRPage]
class ScanQRScreenPage extends _i83.PageRouteInfo<void> {
  const ScanQRScreenPage() : super(ScanQRScreenPage.name, path: '/qrCodeScan');

  static const String name = 'ScanQRScreenPage';
}

/// generated route for
/// [_i36.ServiceItemListAttributeScreen]
class AttributeListPage extends _i83.PageRouteInfo<AttributeListPageArgs> {
  AttributeListPage({_i84.Key? key, String? type})
      : super(AttributeListPage.name,
            path: '/listItemAttributeScreen',
            args: AttributeListPageArgs(key: key, type: type));

  static const String name = 'AttributeListPage';
}

class AttributeListPageArgs {
  const AttributeListPageArgs({this.key, this.type});

  final _i84.Key? key;

  final String? type;

  @override
  String toString() {
    return 'AttributeListPageArgs{key: $key, type: $type}';
  }
}

/// generated route for
/// [_i37.ServiceItemDetailScreen]
class ServiceItemDetailPage
    extends _i83.PageRouteInfo<ServiceItemDetailPageArgs> {
  ServiceItemDetailPage({_i84.Key? key, String? serviceItemId})
      : super(ServiceItemDetailPage.name,
            path: '/serviceItemDetailScreen',
            args: ServiceItemDetailPageArgs(
                key: key, serviceItemId: serviceItemId));

  static const String name = 'ServiceItemDetailPage';
}

class ServiceItemDetailPageArgs {
  const ServiceItemDetailPageArgs({this.key, this.serviceItemId});

  final _i84.Key? key;

  final String? serviceItemId;

  @override
  String toString() {
    return 'ServiceItemDetailPageArgs{key: $key, serviceItemId: $serviceItemId}';
  }
}

/// generated route for
/// [_i38.VendorsGalleryScreen]
class VendorsGalleryPage extends _i83.PageRouteInfo<VendorsGalleryPageArgs> {
  VendorsGalleryPage({_i84.Key? key, List<_i92.GalleryModel>? listImage})
      : super(VendorsGalleryPage.name,
            path: '/vendorGalleryScreen',
            args: VendorsGalleryPageArgs(key: key, listImage: listImage));

  static const String name = 'VendorsGalleryPage';
}

class VendorsGalleryPageArgs {
  const VendorsGalleryPageArgs({this.key, this.listImage});

  final _i84.Key? key;

  final List<_i92.GalleryModel>? listImage;

  @override
  String toString() {
    return 'VendorsGalleryPageArgs{key: $key, listImage: $listImage}';
  }
}

/// generated route for
/// [_i39.HistoryScreen]
class HistoryPage extends _i83.PageRouteInfo<void> {
  const HistoryPage() : super(HistoryPage.name, path: '/history');

  static const String name = 'HistoryPage';
}

/// generated route for
/// [_i40.ActivityDetailScreen]
class ActivityDetailPage extends _i83.PageRouteInfo<ActivityDetailPageArgs> {
  ActivityDetailPage(
      {_i84.Key? key,
      required String id,
      String? orderId,
      required bool isFromQr})
      : super(ActivityDetailPage.name,
            path: '/activityDetail',
            args: ActivityDetailPageArgs(
                key: key, id: id, orderId: orderId, isFromQr: isFromQr));

  static const String name = 'ActivityDetailPage';
}

class ActivityDetailPageArgs {
  const ActivityDetailPageArgs(
      {this.key, required this.id, this.orderId, required this.isFromQr});

  final _i84.Key? key;

  final String id;

  final String? orderId;

  final bool isFromQr;

  @override
  String toString() {
    return 'ActivityDetailPageArgs{key: $key, id: $id, orderId: $orderId, isFromQr: $isFromQr}';
  }
}

/// generated route for
/// [_i41.MapsDerectionScreen]
class MapsDerectionPage extends _i83.PageRouteInfo<MapsDerectionPageArgs> {
  MapsDerectionPage({_i84.Key? key, required _i92.VendorModel vendorInfo})
      : super(MapsDerectionPage.name,
            path: '/MapsDerectionPage',
            args: MapsDerectionPageArgs(key: key, vendorInfo: vendorInfo));

  static const String name = 'MapsDerectionPage';
}

class MapsDerectionPageArgs {
  const MapsDerectionPageArgs({this.key, required this.vendorInfo});

  final _i84.Key? key;

  final _i92.VendorModel vendorInfo;

  @override
  String toString() {
    return 'MapsDerectionPageArgs{key: $key, vendorInfo: $vendorInfo}';
  }
}

/// generated route for
/// [_i42.OrderQrScreen]
class OrderQrPage extends _i83.PageRouteInfo<OrderQrPageArgs> {
  OrderQrPage({_i84.Key? key, required String orderId})
      : super(OrderQrPage.name,
            path: '/OrderQrPage',
            args: OrderQrPageArgs(key: key, orderId: orderId));

  static const String name = 'OrderQrPage';
}

class OrderQrPageArgs {
  const OrderQrPageArgs({this.key, required this.orderId});

  final _i84.Key? key;

  final String orderId;

  @override
  String toString() {
    return 'OrderQrPageArgs{key: $key, orderId: $orderId}';
  }
}

/// generated route for
/// [_i43.LanguageScreen]
class LanguagePage extends _i83.PageRouteInfo<void> {
  const LanguagePage() : super(LanguagePage.name, path: '/languageScreen');

  static const String name = 'LanguagePage';
}

/// generated route for
/// [_i44.ReviewScreen]
class ReviewPage extends _i83.PageRouteInfo<ReviewPageArgs> {
  ReviewPage({_i84.Key? key, String vendorID = ''})
      : super(ReviewPage.name,
            path: '/review',
            args: ReviewPageArgs(key: key, vendorID: vendorID));

  static const String name = 'ReviewPage';
}

class ReviewPageArgs {
  const ReviewPageArgs({this.key, this.vendorID = ''});

  final _i84.Key? key;

  final String vendorID;

  @override
  String toString() {
    return 'ReviewPageArgs{key: $key, vendorID: $vendorID}';
  }
}

/// generated route for
/// [_i45.RewardsDetailScreen]
class RewardsDetailPage extends _i83.PageRouteInfo<void> {
  const RewardsDetailPage() : super(RewardsDetailPage.name, path: '/rewards');

  static const String name = 'RewardsDetailPage';
}

/// generated route for
/// [_i46.RewardsHistoryScreen]
class RewardsHistoryPage extends _i83.PageRouteInfo<void> {
  const RewardsHistoryPage()
      : super(RewardsHistoryPage.name, path: '/RewardsHistoryScreen');

  static const String name = 'RewardsHistoryPage';
}

/// generated route for
/// [_i47.RewardsGuideScreen]
class RewardsGuidePage extends _i83.PageRouteInfo<void> {
  const RewardsGuidePage()
      : super(RewardsGuidePage.name, path: '/RewardsGuidePage');

  static const String name = 'RewardsGuidePage';
}

/// generated route for
/// [_i48.VoucherDetailScreen]
class VoucherDetailPage extends _i83.PageRouteInfo<VoucherDetailPageArgs> {
  VoucherDetailPage({_i84.Key? key, required _i88.VoucherModel voucherDetail})
      : super(VoucherDetailPage.name,
            path: '/VoucherDetailPage',
            args:
                VoucherDetailPageArgs(key: key, voucherDetail: voucherDetail));

  static const String name = 'VoucherDetailPage';
}

class VoucherDetailPageArgs {
  const VoucherDetailPageArgs({this.key, required this.voucherDetail});

  final _i84.Key? key;

  final _i88.VoucherModel voucherDetail;

  @override
  String toString() {
    return 'VoucherDetailPageArgs{key: $key, voucherDetail: $voucherDetail}';
  }
}

/// generated route for
/// [_i49.AffiliateScreen]
class AffiliatePage extends _i83.PageRouteInfo<AffiliatePageArgs> {
  AffiliatePage({_i84.Key? key, required _i86.AccountModel account})
      : super(AffiliatePage.name,
            path: '/AffiliatePage',
            args: AffiliatePageArgs(key: key, account: account));

  static const String name = 'AffiliatePage';
}

class AffiliatePageArgs {
  const AffiliatePageArgs({this.key, required this.account});

  final _i84.Key? key;

  final _i86.AccountModel account;

  @override
  String toString() {
    return 'AffiliatePageArgs{key: $key, account: $account}';
  }
}

/// generated route for
/// [_i50.AffiliateHistoryScreen]
class AffiliateHistoryPage
    extends _i83.PageRouteInfo<AffiliateHistoryPageArgs> {
  AffiliateHistoryPage(
      {_i84.Key? key,
      required List<_i86.AccountModel> firstLevel,
      required List<_i86.AccountModel> secondLevel})
      : super(AffiliateHistoryPage.name,
            path: '/AffiliateHistoryPage',
            args: AffiliateHistoryPageArgs(
                key: key, firstLevel: firstLevel, secondLevel: secondLevel));

  static const String name = 'AffiliateHistoryPage';
}

class AffiliateHistoryPageArgs {
  const AffiliateHistoryPageArgs(
      {this.key, required this.firstLevel, required this.secondLevel});

  final _i84.Key? key;

  final List<_i86.AccountModel> firstLevel;

  final List<_i86.AccountModel> secondLevel;

  @override
  String toString() {
    return 'AffiliateHistoryPageArgs{key: $key, firstLevel: $firstLevel, secondLevel: $secondLevel}';
  }
}

/// generated route for
/// [_i51.TierBenefitsScreen]
class TierBenefitsPage extends _i83.PageRouteInfo<void> {
  const TierBenefitsPage()
      : super(TierBenefitsPage.name, path: '/tierBenefits');

  static const String name = 'TierBenefitsPage';
}

/// generated route for
/// [_i52.MessageDetailScreen]
class MessageDetailPage extends _i83.PageRouteInfo<MessageDetailPageArgs> {
  MessageDetailPage(
      {_i84.Key? key,
      required String roomId,
      dynamic Function(List<_i93.StaffModel>)? onBack,
      required String vendorId,
      _i92.VendorModel? vendorInfo})
      : super(MessageDetailPage.name,
            path: '/messageDetail',
            args: MessageDetailPageArgs(
                key: key,
                roomId: roomId,
                onBack: onBack,
                vendorId: vendorId,
                vendorInfo: vendorInfo));

  static const String name = 'MessageDetailPage';
}

class MessageDetailPageArgs {
  const MessageDetailPageArgs(
      {this.key,
      required this.roomId,
      this.onBack,
      required this.vendorId,
      this.vendorInfo});

  final _i84.Key? key;

  final String roomId;

  final dynamic Function(List<_i93.StaffModel>)? onBack;

  final String vendorId;

  final _i92.VendorModel? vendorInfo;

  @override
  String toString() {
    return 'MessageDetailPageArgs{key: $key, roomId: $roomId, onBack: $onBack, vendorId: $vendorId, vendorInfo: $vendorInfo}';
  }
}

/// generated route for
/// [_i53.StaffScreen]
class CustomerStaffPage extends _i83.PageRouteInfo<CustomerStaffPageArgs> {
  CustomerStaffPage(
      {_i84.Key? key,
      required String vendorId,
      required String orderId,
      dynamic Function(List<_i93.StaffModel>)? onBack})
      : super(CustomerStaffPage.name,
            path: '/CustomerStaffPage',
            args: CustomerStaffPageArgs(
                key: key,
                vendorId: vendorId,
                orderId: orderId,
                onBack: onBack));

  static const String name = 'CustomerStaffPage';
}

class CustomerStaffPageArgs {
  const CustomerStaffPageArgs(
      {this.key, required this.vendorId, required this.orderId, this.onBack});

  final _i84.Key? key;

  final String vendorId;

  final String orderId;

  final dynamic Function(List<_i93.StaffModel>)? onBack;

  @override
  String toString() {
    return 'CustomerStaffPageArgs{key: $key, vendorId: $vendorId, orderId: $orderId, onBack: $onBack}';
  }
}

/// generated route for
/// [_i54.MessageScreen]
class MessagePage extends _i83.PageRouteInfo<void> {
  const MessagePage() : super(MessagePage.name, path: '/messageScreen');

  static const String name = 'MessagePage';
}

/// generated route for
/// [_i55.NotificationScreen]
class NotificationPage extends _i83.PageRouteInfo<void> {
  const NotificationPage()
      : super(NotificationPage.name, path: '/notification_screen');

  static const String name = 'NotificationPage';
}

/// generated route for
/// [_i56.ThemeScreen]
class ThemePage extends _i83.PageRouteInfo<void> {
  const ThemePage() : super(ThemePage.name, path: '/messageScreen');

  static const String name = 'ThemePage';
}

/// generated route for
/// [_i57.ProfileInformation]
class ProfileInformationPage extends _i83.PageRouteInfo<void> {
  const ProfileInformationPage()
      : super(ProfileInformationPage.name, path: '/profileInformation');

  static const String name = 'ProfileInformationPage';
}

/// generated route for
/// [_i58.TermOfServiceScreen]
class TermOfServicePage extends _i83.PageRouteInfo<void> {
  const TermOfServicePage()
      : super(TermOfServicePage.name, path: '/termOfService');

  static const String name = 'TermOfServicePage';
}

/// generated route for
/// [_i59.HelpAndSupportScreen]
class HelpAndSupportPage extends _i83.PageRouteInfo<void> {
  const HelpAndSupportPage()
      : super(HelpAndSupportPage.name, path: '/helpAndSupport');

  static const String name = 'HelpAndSupportPage';
}

/// generated route for
/// [_i60.ListLocalImageScreen]
class ListLocalImagePage extends _i83.PageRouteInfo<void> {
  const ListLocalImagePage()
      : super(ListLocalImagePage.name, path: '/listLocalImageScreen');

  static const String name = 'ListLocalImagePage';
}

/// generated route for
/// [_i61.PlayVideoScreen]
class PlayVideoPage extends _i83.PageRouteInfo<PlayVideoPageArgs> {
  PlayVideoPage({_i84.Key? key, required String path, required int index})
      : super(PlayVideoPage.name,
            path: '/play_video',
            args: PlayVideoPageArgs(key: key, path: path, index: index));

  static const String name = 'PlayVideoPage';
}

class PlayVideoPageArgs {
  const PlayVideoPageArgs({this.key, required this.path, required this.index});

  final _i84.Key? key;

  final String path;

  final int index;

  @override
  String toString() {
    return 'PlayVideoPageArgs{key: $key, path: $path, index: $index}';
  }
}

/// generated route for
/// [_i62.CarouselGalleryScreen]
class VendorCarouselGalleryPage
    extends _i83.PageRouteInfo<VendorCarouselGalleryPageArgs> {
  VendorCarouselGalleryPage(
      {_i84.Key? key, List<_i91.ImageModel>? listImage, int? indexImage})
      : super(VendorCarouselGalleryPage.name,
            path: '/vendorCarouselGallery',
            args: VendorCarouselGalleryPageArgs(
                key: key, listImage: listImage, indexImage: indexImage));

  static const String name = 'VendorCarouselGalleryPage';
}

class VendorCarouselGalleryPageArgs {
  const VendorCarouselGalleryPageArgs(
      {this.key, this.listImage, this.indexImage});

  final _i84.Key? key;

  final List<_i91.ImageModel>? listImage;

  final int? indexImage;

  @override
  String toString() {
    return 'VendorCarouselGalleryPageArgs{key: $key, listImage: $listImage, indexImage: $indexImage}';
  }
}

/// generated route for
/// [_i63.ServiceItemGalleryScreen]
class ServiceItemGalleryPage
    extends _i83.PageRouteInfo<ServiceItemGalleryPageArgs> {
  ServiceItemGalleryPage(
      {_i84.Key? key, List<_i91.ImageModel>? listGallery, String? serviceId})
      : super(ServiceItemGalleryPage.name,
            path: '/vendorsGalleryDetail',
            args: ServiceItemGalleryPageArgs(
                key: key, listGallery: listGallery, serviceId: serviceId));

  static const String name = 'ServiceItemGalleryPage';
}

class ServiceItemGalleryPageArgs {
  const ServiceItemGalleryPageArgs(
      {this.key, this.listGallery, this.serviceId});

  final _i84.Key? key;

  final List<_i91.ImageModel>? listGallery;

  final String? serviceId;

  @override
  String toString() {
    return 'ServiceItemGalleryPageArgs{key: $key, listGallery: $listGallery, serviceId: $serviceId}';
  }
}

/// generated route for
/// [_i64.VendorsGalleryDetail]
class VendorsGalleryDetailPage
    extends _i83.PageRouteInfo<VendorsGalleryDetailPageArgs> {
  VendorsGalleryDetailPage(
      {_i84.Key? key,
      required int index,
      required List<_i92.GalleryModel> listImage})
      : super(VendorsGalleryDetailPage.name,
            path: '/vendorsGalleryDetail',
            args: VendorsGalleryDetailPageArgs(
                key: key, index: index, listImage: listImage));

  static const String name = 'VendorsGalleryDetailPage';
}

class VendorsGalleryDetailPageArgs {
  const VendorsGalleryDetailPageArgs(
      {this.key, required this.index, required this.listImage});

  final _i84.Key? key;

  final int index;

  final List<_i92.GalleryModel> listImage;

  @override
  String toString() {
    return 'VendorsGalleryDetailPageArgs{key: $key, index: $index, listImage: $listImage}';
  }
}

/// generated route for
/// [_i65.NewFeddGallery]
class NewFeddGalleryPage extends _i83.PageRouteInfo<NewFeddGalleryPageArgs> {
  NewFeddGalleryPage(
      {_i84.Key? key,
      required int index,
      required List<_i92.GalleryModel> listImage,
      required String id})
      : super(NewFeddGalleryPage.name,
            path: '/newfeed_gallery',
            args: NewFeddGalleryPageArgs(
                key: key, index: index, listImage: listImage, id: id));

  static const String name = 'NewFeddGalleryPage';
}

class NewFeddGalleryPageArgs {
  const NewFeddGalleryPageArgs(
      {this.key,
      required this.index,
      required this.listImage,
      required this.id});

  final _i84.Key? key;

  final int index;

  final List<_i92.GalleryModel> listImage;

  final String id;

  @override
  String toString() {
    return 'NewFeddGalleryPageArgs{key: $key, index: $index, listImage: $listImage, id: $id}';
  }
}

/// generated route for
/// [_i66.SearchScreen]
class SearchPage extends _i83.PageRouteInfo<SearchPageArgs> {
  SearchPage({_i84.Key? key, String? category})
      : super(SearchPage.name,
            path: '/main_search',
            args: SearchPageArgs(key: key, category: category));

  static const String name = 'SearchPage';
}

class SearchPageArgs {
  const SearchPageArgs({this.key, this.category});

  final _i84.Key? key;

  final String? category;

  @override
  String toString() {
    return 'SearchPageArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [_i67.CustomerQrScreen]
class CustomerQrPage extends _i83.PageRouteInfo<void> {
  const CustomerQrPage() : super(CustomerQrPage.name, path: '/CustomerQrPage');

  static const String name = 'CustomerQrPage';
}

/// generated route for
/// [_i68.CreatePostScreen]
class CreatPostPage extends _i83.PageRouteInfo<CreatPostPageArgs> {
  CreatPostPage({_i84.Key? key})
      : super(CreatPostPage.name,
            path: '/create_page', args: CreatPostPageArgs(key: key));

  static const String name = 'CreatPostPage';
}

class CreatPostPageArgs {
  const CreatPostPageArgs({this.key});

  final _i84.Key? key;

  @override
  String toString() {
    return 'CreatPostPageArgs{key: $key}';
  }
}

/// generated route for
/// [_i69.AddTagsScreen]
class AddTagsPage extends _i83.PageRouteInfo<AddTagsPageArgs> {
  AddTagsPage(
      {_i84.Key? key,
      required dynamic Function(List<_i92.VendorModel>)? onBack,
      required List<_i92.VendorModel> vendors})
      : super(AddTagsPage.name,
            path: '/add_tag_screen',
            args: AddTagsPageArgs(key: key, onBack: onBack, vendors: vendors));

  static const String name = 'AddTagsPage';
}

class AddTagsPageArgs {
  const AddTagsPageArgs(
      {this.key, required this.onBack, required this.vendors});

  final _i84.Key? key;

  final dynamic Function(List<_i92.VendorModel>)? onBack;

  final List<_i92.VendorModel> vendors;

  @override
  String toString() {
    return 'AddTagsPageArgs{key: $key, onBack: $onBack, vendors: $vendors}';
  }
}

/// generated route for
/// [_i70.ConfirmCompleteScreen]
class ConfirmCompletePage extends _i83.PageRouteInfo<ConfirmCompletePageArgs> {
  ConfirmCompletePage(
      {_i84.Key? key,
      required dynamic Function(String, String, String, List<String>)? onBack,
      required String defaultPrice})
      : super(ConfirmCompletePage.name,
            path: '/ConfirmCompletePage',
            args: ConfirmCompletePageArgs(
                key: key, onBack: onBack, defaultPrice: defaultPrice));

  static const String name = 'ConfirmCompletePage';
}

class ConfirmCompletePageArgs {
  const ConfirmCompletePageArgs(
      {this.key, required this.onBack, required this.defaultPrice});

  final _i84.Key? key;

  final dynamic Function(String, String, String, List<String>)? onBack;

  final String defaultPrice;

  @override
  String toString() {
    return 'ConfirmCompletePageArgs{key: $key, onBack: $onBack, defaultPrice: $defaultPrice}';
  }
}

/// generated route for
/// [_i71.UploadBillScreen]
class UploadBillPage extends _i83.PageRouteInfo<UploadBillPageArgs> {
  UploadBillPage(
      {_i84.Key? key, required dynamic Function(List<String>)? onBack})
      : super(UploadBillPage.name,
            path: '/UploadBillPage',
            args: UploadBillPageArgs(key: key, onBack: onBack));

  static const String name = 'UploadBillPage';
}

class UploadBillPageArgs {
  const UploadBillPageArgs({this.key, required this.onBack});

  final _i84.Key? key;

  final dynamic Function(List<String>)? onBack;

  @override
  String toString() {
    return 'UploadBillPageArgs{key: $key, onBack: $onBack}';
  }
}

/// generated route for
/// [_i72.VendorProfileAddressScreen]
class VendorProfileAddressPage
    extends _i83.PageRouteInfo<VendorProfileAddressPageArgs> {
  VendorProfileAddressPage(
      {_i84.Key? key, dynamic Function(double, double, bool)? onBack})
      : super(VendorProfileAddressPage.name,
            path: '/VendorProfileAddressScreen',
            args: VendorProfileAddressPageArgs(key: key, onBack: onBack));

  static const String name = 'VendorProfileAddressPage';
}

class VendorProfileAddressPageArgs {
  const VendorProfileAddressPageArgs({this.key, this.onBack});

  final _i84.Key? key;

  final dynamic Function(double, double, bool)? onBack;

  @override
  String toString() {
    return 'VendorProfileAddressPageArgs{key: $key, onBack: $onBack}';
  }
}

/// generated route for
/// [_i73.VendorProfileInformation]
class VendorProfileInformationPage extends _i83.PageRouteInfo<void> {
  const VendorProfileInformationPage()
      : super(VendorProfileInformationPage.name,
            path: '/VendorProfileInformation');

  static const String name = 'VendorProfileInformationPage';
}

/// generated route for
/// [_i74.VendorsReviewsScreen]
class VendorsReviewsPage extends _i83.PageRouteInfo<void> {
  const VendorsReviewsPage()
      : super(VendorsReviewsPage.name, path: '/VendorsReviewsScreen');

  static const String name = 'VendorsReviewsPage';
}

/// generated route for
/// [_i75.WaitressManagerScreen]
class WaitressManagerPage extends _i83.PageRouteInfo<void> {
  const WaitressManagerPage()
      : super(WaitressManagerPage.name, path: '/WaitressManagerPage');

  static const String name = 'WaitressManagerPage';
}

/// generated route for
/// [_i76.AddWaitressScreen]
class AddWaitressPage extends _i83.PageRouteInfo<AddWaitressPageArgs> {
  AddWaitressPage({_i84.Key? key, dynamic Function(_i93.StaffModel)? onBack})
      : super(AddWaitressPage.name,
            path: '/AddWaitressPage',
            args: AddWaitressPageArgs(key: key, onBack: onBack));

  static const String name = 'AddWaitressPage';
}

class AddWaitressPageArgs {
  const AddWaitressPageArgs({this.key, this.onBack});

  final _i84.Key? key;

  final dynamic Function(_i93.StaffModel)? onBack;

  @override
  String toString() {
    return 'AddWaitressPageArgs{key: $key, onBack: $onBack}';
  }
}

/// generated route for
/// [_i77.AdminOrdersDetailScreen]
class AdminOrdersDetailPage
    extends _i83.PageRouteInfo<AdminOrdersDetailPageArgs> {
  AdminOrdersDetailPage(
      {_i84.Key? key,
      String? orderId,
      bool? isFromList = false,
      dynamic Function(_i87.BookingItemModel)? onBack})
      : super(AdminOrdersDetailPage.name,
            path: '/AdminOrdersDetailPage',
            args: AdminOrdersDetailPageArgs(
                key: key,
                orderId: orderId,
                isFromList: isFromList,
                onBack: onBack));

  static const String name = 'AdminOrdersDetailPage';
}

class AdminOrdersDetailPageArgs {
  const AdminOrdersDetailPageArgs(
      {this.key, this.orderId, this.isFromList = false, this.onBack});

  final _i84.Key? key;

  final String? orderId;

  final bool? isFromList;

  final dynamic Function(_i87.BookingItemModel)? onBack;

  @override
  String toString() {
    return 'AdminOrdersDetailPageArgs{key: $key, orderId: $orderId, isFromList: $isFromList, onBack: $onBack}';
  }
}

/// generated route for
/// [_i78.ListMenuScreen]
class ListMenuPage extends _i83.PageRouteInfo<ListMenuPageArgs> {
  ListMenuPage({_i84.Key? key})
      : super(ListMenuPage.name,
            path: '/ListMenuPage', args: ListMenuPageArgs(key: key));

  static const String name = 'ListMenuPage';
}

class ListMenuPageArgs {
  const ListMenuPageArgs({this.key});

  final _i84.Key? key;

  @override
  String toString() {
    return 'ListMenuPageArgs{key: $key}';
  }
}

/// generated route for
/// [_i79.SelectMenuScreen]
class SelectMenuPage extends _i83.PageRouteInfo<SelectMenuPageArgs> {
  SelectMenuPage(
      {_i84.Key? key,
      dynamic Function(List<_i94.SelectedMenuItemModel>)? onBack,
      List<_i94.SelectedMenuItemModel>? selectedMenu})
      : super(SelectMenuPage.name,
            path: '/SelectMenuPage',
            args: SelectMenuPageArgs(
                key: key, onBack: onBack, selectedMenu: selectedMenu));

  static const String name = 'SelectMenuPage';
}

class SelectMenuPageArgs {
  const SelectMenuPageArgs({this.key, this.onBack, this.selectedMenu});

  final _i84.Key? key;

  final dynamic Function(List<_i94.SelectedMenuItemModel>)? onBack;

  final List<_i94.SelectedMenuItemModel>? selectedMenu;

  @override
  String toString() {
    return 'SelectMenuPageArgs{key: $key, onBack: $onBack, selectedMenu: $selectedMenu}';
  }
}

/// generated route for
/// [_i80.AddSubFeeScreen]
class AddSubFeePage extends _i83.PageRouteInfo<AddSubFeePageArgs> {
  AddSubFeePage(
      {_i84.Key? key, dynamic Function(String, double, String)? onBack})
      : super(AddSubFeePage.name,
            path: '/AddSubFeePage',
            args: AddSubFeePageArgs(key: key, onBack: onBack));

  static const String name = 'AddSubFeePage';
}

class AddSubFeePageArgs {
  const AddSubFeePageArgs({this.key, this.onBack});

  final _i84.Key? key;

  final dynamic Function(String, double, String)? onBack;

  @override
  String toString() {
    return 'AddSubFeePageArgs{key: $key, onBack: $onBack}';
  }
}

/// generated route for
/// [_i81.AddMenuScreen]
class AddMenuPage extends _i83.PageRouteInfo<AddMenuPageArgs> {
  AddMenuPage({_i84.Key? key, dynamic Function(_i94.MenuModel)? onBack})
      : super(AddMenuPage.name,
            path: '/AddMenuPage',
            args: AddMenuPageArgs(key: key, onBack: onBack));

  static const String name = 'AddMenuPage';
}

class AddMenuPageArgs {
  const AddMenuPageArgs({this.key, this.onBack});

  final _i84.Key? key;

  final dynamic Function(_i94.MenuModel)? onBack;

  @override
  String toString() {
    return 'AddMenuPageArgs{key: $key, onBack: $onBack}';
  }
}

/// generated route for
/// [_i82.VoucherScreen]
class VoucherPage extends _i83.PageRouteInfo<VoucherPageArgs> {
  VoucherPage(
      {_i84.Key? key,
      required dynamic Function(_i88.VoucherModel)? onBack,
      required String vendorId,
      _i92.VendorModel? vendorInfo,
      required _i88.VoucherModel selectedVoucher,
      required bool isSelectedVoucher})
      : super(VoucherPage.name,
            path: '/voucher_screen',
            args: VoucherPageArgs(
                key: key,
                onBack: onBack,
                vendorId: vendorId,
                vendorInfo: vendorInfo,
                selectedVoucher: selectedVoucher,
                isSelectedVoucher: isSelectedVoucher));

  static const String name = 'VoucherPage';
}

class VoucherPageArgs {
  const VoucherPageArgs(
      {this.key,
      required this.onBack,
      required this.vendorId,
      this.vendorInfo,
      required this.selectedVoucher,
      required this.isSelectedVoucher});

  final _i84.Key? key;

  final dynamic Function(_i88.VoucherModel)? onBack;

  final String vendorId;

  final _i92.VendorModel? vendorInfo;

  final _i88.VoucherModel selectedVoucher;

  final bool isSelectedVoucher;

  @override
  String toString() {
    return 'VoucherPageArgs{key: $key, onBack: $onBack, vendorId: $vendorId, vendorInfo: $vendorInfo, selectedVoucher: $selectedVoucher, isSelectedVoucher: $isSelectedVoucher}';
  }
}
