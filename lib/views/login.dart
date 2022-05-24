import 'package:flutter/material.dart';
import 'package:komikku/dex/apis/auth_api.dart';
import 'package:komikku/dex/models/login.dart' as auth;
import 'package:komikku/utils/authentication.dart';
import 'package:komikku/utils/event_bus.dart';
import 'package:komikku/utils/toast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black45,
              ),
              onPressed: () => Navigator.pop(context),
            );
          },
        ),
      ),

      /// 必须使用SingleChildScrollView包裹，防止键盘显示时底部"Bottom Overflowed"
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header image
            Container(
              padding: const EdgeInsets.only(top: 30),
              height: 220,
              child: Image.asset('assets/images/login-cartoon.png'),
            ),

            /// Input form
            Form(
              key: _formKey,
              child: Container(
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
                          onSaved: (value) => _email = value?.trim(),
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
            Container(
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
          ],
        ),
      ),
    );
  }

  /// 登录
  _login() async {
    _formKey.currentState?.save();
    if (_email?.isEmpty ?? true) {
      _showDialog('账号不能为空');
      return;
    }
    if (_password?.isEmpty ?? true) {
      _showDialog('密码不能为空');
      return;
    }

    try {
      var response = await AuthApi.loginAsync(auth.Login(email: _email!, password: _password!));
      await setRefresh(response.token.refresh);
      await setSession(response.token.session);

      // 发送事件
      bus.emit('login');

      // 登录成功，退出本页面
      if (!mounted) return;
      Toast.toast(context, '登录成功');

      // 回退
      Navigator.of(context).pop();
    } catch (e) {
      _showDialog('账号或密码有误');
      return;
    }
  }

  /// 显示提示框
  void _showDialog(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('提示'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('确定'),
              ),
            ],
          );
        });
  }
}
