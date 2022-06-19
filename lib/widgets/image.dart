import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import 'indicator.dart';
import '../core/utils/set_state_complain.dart';

class ExtendedNetworkImage extends StatefulWidget {
  /// The target image that is displayed.
  final String imageUrl;

  /// How to inscribe the image into the space allocated during layout.
  ///
  /// The default varies based on the other fields. See the discussion at
  /// [paintImage].
  final BoxFit? fit;

  /// If non-null, require the image to have this width.
  ///
  /// If null, the image will pick a size that best preserves its intrinsic
  /// aspect ratio. This may result in a sudden change if the size of the
  /// placeholder widget does not match that of the target image. The size is
  /// also affected by the scale factor.
  final double? width;

  /// If non-null, require the image to have this height.
  ///
  /// If null, the image will pick a size that best preserves its intrinsic
  /// aspect ratio. This may result in a sudden change if the size of the
  /// placeholder widget does not match that of the target image. The size is
  /// also affected by the scale factor.
  final double? height;

  /// The duration of the fade-out animation for the [placeholder].
  final Duration? fadeOutDuration;

  /// Widget displayed while the target [imageUrl] is loading.
  final ProgressIndicatorBuilder? progressIndicatorBuilder;

  /// Widget displayed while the target [imageUrl] failed loading.
  final LoadingErrorWidgetBuilder? errorWidget;

  const ExtendedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.fit,
    this.width,
    this.height,
    this.fadeOutDuration,
    this.progressIndicatorBuilder,
    this.errorWidget,
  }) : super(key: key);

  @override
  State<ExtendedNetworkImage> createState() => _ExtendedNetworkImageState();
}

class _ExtendedNetworkImageState extends State<ExtendedNetworkImage> {
  final _rebuildWidgetKey = ''.obs;
  final _retries = 3;
  var _retryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(() => CachedNetworkImage(
          key: _rebuildWidgetKey.value.isEmpty
              ? null
              : ValueKey(_rebuildWidgetKey.value),
          imageUrl: widget.imageUrl,
          fit: widget.fit,
          width: widget.width,
          height: widget.height,
          fadeOutDuration: widget.fadeOutDuration,
          progressIndicatorBuilder: widget.progressIndicatorBuilder,
          errorWidget: (context, url, error) {
            if (kDebugMode) {
              print(error);
            }

            if (_retryIndex < _retries) {
              _retryIndex++;
              noComplain(() => _rebuildWidgetKey.value = const Uuid().v1());
              return const SizedBox.shrink();
            }

            _retryIndex = 0;
            return TryAgainIconExceptionIndicator(
              onTryAgain: () => _rebuildWidgetKey.value = const Uuid().v1(),
            );
          },
        ));
  }
}
