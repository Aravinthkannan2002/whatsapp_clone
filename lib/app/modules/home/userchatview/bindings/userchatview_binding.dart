import 'package:get/get.dart';

import '../controllers/userchatview_controller.dart';

class UserchatviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserchatviewController>(
      () => UserchatviewController(),
    );
  }
}
