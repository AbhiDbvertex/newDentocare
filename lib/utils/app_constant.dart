import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../pages/payment/payment.dart';
import '../pages/video/video.dart';
import 'mycolor.dart';

class AppConstant {
  static String logo_url =
      "https://work.dbvertex.com/dentist1/assets/images/logo.png";
  static String user_id = "";
  static final String MOBILE_ERROR = "Please fill valid mobile number.";
  static final String PASSWORD_ERROR = "Please fill valid password.";
  static final String COUNTRY_ERROR = "Please select country.";
  static final String OTP_ERROR = "OTP didn't match.";
  static final String BLANK_ERROR = "OTP didn't match.";
  static final String FETCH_MOBILE = "Couldn't fetch mobile number.";

  static final String TEXT_HEAD_OTP = "OTP";
  static final String TEXT_CON_NEW_PASSWORD = "Confirm New Password";
  static final String REM_ME = "Remember Me ?";
  static final String FORGOT_PW = "Forgot Password ?";
  static final String EMAIL_ADD = "Email Address";
  static final String PASSWORD = "Password";

  static final String TEXT_NEW_PASSWORD = "New Password";
  static final String TEXT_CONTACT_NUMBER = "Contact Number";

  static final double APP_NORMAL_PADDING = 8.00;
  static final double APP_LARGE_PADDING = 14.00;
  static final double APP_EXTRA_LARGE_PADDING = 24.00;

  static final double SMALL_TEXT_SIZE = 8.00;
  static final double MEDIUM_TEXT_SIZE = 10.00;
  static final double LOCATION_TEXT_SIZE = 12.00;
  static final double SMALL_SIZE = 14.00;
  static final double EXTRA_MEDIUM_SIZE = 16.00;

  static final double MEDIUM_SIZE = 20.00;
  static final double HEADLINE_SIZE = 20.00;
  static final double LARGE_SIZE = 28.00;

  static final double TEXT_HEAD_WIDTH = 270;
  static final double TEXT_HEAD_HIGHT = 41;

  static final String ERROR_NEW_PASSWORD = "Please enter valid new password.";
  static final String ERROR_CONFIRM_NEW_PASSWORD =
      "Please enter valid confirm new password.";
  static final String ERROR_PASSWORD_MATCH = "Password didn't match";
  static final String ERROR_EMAIL = "Please enter valid email address.";

  static final String LOGIN_HEAD = "Login";
  static final String PROFILE_HEAD = "My Profile";
  static final String SIGNUP_NAME = "Signup";
  static final String FORGOT_PASSWORD_HEAD = "Forgot Password";

  static final String REGISTER = "Register";

  static final String SUBMIT = "Submit";
  static final String UPDATE = "Update";
  static final String CHAT = "Chat";
  static final String CHATLIST = "Chat List";

  static final String HINT_TEXT_EMAIL = "Enter Your Email Address";
  static final String HINT_TEXT_NAME = "Enter Your Full Name";

  static final String HINT_TEXT_MOBILE = "Enter Your Mobile Number";

  static final String LOGIN_EMAIL_TEXT = "E-mail/Mobile";

  static final String HINT_TEXT_PASSWORD = "Enter Your Password";
  static final String LOGIN_HEAD_TEXT_PASSWORD = "Enter Your Password";
  static final String HINT_TEXT_OTP = "Enter OTP";
  static final String HINT_TEXT_PASS = "Enter New Password";
  static final String HINT_TEXT_CON_PASSWORD = "Enter Confirm Password";
  static final String HINT_TEXT_NEW_CON_PASSWORD = "Enter New Confirm Password";
  static final String HINT_TEXT_CONTACT_NUMBER = "Enter Your Contact Number";

  static final String TEXT_PASS = "New Password";
  static final String TEXT_CON_PASSWORD = "Confirm New Password";
  static final String TEXT_OTP = "Otp";
  static final String TEXT_MOBILE_NUMBER = "Mobile Number";
  static final String TEXT_NAME = "Full Name";
  static final String TEXT_MOBILE = "Enter Your Mobile";
  static final String TEXT_PASSWORD = "Enter Your Password";
  static final String TEXT_OTP_MESSSAGE =
      "Enter your OTP received on your registerd email";
  static final String TEXT_OTP_HEAD = "Enter OTP";
  static final String TEXT_EMAIL = "Email";
  static final String TEXT_HEAD_CHANGE_PW = "Change Password";
  static final String TEXT_HEAD_NOTIFICATION = "Notification";

  static const String APP_NAME = "Pearllinedentocare";

    static final String BASE_URL = "https://work.dbvertex.com/dentist1";

  static final String LOGOUT_ENDPOINT = "/api/logout/";

