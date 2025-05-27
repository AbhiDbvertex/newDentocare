//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../utils/component_screen.dart';
// import 'package:http/http.dart' as http;
//
// class FAQScreen extends StatefulWidget {
//   const FAQScreen({super.key});
//
//   @override
//   State<FAQScreen> createState() => _FAQScreenState();
// }
//
// class _FAQScreenState extends State<FAQScreen> {
//   final faqController = Get.put(FAQController());
//
//   final _titleStyle =
//   const TextStyle(fontSize: 36, fontWeight: FontWeight.w500);
//   final _questionStyle =
//   const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
//   final _answerStyle = const TextStyle(
//       fontSize: 14, color: Colors.grey, fontStyle: FontStyle.italic);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           // appBar: CustomAppBar(
//           //   title: "FAQ",
//           // ),
//           body: Column(
//             children: [
//               CustomAppBar(
//                 title: "FAQ",
//               ),
//               Align(
//                 alignment: Alignment.center,
//                 child: Column(
//                   children: [
//                     Text("Frequently", style: _titleStyle),
//                     Text("Asked Questions", style: _titleStyle),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Divider(
//                 color: Colors.grey,
//                 thickness: 0.5,
//               ),
//               Expanded(child: _faqList),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget get _faqList => Obx(() {
//     if (faqController.faqList.value.isEmpty) {
//       return const Center(child: CircularProgressIndicator());
//     }
//     return ListView.separated(
//       separatorBuilder: (_, __) => const Divider(
//         color: Colors.grey,
//         thickness: 0.5,
//       ),
//       padding: const EdgeInsets.all(10),
//       itemCount: faqController.faqList.value.length,
//       itemBuilder: (_, index) {
//         final item = faqController.faqList.value[index];
//
//         return Card(
//           color: Colors.transparent,
//           elevation: 0,
//           child: ExpansionTile(
//             shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.zero),
//             tilePadding: EdgeInsets.zero,
//             onExpansionChanged: (isOpen) =>
//                 faqController.toggleExpand(index, isOpen),
//             title: Text(item.question, style: _questionStyle),
//             trailing: Obx(() => Icon(
//                 size: 25,
//                 faqController.isExpanded[index].value
//                     ? Icons.close
//                     : Icons.add,
//                 color: Colors.red)),
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Text(item.answer, style: _answerStyle),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   });
// }
// class FAQModel {
//   final String question;
//   final String answer;
//   FAQModel({required this.question, required this.answer});
// }
//
// class FAQController extends GetxController {
//   var faqList = Rx<List<FAQModel>>([]);
//   final isExpanded = <RxBool>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadList();
//   }
//
//   Future<getFAQmodule?> getFAQ () async {
//     final url = 'https://work.dbvertex.com/dentist1/api/getAllFaqs';
//
//
//     try {
//       var respones = await http.get(Uri.parse(url));
//       if(respones.statusCode == 200){
//         var jsondata = json.decode(respones.body);
//         getFAQmodule.fromJson(jsondata);
//       }
//
//     } catch (e) {
//       print('getFAQ error : $e');
//     }
//     return null;
//   }
//   void loadList() async {
//     final result = await getFAQ();
//     if (result != null && result.data != null) {
//       var newList = result.data!
//           .map((e) => FAQModel(question: e.question ?? '', answer: e.answer ?? ''))
//           .toList();
//
//       faqList.value = newList;
//       isExpanded.value = List.generate(newList.length, (index) => false.obs);
//     }
//   }
//
//   // void loadList() {
//   //   final data = [
//   //     FAQModel(
//   //       question: "What is Dentocare?",
//   //       answer:
//   //       "Dentocare is an online dentist app that helps you book appointments, upload dental reports, and manage your dental care with ease.",
//   //     ),
//   //     FAQModel(
//   //       question: "How does Dentocare work?",
//   //       answer:
//   //       "You can book appointments with nearby dentists, upload dental reports like X-rays or photos, and track your treatment progress through the app.",
//   //     ),
//   //     FAQModel(
//   //       question: "How do I upload a photo for a report?",
//   //       answer:
//   //       "Go to the 'Upload Report' section, select a photo from your camera or gallery, and tap 'Upload.' Ensure the photo is clear and your internet connection is active.",
//   //     ),
//   //     FAQModel(
//   //       question: "How can I cancel an appointment?",
//   //       answer:
//   //       "You can cancel your appointment within 10 minutes of booking from the 'My Appointments' section. After that, please contact the clinic directly.",
//   //     ),
//   //   ];
//   //   faqList.value = data;
//   //   isExpanded.value = List.generate(
//   //     data.length,
//   //         (index) => false.obs,
//   //   );
//   // }
//
//   void toggleExpand(int index, bool isOpen) {
//     isExpanded[index].value = isOpen;
//   }
// }
//
// class getFAQmodule {
//   bool? status;
//   String? message;
//   List<Data>? data;
//
//   getFAQmodule({this.status, this.message, this.data});
//
//   getFAQmodule.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? id;
//   String? question;
//   String? answer;
//   String? createdAt;
//   String? updatedAt;
//
//   Data({this.id, this.question, this.answer, this.createdAt, this.updatedAt});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     question = json['question'];
//     answer = json['answer'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['question'] = this.question;
//     data['answer'] = this.answer;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utils/component_screen.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final faqController = Get.put(FAQController());

  final _titleStyle = const TextStyle(fontSize: 36, fontWeight: FontWeight.w500);
  final _questionStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  final _answerStyle = const TextStyle(
      fontSize: 14, color: Colors.grey, fontStyle: FontStyle.italic);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              CustomAppBar(
                title: "FAQ",
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text("Frequently", style: _titleStyle),
                    Text("Asked Questions", style: _titleStyle),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              Expanded(child: _faqList),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _faqList => Obx(() {
    if (faqController.faqList.value.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.separated(
      separatorBuilder: (_, __) => const Divider(
        color: Colors.grey,
        thickness: 0.5,
      ),
      padding: const EdgeInsets.all(10),
      itemCount: faqController.faqList.value.length,
      itemBuilder: (_, index) {
        final item = faqController.faqList.value[index];

        return Card(
          color: Colors.transparent,
          elevation: 0,
          child: ExpansionTile(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero),
            tilePadding: EdgeInsets.zero,
            onExpansionChanged: (isOpen) =>
                faqController.toggleExpand(index, isOpen),
            title: Text(item.question, style: _questionStyle),
            trailing: Obx(() => Icon(
              size: 25,
              faqController.isExpanded[index].value
                  ? Icons.close
                  : Icons.add,
              color: Colors.red,
            )),
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(item.answer, style: _answerStyle),
              ),
            ],
          ),
        );
      },
    );
  });
}

