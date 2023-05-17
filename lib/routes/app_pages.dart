import 'package:exopets/module/admin/admin_page.dart';
import 'package:exopets/module/auth/forgot_password.dart';
import 'package:exopets/module/auth/login_page.dart';
import 'package:exopets/module/auth/register_page.dart';
import 'package:exopets/module/checkout/checkout_page.dart';
import 'package:exopets/module/dashboard/dashboard_page.dart';
import 'package:exopets/module/dashboard/widget/privacy_policy.dart';
import 'package:exopets/module/dashboard/widget/term_and_condition.dart';
import 'package:exopets/module/profile/profile_page.dart';
import 'package:exopets/module/store/add_product.dart';
import 'package:exopets/module/store/store_page.dart';
import 'package:exopets/module/transaction/transaction_page.dart';
import 'package:exopets/module/wishlist/wishlist_page.dart';
import 'package:exopets/routes/app_routes.dart';
import 'package:flutter/material.dart';


class Pages {
  static Map<String, Widget Function(BuildContext)> pages = {
    Routes.LOGIN: (context) => const LoginPage(),
    Routes.REGISTER: (context) => const RegisterPage(),
    Routes.FORGOT_PASSWORD: (context) => const ForgotPasswordPage(),
    Routes.DASHBOARD: (context) => const DashboardPage(),
    Routes.CHECKOUT: (context) => const CheckoutPage(),
    Routes.WISHLIST: (context) => const WishlistPage(),
    Routes.TRANSACTION: (context) => const TransactionPage(),
    Routes.PROFILE: (context) => const ProfilePage(),
    Routes.STORE: (context) => const StorePage(),
    Routes.ADD_PRODUCT: (context) => const AddProductPage(),
    Routes.ADMIN: (context) => const AdminPage(),
    Routes.PRIVACY_POLICY: (context) => const PrivacyPolicy(),
    Routes.TERMS_CONDITIONS: (context) => const TermAndCondition(),
  };
}