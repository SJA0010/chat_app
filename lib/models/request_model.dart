// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RequestModel {
  String? senderName;
  String? senderId;
  String? reciverName;
  String? reciverId;
  int? status;
  String? requestId;
  RequestModel({
    this.senderName,
    this.senderId,
    this.reciverName,
    this.reciverId,
    this.status,
    this.requestId,
  });

  RequestModel copyWith({
    String? senderName,
    String? senderId,
    String? reciverName,
    String? reciverId,
    int? status,
    String? requestId,
  }) {
    return RequestModel(
      senderName: senderName ?? this.senderName,
      senderId: senderId ?? this.senderId,
      reciverName: reciverName ?? this.reciverName,
      reciverId: reciverId ?? this.reciverId,
      status: status ?? this.status,
      requestId: requestId ?? this.requestId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderName': senderName,
      'senderId': senderId,
      'reciverName': reciverName,
      'reciverId': reciverId,
      'status': status,
      'requestId': requestId,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      senderName:
          map['senderName'] != null ? map['senderName'] as String : null,
      senderId: map['senderId'] != null ? map['senderId'] as String : null,
      reciverName:
          map['reciverName'] != null ? map['reciverName'] as String : null,
      reciverId: map['reciverId'] != null ? map['reciverId'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      requestId: map['requestId'] != null ? map['requestId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestModel.fromJson(String source) =>
      RequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestModel(senderName: $senderName, senderId: $senderId, reciverName: $reciverName, reciverId: $reciverId, status: $status, requestId: $requestId)';
  }

  @override
  bool operator ==(covariant RequestModel other) {
    if (identical(this, other)) return true;

    return other.senderName == senderName &&
        other.senderId == senderId &&
        other.reciverName == reciverName &&
        other.reciverId == reciverId &&
        other.status == status &&
        other.requestId == requestId;
  }

  @override
  int get hashCode {
    return senderName.hashCode ^
        senderId.hashCode ^
        reciverName.hashCode ^
        reciverId.hashCode ^
        status.hashCode ^
        requestId.hashCode;
  }
}
