import 'package:day_count/controller/controller.dart';
import 'package:get/get.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkController());
    Get.put(WorkController());
  }
}
