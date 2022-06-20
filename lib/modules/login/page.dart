import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/message.dart';

import 'controller.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    /// Big image on top
    final bigImg = Container(
      margin: const EdgeInsets.only(top: 80),
      height: 220,
      child: Image.asset('assets/images/login-cartoon.png'),
    );

    /// Input form
    final form = Form(
      key: controller.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Card(
          child: Column(
            children: [
              /// Email
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                child: TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '请输入账号',
                    icon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                  ),
                  onSaved: (value) =>
                      controller.emailOrUsername = value?.trim(),
                ),
              ),
              Divider(height: 0.5, indent: 16, color: Colors.grey[300]),

              /// Password
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                child: TextFormField(
                  maxLines: 1,
                  obscureText: true,
                  autofocus: false,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '请输入密码',
                    icon: Icon(Icons.lock, color: Colors.grey),
                  ),
                  onSaved: (value) => controller.password = value?.trim(),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    /// Button of login
    final loginButton = Padding(
      padding: const EdgeInsets.fromLTRB(35, 30, 35, 0),
      child: OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          minimumSize: MaterialStateProperty.all(const Size(300, 35)),
        ),
        child: const Text('登录'),
        onPressed: () async {
          try {
            await controller.login();
            toast('登录成功');
            Get.back();
          } catch (e) {
            toast('账号或密码有误');
            return;
          }
        },
      ),
    );

    /// Go to signup
    final goto = Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(
              text: '本应用不提供注册服务，请',
              style: TextStyle(color: Colors.black45),
            ),
            TextSpan(
              text: '点击',
              style: const TextStyle(
                color: Colors.purple,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => controller.launchInBrowser(Uri(
                    scheme: 'https',
                    host: 'mangadex.org',
                    path: 'account/signup')),
            ),
            const TextSpan(
              text: '前往官网',
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [bigImg, form, loginButton, goto],
        ),
      ),
    );
  }
}
