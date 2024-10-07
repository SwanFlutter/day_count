// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:get/get.dart';

class WorkModel {
  String? id;
  String? name;
  RxList<WorkHalf>? workHalves = <WorkHalf>[].obs;

  WorkModel({
    this.id,
    this.name,
    this.workHalves,
  });

  // متد تبدیل به JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'workHalves': workHalves?.map((e) => e.toJson()).toList(),
    };
  }

  // متد تبدیل از JSON
  factory WorkModel.fromJson(Map<String, dynamic> json) {
    return WorkModel(
      id: json['id'],
      name: json['name'],
      workHalves: (json['workHalves'] as List<dynamic>?)?.map((e) => WorkHalf.fromJson(e)).toList().obs, // تبدیل به RxList
    );
  }
}

class WorkHalf {
  String? id;
  String? date;
  String? description;
  String? daysOfWeek;

  WorkHalf({
    required this.id,
    this.date,
    this.description,
    this.daysOfWeek,
  });

  // متد تبدیل به JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'description': description,
      'daysOfWeek': daysOfWeek,
    };
  }

  // متد تبدیل از JSON
  factory WorkHalf.fromJson(Map<String, dynamic> json) {
    return WorkHalf(
      id: json['id'],
      date: json['date'],
      description: json['description'],
      daysOfWeek: json['daysOfWeek'],
    );
  }
}
