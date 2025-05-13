
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/component_screen.dart';


class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final faqController = Get.put(FAQController());

  final _titleStyle =
  const TextStyle(fontSize: 36, fontWeight: FontWeight.w500);
  final _questionStyle =
  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  final _answerStyle = const TextStyle(
      fontSize: 14, color: Colors.grey, fontStyle: FontStyle.italic);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.white,
          // appBar: CustomAppBar(
          //   title: "FAQ",
          // ),
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
                color: Colors.red)),
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

  void loadList() {
    final data = [
      FAQModel(
        question: "What is Dentocare?",
        answer:
        "Dentocare is an online dentist app that helps you book appointments, upload dental reports, and manage your dental care with ease.",
      ),
      FAQModel(
        question: "How does Dentocare work?",
        answer:
        "You can book appointments with nearby dentists, upload dental reports like X-rays or photos, and track your treatment progress through the app.",
      ),
      FAQModel(
        question: "How do I upload a photo for a report?",
        answer:
        "Go to the 'Upload Report' section, select a photo from your camera or gallery, and tap 'Upload.' Ensure the photo is clear and your internet connection is active.",
      ),
      FAQModel(
        question: "How can I cancel an appointment?",
        answer:
        "You can cancel your appointment within 10 minutes of booking from the 'My Appointments' section. After that, please contact the clinic directly.",
      ),
    ];
    faqList.value = data;
    isExpanded.value = List.generate(
      data.length,
          (index) => false.obs,
    );
  }

  void toggleExpand(int index, bool isOpen) {
    isExpanded[index].value = isOpen;
  }
}
