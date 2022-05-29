import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:komikku/dex/apis/auth_api.dart';
import 'package:komikku/dex/models/login.dart' as auth;
import 'package:komikku/utils/authentication.dart';
import 'package:komikku/utils/event_bus.dart';
import 'package:komikku/utils/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  final _formKey = GlobalKey<FormState>();
  Future<void>? _launched;
  String? _emailOrUsername;
  String? _password;

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
                          style: const TextStyle(fontSize: 15),
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
                          style: const TextStyle(fontSize: 15),
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
                  side: MaterialStateProperty.all(const BorderSide(color: Colors.orange, width: 1)),
                  minimumSize: MaterialStateProperty.all(const Size(300, 35)),
                ),
                onPressed: () => _login(),
                child: const Text('登录', style: TextStyle(color: Colors.orange)),
              ),
            ),

            /// Signup Arrow
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  Text.rich(
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
                          recognizer: _tapGestureRecognizer
                            ..onTap = () => setState(() => _launched = _launchInBrowser(Uri(
                                scheme: 'https', host: 'mangadex.org', path: 'account/signup'))),
                        ),
                        const TextSpan(
                          text: '前往官网',
                          style: TextStyle(color: Colors.black45),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder<void>(
                    future: _launched,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        showText(text: '错误: ${snapshot.error}');
                      }
                      return const Text('');
                    },
                  ),
                ],
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

  /// 登录
  _login() async {
    _formKey.currentState?.save();
    if (!_validate()) return;

    try {
      var login = _emailOrUsername!.contains('@')
          ? auth.Login(email: _emailOrUsername!, password: _password!)
          : auth.Login(username: _emailOrUsername!, password: _password!);

      var response = await AuthApi.loginAsync(login);
      await setRefresh(response.token.refresh);
      await setSession(response.token.session);

      // 发送事件
      bus.emit('login');

      // 登录成功，退出本页面
      showText(text: '登录成功');

      // 回退
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      showText(text: '账号或密码有误');
      return;
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
