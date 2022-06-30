enum DeviceType { ios, android }

extension EnumDevices on DeviceType {
  String value() {
    return deceiveTypeToString(this);
  }

  DeviceType parse(String type) {
    return stringToDeceiveType(type);
  }

  String toJsonString() {
    switch (this) {
      case DeviceType.ios:
        return 'ios';
      case DeviceType.android:
        return "android";
    }
  }

  String getType() {
    switch (this) {
      case DeviceType.ios:
        return "ios";
      case DeviceType.android:
        return 'android';
    }
  }

  String display() {
    switch (this) {
      case DeviceType.ios:
        return "ios";
      case DeviceType.android:
        return 'android';
    }
  }
}

DeviceType stringToDeceiveType(String type) {
  switch (type) {
    case 'ios':
      return DeviceType.ios;
    case 'android':
      return DeviceType.android;
    default:
      return DeviceType.ios;
  }
}

String deceiveTypeToString(DeviceType type) {
  switch (type) {
    case DeviceType.ios:
      return 'ios';
    case DeviceType.android:
      return 'android';
  }
}
