import 'package:day_count/binding/bindings.dart';
import 'package:day_count/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      textDirection: TextDirection.rtl,
      initialBinding: MyBindings(),
      onInit: () {
        workController.onInit();
        workController.loadWorksFromStorage();
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
