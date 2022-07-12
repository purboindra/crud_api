import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:learn_api/app/data/user_model.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final homeController = Get.find<HomeController>();
  var dataList = <UserModel>[].obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<UserModel>>(
          future: controller.getResult(),
          // initialData: dataList,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("ERROR"),
              );
            }
            if (snapshot.hasData) {
              var data = snapshot.data;
              dataList.value = data!;
              if (dataList.isNotEmpty) {
                return Obx(
                  () => ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onLongPress: () {
                          deleteData(dataList[index].id!);
                        },
                        onTap: () {
                          showData(dataList[index].id!);
                        },
                        child: ListTile(
                          title: Text("${dataList[index].nama}"),
                          subtitle: Text("${dataList[index].quote}"),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: Center(
          child: Icon(
            CupertinoIcons.add,
            size: 32,
          ),
        ),
        onPressed: () async {
          addData();
        },
      ),
    );
  }

  void addData() async {
    RxBool response = await homeController.updateData(
        "Alexxxx Johnn", "avatar", "alamat", "email", "pekerjaan", "quote");

    if (response.value == true) {
      dataList.value = await homeController.getResult();
    }
  }

  void showData(String id) async {
    UserModel response = await homeController.singleData(id);
    log("data = ${response.nama} ${response.email}");
  }

  void deleteData(String id) async {
    RxBool response = await homeController.deleteData(id);
    if (response.value == true) {
      dataList.value = await homeController.getResult();
    }
  }
}
