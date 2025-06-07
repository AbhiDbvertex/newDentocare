import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dentocoreauth/data/api/apiclient.dart';

class AuthRepository extends GetxService {
  final ApiClient apiClient;

  AuthRepository({required this.apiClient});

  Future<Response> login(Map body) async {
    return await apiClient.login("/api/login",body);
  }

  Future<Response> loginByGoogle(Map body) async {
    return await apiClient.loginByGoogle("/api/google_login",body);
  }

  Future<Response> Signup(String name,String email,String address,String mobile,String password, String dob) async {
    return await apiClient.signUp("/api/signup",name,email,address,mobile,password,dob);
  }

  Future<Response> resendOtp(String email)async{
    return await apiClient.resendOtp("/api/resend_otp",email);
  }

  Future<Response> verifyOtp(String email,String otp)async{
    return await apiClient.verifyOtp("/api/verifyotp",email,otp);
  }

  Future<Response> forgotPassword(String email)async{
    return await apiClient.forgotPassword("/api/forget_password",email);
  }

  Future<Response> createPassword(String email,String password,String confirm_password,)async{
    return await apiClient.createPassword("/api/forget_password_post",email,password,confirm_password);
  }
}
