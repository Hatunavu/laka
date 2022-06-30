enum NotificationType {
  orderSuccess,
  orderCancled,
  orderConfirmed,
  orderComplete,
  orderUpdated,
  vendorOrderNew,
  vendorOrderCanceled,
  vendorOrderUpdated,
  post,
  postNewReaction,
  comment,
  chat
}

extension EnumNotification on NotificationType {
  String toJsonString() {
    switch (this) {
      case NotificationType.orderSuccess:
        return "order_success";
      case NotificationType.orderCancled:
        return "order_cancled";
      case NotificationType.orderConfirmed:
        return "order_confirmed";
      case NotificationType.orderComplete:
        return "order_complete";
      case NotificationType.orderUpdated:
        return "order_updated";
      case NotificationType.vendorOrderNew:
        return "vendor_order_new";
      case NotificationType.vendorOrderCanceled:
        return "vendor_order_canceled";
      case NotificationType.vendorOrderUpdated:
        return "vendor_order_updated";
      case NotificationType.post:
        return "post";
      case NotificationType.postNewReaction:
        return "post_new_reaction";
      case NotificationType.comment:
        return "comment";
      case NotificationType.chat:
        return "chat";
    }
  }

  String getType() {
    switch (this) {
      case NotificationType.orderSuccess:
        return "order_success";
      case NotificationType.orderCancled:
        return "order_cancled";
      case NotificationType.orderConfirmed:
        return "order_confirmed";
      case NotificationType.orderComplete:
        return "order_complete";
      case NotificationType.orderUpdated:
        return "order_updated";
      case NotificationType.vendorOrderNew:
        return "vendor_order_new";
      case NotificationType.vendorOrderCanceled:
        return "vendor_order_canceled";
      case NotificationType.vendorOrderUpdated:
        return "vendor_order_updated";
      case NotificationType.post:
        return "post";
      case NotificationType.postNewReaction:
        return "post_new_reaction";
      case NotificationType.comment:
        return "comment";
      case NotificationType.chat:
        return "chat";
    }
  }
}

NotificationType stringToNotificationType(String type) {
  switch (type) {
    case 'order_success':
      return NotificationType.orderSuccess;
    case "order_cancled":
      return NotificationType.orderCancled;
    case "order_confirmed":
      return NotificationType.orderConfirmed;
    case "order_complete":
      return NotificationType.orderComplete;
    case "order_updated":
      return NotificationType.orderUpdated;
    case "vendor_order_new":
      return NotificationType.vendorOrderNew;
    case "vendor_order_canceled":
      return NotificationType.vendorOrderCanceled;
    case "vendor_order_updated":
      return NotificationType.vendorOrderUpdated;
    case "post_new_reaction":
      return NotificationType.postNewReaction;
    case "post":
      return NotificationType.post;
    case "comment":
      return NotificationType.comment;
    case "chat":
      return NotificationType.chat;
    default:
      return NotificationType.orderSuccess;
  }
}

String notificationTypeToString(NotificationType type) {
  switch (type) {
    case NotificationType.orderSuccess:
      return "order_success";
    case NotificationType.orderCancled:
      return "order_cancled";
    case NotificationType.orderConfirmed:
      return "order_confirmed";
    case NotificationType.orderComplete:
      return "order_complete";
    case NotificationType.orderUpdated:
      return "order_updated";
    case NotificationType.vendorOrderNew:
      return "vendor_order_new";
    case NotificationType.vendorOrderCanceled:
      return "vendor_order_canceled";
    case NotificationType.vendorOrderUpdated:
      return "vendor_order_updated";
    case NotificationType.post:
      return "post";
    case NotificationType.postNewReaction:
      return "post_new_reaction";
    case NotificationType.comment:
      return "comment";
    case NotificationType.chat:
      return "chat";
  }
}
