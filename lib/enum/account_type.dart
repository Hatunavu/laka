enum AccountType { vendor, customer }

extension EnumAccount on AccountType {
  String value() {
    return accountTypeToString(this);
  }

  AccountType parse(String value) {
    return stringToAccountType(value);
  }

  String toJsonString() {
    switch (this) {
      case AccountType.vendor:
        return 'vendor';
      case AccountType.customer:
        return "customer";
    }
  }

  String getType() {
    switch (this) {
      case AccountType.customer:
        return "customer";
      case AccountType.vendor:
        return 'vendor';
    }
  }

  String display() {
    switch (this) {
      case AccountType.customer:
        return "customer";
      case AccountType.vendor:
        return 'vendor';
    }
  }
}

AccountType stringToAccountType(String type) {
  switch (type) {
    case 'vendor':
      return AccountType.vendor;
    case 'customer':
      return AccountType.customer;
    default:
      return AccountType.customer;
  }
}

String accountTypeToString(AccountType type) {
  switch (type) {
    case AccountType.vendor:
      return 'vendor';
    case AccountType.customer:
      return 'customer';
  }
}
