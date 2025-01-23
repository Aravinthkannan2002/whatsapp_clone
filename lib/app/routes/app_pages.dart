import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/calls/bindings/calls_binding.dart';
import '../modules/home/calls/views/calls_view.dart';
import '../modules/home/chat/bindings/chat_binding.dart';
import '../modules/home/chat/views/chat_view.dart';
import '../modules/home/group/bindings/group_binding.dart';
import '../modules/home/group/views/group_view.dart';
import '../modules/home/status/bindings/status_binding.dart';
import '../modules/home/status/views/status_view.dart';
import '../modules/home/userchatview/bindings/userchatview_binding.dart';
import '../modules/home/userchatview/views/userchatview_view.dart';
import '../modules/home/views/home_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.GROUP,
          page: () => const GroupView(),
          binding: GroupBinding(),
        ),
        GetPage(
          name: _Paths.CHAT,
          page: () => ChatView(),
          binding: ChatBinding(),
        ),
        GetPage(
          name: _Paths.STATUS,
          page: () => const StatusView(),
          binding: StatusBinding(),
        ),
        GetPage(
          name: _Paths.CALLS,
          page: () => const CallsView(),
          binding: CallsBinding(),
        ),
       GetPage(
  name: _Paths.USERCHATVIEW,
  page: () => UserchatviewView(user: Get.arguments), // Pass user via arguments
  binding: UserchatviewBinding(),
),

      ],
    ),
  ];
}
