import 'package:get/get.dart';
import 'package:dentocoreauth/data/api/apiclient.dart';

class ProfileRepository extends GetxService {
  final ApiClient apiclient;

  ProfileRepository({required this.apiclient});

  Future<Response> getProfile(String id) async {
    return apiclient.getProfile("/api/profile_get/${id}");
  }

  Future<Response> updateProfile(Map body) async {
    return apiclient.updateProfile("/api/profile_upadte", body);
  }

  Future<Response> updateProfileImage(Map body) async {
    return apiclient.updateProfileImage("/api/profileimage_upadte", body);
  }
}
