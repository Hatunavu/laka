// ignore_for_file: constant_identifier_names

enum FcmType { Order, Account, Post, Comment, Chat }

extension EnumFCM on FcmType {
  String toJsonString() {
    switch (this) {
      case FcmType.Order:
        return "Order";
      case FcmType.Account:
        return "Account";
      case FcmType.Post:
        return "Post";
      case FcmType.Comment:
        return "Comment";
      case FcmType.Chat:
        return "Chat";
    }
  }

  String getType() {
    switch (this) {
      case FcmType.Order:
        return "Order";
      case FcmType.Account:
        return "Account";
      case FcmType.Post:
        return "Post";
      case FcmType.Comment:
        return "Comment";
      case FcmType.Chat:
        return "Chat";
    }
  }
}

FcmType stringToFCMType(String type) {
  switch (type) {
    case 'Order':
      return FcmType.Order;
    case "Account":
      return FcmType.Account;
    case "Post":
      return FcmType.Post;
    case "Comment":
      return FcmType.Comment;
    case "Chat":
      return FcmType.Chat;
    default:
      return FcmType.Account;
  }
}

String fcmTypeToString(FcmType type) {
  switch (type) {
    case FcmType.Order:
      return "Order";
    case FcmType.Account:
      return "Account";
    case FcmType.Post:
      return "Post";
    case FcmType.Comment:
      return "Comment";
    case FcmType.Chat:
      return "Chat";
  }
}
