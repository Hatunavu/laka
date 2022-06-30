enum ReviewType { all, media, content, star_1, star_2, star_3, star_4, star_5 }

extension EnumReview on ReviewType {
  String value() {
    return reviewTypeToString(this);
  }

  ReviewType parse(String value) {
    return stringToReviewType(value);
  }

  String toJsonString() {
    switch (this) {
      case ReviewType.all:
        return 'all';
      case ReviewType.media:
        return "media";
      case ReviewType.content:
        return "content";
      case ReviewType.star_1:
        return "star_1";
      case ReviewType.star_2:
        return "star_2";
      case ReviewType.star_3:
        return "star_3";
      case ReviewType.star_4:
        return "star_4";
      case ReviewType.star_5:
        return "star_5";
    }
  }

  String getType() {
    switch (this) {
      case ReviewType.all:
        return "all";
      case ReviewType.media:
        return 'media';
      case ReviewType.content:
        return "content";
      case ReviewType.star_1:
        return "star_1";
      case ReviewType.star_2:
        return "star_2";
      case ReviewType.star_3:
        return "star_3";
      case ReviewType.star_4:
        return "star_4";
      case ReviewType.star_5:
        return "star_5";
    }
  }

  String display() {
    switch (this) {
      case ReviewType.all:
        return "Tất cả";
      case ReviewType.media:
        return 'Có hình ảnh';
      case ReviewType.content:
        return "Có bình luận";
      case ReviewType.star_1:
        return "1";
      case ReviewType.star_2:
        return "2";
      case ReviewType.star_3:
        return "3";
      case ReviewType.star_4:
        return "4";
      case ReviewType.star_5:
        return "5";
    }
  }
}

ReviewType stringToReviewType(String type) {
  switch (type) {
    case 'Tất cả':
      return ReviewType.all;
    case 'Có hình ảnh':
      return ReviewType.media;
    case 'Có bình luận':
      return ReviewType.content;
    case '1':
      return ReviewType.star_1;
    case '2':
      return ReviewType.star_2;
    case '3':
      return ReviewType.star_3;
    case '4':
      return ReviewType.star_4;
    case '5':
      return ReviewType.star_5;
    default:
      return ReviewType.all;
  }
}

String reviewTypeToString(ReviewType type) {
  switch (type) {
    case ReviewType.all:
      return 'all';
    case ReviewType.media:
      return 'media';
    case ReviewType.content:
      return 'content';
    case ReviewType.star_1:
      return "1";
    case ReviewType.star_2:
      return "2";
    case ReviewType.star_3:
      return "3";
    case ReviewType.star_4:
      return "4";
    case ReviewType.star_5:
      return "5";
  }
}
