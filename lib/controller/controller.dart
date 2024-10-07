import 'package:day_count/model/work_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shamsi_date/shamsi_date.dart';

final GetStorage _storage = GetStorage();

class WorkController extends GetxController {
  Rx<WorkModel> work = WorkModel().obs;
  RxList<WorkModel> works = <WorkModel>[].obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController daysOfWeek = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late Jalali time;

  @override
  void onInit() {
    time = Jalali.now();
    loadWorksFromStorage(); // بارگذاری داده‌ها از GetStorage
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    daysOfWeek.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  // بارگذاری داده‌ها از GetStorage
  void loadWorksFromStorage() {
    List<dynamic>? storedWorks = _storage.read<List<dynamic>>('works');
    if (storedWorks != null && storedWorks.isNotEmpty) {
      works.assignAll(storedWorks.map((json) => WorkModel.fromJson(json)).toList());
    }
  }

  // ذخیره‌سازی داده‌ها در GetStorage
  void saveWorksToStorage() {
    _storage.write('works', works.map((work) => work.toJson()).toList());
    debugPrint('works saved to storage${_storage.read('works') ?? []}');
  }

  void removeWorkFromStorage(String workId) {
    // حذف کار از GetStorage
    final storedWorks = _storage.read<List<Map<String, dynamic>>>('works') ?? [];
    storedWorks.removeWhere((work) => work['id'] == workId);
    _storage.write('works', storedWorks);
  }

  void createNewWork() {
    String workId = UniqueKey().toString();
    WorkModel newWork = WorkModel(
      id: workId,
      name: nameController.text,
      workHalves: <WorkHalf>[].obs,
    );

    works.add(newWork);
    saveWorksToStorage(); // ذخیره‌سازی داده‌ها در GetStorage با استفاده از ک;
    nameController.clear();
  }

  void addWorkHalf(String workId) {
    String halfId = UniqueKey().toString();
    WorkHalf newHalf = WorkHalf(
      id: halfId,
      date: '${time.year}/${time.month}/${time.day}',
      description: descriptionController.text,
      daysOfWeek: daysOfWeek.text,
    );

    // واکنش‌گرا کردن افزودن به لیست
    works.firstWhere((element) => element.id == workId).workHalves?.add(newHalf);
    saveWorksToStorage();
    descriptionController.clear();
    daysOfWeek.clear();
  }

  void editWork(String workId) {
    Get.defaultDialog(
      title: "ویرایش کار",
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "نام جدید کار",
            ),
          ),
        ],
      ),
      confirm: MaterialButton(
        color: Colors.green,
        child: const Text('تایید', style: TextStyle(color: Colors.white)),
        onPressed: () {
          works.firstWhere((element) => element.id == workId).name = nameController.text;
          nameController.clear();
          Get.back(); // بستن دیالوگ
        },
      ),
      cancel: MaterialButton(
        color: Colors.red,
        child: const Text('لغو', style: TextStyle(color: Colors.white)),
        onPressed: () {
          Get.back(); // بستن دیالوگ
        },
      ),
    );
    saveWorksToStorage();
  }

  void deleteWork(String workId) {
    Get.defaultDialog(
      title: "حذف کار",
      content: const Text("آیا مطمئن هستید که می‌خواهید این کار را حذف کنید؟"),
      confirm: MaterialButton(
        color: Colors.red,
        child: const Text('حذف', style: TextStyle(color: Colors.white)),
        onPressed: () {
          works.removeWhere((element) => element.id == workId);
          removeWorkFromStorage(workId);
          saveWorksToStorage();
          Get.back(); // بستن دیالوگ
        },
      ),
      cancel: MaterialButton(
        color: Colors.grey,
        child: const Text('لغو', style: TextStyle(color: Colors.white)),
        onPressed: () {
          Get.back(); // بستن دیالوگ
        },
      ),
    );
    saveWorksToStorage();
  }

  void editWorkHalf(String workId, String workHalfId) {
    WorkHalf workHalf = works.firstWhere((element) => element.id == workId).workHalves!.firstWhere((half) => half.id == workHalfId);

    // مقداردهی اولیه کنترلرها با مقادیر قبلی
    descriptionController.text = workHalf.description!;
    daysOfWeek.text = workHalf.daysOfWeek!;

    Get.defaultDialog(
      title: "ویرایش جزئیات کار",
      content: Column(
        children: [
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "توضیحات جدید",
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: daysOfWeek,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "روزهای هفته جدید",
            ),
          ),
        ],
      ),
      confirm: MaterialButton(
        color: Colors.green,
        child: const Text('تایید', style: TextStyle(color: Colors.white)),
        onPressed: () {
          // به‌روزرسانی مقادیر
          workHalf.description = descriptionController.text;
          workHalf.daysOfWeek = daysOfWeek.text;

          descriptionController.clear();
          daysOfWeek.clear();
          Get.back(); // بستن دیالوگ
        },
      ),
      cancel: MaterialButton(
        color: Colors.red,
        child: const Text('لغو', style: TextStyle(color: Colors.white)),
        onPressed: () {
          Get.back(); // بستن دیالوگ
        },
      ),
    );
  }

  void deleteWorkHalf(String workId, String workHalfId) {
    Get.defaultDialog(
      title: "حذف جزئیات کار",
      content: const Text("آیا مطمئن هستید که می‌خواهید این جزئیات کار را حذف کنید؟"),
      confirm: MaterialButton(
        color: Colors.red,
        child: const Text('حذف', style: TextStyle(color: Colors.white)),
        onPressed: () {
          // حذف WorkHalf از workHalves
          works.firstWhere((element) => element.id == workId).workHalves?.removeWhere((half) => half.id == workHalfId);

          removeWorkFromStorage(workId);

          Get.back(); // بستن دیالوگ
        },
      ),
      cancel: MaterialButton(
        color: Colors.grey,
        child: const Text('لغو', style: TextStyle(color: Colors.white)),
        onPressed: () {
          Get.back(); // بستن دیالوگ
        },
      ),
    );
  }
}
