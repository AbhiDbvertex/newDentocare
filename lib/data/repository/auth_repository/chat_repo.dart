import 'package:get/get_connect/http/src/response/response.dart';

import '../../api/apiclient.dart';

class ChatRepository {
  final ApiClient apiClient;

  ChatRepository({required this.apiClient});

  Future<Response> getChat(
    String senderID,
    String receiverID,
  ) async {
    return apiClient.getchat("/api/chatmessage_get/${senderID}/${receiverID}");
  }

  Future<Response> sendChat(Map body) async {
    return apiClient.sendChat("/api/chat", body);
  }

  Future<Response> updateChatStatus(Map body) async {
    return apiClient.updateChatStatus("/api/readstatusupdate", body);
  }
}
