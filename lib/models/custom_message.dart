import 'package:cometchat/models/app_entity.dart';
import 'package:cometchat/models/base_message.dart';
import 'package:cometchat/models/group.dart';
import 'package:cometchat/models/user.dart';
import 'dart:convert';

import 'package:cometchat/utils/constants.dart';

class CustomMessage extends BaseMessage {
  String? subType;
  Map<String, dynamic>? customData;
  List<String>? tags;

  CustomMessage({
    this.subType,
    required this.customData,
    this.tags,
    int? id,
    String? muid,
    User? sender,
    AppEntity? receiver,
    required String receiverUid,
    required String type,
    required String receiverType,
    String? category,
    DateTime? sentAt,
    DateTime? deliveredAt,
    DateTime? readAt,
    Map<String, dynamic>? metadata,
    DateTime? readByMeAt,
    DateTime? deliveredToMeAt,
    DateTime? deletedAt,
    DateTime? editedAt,
    String? deletedBy,
    String? editedBy,
    DateTime? updatedAt,
    String? conversationId,
    int? parentMessageId,
    int? replyCount,
  }) : super(
          id: id ?? 0,
          muid: muid ?? '',
          sender: sender,
          receiver: receiver,
          receiverUid: receiverUid,
          type: type,
          receiverType: receiverType,
          category: category ?? '',
          sentAt: sentAt,
          deliveredAt: deliveredAt,
          readAt: readAt,
          metadata: metadata,
          readByMeAt: readByMeAt,
          deliveredToMeAt: deliveredToMeAt,
          deletedAt: deletedAt,
          editedAt: editedAt,
          deletedBy: deletedBy,
          editedBy: editedBy,
          updatedAt: updatedAt,
          conversationId: conversationId,
          parentMessageId: parentMessageId ?? 0,
          replyCount: replyCount ?? 0,
        );

  factory CustomMessage.fromMap(dynamic map, {AppEntity? receiver}) {
    if (map == null)
      throw ArgumentError('The type of custom message map is null');

    final appEntity = (map['receiver'] == null)
        ? receiver
        : (map['receiverType'] == 'user')
            ? User.fromMap(map['receiver'])
            : Group.fromMap(map['receiver']);

    final conversationId = map['conversationId'].isEmpty
        ? map['receiverType'] == 'user'
            ? '${map['sender']['uid']}_user_${(appEntity as User).uid}'
            : 'group_${map['receiver']['guid']}'
        : map['conversationId'];

    return CustomMessage(
      subType: map['subType'] ?? '',
      customData:
          Map<String, dynamic>.from(json.decode(map['customData'] ?? '{}')),
      id: map['id'],
      muid: map['muid'],
      sender: map['sender'] == null ? null : User.fromMap(map['sender']),
      receiver: appEntity,
      receiverUid: map['receiverUid'],
      type: map['type'],
      receiverType: map['receiverType'],
      category: map['category'],
      sentAt: map['sentAt'] == 0 || map['sentAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['sentAt'] * 1000),
      deliveredAt: map['deliveredAt'] == 0 || map['deliveredAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['deliveredAt'] * 1000),
      readAt: map['readAt'] == 0 || map['readAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['readAt'] * 1000),
      metadata: Map<String, dynamic>.from(json.decode(map['metadata'] ?? '{}')),
      readByMeAt: map['readByMeAt'] == 0 || map['readByMeAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['readByMeAt'] * 1000),
      deliveredToMeAt: map['deliveredToMeAt'] == 0 ||
              map['deliveredToMeAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['deliveredToMeAt'] * 1000),
      deletedAt: map['deletedAt'] == 0 || map['deletedAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['deletedAt'] * 1000),
      editedAt: map['editedAt'] == 0 || map['editedAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['editedAt'] * 1000),
      deletedBy: map['deletedBy'],
      editedBy: map['editedBy'],
      updatedAt: map['updatedAt'] == 0 || map['updatedAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] * 1000),
      conversationId: conversationId,
      parentMessageId: map['parentMessageId'],
      replyCount: map['replyCount'],
      tags: List<String>.from(map['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    print("to json custom message");
    User? userObj = sender;

    late Map receiverMap;
    if (receiverType == CometChatReceiverType.group) {
      Group grp = receiver as Group;
      receiverMap = grp.toJson();
    } else {
      User usr = receiver as User;
      receiverMap = usr.toJson();
    }

    final map = <String, dynamic>{};
    map['metadata'] = metadata;
    if (receiver != null) {
      map['receiver'] = receiverMap;
    }
    map['editedBy'] = editedBy;
    map['conversationId'] = conversationId;
    map['sentAt'] = sentAt == null ? 0 : sentAt?.millisecondsSinceEpoch;
    map['receiverUid'] = receiverUid;
    map['type'] = type;
    map['readAt'] = readAt == null ? 0 : readAt?.millisecondsSinceEpoch;
    map['deletedBy'] = deletedBy;
    map['deliveredAt'] =
        deliveredAt == null ? 0 : deliveredAt?.millisecondsSinceEpoch;
    map['muid'] = muid;

    map['deletedAt'] =
        deletedAt == null ? 0 : deletedAt?.millisecondsSinceEpoch;
    map['replyCount'] = replyCount;
    if (sender != null) {
      map['sender'] = userObj!.toJson();
    }
    map['receiverType'] = receiverType;
    map['editedAt'] = editedAt == null ? 0 : editedAt?.millisecondsSinceEpoch;
    map['parentMessageId'] = parentMessageId;
    map['readByMeAt'] =
        readByMeAt == null ? 0 : readByMeAt?.millisecondsSinceEpoch;
    map['id'] = id;
    map['category'] = category;
    map['deliveredToMeAt'] =
        deliveredToMeAt == null ? 0 : deliveredToMeAt?.millisecondsSinceEpoch;
    map['updatedAt'] =
        updatedAt == null ? 0 : updatedAt?.millisecondsSinceEpoch;
    map['customData'] = customData;
    map['tags'] = tags;
    return map;
  }

  @override
  String toString() {
    return 'CustomMessage{id: ${id}, receiverUID: $receiverUid , receiverType: $receiverType subType: $subType, customData: $customData, tags: $tags}';
  }
}
