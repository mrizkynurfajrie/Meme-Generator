// To parse this JSON data, do
//
//     final memeImages = memeImagesFromJson(jsonString);

import 'dart:convert';

List<MemeImages> memeImagesFromJson(String str) => List<MemeImages>.from(json.decode(str).map((x) => MemeImages.fromJson(x)));

String memeImagesToJson(List<MemeImages> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemeImages {
    MemeImages({
        this.id,
        this.name,
        this.url,
        this.width,
        this.height,
        this.boxCount,
        this.captions,
    });

    String? id;
    String? name;
    String? url;
    int? width;
    int? height;
    int? boxCount;
    int? captions;

    factory MemeImages.fromJson(Map<String, dynamic> json) => MemeImages(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        width: json["width"],
        height: json["height"],
        boxCount: json["box_count"],
        captions: json["captions"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "width": width,
        "height": height,
        "box_count": boxCount,
        "captions": captions,
    };
}
