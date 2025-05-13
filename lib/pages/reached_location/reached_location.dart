// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:get/get.dart';
// import 'package:location/location.dart';
// import 'package:dentocoreauth/utils/mycolor.dart';
// import 'package:permission_handler/permission_handler.dart'as NEWPERMISSION;
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../utils/app_constant.dart';
// import '../../utils/component_screen.dart';
//
// class ReachedLocation extends StatefulWidget {
//   const ReachedLocation({Key? key}) : super(key: key);
//
//   @override
//   State<ReachedLocation> createState() => _ReachedLocationState();
// }
//
// class _ReachedLocationState extends State<ReachedLocation> {
//
//   // Static location coordinates (replace with your clinic's actual coordinates)
//   final double staticLat = 22.7552; // Dummy: Delhi coordinates
//   final double staticLng = 75.8968;
//   final String staticLocationName = "Pearl Line Dentocare Clinic";
//
//   // Location package instance
//   final Location location = Location();
//
//   // Function to get current location and open Google Maps
//    static Future<void> openGoogleMapsRoute() async {
//     try {
//       // Check if location service is enabled
//       bool serviceEnabled = await location.serviceEnabled();
//       if (!serviceEnabled) {
//         serviceEnabled = await location.requestService();
//         if (!serviceEnabled) {
//           Get.snackbar("Error", "Location services are disabled.");
//           return;
//         }
//       }
//
//       // Check location permission
//       PermissionStatus permission = await location.hasPermission();
//       if (permission == PermissionStatus.denied) {
//         permission = await location.requestPermission();
//         if (permission != PermissionStatus.granted) {
//           Get.snackbar("Error", "Location permission denied.");
//           return;
//         }
//       }
//
//       // Get current location
//       LocationData? currentLocation;
//       try {
//         currentLocation = await _location.getLocation();
//       } catch (e) {
//         Get.snackbar("Error", "Failed to get current location: $e");
//         return;
//       }
//
//       if (currentLocation.latitude == null || currentLocation.longitude == null) {
//         Get.snackbar("Error", "Unable to retrieve current location.");
//         return;
//       }
//
//       // Generate Google Maps URL
//       final String googleMapsUrl =
//           "google.navigation:q=$staticLat,$staticLng&mode=d"; // Driving mode
//
//       // Launch Google Maps
//       final Uri uri = Uri.parse(googleMapsUrl);
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(uri, mode: LaunchMode.externalApplication);
//       } else {
//         // Fallback to browser
//         final String fallbackUrl =
//             "https://www.google.com/maps/dir/?api=1&destination=$staticLat,$staticLng";
//         final Uri fallbackUri = Uri.parse(fallbackUrl);
//         if (await canLaunchUrl(fallbackUri)) {
//           await launchUrl(fallbackUri);
//         } else {
//           Get.snackbar("Error", "Could not open Google Maps.");
//         }
//       }
//     } catch (e) {
//       Get.snackbar("Error", "An error occurred: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle(
//         statusBarColor: MyColor.primarycolor,
//         statusBarIconBrightness: Brightness.light,
//         statusBarBrightness: Brightness.light,
//         systemNavigationBarColor: Colors.transparent,
//       ),
//       child: Scaffold(
//         body: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               CustomAppBar(title: 'Service'),
//               // Get Directions Button
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 child: Bounceable(
//                   onTap: openGoogleMapsRoute,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       gradient: AppConstant.BUTTON_COLOR,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     height: 44,
//                     width: double.infinity,
//                     child: Center(
//                       child: Text(
//                         "Get Directions to $staticLocationName",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: AppConstant.MEDIUM_SIZE,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:dentocoreauth/utils/mycolor.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/app_constant.dart';
import '../../utils/component_screen.dart';

class ReachedLocation extends StatefulWidget {
  const ReachedLocation({Key? key}) : super(key: key);

  @override
  State<ReachedLocation> createState() => _ReachedLocationState();

  // 🧠 Static method & data here
  static final Location _location = Location();
  static final double staticLat = 12.7321115;
  static final double staticLng = 77.8253165;
  static final String staticLocationName = "Pearl Line Dentocare Clinic";

  static Future<void> openGoogleMapsRoute() async {
    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          Get.snackbar("Error", "Location services are disabled.");
          return;
        }
      }

      PermissionStatus permission = await _location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await _location.requestPermission();
        if (permission != PermissionStatus.granted) {
          Get.snackbar("Error", "Location permission denied.");
          return;
        }
      }

      LocationData currentLocation;
      try {
        currentLocation = await _location.getLocation();
      } catch (e) {
        Get.snackbar("Error", "Failed to get current location: $e");
        return;
      }

      if (currentLocation.latitude == null || currentLocation.longitude == null) {
        Get.snackbar("Error", "Unable to retrieve current location.");
        return;
      }

      final String googleMapsUrl = "google.navigation:q=$staticLat,$staticLng&mode=d";

      final Uri uri = Uri.parse(googleMapsUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        final String fallbackUrl =
            "https://www.google.com/maps/dir/?api=1&destination=$staticLat,$staticLng";
        final Uri fallbackUri = Uri.parse(fallbackUrl);
        if (await canLaunchUrl(fallbackUri)) {
          await launchUrl(fallbackUri);
        } else {
          Get.snackbar("Error", "Could not open Google Maps.");
        }
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }
}

class _ReachedLocationState extends State<ReachedLocation> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: MyColor.primarycolor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomAppBar(title: 'Service'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Bounceable(
                  onTap: ReachedLocation.openGoogleMapsRoute,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppConstant.BUTTON_COLOR,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 44,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Get Directions to ${ReachedLocation.staticLocationName}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppConstant.MEDIUM_SIZE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
