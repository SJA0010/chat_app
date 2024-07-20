// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FriendModel {
  String? friendName;
  String? friendId;
  String? userId;
  String? id;
  FriendModel({
    this.friendName,
    this.friendId,
    this.userId,
    this.id,
  });

  FriendModel copyWith({
    String? friendName,
    String? friendId,
    String? userId,
    String? id,
  }) {
    return FriendModel(
      friendName: friendName ?? this.friendName,
      friendId: friendId ?? this.friendId,
      userId: userId ?? this.userId,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'friendName': friendName,
      'friendId': friendId,
      'userId': userId,
      'id': id,
    };
  }

  factory FriendModel.fromMap(Map<String, dynamic> map) {
    return FriendModel(
      friendName:
          map['friendName'] != null ? map['friendName'] as String : null,
      friendId: map['friendId'] != null ? map['friendId'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FriendModel.fromJson(String source) =>
      FriendModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FriendModel(friendName: $friendName, friendId: $friendId, userId: $userId, id: $id)';
  }

  @override
  bool operator ==(covariant FriendModel other) {
    if (identical(this, other)) return true;

    return other.friendName == friendName &&
        other.friendId == friendId &&
        other.userId == userId &&
        other.id == id;
  }

  @override
  int get hashCode {
    return friendName.hashCode ^
        friendId.hashCode ^
        userId.hashCode ^
        id.hashCode;
  }
}
