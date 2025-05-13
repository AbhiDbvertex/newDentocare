import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:dentocoreauth/data/repository/auth_repository/profile_repository.dart';
import 'package:dentocoreauth/utils/app_constant.dart';
import '../Utills/Utills.dart';
import '../models/auth_model/profile_dto.dart';

class ProfileController extends GetxController {
  final ProfileRepository profileRepository;

  ProfileController({required this.profileRepository});

  // late ProfileService profileService;
  var util = Utills();
  var name_profile = TextEditingController();
  var email_profile = TextEditingController();
  var contact_profile = TextEditingController();
  var _image = "".obs;

  RxString get image => _image;
  File? fimage1;

  bool validation() {
    if (name_profile.text.isEmpty) {
      util.showSnackBar("Alert", "Please enter name!", false);
      return false;
    } else if (email_profile.text.isEmpty) {
      util.showSnackBar("Alert", "Please enter email!", false);
      return false;
    } else if (contact_profile.text.isEmpty) {
      util.showSnackBar("Alert", "Please enter mobile number!", false);
      return false;
    } else {
      return true;
    }
  }

  Future<void> update_profile(
      String id, String name, String email, String mobile, File? img) async {
    if (validation() == false) {
      return;
    }

    util.startLoading();
    //  print("imageout"+img.toString());
    // print("imageout"+'data:image/png;base64,' +
    //     base64Encode(img!.readAsBytesSync()));
    var res = await http.post(
        Uri.parse(AppConstant.BASE_URL + AppConstant.UPDATE_PROFILE_ENDPOINT),
        body: <String, String>{
          "name": name,
          "email": email,
          "mobile": mobile,
          "user_id": id,
          'photo': img != null ? base64Encode(img!.readAsBytesSync()) : '',
        });
    if (res.statusCode == 200) {
      util.showFailProcess();
      var response = jsonDecode(res.body);
      if (response['status'] == true) {
        util.showSuccessProcess();
        util.showSnackBar("Alert", response['message'], true);
        return response;
      } else if (response['status' == false]) {
        util.showFailProcess();
        util.showSnackBar("Alert", "Something went wrong!", false);
        return null;
      }
    } else {
      util.showSnackBar("Alert", "failed", false);
      util.showFailProcess();
      return null;
    }
  }

  Future<void> updateprofile(String uid) async {
    if (validation() == false) {
      return null;
    }
    util.startLoading();
    var res = await profileRepository.updateProfile({
      "name": name_profile.text.toString(),
      "email": email_profile.text.toString(),
      "mobile": contact_profile.text.toString(),
      "id": uid
    });

    if (res.statusCode == 200 || res.statusCode == 201) {
      util.showFailProcess();
      var temp = jsonDecode(res.bodyString!);
      if (temp != null) {
        if (temp['message'].toString() != null) {
          Get.back();
          util.showSnackBar("Alert", temp['message'].toString(), true);
          //
        }
      }
    } else if (res.statusCode == 400) {
      util.showFailProcess();
      util.showSnackBar("Alert", "Something went wrong!", false);
    } else {
      util.showFailProcess();
      util.showSnackBar("Alert", "Something went wrong!", false);
    }
  }

  Future<ProfileDto?> getProfile(String uid) async {
    util.startLoading();

    var res = await profileRepository.getProfile(uid);
    if (res.statusCode == 200 || res.statusCode == 201) {
      util.showSuccessProcess();

      var temp = profileDtoFromJson(res.bodyString!);
      if (temp.status == true) {
        name_profile.text = temp.body.name.toString().capitalizeFirst!;
        email_profile.text = temp.body.email.toString();
        contact_profile.text = temp.body.mobile.toString();
        _image.value=temp.body.image;
        return temp;
      } else if (temp.status == false) {
        util.showSnackBar("Alert", temp.message.toString(), false);
      }
    } else if (res.statusCode == 400) {
      util.showSuccessProcess();
     // util.showSnackBar("Alert", "Somethig went wrong!", false);
    } else {
      util.showFailProcess();
    }
  }

  Future<void> updateprofileImage(String uid, File? img) async {
    util.startLoading();
    var res =
        await profileRepository.updateProfileImage({"id": uid, "photo": img});

    if (res.statusCode == 201 || res.statusCode == 200) {
      util.showFailProcess();
      var temp = jsonDecode(res.bodyString!);
      if (temp != null) {
        if (temp['message'].toString() != null) {
          util.showSnackBar("Alert", temp['message'].toString(), true);
        }
      }
    } else if (res.statusCode == 400) {
      util.showFailProcess();
      util.showSnackBar("Alert", "Something went wrong!", false);
    } else {
      util.showFailProcess();
      util.showSnackBar("Alert", "Something went wrong!", false);
    }
  }
}
