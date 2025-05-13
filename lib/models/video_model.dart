// To parse this JSON data, do
//
//     final videoDto = videoDtoFromJson(jsonString);

import 'dart:convert';

VideoDto videoDtoFromJson(String str) => VideoDto.fromJson(json.decode(str));

String videoDtoToJson(VideoDto data) => json.encode(data.toJson());

class VideoDto {
  bool status;
  String message;
  List<VideoBody> body;

  VideoDto({
    required this.status,
    required this.message,
    required this.body,
  });

  factory VideoDto.fromJson(Map<String, dynamic> json) => VideoDto(
    status: json["status"],
    message: json["message"],
    body: List<VideoBody>.from(json["body"].map((x) => VideoBody.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "body": List<dynamic>.from(body.map((x) => x.toJson())),
  };
}

class VideoBody {
  String id;
  String video;
  String videolink;
  String title;

  VideoBody({
    required this.id,
    required this.video,
    required this.videolink,
    required this.title,
  });

  factory VideoBody.fromJson(Map<String, dynamic> json) => VideoBody(
    id: json["id"],
    video: json["video"],
    videolink: json["videolink"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "video": video,
    "videolink": videolink,
    "title": title,
  };
}
