import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikku/core/utils/toast.dart';
import 'package:komikku/modules/me_module/user_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatelessWidget {
  static final _formKey = GlobalKey<FormState>();
  static String? _emailOrUsername;
  static String? _password;

  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header image
            Container(
              margin: const EdgeInsets.only(top: 80),
              height: 220,
              child: Image.asset('assets/images/login-cartoon.png'),
            ),

            /// Input form
            Form(
              key: _formKey,
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
                          onSaved: (value) => _emailOrUsername = value?.trim(),
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
                          onSaved: (value) => _password = value?.trim(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// Login button
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 30, 35, 0),
              child: OutlinedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  minimumSize: MaterialStateProperty.all(const Size(300, 35)),
                ),
                child: const Text('登录'),

                /// 登录
                onPressed: () async {
                  _formKey.currentState?.save();
                  if (!_validate()) return;

                  try {
                    await UserController.to.login(_emailOrUsername!, _password!);

                    // 登录成功，退出本页面
                    showText(text: '登录成功');

                    // 回退
                    Get.back();
                  } catch (e) {
                    showText(text: '账号或密码有误');
                    return;
                  }
                },
              ),
            ),

            /// Signup Arrow
            Padding(
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
                        ..onTap = () => _launchInBrowser(
                            Uri(scheme: 'https', host: 'mangadex.org', path: 'account/signup')),
                    ),
                    const TextSpan(
                      text: '前往官网',
                      style: TextStyle(color: Colors.black45),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 跳转浏览器
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  /// 验证
  bool _validate() {
    if (_emailOrUsername?.isEmpty ?? true) {
      showText(text: '账号不能为空');
      return false;
    }
    if (_password?.isEmpty ?? true) {
      showText(text: '密码不能为空');
      return false;
    }
    if (_password!.length < 8) {
      showText(text: '密码不能小于8位');
      return false;
    }
    if (_password!.length > 1024) {
      showText(text: '密码不能大于1024位');
      return false;
    }

    return true;
  }
}
