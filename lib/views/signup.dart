import 'package:flutter/material.dart';
import 'package:komikku/dex/apis/account_api.dart';
import 'package:komikku/dex/models.dart';
import 'package:komikku/utils/toast.dart';

@Deprecated('官方不允许App进行注册，注册需要移步官网')
class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

@Deprecated('官方不允许App进行注册，注册需要移步官网')
class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  String? _username;
  String? _password;
  String? _email;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          /// Header image
          Container(
            padding: const EdgeInsets.only(top: 30),
            height: 220,
            child: Image.asset('assets/images/signup-cartoon.png'),
          ),

          /// Input form
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Card(
                child: Column(
                  children: [
                    /// Username
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.name,
                        autofocus: false,
                        style: const TextStyle(fontSize: 15),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '请输入用户名',
                          icon: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                        ),
                        onSaved: (value) => _username = value?.trim(),
                      ),
                    ),

                    Divider(height: 0.5, indent: 16, endIndent: 16, color: Colors.grey[300]),

                    /// Password
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15),
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

                    Divider(height: 0.5, indent: 16, endIndent: 16, color: Colors.grey[300]),

                    /// Email
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                      child: TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        style: const TextStyle(fontSize: 15),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '请输入邮箱地址',
                          icon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                        ),
                        onSaved: (value) => _email = value?.trim(),
                      ),
                    )
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
                side: MaterialStateProperty.all(const BorderSide(color: Colors.blueGrey, width: 1)),
                minimumSize: MaterialStateProperty.all(const Size(300, 35)),
              ),
              onPressed: () => _signup(),
              // TODO: activate account
              // onPressed: () => Navigator.pushNamed(context, '/activate-account'),
              child: const Text('注册', style: TextStyle(color: Colors.blueGrey)),
            ),
          ),

          /// Signup Arrow
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.arrow_back_ios_rounded, size: 16, color: Colors.black45),
                Text('向左滑动前往登录', style: TextStyle(color: Colors.black45)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 注册
  _signup() async {
    _formKey.currentState?.save();
    if (!_validate()) return;

    try {
      var response = await AccountApi.createAccountAsync(AccountCreate(
        username: _username!,
        password: _password!,
        email: _email!,
      ));
      showText(text: '${response.data.attributes.username}，已发送激活邮件到您邮箱');
    } catch (e) {
      showText(text: '注册失败，发生错误: $e');
    }
  }

  /// 验证
  bool _validate() {
    if (_username?.isEmpty ?? true) {
      showText(text: '用户名不能为空');
      return false;
    }
    if (_password?.isEmpty ?? true) {
      showText(text: '密码不能为空');
      return false;
    }
    if (_email?.isEmpty ?? true) {
      showText(text: '邮箱地址不能为空');
      return false;
    }
    if (_username!.length > 64) {
      showText(text: '用户不能大于64位');
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
