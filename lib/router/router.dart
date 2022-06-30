import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/router/app_router.dart';
import 'package:client_tggt/screen/activity/detail/activity_detail_screen.dart';
import 'package:client_tggt/screen/activity/maps_derection/maps_derection_screen.dart';
import 'package:client_tggt/screen/activity/qr_screen/order_qr_screen.dart';
import 'package:client_tggt/screen/admin_page/admin_main/admin_main_screen.dart';
import 'package:client_tggt/screen/admin_page/admin_orders/detail/admin_orders_detail_screen.dart';
import 'package:client_tggt/screen/auth/address/vendor_add_address_screen.dart';
import 'package:client_tggt/screen/auth/forgot_password/forgot_password_screen.dart';
import 'package:client_tggt/screen/auth/forgot_password/forgot_password_update_screen.dart';
import 'package:client_tggt/screen/auth/forgot_password/forgotpassword_verify_screen.dart';
import 'package:client_tggt/screen/auth/signin/signin_screen.dart';
import 'package:client_tggt/screen/auth/signin/signin_telephone_screen.dart';
import 'package:client_tggt/screen/auth/signin/signin_verify_screen.dart';
import 'package:client_tggt/screen/auth/signup/complete_register_screen.dart';
import 'package:client_tggt/screen/auth/signup/signup_screen.dart';
import 'package:client_tggt/screen/auth/signup/signup_vendor/signup_vendor_fifth.dart';
import 'package:client_tggt/screen/auth/signup/signup_vendor/signup_vendor_first.dart';
import 'package:client_tggt/screen/auth/signup/signup_vendor/signup_vendor_fourth.dart';
import 'package:client_tggt/screen/auth/signup/apply_vendor/apply_vendor_information.dart';
import 'package:client_tggt/screen/auth/signup/signup_vendor/signup_vendor_second.dart';
import 'package:client_tggt/screen/auth/signup/signup_vendor/signup_vendor_success.dart';
import 'package:client_tggt/screen/auth/signup/signup_vendor/signup_vendor_third.dart';
import 'package:client_tggt/screen/auth/signup/signup_vendor_screen.dart';
import 'package:client_tggt/screen/auth/verify/verify_screen.dart';
import 'package:client_tggt/screen/filter_vendors/filter_vendors_screen.dart';
import 'package:client_tggt/screen/history/history_screen.dart';
import 'package:client_tggt/screen/home/widget/customer_qr_screen.dart';
import 'package:client_tggt/screen/main/main_screen.dart';
import 'package:client_tggt/screen/message/create_post_screen.dart';
import 'package:client_tggt/screen/message/list_local_image_screen.dart';
import 'package:client_tggt/screen/message/newfeed_detail_screen.dart';
import 'package:client_tggt/screen/message/tags/add_tags_screen.dart';
import 'package:client_tggt/screen/message/widget/newfeed_gallery.dart';
import 'package:client_tggt/screen/message/widget/play_video_screen.dart';
import 'package:client_tggt/screen/notification/notification_screen.dart';
import 'package:client_tggt/screen/profile/affiliate/affiliate_screen.dart';
import 'package:client_tggt/screen/profile/affiliate/history/affiliate_history_screen.dart';
import 'package:client_tggt/screen/profile/help_and_support/help_and_support_screen.dart';
import 'package:client_tggt/screen/profile/language/language_screen.dart';
import 'package:client_tggt/screen/profile/message/message_detail_screen.dart';
import 'package:client_tggt/screen/profile/message/staff/staff_screen.dart';
import 'package:client_tggt/screen/profile/newfeed/user_newfeed_screen.dart';
import 'package:client_tggt/screen/profile/profile_information/profile_information.dart';
import 'package:client_tggt/screen/profile/theme/theme_screen.dart';
import 'package:client_tggt/screen/profile/term_of_service/term_of_service_screen.dart';
import 'package:client_tggt/screen/review/review_screen.dart';
import 'package:client_tggt/screen/profile/message/message_screen.dart';
import 'package:client_tggt/screen/rewards/detail/rewards_detail_screen.dart';
import 'package:client_tggt/screen/rewards/rewards_guide/rewards_guide_screen.dart';
import 'package:client_tggt/screen/rewards/rewards_history/rewards_history_screen.dart';
import 'package:client_tggt/screen/rewards/rewards_screen.dart';
import 'package:client_tggt/screen/rewards/tier_benefits/tier_benefits_screen.dart';
import 'package:client_tggt/screen/rewards/voucher/voucher_detail_screen.dart';
import 'package:client_tggt/screen/rewards/voucher/voucher_screen.dart';
import 'package:client_tggt/screen/search/search_screen.dart';
import 'package:client_tggt/screen/search_vendors/search_vendors_screen.dart';
import 'package:client_tggt/screen/splash/splash_creen.dart';
import 'package:client_tggt/screen/vendors/booking/confirm_complete/comfirm_complete.dart';
import 'package:client_tggt/screen/vendors/booking/create_order/vendor_screate_order_screen.dart';
import 'package:client_tggt/screen/vendors/booking/create_order/widget/vendor_list_product_screen.dart';
import 'package:client_tggt/screen/vendors/booking/detail/booking_detail_screen.dart';
import 'package:client_tggt/screen/vendors/booking/sub_fee/sub_fee_screen.dart';
import 'package:client_tggt/screen/vendors/booking/upload_bill/upload_bill_screen.dart';
import 'package:client_tggt/screen/vendors/main/vendors_main_screen.dart';
import 'package:client_tggt/screen/vendors/product/add_product/vendor_add_product_screen.dart';
import 'package:client_tggt/screen/vendors/product/product_detail/gallery/carousel_gallery_screen.dart';
import 'package:client_tggt/screen/vendors/product/product_detail/gallery/gallery_screen.dart';
import 'package:client_tggt/screen/vendors/product/product_detail/list_attribute/service_item_list_attribute_screen.dart';
import 'package:client_tggt/screen/vendors/product/product_detail/service_item_detail_screen.dart';
import 'package:client_tggt/screen/vendors/profile/menu/add_menu/add_menu_screen.dart';
import 'package:client_tggt/screen/vendors/profile/menu/list_menu_screen.dart';
import 'package:client_tggt/screen/vendors/profile/menu/select_menu/select_menu_screen.dart';
import 'package:client_tggt/screen/vendors/profile/vendor_profile_information.dart/vendor_profile_address_screen.dart';
import 'package:client_tggt/screen/vendors/profile/vendor_profile_information.dart/vendor_profile_information_screen.dart';
import 'package:client_tggt/screen/vendors/profile/vendor_reviews/vendor_reviews_screen.dart';
import 'package:client_tggt/screen/vendors/profile/waitress/add_waitress_screen.dart';
import 'package:client_tggt/screen/vendors/profile/waitress/waitress_manager_screen.dart';
import 'package:client_tggt/screen/vendors/qrcode/qrcode_screen.dart';
import 'package:client_tggt/screen/vendors_detail/vendors_detail_screen.dart';
import 'package:client_tggt/screen/vendors_detail/widgets/list_product_of_varient.dart';
import 'package:client_tggt/screen/vendors_gallery/vendors_gallery_screen.dart';
import 'package:client_tggt/screen/vendors_gallery/widgets/vendors_gallery_detail.dart';
import 'package:client_tggt/screen/vendors_list/vendors_screen.dart';
import 'package:client_tggt/shared/widget/errorpage/something_went_wrong.dart';
import 'package:flutter/material.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
        page: SplashScreen,
        name: "SplashPage",
        path: AppRoutes.splashScreen,
        initial: true),
    AutoRoute(page: MainScreen, name: "MainPage", path: AppRoutes.main),
    // AutoRoute(
    //     page: SigninTelephoneScreen,
    //     name: "SigninTelephonePage",
    //     path: AppRoutes.loginTelephone),
    CustomRoute(
      page: SigninTelephoneScreen,
      name: "SigninTelephonePage",
      path: AppRoutes.loginTelephone,
      fullscreenDialog: true,
      barrierDismissible: false,
      opaque: false,
      transitionsBuilder: slideBottomToTop,
    ),
    AutoRoute(
        page: SignInVerifyScreen,
        name: "SignInVerifyPage",
        path: AppRoutes.loginVerify),
    AutoRoute(
        page: CompleteRegisterScreen,
        name: "CompleteRegisterPage",
        path: "/complete_register"),

    AutoRoute(
        page: SignupVendorScreen,
        name: "SignupVendorPage",
        path: AppRoutes.signupVendor),
    AutoRoute(
        page: SignUpVendorFirst,
        name: "SignUpVendorFirstPage",
        path: "/SignUpVendorFirstPage"),
    AutoRoute(
        page: ApplyVendorInformation,
        name: "ApplyVendorInformationPage",
        path: "/ApplyVendorInformationPage"),
    AutoRoute(
        page: SignupVendorSecond,
        name: "SignupVendorSecondPage",
        path: "/SignupVendorSecondPage"),
    AutoRoute(
        page: SignupVendorThirdScreen,
        name: "SignupVendorThirdPage",
        path: "/SignupVendorThirdPage"),
    AutoRoute(
        page: SignupVendorFourth,
        name: "SignupVendorFourthPage",
        path: "/SignupVendorFourthPage"),
    AutoRoute(
        page: SignupVendorFifth,
        name: "SignupVendorFifthPage",
        path: "/SignupVendorFifthPage"),
    AutoRoute(
        page: VendorAddAdressScreen,
        name: "VendorAddAdressPage",
        path: "/VendorAddAdressPage"),
    AutoRoute(
        page: SignupVendorSuccess,
        name: "SignupVendorSuccessPage",
        path: "/SignupVendorSuccessPage"),
    // AutoRoute(page: SigninScreen, name: "SigninPage", path: AppRoutes.login),
    CustomRoute(
      page: SigninScreen,
      name: "SigninPage",
      path: AppRoutes.login,
      fullscreenDialog: true,
      barrierDismissible: false,
      opaque: false,
      transitionsBuilder: slideBottomToTop,
    ),
    CustomRoute(
      page: SignupScreen,
      name: "SignupPage",
      path: AppRoutes.signup,
      fullscreenDialog: true,
      barrierDismissible: false,
      opaque: false,
      transitionsBuilder: slideBottomToTop,
    ),
    // AutoRoute(page: SignupScreen, name: "SignupPage", path: AppRoutes.signup),
    AutoRoute(page: VerifyScreen, name: "VerifyPage", path: AppRoutes.verify),
    AutoRoute(
        page: VendorMainScreen,
        name: "VendorMainPage",
        path: AppRoutes.vendorListScreen),
    AutoRoute(
        page: AdminMainScreen, name: "AdminMainPage", path: "/AdminMainScreen"),
    AutoRoute(
        page: ForgotPasswordScreen,
        name: "ForgotPasswordPage",
        path: AppRoutes.forgotPassword),
    AutoRoute(
        page: ForgotPasswordVerifyScreen,
        name: "ForgotPasswordVerifyPage",
        path: "/ForgotPasswordVerifyScreen"),
    AutoRoute(
        page: ForgotPasswordUpdateScreen,
        name: "ForgotPasswordUpdatePage",
        path: "/ForgotPasswordUpdateScreen"),
    AutoRoute(
        page: SearchVendorScreen,
        name: "SearchVendorPage",
        path: AppRoutes.seachVendor),
    AutoRoute(
        page: FilterVendorsScreen,
        name: "FilterVendorsPage",
        path: AppRoutes.filterVendors),
    AutoRoute(
        page: VendorsCreateOrderScreen,
        name: "VendorsCreateOrderPage",
        path: "/VendorsCreateOrderPage"),
    AutoRoute(
        page: VendorListProductScreen,
        name: "VendorListProductPage",
        path: "/VendorListProductPage"),

    AutoRoute(
        page: BookingDetailScreen,
        name: "BookingDetailPage",
        path: AppRoutes.bookingDetail),
    AutoRoute(
        page: SomethingWentWrongScreen,
        name: "SomethingWentWrongPage",
        path: AppRoutes.errorScreen),
    AutoRoute(
        page: NewfeedDetailScreen,
        name: "NewfeedDetailPage",
        path: AppRoutes.newfeedDetail),

    AutoRoute(
        page: UserNewfeedScreen,
        name: "UserNewfeedPage",
        path: "/UserNewfeedPage"),
    AutoRoute(
        page: VendorsScreen, name: "VendorsPage", path: AppRoutes.vendorScreen),

    CustomRoute(
        page: VendorsDetailScreen,
        name: "VendorsDetailPage",
        path: AppRoutes.vendorDetail,
        transitionsBuilder: TransitionsBuilders.fadeIn),
    AutoRoute(
        page: ProductsOfVarientScreen,
        name: "ProductsOfVarientPage",
        path: '/ProductsOfVarientPage'),

    // CustomRoute(
    //     fullscreenDialog: true,
    //     opaque: false,
    //     barrierDismissible: true,
    //     page: VendorsDetailScreen,
    //     name: "VendorsDetailPage",
    //     path: AppRoutes.vendorDetail),
    AutoRoute(
        page: VendorAddProductScreen,
        name: "VendorAddProductPage",
        path: AppRoutes.vendorAddProduct),
    AutoRoute(
        page: ScanQRPage, name: "ScanQRScreenPage", path: AppRoutes.qrCodeScan),
    AutoRoute(
        page: ServiceItemListAttributeScreen,
        name: "AttributeListPage",
        path: AppRoutes.listItemAttributeScreen),
    AutoRoute(
        page: ServiceItemDetailScreen,
        name: "ServiceItemDetailPage",
        path: AppRoutes.serviceItemDetailScreen),
    AutoRoute(
        page: VendorsGalleryScreen,
        name: "VendorsGalleryPage",
        path: AppRoutes.vendorGalleryScreen),
    AutoRoute(
        page: HistoryScreen, name: "HistoryPage", path: AppRoutes.history),
    AutoRoute(
        page: ActivityDetailScreen,
        name: "ActivityDetailPage",
        path: AppRoutes.activityDetail),

    AutoRoute(
        page: MapsDerectionScreen,
        name: "MapsDerectionPage",
        path: "/MapsDerectionPage"),
    AutoRoute(page: OrderQrScreen, name: "OrderQrPage", path: "/OrderQrPage"),
    AutoRoute(
        page: LanguageScreen,
        name: "LanguagePage",
        path: AppRoutes.languageScreen),
    AutoRoute(
      page: ReviewScreen,
      name: "ReviewPage",
      path: AppRoutes.reviewScreen,
    ),
    AutoRoute(
      page: RewardsDetailScreen,
      name: "RewardsDetailPage",
      path: AppRoutes.rewardsScreen,
    ),
    AutoRoute(
      page: RewardsHistoryScreen,
      name: "RewardsHistoryPage",
      path: "/RewardsHistoryScreen",
    ),
    AutoRoute(
      page: RewardsGuideScreen,
      name: "RewardsGuidePage",
      path: "/RewardsGuidePage",
    ),
    AutoRoute(
      page: VoucherDetailScreen,
      name: "VoucherDetailPage",
      path: "/VoucherDetailPage",
    ),

    AutoRoute(
      page: AffiliateScreen,
      name: "AffiliatePage",
      path: "/AffiliatePage",
    ),
    AutoRoute(
      page: AffiliateHistoryScreen,
      name: "AffiliateHistoryPage",
      path: "/AffiliateHistoryPage",
    ),

    AutoRoute(
      page: TierBenefitsScreen,
      name: "TierBenefitsPage",
      path: AppRoutes.tierBenefitsScreen,
    ),
    AutoRoute(
        page: MessageDetailScreen,
        name: "MessageDetailPage",
        path: AppRoutes.messageDetail),
    AutoRoute(
        page: StaffScreen,
        name: "CustomerStaffPage",
        path: "/CustomerStaffPage"),
    AutoRoute(
        page: MessageScreen,
        name: "MessagePage",
        path: AppRoutes.messageScreen),
    AutoRoute(
        page: NotificationScreen,
        name: "NotificationPage",
        path: "/notification_screen"),
    AutoRoute(
        page: ThemeScreen, name: "ThemePage", path: AppRoutes.messageScreen),
    AutoRoute(
        page: ProfileInformation,
        name: "ProfileInformationPage",
        path: AppRoutes.profileInformation),
    AutoRoute(
        page: TermOfServiceScreen,
        name: "TermOfServicePage",
        path: AppRoutes.termOfService),
    AutoRoute(
        page: HelpAndSupportScreen,
        name: "HelpAndSupportPage",
        path: AppRoutes.helpAndSupport),
    AutoRoute(
        page: ListLocalImageScreen,
        name: "ListLocalImagePage",
        path: AppRoutes.listLocalImageScreen),
    CustomRoute(
      page: PlayVideoScreen,
      name: "PlayVideoPage",
      path: "/play_video",
      fullscreenDialog: true,
      barrierDismissible: false,
      opaque: false,
      transitionsBuilder: slideBottomToTop,
    ),
    // CustomRoute(
    //     page: CarouselGalleryScreen,
    //     name: "VendorCarouselGalleryPage",
    //     path: AppRoutes.vendorCarouselGallery,
    //     transitionsBuilder: TransitionsBuilders.fadeIn),

    CustomRoute(
        fullscreenDialog: true,
        opaque: false,
        barrierDismissible: true,
        page: CarouselGalleryScreen,
        name: "VendorCarouselGalleryPage",
        path: AppRoutes.vendorCarouselGallery),
    CustomRoute(
      page: ServiceItemGalleryScreen,
      name: "ServiceItemGalleryPage",
      path: AppRoutes.vendorsGalleryDetail,
      fullscreenDialog: true,
      barrierDismissible: false,
      opaque: false,
      transitionsBuilder: slideBottomToTop,
    ),
    CustomRoute(
        fullscreenDialog: true,
        opaque: false,
        barrierDismissible: true,
        page: VendorsGalleryDetail,
        name: "VendorsGalleryDetailPage",
        path: AppRoutes.vendorsGalleryDetail),
    CustomRoute(
        fullscreenDialog: true,
        opaque: false,
        barrierDismissible: true,
        page: NewFeddGallery,
        name: "NewFeddGalleryPage",
        path: "/newfeed_gallery"),
    CustomRoute(
      page: SearchScreen,
      name: "SearchPage",
      path: "/main_search",
      fullscreenDialog: true,
      barrierDismissible: false,
      opaque: false,
      transitionsBuilder: slideBottomToTop,
    ),
    CustomRoute(
      page: CustomerQrScreen,
      name: "CustomerQrPage",
      path: "/CustomerQrPage",
      fullscreenDialog: true,
      barrierDismissible: false,
      opaque: false,
      transitionsBuilder: slideBottomToTop,
    ),
    // CustomRoute(
    //     page: SearchScreen,
    //     name: "SearchPage",
    //     path: "/main_search",
    //     transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
      page: CreatePostScreen,
      name: "CreatPostPage",
      path: "/create_page",
      fullscreenDialog: true,
      barrierDismissible: false,
      opaque: false,
      transitionsBuilder: slideBottomToTop,
    ),
    // AutoRoute(page: AddTagsScreen, name: "AddTagsPage", path: "/AddTagsScreen"),
    CustomRoute(
      page: AddTagsScreen,
      name: "AddTagsPage",
      path: "/add_tag_screen",
      fullscreenDialog: true,
      barrierDismissible: false,
      opaque: false,
      transitionsBuilder: slideBottomToTop,
    ),
    AutoRoute(
        page: ConfirmCompleteScreen,
        name: "ConfirmCompletePage",
        path: "/ConfirmCompletePage"),
    AutoRoute(
        page: UploadBillScreen,
        name: "UploadBillPage",
        path: "/UploadBillPage"),
    AutoRoute(
        page: VendorProfileAddressScreen,
        name: "VendorProfileAddressPage",
        path: "/VendorProfileAddressScreen"),
    AutoRoute(
        page: VendorProfileInformation,
        name: "VendorProfileInformationPage",
        path: "/VendorProfileInformation"),
    AutoRoute(
        page: VendorsReviewsScreen,
        name: "VendorsReviewsPage",
        path: "/VendorsReviewsScreen"),
    AutoRoute(
        page: WaitressManagerScreen,
        name: "WaitressManagerPage",
        path: "/WaitressManagerPage"),
    AutoRoute(
        page: AddWaitressScreen,
        name: "AddWaitressPage",
        path: "/AddWaitressPage"),
    AutoRoute(
        page: AdminOrdersDetailScreen,
        name: "AdminOrdersDetailPage",
        path: "/AdminOrdersDetailPage"),
    AutoRoute(
        page: ListMenuScreen, name: "ListMenuPage", path: "/ListMenuPage"),
    AutoRoute(
        page: SelectMenuScreen,
        name: "SelectMenuPage",
        path: "/SelectMenuPage"),
    AutoRoute(
        page: AddSubFeeScreen, name: "AddSubFeePage", path: "/AddSubFeePage"),
    AutoRoute(page: AddMenuScreen, name: "AddMenuPage", path: "/AddMenuPage"),
    CustomRoute(
      page: VoucherScreen,
      name: "VoucherPage",
      path: "/voucher_screen",
      fullscreenDialog: true,
      barrierDismissible: false,
      opaque: false,
      transitionsBuilder: slideBottomToTop,
    ),
  ],
)
class $AppRouter {}

Widget slideBottomToTop(context, animation, secondaryAnimation, child) {
  const begin = Offset(0.0, 1.0);
  const end = Offset.zero;
  const curve = Curves.fastLinearToSlowEaseIn;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  return SlideTransition(
    position: animation.drive(tween),
    child: child,
  );
}