class FAQModel {
  final String question;
  final String answer;
  FAQModel({required this.question, required this.answer});
}

class FAQController extends GetxController {
  var faqList = Rx<List<FAQModel>>([]);
  final isExpanded = <RxBool>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadList();
  }

  Future<getFAQmodule?> getFAQ() async {
    final url = 'https://work.dbvertex.com/dentist1/api/getAllFaqs';
    try {
      var response = await http.get(Uri.parse(url));
      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);
        return getFAQmodule.fromJson(jsondata);
      } else {
        print('API Error: Status code ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('getFAQ error: $e');
      return null;
    }
  }

  void loadList() async {
    final result = await getFAQ();
    if (result != null && result.data != null) {
      var newList = result.data!
          .map((e) => FAQModel(
        question: e.question ?? '',
        answer: e.answer ?? '',
      ))
          .toList();
      faqList.value = newList;
      isExpanded.value = List.generate(newList.length, (index) => false.obs);
    } else {
      // Optional: Fallback to mock data or show an error state
      faqList.value = [];
      isExpanded.value = [];
      Get.snackbar('Error', 'Failed to load FAQs. Please try again.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void toggleExpand(int index, bool isOpen) {
    isExpanded[index].value = isOpen;
  }
}

class getFAQmodule {
  bool? status;
  String? message;
  List<Data>? data;

  getFAQmodule({this.status, this.message, this.data});

  getFAQmodule.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? question;
  String? answer;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.question, this.answer, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}