  static final String REG_ENDPOINT = "/api/webservice/registration";
  static final String LOG_ENDPOINT = "/api/webservice/login";
  static final String OTP_ENDPOINT = "/api/webservice/verifyotp";
  static final String LOGIN_ENDPOINT = "/api/webservice/login/";
  static final String GET_PROFILE_ENDPOINT = "/api/webservice/profile/";

  static final String FORGOT_PW_ENDPOINT = "/api/webservice/forget_password";
  static final String CREATE_PW_ENDPOINT = "/api/webservice/forgot_password";
  static final String RESEND_OTP_ENDPOINT = "/api/webservice/resendotp";
  static final String CHANGE_PW_ENDPOINT = "/api/webservice/change_password";

  static final String UPDATE_PROFILE_ENDPOINT =
      "/api/webservice/update_profile";
  static final String ALLPOST_ENDPOINT = "/api/webservice/allpost";
  static final String MYPOST_ENDPOINT = "/api/webservice/mypost/";
  static final String NEWS_ENDPOINT = "/api/webservice/news";
  static final String CHATLIST_ENDPOINT = "/api/webservice/chatlist/";
  static final String CHATMSG_ENDPOINT = "/api/webservice/chatmessage/";
  static final String POST_ENDPOINT = "/api/webservice/post";
  static final String POST_FILTER = "/api/webservice/fillter";

  static final String POST_VERIFY = "/api/webservice/verifyotp";
  static final String POST_RESENDOTP = "/api/webservice/resendotp";
  static final String POST_FORGET_PASSWORD = "/api/webservice/forget_password";
  static final String TEXT_HEAD_CREATE_PASSWORD = "Create Password";

  static final Gradient BUTTON_COLOR = LinearGradient(colors: [
    MyColor.BUTTON_GRADIENT_START_COLOR,
    MyColor.BUTTON_GRADIENT_END_COLOR,
  ], begin: Alignment.centerLeft, end: Alignment.centerRight);

  static final Gradient SETTING_BUTTON_COLOR = LinearGradient(colors: [
    MyColor.SETTING_GRADIENT_START_COLOR,
    MyColor.SETTING_GRADIENT_END_COLOR,
  ], begin: Alignment.centerLeft, end: Alignment.centerRight);

  static final Gradient Notification_gradient = LinearGradient(colors: [
    Color.fromRGBO(186, 247, 255, 1),
    Color.fromRGBO(139, 167, 241, 0.29)
  ], begin: Alignment.topLeft, end: Alignment.topRight);

  static final Gradient LOGOUT_SETTING_BUTTON_COLOR = LinearGradient(colors: [
    MyColor.LOGOUT_BUTTON_GRADIENT_START_COLOR,
    MyColor.LOGOUT_BUTTON_GRADIENT_END_COLOR,
  ], begin: Alignment.centerLeft, end: Alignment.centerRight);

