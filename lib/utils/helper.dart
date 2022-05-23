class RelativeDateFormat {
  static const oneMinute = 60000;
  static const oneHour = 3600000;
  static const oneDay = 86400000;
  static const oneWeek = 604800000;

  static const oneSecondAgo = "秒前";
  static const oneMinuteAgo = "分钟前";
  static const oneHourAgo = "小时前";
  static const oneDayAgo = "天前";
  static const oneMonthAgo = "月前";
  static const oneYearAgo = "年前";

  /// 时间转换
  static String format(DateTime date) {
    var delta = DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;
    if (delta < 1 * oneMinute) {
      var seconds = toSeconds(delta);
      return (seconds <= 0 ? 1 : seconds).toInt().toString() + oneSecondAgo;
    }
    if (delta < 60 * oneMinute) {
      var minutes = toMinutes(delta);
      return (minutes <= 0 ? 1 : minutes).toInt().toString() + oneMinuteAgo;
    }
    if (delta < 24 * oneHour) {
      var hours = toHours(delta);
      return (hours <= 0 ? 1 : hours).toInt().toString() + oneHourAgo;
    }
    if (delta < 48 * oneHour) {
      return "昨天";
    }
    if (delta < 30 * oneDay) {
      var days = toDays(delta);
      return (days <= 0 ? 1 : days).toInt().toString() + oneDayAgo;
    }
    if (delta < 12 * 4 * oneWeek) {
      var months = toMonths(delta);
      return (months <= 0 ? 1 : months).toInt().toString() + oneMonthAgo;
    } else {
      var years = toYears(delta);
      return (years <= 0 ? 1 : years).toInt().toString() + oneYearAgo;
    }
  }

  static num toSeconds(num date) {
    return date / 1000;
  }

  static num toMinutes(num date) {
    return toSeconds(date) / 60;
  }

  static num toHours(num date) {
    return toMinutes(date) / 60;
  }

  static num toDays(num date) {
    return toHours(date) / 24;
  }

  static num toMonths(num date) {
    return toDays(date) / 30;
  }

  static num toYears(num date) {
    return toMonths(date) / 365;
  }
}
