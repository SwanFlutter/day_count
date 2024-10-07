import 'package:date_cupertino_bottom_sheet_picker/date_cupertino_bottom_sheet_picker.dart';
import 'package:day_count/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CreateWork extends StatelessWidget {
  final String workId;

  const CreateWork({required this.workId, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('افزودن کار', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple[800],
        leading: const BackButton(color: Colors.white),
      ),
      body: SizedBox(
        width: double.infinity,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              DatePickerPersian(
                firstDate: Jalali.now(),
                lastDate: Jalali(1450, 1, 1),
                selectedDate: Jalali.now(),
                onChanged: (date) {
                  workController.time = date;
                },
              ),
              const SizedBox(height: 15),
              TextField(
                controller: workController.daysOfWeek,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  labelText: 'چند شنبه است...',
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: workController.descriptionController,
                minLines: 4,
                maxLines: 6,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  labelText: 'توضیحات...',
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                height: 55,
                minWidth: size.width * 0.8,
                shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                color: Theme.of(context).primaryColorLight,
                onPressed: () {
                  workController.addWorkHalf(workId);
                  Get.back();
                },
                child: const Text('ثبت'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
