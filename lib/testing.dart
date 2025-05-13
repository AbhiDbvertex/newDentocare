// // import 'package:flutter/material.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // // import 'package:firebase_database/firebase_database.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:firebase_database/firebase_database.dart';
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: UserFormScreen(),
// //     );
// //   }
// // }
// //
// // class UserFormScreen extends StatefulWidget {
// //   @override
// //   _UserFormScreenState createState() => _UserFormScreenState();
// // }
// //
// // class _UserFormScreenState extends State<UserFormScreen> {
// //   final nameCtrl = TextEditingController();
// //   final emailCtrl = TextEditingController();
// //   final addressCtrl = TextEditingController();
// //   final pincodeCtrl = TextEditingController();
// //   final propertySizeCtrl = TextEditingController();
// //
// //   String location = 'Fetching...';
// //
// //   void getCurrentLocation() async {
// //     bool serviceEnabled;
// //     LocationPermission permission;
// //
// //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       setState(() {
// //         location = "Location not enabled";
// //       });
// //       return;
// //     }
// //
// //     permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.deniedForever ||
// //         permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //     }
// //
// //     Position pos = await Geolocator.getCurrentPosition();
// //     setState(() {
// //       location = '${pos.latitude}, ${pos.longitude}';
// //     });
// //   }
// //
// //   void submitData() {
// //     DatabaseReference ref =  FirebaseDatabase.instance.ref("users").push();
// //     ref.set({
// //       'name': nameCtrl.text,
// //       'email': emailCtrl.text,
// //       'address': addressCtrl.text,
// //       'pincode': pincodeCtrl.text,
// //       'propertySize': propertySizeCtrl.text,
// //       'location': location
// //     });
// //
// //     ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Data stored in Firebase ✅")));
// //
// //     nameCtrl.clear();
// //     emailCtrl.clear();
// //     addressCtrl.clear();
// //     pincodeCtrl.clear();
// //     propertySizeCtrl.clear();
// //     setState(() {
// //       location = 'Fetching...';
// //     });
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     getCurrentLocation();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("User Info")),
// //       body: SingleChildScrollView(
// //         padding: EdgeInsets.all(16),
// //         child: Column(
// //           children: [
// //             buildTextField(nameCtrl, "Name"),
// //             buildTextField(emailCtrl, "Email"),
// //             buildTextField(addressCtrl, "Address"),
// //             buildTextField(pincodeCtrl, "Pincode"),
// //             buildTextField(propertySizeCtrl, "Property Size"),
// //             SizedBox(height: 16),
// //             Text("Location: $location"),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: submitData,
// //               child: Text("Submit"),
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget buildTextField(TextEditingController ctrl, String hint) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 8),
// //       child: TextField(
// //         controller: ctrl,
// //         decoration: InputDecoration(
// //             border: OutlineInputBorder(), labelText: hint),
// //       ),
// //     );
// //   }
// // }
//
/*
import 'package:get/get_core/src/get_main.dart';
import 'controllers/user_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'controllers/user_controller.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

void main() => runApp(CarouselDemo());

final themeMode = ValueNotifier(2);

class CarouselDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (context, value, g) {
        return MaterialApp(
          initialRoute: '/',
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.values.toList()[value as int],
          debugShowCheckedModeBanner: false,
          routes: {
            '/indicator': (ctx) => CarouselWithIndicatorDemo(),
          },
        );
      },
      valueListenable: themeMode,
    );
  }
}
final List<Widget> imageSliders = imgList
    .map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.network(item, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text(
                  'No. ${imgList.indexOf(item)} image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )),
  ),
))
    .toList();

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carousel with indicator controller demo')),
      body: Column(children: [
        Stack(
          children:[
            Expanded(
            child: CarouselSlider(
              items: userController.getimage.value,
              carouselController: _controller,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
          ),
        ],),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 11.0,
                height: 11.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}
*/

// import 'package:carousel_slider/carousel_controller.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import 'controllers/user_controller.dart';
//
// class CarouselWithIndicatorDemo extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _CarouselWithIndicatorState();
//   }
  // }
//
// class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
//   int _current = 0;
//   final CarouselSliderController _controller = CarouselSliderController();
//   final UserController userController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Carousel with indicator controller demo')),
//       body: Obx(() {
//         // Check if banner items are loading or empty
//         if (userController.isLoading.value && userController.bannerItems.isEmpty) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (userController.bannerItems.isEmpty) {
//           return Center(child: Text('No banners available'));
//         }
//
//         // Create image sliders from banner items
//         final List<Widget> imageSliders = userController.bannerItems
//             .asMap()
//             .entries
//             .map((entry) {
//           final item = entry.value;
//           return Container(
//             margin: EdgeInsets.all(5.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(5.0)),
//               child: Stack(
//                 children: <Widget>[
//                   Image.network(
//                     item.image,
//                     fit: BoxFit.cover,
//                     width: 1000.0,
//                     errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
//                   ),
//                   Positioned(
//                     bottom: 0.0,
//                     left: 0.0,
//                     right: 0.0,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             Color.fromARGB(200, 0, 0, 0),
//                             Color.fromARGB(0, 0, 0, 0),
//                           ],
//                           begin: Alignment.bottomCenter,
//                           end: Alignment.topCenter,
//                         ),
//                       ),
//                       padding: EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 20.0),
//                       child: Text(
//                         item.title, // Use banner title
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         })
//             .toList();
//         return Column(
//           children: [
//             Stack(
//               children:[ Expanded(
//                 child: CarouselSlider(
//                   items: imageSliders,
//                   carouselController: _controller,
//                   options: CarouselOptions(
//                     autoPlay: true,
//                     enlargeCenterPage: true,
//                     aspectRatio: 2.0,
//                     onPageChanged: (index, reason) {
//                       setState(() {
//                         _current = index;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//             ],),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: userController.bannerItems.asMap().entries.map((entry) {
//                 return GestureDetector(
//                   onTap: () => _controller.animateToPage(entry.key),
//                   child: Container(
//                     width: 11.0,
//                     height: 11.0,
//                     margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: (Theme.of(context).brightness == Brightness.dark
//                           ? Colors.white
//                           : Colors.black)
//                           .withOpacity(_current == entry.key ? 0.9 : 0.4),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }