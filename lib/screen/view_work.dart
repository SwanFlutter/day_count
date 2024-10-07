import 'package:day_count/model/work_model.dart';
import 'package:day_count/screen/create_work.dart';
import 'package:day_count/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewWork extends StatelessWidget {
  final WorkModel work;

  const ViewWork(this.work, {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('کارهای ${work.name}', style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple[800],
        leading: const BackButton(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => CreateWork(workId: work.id!));
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: work.workHalves?.length == 0
                ? [
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.48),
                      child: const Center(child: Text('هیچ جزئیاتی برای نمایش وجود ندارد')),
                    )
                  ]
                : List.generate(
                    work.workHalves?.length ?? 0,
                    (index) {
                      return InkWell(
                        onTap: () {
                          workController.editWorkHalf(work.id!, work.workHalves![index].id!);
                        },
                        onLongPress: () {
                          workController.deleteWorkHalf(work.id!, work.workHalves![index].id!);
                        },
                        child: Card(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          margin: const EdgeInsets.all(10),
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title: Text(
                              work.workHalves![index].description!,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('تاریخ: ${work.workHalves![index].date} - ${work.workHalves![index].daysOfWeek}'),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
