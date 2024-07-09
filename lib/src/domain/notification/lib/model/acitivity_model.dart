import 'dart:convert';

ActivtyLogsModel activtyLogsModelFromJson(String str) =>
    ActivtyLogsModel.fromJson(json.decode(str));

String activtyLogsModelToJson(ActivtyLogsModel data) =>
    json.encode(data.toJson());

class ActivtyLogsModel {
  bool success;
  String message;
  List<Data> data;

  ActivtyLogsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ActivtyLogsModel.fromJson(Map<String, dynamic> json) =>
      ActivtyLogsModel(
        success: json["success"],
        message: json["message"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  String id;
  String body;
  dynamic propertyId;
  String folderId;
  dynamic connectionInviteId;
  bool readStatus;
  DateTime createdAt;
  Folder folder;
  String noti_type;
  FromUser fromUser;

  Data({
    required this.id,
    required this.body,
    required this.propertyId,
    required this.folderId,
    required this.connectionInviteId,
    required this.readStatus,
    required this.createdAt,
    required this.noti_type,
    required this.folder,
    required this.fromUser,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        body: json["body"],
        propertyId: json["property_id"],
        folderId: json["folder_id"],
        noti_type: json["noti_type"],
        connectionInviteId: json["connection_invite_id"],
        readStatus: json["read_status"],
        createdAt: DateTime.parse(json["created_at"]),
        folder: json.containsKey("folder")
            ? Folder.fromJson(json["folder"])
            : Folder(name: ""), // Check if "folder" key exists
        fromUser: FromUser.fromJson(json["from_user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "property_id": propertyId,
        "folder_id": folderId,
        "noti_type": noti_type,
        "connection_invite_id": connectionInviteId,
        "read_status": readStatus,
        "created_at": createdAt.toIso8601String(),
        "folder": folder.toJson(),
        "from_user": fromUser.toJson(),
      };
}

class Folder {
  String name;

  Folder({
    required this.name,
  });

  factory Folder.fromJson(Map<String, dynamic> json) => Folder(
        name: json["name"] ??
            "", 
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class FromUser {
  String firstname;
  String lastname;
  String profileImageUrl;

  FromUser({
    required this.firstname,
    required this.lastname,
    required this.profileImageUrl,
  });

  factory FromUser.fromJson(Map<String, dynamic> json) => FromUser(
        firstname: json["firstname"],
        lastname: json["lastname"],
        profileImageUrl: json["profile_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "profile_image_url": profileImageUrl,
      };
}
