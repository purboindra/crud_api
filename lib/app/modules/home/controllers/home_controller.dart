import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:learn_api/app/data/user_model.dart';

class HomeController extends GetxController {
  // var isLoading = false.obs;

  Future<List<UserModel>> getResult() async {
    final url =
        Uri.parse("https://6283762138279cef71d77f41.mockapi.io/api/v1/data2");
    final response = await http.get(url);
    // isLoading.value == true;
//
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      List dataResponse = jsonResponse;

      // isLoading.value == false;
      return dataResponse.map((e) => UserModel.fromJson(e)).toList();
    } else {
      // isLoading.value == false;
      throw Exception("Oops.. something wrong");
    }
  }

  Future updateData(
    String? nama,
    String? avatar,
    String? alamat,
    String? email,
    String? pekerjaan,
    String? quote,
  ) async {
    var url = Uri.parse(
      "https://6283762138279cef71d77f41.mockapi.io/api/v1/data2",
    );
    final respon = await http.post(
      url,
      body: {
        "nama": nama,
        "avatar": avatar,
        "alamat": alamat,
        "email": email,
        "pekerjaan": pekerjaan,
        "quote": quote,
      },
    );

    if (respon.statusCode == 201) {
      print(respon.body);
      return true.obs;
    } else {
      throw Exception("Something wrong");
    }
  }

  Future<UserModel> singleData(String id) async {
    final url = Uri.parse(
        "https://6283762138279cef71d77f41.mockapi.io/api/v1/data2/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      UserModel jsonResponse = UserModel.fromJson(jsonDecode(response.body));
      return jsonResponse;
    } else {
      throw Exception("Something wrong");
    }
  }

  Future<RxBool> deleteData(String id) async {
    final url = Uri.parse(
        "https://6283762138279cef71d77f41.mockapi.io/api/v1/data2/$id");
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return true.obs;
    } else {
      throw Exception("Something wrong");
      // return false.obs;
    }
  }
}
