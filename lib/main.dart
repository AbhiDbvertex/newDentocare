// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

 // import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(); // Initialize Firebase
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Google Auth Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: Colors.white,
//       ),
//       home: const AuthScreen(),
//     );
//   }
// }

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});
//
//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }
//
// class _AuthScreenState extends State<AuthScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
//   User? _user;
//
//   @override
//   void initState() {
//     super.initState();
//     _auth.authStateChanges().listen((User? user) {
//       setState(() {
//         _user = user;
//       });
//     });
//   }
//
//   Future<void> _signInWithGoogle() async {
//     try {
//       // Trigger Google Sign-In flow
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) return; // User canceled the sign-in
//
//       // Get authentication details
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//       // Create Firebase credential
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       // Sign in to Firebase
//       final UserCredential userCredential = await _auth.signInWithCredential(credential);
//       setState(() {
//         _user = userCredential.user;
//       });
//     } catch (e) {
//       print('Error during Google Sign-In: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Sign-In failed: $e')),
//       );
//     }
//   }
//
//   Future<void> _signOut() async {
//     await _googleSignIn.signOut();
//     await _auth.signOut();
//     setState(() {
//       _user = null;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       body: Center(
//         child: _user == null ? _buildSignInUI(height, width) : _buildUserInfoUI(height, width),
//       ),
//     );
//   }
//
//   Widget _buildSignInUI(double height, double width) {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(height: height * 0.1),
//           const Text(
//             'Welcome',
//             style: TextStyle(
//               fontSize: 32,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           SizedBox(height: height * 0.02),
//           const Text(
//             'Sign in to continue',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey,
//             ),
//           ),
//           SizedBox(height: height * 0.05),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: width * 0.1),
//             child: ElevatedButton.icon(
//               onPressed: _signInWithGoogle,
//               icon: Icon(Icons.gpp_good),
//               label: const Text(
//                 'Sign in with Google',
//                 style: TextStyle(fontSize: 16),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.black87,
//                 minimumSize: Size(width * 0.8, 50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   side: const BorderSide(color: Colors.grey),
//                 ),
//                 elevation: 2,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildUserInfoUI(double height, double width) {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(height: height * 0.1),
//           CircleAvatar(
//             radius: 50,
//             backgroundImage: _user!.photoURL != null ? NetworkImage(_user!.photoURL!) : null,
//             child: _user!.photoURL == null ? const Icon(Icons.person, size: 50) : null,
//           ),
//           SizedBox(height: height * 0.02),
//           Text(
//             _user!.displayName ?? 'No Name',
//             style: const TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           SizedBox(height: height * 0.01),
//           Text(
//             _user!.email ?? 'No Email',
//             style: const TextStyle(
//               fontSize: 16,
//               color: Colors.grey,
//             ),
//           ),
//           SizedBox(height: height * 0.05),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: width * 0.1),
//             child: ElevatedButton(
//               onPressed: _signOut,
//               child: const Text(
//                 'Sign Out',
//                 style: TextStyle(fontSize: 16),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.redAccent,
//                 foregroundColor: Colors.white,
//                 minimumSize: Size(width * 0.8, 50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 elevation: 2,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:dentocoreauth/pages/splash/splash.dart';
// import 'package:dentocoreauth/utils/mycolor.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:get_storage/get_storage.dart';
// // import 'package:pearllinedentocare/pages/splash/splash.dart';
// // import 'package:pearllinedentocare/utils/mycolor.dart';
// import 'FirebaseApi/FirebaseApi.dart';
// // import 'Testing.dart';
// import 'controllers/appoinment_detail_page.dart';
// import 'controllers/services_controller.dart';
// import 'helper/dependencies.dart' as dep;
// import 'firebase_options.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await dep.init();
//   await GetStorage.init();
//   await dotenv.load(fileName: "lib/.env");
//   // 👇 GetX ke through FirebaseApi inject kar do
//   Get.put(FirebaseApi());
//   Get.put(Servicescontroller());
//   Get.put(AppoinmentDetailPages());
//
//   // 👇 fir initFirebase call karo
//   await Get.find<FirebaseApi>().initFirebase();
//   print("Abhi:- new code test");
//
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle(
//         statusBarColor:  MyColor.primarycolor, // Deep blue status bar
//         statusBarIconBrightness: Brightness.light,
//         statusBarBrightness: Brightness.dark,
//         systemNavigationBarColor: MyColor.primarycolor,
//       ),
//       child: GetMaterialApp(
//         title: 'pearllinedentocare',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         home: const Splash(),
//         // home: ReachedLocation(),
//         builder: (context, child) {
//           return EasyLoading.init()(context, child);
//         },
//       ),
//     );
//   }
// }



// // an error occurred PlarformException(sign in failed, com.google android.gms.common.api.apiException:10, null, nul)

//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'firebase_options.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//   // Request notification permissions (especially for iOS)
//   await messaging.requestPermission();
//
//   // Get FCM token
//   String? token = await messaging.getToken();
//   print("🔥 FCM Token: $token");
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Firebase Google Auth',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const LoginScreen(), // 👈 Login screen as home
//     );
//   }
// }
//
// Future<UserCredential?> signInWithGoogle() async {
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//   if (googleUser == null) {
//     print('❌ User cancelled the sign-in');
//     return null;
//   }
//
//   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );
//
//   UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
//
//   print("✅ Logged in as: ${userCredential.user?.email}");
//   return userCredential;
// }
//
// Future<void> getAuthToken() async {
//   User? user = FirebaseAuth.instance.currentUser;
//
//   if (user != null) {
//     String? token = await user.getIdToken();
//     print("🔐 Auth Token: $token");
//   } else {
//     print("⚠️ User not logged in");
//   }
// }
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Google Login")),
//       body: Center(
//         child: ElevatedButton.icon(
//           icon: const Icon(Icons.login),
//           label: const Text("Login with Google"),
//           onPressed: () async {
//             final userCredential = await signInWithGoogle();
//             if (userCredential != null) {
//               await getAuthToken();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
   ///  current updated code

// import 'package:dentocoreauth/pages/splash/splash.dart';
// import 'package:dentocoreauth/testing.dart';
// import 'package:dentocoreauth/utils/mycolor.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// import 'FirebaseApi/FirebaseApi.dart';
// import 'controllers/appoinment_detail_page.dart';
// import 'controllers/services_controller.dart';
// import 'firebase_options.dart';
// import 'helper/dependencies.dart' as dep;
// void main() async {
//   print("Abhi:- stap ------------> 1");
//   WidgetsFlutterBinding.ensureInitialized();
//   print("Abhi:- stap ------------> 2");
//   // await Firebase.initializeApp(); // Initialize Firebase
//
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   print("Abhi:- stap ------------> 3");
//   await dep.init();
//   print("Abhi:- stap ------------> 4");
//   await GetStorage.init();
//   print("Abhi:- stap ------------> 5");
//  await dotenv.load(fileName: "lib/.env");
//   print("Abhi:- stap ------------> 6");
//   // 👇 GetX ke through FirebaseApi inject kar do
//   Get.put(FirebaseApi());
//   print("Abhi:- stap ------------> 7");
//   Get.put(Servicescontroller());
//   print("Abhi:- stap ------------> 8");
//   Get.put(AppoinmentDetailPages());
//   print("Abhi:- stap ------------> 9");
//   await Get.find<FirebaseApi>().initFirebase();
//   print("Abhi:- stap ------------> 10");
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//   print("Abhi:- stap ------------> 11");
//   runApp(const MyApp());
//   print("Abhi:- stap ------------> 12");
// }
//
// class MyApp extends StatelessWidget {
//
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     print("Abhi:- stap ------------> 13");
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle(
//         statusBarColor:  MyColor.primarycolor, // Deep blue status bar
//         statusBarIconBrightness: Brightness.light,
//         statusBarBrightness: Brightness.dark,
//         systemNavigationBarColor: MyColor.primarycolor,
//     ),
//     child: GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'pearllinedentocare',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: Colors.white,
//       ),
//       home: const Splash()/*CarouselWithIndicatorDemo()*/,
//       builder: (context, child) {
//         return EasyLoading.init()(context, child);
//       },
//     ),);
//   }
// }

///

import 'package:dentocoreauth/pages/splash/splash.dart';
import 'package:dentocoreauth/testing.dart';
import 'package:dentocoreauth/utils/mycolor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'FirebaseApi/FirebaseApi.dart';
import 'controllers/appoinment_detail_page.dart';
import 'controllers/services_controller.dart';
import 'firebase_options.dart';
import 'helper/dependencies.dart' as dep;

void main() async {
  print("Abhi:- stap ------------> 1");
  WidgetsFlutterBinding.ensureInitialized();
  print("Abhi:- stap ------------> 2");

  // Initialize Firebase only once
  await initializeFirebase();

  print("Abhi:- stap ------------> 3");
  await dep.init();
  print("Abhi:- stap ------------> 4");
  await GetStorage.init();
  print("Abhi:- stap ------------> 5");
  await dotenv.load(fileName: "lib/.env");
  print("Abhi:- stap ------------> 6");
  // 👇 GetX ke through FirebaseApi inject kar do
  Get.put(FirebaseApi());
  print("Abhi:- stap ------------> 7");
  Get.put(Servicescontroller());
  print("Abhi:- stap ------------> 8");
  Get.put(AppoinmentDetailPages());
  print("Abhi:- stap ------------> 9");
  await Get.find<FirebaseApi>().initFirebase();
  print("Abhi:- stap ------------> 10");
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  print("Abhi:- stap ------------> 11");
  runApp(const MyApp());
  print("Abhi:- stap ------------> 12");
}

// Firebase Initialization function
Future<void> initializeFirebase() async {
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    print("Firebase Initialized successfully");
  } catch (e) {
    print("Firebase already initialized or error: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("Abhi:- stap ------------> 13");
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: MyColor.primarycolor, // Deep blue status bar
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: MyColor.primarycolor,
      ),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'pearllinedentocare',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const Splash() /*CarouselWithIndicatorDemo()*/,
        builder: (context, child) {
          return EasyLoading.init()(context, child);
        },
      ),
    );
  }
}
