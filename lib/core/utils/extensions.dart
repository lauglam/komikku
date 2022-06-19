import 'dart:convert';

import 'package:flutter/material.dart';

/// Object extensions.
extension ObjectX<T> on T {
  dynamic get deepClone => jsonDecode(jsonEncode(this));
}

/// Scroll controller extensions.
extension ScrollControllerX on ScrollController {
  /// Whether on the bottom of list.
  bool get onBottom {
    return positions.isNotEmpty &&
        position.atEdge &&
        position.pixels == position.maxScrollExtent;
  }

  /// Whether on the top of list.
  bool get onTop {
    return positions.isNotEmpty &&
        position.atEdge &&
        position.pixels == position.minScrollExtent;
  }
}
