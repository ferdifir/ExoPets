import 'package:exopets/module/admin/admin_page.dart';
import 'package:exopets/module/auth/forgot_password.dart';
import 'package:exopets/module/auth/login_page.dart';
import 'package:exopets/module/auth/register_page.dart';
import 'package:exopets/module/checkout/cart_page.dart';
import 'package:exopets/module/checkout/checkout_page.dart';
import 'package:exopets/module/dashboard/dashboard_page.dart';
import 'package:exopets/module/profile/edit_profile.dart';
import 'package:exopets/module/dashboard/widget/privacy_policy.dart';
import 'package:exopets/module/dashboard/widget/term_and_condition.dart';
import 'package:exopets/module/profile/profile_page.dart';
import 'package:exopets/module/search/search_page.dart';
import 'package:exopets/module/splash/splash_screen.dart';
import 'package:exopets/module/store/add_product.dart';
import 'package:exopets/module/store/create_store.dart';
import 'package:exopets/module/store/store_page.dart';
import 'package:exopets/module/transaction/transaction_page.dart';
import 'package:exopets/module/wishlist/wishlist_page.dart';
import 'package:exopets/routes/app_routes.dart';
import 'package:get/get.dart';


class Pages {
  static List<GetPage> pages = [
    GetPage(name: Routes.SPLASH, page: () => SplashScreen()),
    GetPage(name: Routes.LOGIN, page: () => const LoginPage()),
    GetPage(name: Routes.REGISTER, page: () => RegisterPage()),
    GetPage(name: Routes.FORGOT_PASSWORD, page: () => ForgotPasswordPage()),
    GetPage(name: Routes.DASHBOARD, page: () => DashboardPage()),
    GetPage(name: Routes.CHECKOUT, page: () => CheckoutPage()),
    GetPage(name: Routes.WISHLIST, page: () => WishlistPage()),
    GetPage(name: Routes.TRANSACTION, page: () => TransactionPage()),
    GetPage(name: Routes.PROFILE, page: () => const ProfilePage()),
    GetPage(name: Routes.STORE, page: () => StorePage()),
    GetPage(name: Routes.ADD_PRODUCT, page: () => const AddProductPage()),
    GetPage(name: Routes.ADMIN, page: () => const AdminPage()),
    GetPage(name: Routes.PRIVACY_POLICY, page: () => const PrivacyPolicy()),
    GetPage(name: Routes.TERMS_CONDITIONS, page: () => const TermAndCondition()),
    GetPage(name: Routes.EDIT_PROFILE, page: () => const EditProfile()),
    GetPage(name: Routes.CREATE_STORE, page: () => CreateStore()),
    GetPage(name: Routes.CART, page: () => CartPage()),
    GetPage(name: Routes.SEARCH, page: () => const SearchPage()),
  ];
}