  static final Gradient Book_BG = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xff0faac0), Color(0x7affffff)],
  );

  static final Gradient paitent_1_bg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromRGBO(137, 62, 156, 1), Color.fromRGBO(248, 43, 115, 1)],
  );

  static final Gradient paitent_2_bg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromRGBO(84, 138, 216, 1), Color.fromRGBO(138, 75, 211, 1)],
  );

  static final Gradient paitent_3_bg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromRGBO(211, 150, 70, 1), Color.fromRGBO(204, 204, 205, 1)],
  );

  static final Gradient paitent_4_bg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromRGBO(243, 62, 98, 1), Color.fromRGBO(247, 147, 52, 1)],
  );

  static final Gradient paitent_5_bg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromRGBO(214, 35, 234, 1), Color.fromRGBO(204, 204, 204, 1)],
  );

  static final double BUTTON_WIDTH = 289.00;
  static final double BUTTON_HIGHT = 44.00;

  static final EDITTEXT_BOX_WIDTH = 329.00;
  static final double EDITTEXT_BOX_HIGHT = 45; //design 70 too big

  static final Gradient bg_test = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(255, 255, 255, 1),
        Color.fromRGBO(114, 196, 255, 0.69)
      ]);

  static final String TITLE_TEXT_PROFILE = "Profile";

  static final String TITLE_TEXT_SETTING = "Setting";
  static final String TITLE_TEXT_MY_PROFILE = "My Profile";
  static final String TITLE_TEXT_CHANGE_PASSWORD = "Change Password";
  static final String TITLE_TEXT_NOTIFICATION = "Notification";
  static final String TITLE_TEXT_VIDEO = "Video";
  static final String TITLE_TEXT_APPOINTEMNT = "Appointment";
  static final String TITLE_TEXT_PRESCRIPTION = "Prescription";
  static final String TITLE_TEXT_PAY_HISTORY = "Payment History";
  static final String TITLE_TEXT_SERVICES = "Services";

  static final String TITLE_TEXT_ABOUTUS = "About Us";

  static final String TITLE_TEXT_PRIVACYPOLICY = "Privacy Policy";

  static signup_text(BuildContext? context) {
    return Expanded(
      child: Container(
        height: 25,
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account?",
                style: GoogleFonts.nunitoSans(
                    textStyle: Theme.of(context!).textTheme.displayLarge,
                    fontSize: AppConstant.SMALL_SIZE,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    color: MyColor.LOGIN_TEXT_HAVE_AC_COLOR)),
            Text(" Sign up",
                style: GoogleFonts.nunitoSans(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: AppConstant.SMALL_SIZE,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    color: MyColor.LOGIN_TEXT_SIGNUP_COLOR))
          ],
        )),
      ),
    );
  }

  static lgoin_text(BuildContext? context) {
    return Container(
      height: 25,
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Already Have Account?",
              style: GoogleFonts.nunitoSans(
                  textStyle: Theme.of(context!).textTheme.displayLarge,
                  fontSize: AppConstant.SMALL_SIZE,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  color: MyColor.LOGIN_TEXT_HAVE_AC_COLOR)),
          Text(
            " Login",
            style: GoogleFonts.nunitoSans(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: AppConstant.SMALL_SIZE,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                color: MyColor.LOGIN_TEXT_SIGNUP_COLOR),
          )
        ],
      )),
    );
  }

  static shadow() {
    return BoxDecoration(
      color: Colors.blue,
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: const Offset(
            5.0,
            5.0,
          ),
          blurRadius: 10.0,
          spreadRadius: 2.0,
        ), //BoxShadow
        BoxShadow(
          color: Colors.white,
          offset: const Offset(0.0, 0.0),
          blurRadius: 0.0,
          spreadRadius: 0.0,
        ), //
        // BoxShadow
      ],
    );
  }

  static whiteShadow() {
    return BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: const Offset(
            5.0,
            5.0,
          ),
          blurRadius: 10.0,
          spreadRadius: 2.0,
        ), //BoxShadow
        BoxShadow(
          color: Colors.white,
          offset: const Offset(0.0, 0.0),
          blurRadius: 0.0,
          spreadRadius: 0.0,
        ), //
        // BoxShadow
      ],
    );
  }

  static OpenSans(BuildContext? context, Color color) {
    return GoogleFonts.nunitoSans(
        textStyle: Theme.of(context!).textTheme.displayLarge,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: color);
  }

  static Lextendnew(BuildContext? context, Color color, double? size,
      [FontWeight? fontWeight]) {
    return GoogleFonts.lexend(
        textStyle: Theme.of(context!).textTheme.displayLarge,
        fontSize: size == null ? 10 : size,
        fontWeight: fontWeight ?? FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: color);
  }

  static TitleFont(
    BuildContext? context, [
    FontWeight? fontWeight,
  ]) {
    return GoogleFonts.abrilFatface(
      textStyle: Theme.of(context!).textTheme.displayLarge,
      fontSize: 20,
      fontWeight: fontWeight ?? FontWeight.w400,
      fontStyle: FontStyle.normal,
    );
  }

  static TitleFontService(
    BuildContext? context, [
    FontWeight? fontWeight,
  ]) {
    return GoogleFonts.abrilFatface(
      textStyle: Theme.of(context!).textTheme.displayLarge,
      fontSize: 15,
      fontWeight: fontWeight ?? FontWeight.w400,
      fontStyle: FontStyle.normal,
    );
  }

  static setData(String key, dynamic value) => GetStorage().write(key, value);

  static storePaymentInfo(String key, PaymentModel value) =>
      GetStorage().write(key, value);

  static String? getString(String key) => GetStorage().read(key);

  static PaymentModel getPaymentInfo(String key) => GetStorage().read(key);

  static void removeData(String key) => GetStorage().remove(key);

  // static HEADLINE_TEXT(String text, context) => GradientText(
  //       text,
  //       style: AppConstant.TitleFont(context),
  //       gradient: LinearGradient(colors: [
  //         Color.fromRGBO(30, 106, 161, 0.84),
  //         Color.fromRGBO(82, 106, 236, 1),
  //         Color.fromRGBO(30, 106, 161, 0.84),
  //       ]),
  //     );

  // static HEADLINE_TEXT_SERVICE(String text, context) => GradientText(
  //       text,
  //       style: AppConstant.TitleFontService(context),
  //       gradient: LinearGradient(colors: [
  //         MyColor.HEADLINE_TEXT_GRADIENT_START_COLOR,
  //         MyColor.HEADLINE_TEXT_GRADIENT_END_COLOR,
  //       ]),
  //     );

  static void save_data(String key, String val) async {
    await AppConstant.setData(key, val);
  }

  static String take_data(String key) {
    return AppConstant.getString(key).toString();
  }

  static final String dummy_text =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book";
}
