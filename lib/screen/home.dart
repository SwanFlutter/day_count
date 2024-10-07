import 'package:day_count/controller/controller.dart';
import 'package:day_count/screen/view_work.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

WorkController workController = Get.find<WorkController>();

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('روز شمار کار', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple[800],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: workController.works.isEmpty
                  ? [
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.48),
                        child: const Center(child: Text('هیچ کاری برای نمایش وجود ندارد', style: TextStyle(fontWeight: FontWeight.bold))),
                      )
                    ]
                  : List.generate(
                      workController.works.length,
                      (index) {
                        return InkWell(
                          onTap: () {
                            // انتقال به صفحه‌ای برای افزودن WorkHalf
                            Get.to(() => ViewWork(workController.works[index]), fullscreenDialog: true);
                          },
                          onLongPress: () {
                            // حذف کار
                            workController.deleteWork(workController.works[index].id!);
                          },
                          onDoubleTap: () {
                            // ویرایش کار
                            workController.editWork(workController.works[index].id!);
                          },
                          child: Card(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            margin: const EdgeInsets.all(10),
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: Text(workController.works[index].name!, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text('${workController.works[index].workHalves?.length ?? 0} کار اضافه شده', style: const TextStyle(fontWeight: FontWeight.bold)),
                              trailing: const Icon(Icons.chevron_right),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            title: 'افزودن کارفرما',
            content: SizedBox(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: TextField(
                  controller: workController.nameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    labelText: "کارفرما",
                  ),
                ),
              ),
            ),
            confirm: MaterialButton(
              height: 55,
              minWidth: 170,
              color: Colors.purple[800],
              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              onPressed: () {
                workController.createNewWork();
                Get.back();
              },
              child: const Text('تایید', style: TextStyle(color: Colors.white)),
            ),
            cancel: MaterialButton(
              height: 55,
              color: Colors.white,
              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              onPressed: () {
                Get.back();
              },
              child: const Text('لغو', style: TextStyle(color: Colors.purple)),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
