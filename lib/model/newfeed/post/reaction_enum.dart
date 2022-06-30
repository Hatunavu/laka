enum ReactionType { love }

extension EnumReaction on ReactionType {
  String toJsonString() {
    switch (this) {
      case ReactionType.love:
        return 'love';
    }
  }

  String getType() {
    switch (this) {
      case ReactionType.love:
        return "love";
    }
  }

  String display() {
    switch (this) {
      case ReactionType.love:
        return "love";
    }
  }
}

ReactionType stringToReactionType(String type) {
  switch (type) {
    case 'love':
      return ReactionType.love;
    default:
      return ReactionType.love;
  }
}

String reactionTypeToString(ReactionType type) {
  switch (type) {
    case ReactionType.love:
      return 'love';
  }
}
