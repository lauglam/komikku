/// 漫画状态
enum Status {
  /// 正在进行
  ongoing,

  /// 完结
  completed,

  /// 暂停
  hiatus,

  /// 取消
  cancelled,
}

const statusEnumChineseMap = {
  Status.ongoing: '正在连载',
  Status.completed: '已完结',
  Status.hiatus: '暂停连载',
  Status.cancelled: '取消连载',
};
