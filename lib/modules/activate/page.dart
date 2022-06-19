import 'package:flutter/material.dart';

@Deprecated('官方不允许App进行注册，注册需要移步官网')
class ActivateAccount extends StatelessWidget {
  const ActivateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('请输入您邮箱受到的验证码'));
  }
}
