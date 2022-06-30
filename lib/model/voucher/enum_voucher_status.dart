enum VoucherStatusType { expireDate, available }

extension EnumVoucherStatusType on VoucherStatusType {
  String value() {
    return voucherStatusTypeToString(this);
  }

  VoucherStatusType parse(String value) {
    return stringToVoucherStatusType(value);
  }

  String toJsonString() {
    switch (this) {
      case VoucherStatusType.expireDate:
        return "expire_date";
      case VoucherStatusType.available:
        return 'available';
    }
  }

  String getType() {
    switch (this) {
      case VoucherStatusType.expireDate:
        return "expire_date";
      case VoucherStatusType.available:
        return "available";
    }
  }

  String display() {
    switch (this) {
      case VoucherStatusType.expireDate:
        return "Đã hết hạn";
      case VoucherStatusType.available:
        return "Còn hạn";
    }
  }
}

VoucherStatusType stringToVoucherStatusType(String type) {
  switch (type) {
    case "expire_date":
      return VoucherStatusType.expireDate;
    case 'available':
      return VoucherStatusType.available;
    default:
      return VoucherStatusType.expireDate;
  }
}

String voucherStatusTypeToString(VoucherStatusType type) {
  switch (type) {
    case VoucherStatusType.expireDate:
      return "expire_date";
    case VoucherStatusType.available:
      return 'available';
  }
}
