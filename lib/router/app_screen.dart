import 'package:client_tggt/router/app_router.dart';
import 'package:client_tggt/screen/activity/detail/activity_detail_binding.dart';
import 'package:client_tggt/screen/activity/detail/activity_detail_screen.dart';
import 'package:client_tggt/screen/auth/forgot_password/forgot_password_screen.dart';
import 'package:client_tggt/screen/auth/signin/signin_screen.dart';
import 'package:client_tggt/screen/auth/signup/signup_screen.dart';
import 'package:client_tggt/screen/auth/verify/verify_screen.dart';
import 'package:client_tggt/screen/filter_vendors/filter_vendors_binding.dart';
import 'package:client_tggt/screen/filter_vendors/filter_vendors_screen.dart';
import 'package:client_tggt/screen/activity/activity_binding.dart';
import 'package:client_tggt/screen/activity/activity_screen.dart';
import 'package:client_tggt/screen/history/history_binding.dart';
import 'package:client_tggt/screen/history/history_screen.dart';
import 'package:client_tggt/screen/main/main_binding.dart';
import 'package:client_tggt/screen/main/main_screen.dart';
import 'package:client_tggt/screen/profile/language/language_screen.dart';
import 'package:client_tggt/screen/search/search_binding.dart';
import 'package:client_tggt/screen/search/search_screen.dart';
import 'package:client_tggt/screen/search_vendors/search_vendors_screen.dart';
import 'package:client_tggt/screen/splash/splash_binding.dart';
import 'package:client_tggt/screen/splash/splash_creen.dart';
import 'package:client_tggt/screen/vendors/booking/detail/booking_detail_binding.dart';
import 'package:client_tggt/screen/vendors/booking/detail/booking_detail_screen.dart';
import 'package:client_tggt/screen/vendors/main/vendors_main_binding.dart';
import 'package:client_tggt/screen/vendors/main/vendors_main_screen.dart';
import 'package:client_tggt/screen/vendors/product/product_detail/gallery/gallery_screen.dart';
import 'package:client_tggt/screen/vendors_list/vendors_binding.dart';
import 'package:client_tggt/screen/vendors_list/vendors_screen.dart';
import 'package:client_tggt/shared/widget/errorpage/something_went_wrong.dart';
import 'package:get/route_manager.dart';

class AppScreen {
  static var list = [
    GetPage(
        name: AppRoutes.splashScreen,
        page: () => const SplashScreen(
              isFristLoad: false,
            ),
        binding: SplashBinding()),
    GetPage(
        name: AppRoutes.main,
        page: () => const MainScreen(),
        binding: MainBinding()),
    GetPage(
        name: AppRoutes.vendorListScreen,
        page: () => const VendorMainScreen(),
        binding: VendorsMainBinding()),
    GetPage(name: AppRoutes.login, page: () => const SigninScreen()),
    GetPage(name: AppRoutes.signup, page: () => const SignupScreen()),
    GetPage(
        name: AppRoutes.forgotPassword,
        page: () => const ForgotPasswordScreen()),
    GetPage(name: AppRoutes.verify, page: () => const VerifyScreen()),
    GetPage(
        name: AppRoutes.seachVendor, page: () => const SearchVendorScreen()),
    GetPage(
        name: AppRoutes.search,
        page: () => SearchScreen(),
        binding: SearchBinding()),
    GetPage(
        name: AppRoutes.filterVendors,
        page: () => FilterVendorsScreen(
              isFilterByCity: false,
            ),
        binding: FilterVendorsBinding()),
    GetPage(
        name: AppRoutes.errorScreen,
        page: () => const SomethingWentWrongScreen()),
    GetPage(
        name: AppRoutes.vendorScreen,
        page: () => const VendorsScreen(),
        binding: VendorsBinding()),
    // GetPage(
    //     name: AppRoutes.vendorDetail,
    //     page: () => const VendorsDetailScreen(),
    //     binding: VendorsDetailBinding()),
    GetPage(
        name: AppRoutes.activity,
        page: () => ActivityScreen(),
        binding: ActivityBinding()),
    GetPage(
        name: AppRoutes.activityDetail,
        page: () => ActivityDetailScreen(id: "", isFromQr: false),
        binding: ActivityDetailBinding()),
    GetPage(
        name: AppRoutes.history,
        page: () => const HistoryScreen(),
        binding: HistoryBinding()),
    GetPage(
        name: AppRoutes.bookingDetail,
        page: () => BookingDetailScreen(),
        binding: BookingDetailBinding()),
    GetPage(
      name: AppRoutes.languageScreen,
      page: () => const LanguageScreen(),
    ),
    GetPage(
      name: AppRoutes.serviceItemGallery,
      page: () => const ServiceItemGalleryScreen(),
    )
  ];
}
