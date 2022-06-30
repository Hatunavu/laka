enum VoucherType { all, system, vendor }

extension EnumVoucherType on VoucherType {
  String value() {
    return voucherTypeToString(this);
  }

  VoucherType parse(String value) {
    return stringToVoucherType(value);
  }

  String toJsonString() {
    switch (this) {
      case VoucherType.all:
        return "Tất cả";
      case VoucherType.system:
        return 'Laka';
      case VoucherType.vendor:
        return "Shop";
    }
  }

  String getType() {
    switch (this) {
      case VoucherType.all:
        return "all";
      case VoucherType.system:
        return "system";
      case VoucherType.vendor:
        return 'vendor';
    }
  }

  String display() {
    switch (this) {
      case VoucherType.all:
        return "all";
      case VoucherType.system:
        return "system";
      case VoucherType.vendor:
        return 'vendor';
    }
  }
}

VoucherType stringToVoucherType(String type) {
  switch (type) {
    case "all":
      return VoucherType.all;
    case 'system':
      return VoucherType.system;
    case 'vendor':
      return VoucherType.vendor;

    default:
      return VoucherType.system;
  }
}

String voucherTypeToString(VoucherType type) {
  switch (type) {
    case VoucherType.all:
      return "all";
    case VoucherType.system:
      return 'system';
    case VoucherType.vendor:
      return 'vendor';
  }
}
