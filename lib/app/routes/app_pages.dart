// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../modules/complaint/bindings/complaint_binding.dart';
import '../modules/complaint/views/complaint_view.dart';
import '../modules/contract/bindings/contract_binding.dart';
import '../modules/contract/views/contract_view.dart';
import '../modules/custom_payment/bindings/custom_payment_binding.dart';
import '../modules/custom_payment/views/custom_payment_view.dart';
import '../modules/delegation/bindings/delegation_binding.dart';
import '../modules/delegation/views/delegation_view.dart';
import '../modules/forget/bindings/forget_binding.dart';
import '../modules/forget/views/forget_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/filter_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/search_view.dart';
import '../modules/locations/bindings/locations_binding.dart';
import '../modules/locations/views/locations_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main_home_page/bindings/main_home_page_binding.dart';
import '../modules/main_home_page/views/main_home_page_view.dart';
import '../modules/message/bindings/message_binding.dart';
import '../modules/message/views/message_view.dart';
import '../modules/musaneda/bindings/musaneda_binding.dart';
import '../modules/musaneda/views/musaneda_view.dart';
import '../modules/musaneda/views/resume_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/order/bindings/order_binding.dart';
import '../modules/order/views/order_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/technical_support/bindings/technical_support_binding.dart';
import '../modules/technical_support/views/technical_support_view.dart';
import '../modules/transfer_sponsorship/bindings/transfer_sponsorship_binding.dart';
import '../modules/transfer_sponsorship/views/transfer_sponsorship_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;
  static const MAIN = Routes.HOME;
  static const MAIN_HOME_PAGE = Routes.MAIN_HOME_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.FORGET,
      page: () => const ForgetView(),
      binding: ForgetBinding(),
    ),
    GetPage(
      name: _Paths.MUSANEDA,
      page: () => const MusanedaView(),
      binding: MusanedaBinding(),
    ),
    GetPage(
      name: _Paths.CONTRACT,
      page: () => const ContractView(),
      binding: ContractBinding(),
    ),
    GetPage(
      name: _Paths.FILTER,
      page: () => const FilterView(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(isReal: false),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DELEGATION,
      page: () => const DelegationView(),
      binding: DelegationBinding(),
    ),
    GetPage(
      name: _Paths.LOCATIONS,
      page: () => const LocationsView(),
      binding: LocationsBinding(),
    ),
    GetPage(
      name: _Paths.COMPLAINT,
      page: () => const ComplaintView(),
      binding: ComplaintBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => const OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_HOME_PAGE,
      page: () => const MainHomePageView(),
      binding: MainHomePageBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOM_PAYMENT,
      page: () => const CustomPaymentView(),
      binding: CustomPaymentBinding(),
    ),
    GetPage(
      name: _Paths.RESUME,
      page: () => const ResumeView(),
      binding: MusanedaBinding(),
    ),
    // GetPage(
    //   name: _Paths.CV,
    //   page: () => const CvView(),
    //   binding: CvBinding(),
    // ),
    GetPage(
      name: _Paths.MESSAGE,
      page: () => const MessageView(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: _Paths.TRANSFER_SPONSORSHIP,
      page: () => const TransferSponsorshipView(),
      binding: TransferSponsorshipBinding(),
    ),
    GetPage(
      name: _Paths.TECHNICAL_SUPPORT,
      page: () => const TechnicalSupportView(),
      binding: TechnicalSupportBinding(),
    ),
  ];
}
