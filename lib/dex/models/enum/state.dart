enum State {
  /// 草稿
  draft,

  /// 已提交
  submitted,

  /// 已发布
  published,

  /// 已拒绝
  rejected
}


const stateEnumMap = {
  State.draft: 'draft',
  State.submitted: 'submitted',
  State.published: 'published',
  State.rejected: 'rejected',
};
