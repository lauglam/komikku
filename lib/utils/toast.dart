import 'package:flutter/material.dart';

class Toast {
  static OverlayEntry? _overlayEntry;
  static bool _showing = false;
  static DateTime? _startedTime;
  static String? _message;
  static int? _showTime;
  static Color? _backgroundColor;
  static Color? _textColor;
  static double? _textSize;
  static ToastPosition? _position;
  static double? _horizontal;
  static double? _vertical;

  static void toast(
    BuildContext context,
    String message, {
    int showTime = 2000,
    Color backgroundColor = Colors.black45,
    Color textColor = Colors.white,
    double textSize = 14,
    ToastPosition position = ToastPosition.bottom,
    double horizontal = 20,
    double vertical = 10,
  }) async {
    _message = message;
    _startedTime = DateTime.now();
    _showTime = showTime;
    _backgroundColor = backgroundColor;
    _textColor = textColor;
    _textSize = textSize;
    _position = position;
    _horizontal = horizontal;
    _vertical = vertical;

    // 获取OverlayState
    var overlayState = Overlay.of(context);

    _showing = true;
    _overlayEntry ??= OverlayEntry(
      builder: (context) => Positioned(
        top: _calPosition(context),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: AnimatedOpacity(
              opacity: _showing ? 1 : 0,
              duration:
                  _showing ? const Duration(milliseconds: 100) : const Duration(milliseconds: 400),
              child: Center(
                child: Card(
                  color: _backgroundColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: _horizontal!,
                      vertical: _vertical!,
                    ),
                    child: Text(
                      _message!,
                      style: TextStyle(
                        fontSize: _textSize,
                        color: _textColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    assert(overlayState != null);
    overlayState?.insert(_overlayEntry!);

    // 重新绘制UI
    _overlayEntry!.markNeedsBuild();

    // 等待
    await Future.delayed(Duration(milliseconds: _showTime!));

    // 2秒后，是否应该消失
    if (DateTime.now().difference(_startedTime!).inMilliseconds > _showTime!) {
      _showing = false;
      _overlayEntry!.markNeedsBuild();
      await Future.delayed(const Duration(milliseconds: 400));
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  /// toast位置
  static _calPosition(context) {
    double val;
    switch (_position!) {
      case ToastPosition.top:
        val = MediaQuery.of(context).size.height * 1 / 4;
        break;
      case ToastPosition.center:
        val = MediaQuery.of(context).size.height * 2 / 5;
        break;
      case ToastPosition.bottom:
        val = MediaQuery.of(context).size.height * 3 / 4;
        break;
    }
    return val;
  }
}

/// 位置
enum ToastPosition {
  /// 上方
  top,

  /// 中间
  center,

  /// 底部
  bottom,
}
