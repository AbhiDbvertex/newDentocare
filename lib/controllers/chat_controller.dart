
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:dentocoreauth/Utills/Utills.dart';
import '../models/chat_response_dto.dart' as myChatResponse;
import '../data/repository/auth_repository/chat_repo.dart';

class ChatController extends GetxController {
  final ChatRepository chatRepository;

  ChatController({required this.chatRepository});
  File? fimage1;
  final utill = Utills();
  var chatTxt = TextEditingController();
  var load_status = false.obs;
  //final chatservice = ChatServices();
  var sender_id = "";
  RxList<myChatResponse.chatBODY?> _chats = <myChatResponse.chatBODY?>[].obs;
  RxList<myChatResponse.chatBODY?> get chats => _chats;
  // RxInt _listlen = 0.obs;
  // RxInt get listlen => _listlen;




  @override
  void onReady() {
    super.onReady();
    


  }


  @override
  void dispose() {
    super.dispose();

  }


  
 

  Future<myChatResponse.ChatResponseDto?> getChat(
    String send,
    String rec,
  ) async {
   // utill.startLoading();
    load_status.value = false;

    var chatres = await chatRepository.getChat(send, rec);
    if (chatres != null) {
     // utill.stopLoading();
      //items(chatres.data);
      if (chatres.statusCode == 200 || chatres.statusCode == 201) {
        //utill.stopLoading();
        final my_response =
            myChatResponse.chatResponseDtoFromJson(chatres.bodyString!);
        _chats(my_response.data);
        update();
        debugPrint("chatdata" + chats.value[0]!.message.toString());
        // _listlen.value = _chats.length;
        // _listlen.refresh();
       // load_status.value=false;
        return my_response;
      } else {
       // utill.stopLoading();
        //load_status.value = false;
       // utill.showSnackBar("Alert", '${chatres.statusCode.toString()}', true);
        return null;
      }
    } else {
     // utill.stopLoading();
     // load_status.value = false;
     //  utill.showSnackBar(
     //      "Alert failed", '${chatres.statusCode.toString()}', true);
      return null;
    }
  }

  validation() {
    if (chatTxt.text.isEmpty) {
      utill.showSnackBar("Alert", "Please enter message", false);
      return false;
    } else {
      return true;
    }
  }




  Future<void> sendChat(String sender_id, String receiver_id,[File? image]) async {

    EasyLoading.show(status: 'Sending...');

    var res = await chatRepository.sendChat({
      "sender_id": sender_id,
      "receiver_id": receiver_id,
      "message": chatTxt.text,
      "image": image != null ? base64Encode(image!.readAsBytesSync()) : '',


    });

    if (res.statusCode == 200 || res.statusCode == 201) {
      //utill.showFailProcess();
     // EasyLoading.showInfo("Message sent");
      utill.showFailProcess();
      var temp = jsonDecode(res.bodyString!);
      if (temp != null) {
        if (temp['message'].toString() != null) {
          chatTxt.text = "";
        }
      }
    } else if (res.statusCode == 400) {
      utill.showFailProcess();
      utill.showSnackBar("Alert", "Something went wrong!", false);
    } else {
      utill.showFailProcess();
      utill.showSnackBar("Alert", "Something went wrong!", false);
    }
  }

  Future<void> updateChatStatus(String user_id) async {
    utill.startLoading();
    debugPrint("chatupdated"+"called");
    var res = await chatRepository.updateChatStatus({
      "user_id": user_id,
    });

    if (res.statusCode == 200 || res.statusCode == 201) {
      utill.showFailProcess();
      debugPrint("chatupdated"+"200");
      var temp = jsonDecode(res.bodyString!);
      if (temp != null) {
        if (temp['message'].toString() != null) {

        }
      }
    } else if (res.statusCode == 400) {
      debugPrint("chatupdated"+"400");
      utill.showFailProcess();
     // utill.showSnackBar("Alert", "Something went wrong!", false);
    } else {
      debugPrint("chatupdated"+"failed");
      utill.showFailProcess();
     // utill.showSnackBar("Alert", "Something went wrong!", false);
    }
  }


  //https://work.dbvertex.com/dentist1/api/readstatusupdate

  // Future<ChatListDto?> getChatList(String uid) async {
  //   var chatres = await chatservice.getChatList(uid);
  //   if (chatres != null) {
  //     return chatres;
  //   } else {
  //     return null;
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
  }
}
