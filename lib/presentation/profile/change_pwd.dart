import 'package:boilerplate/core/stores/misc/misc_store.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/di/services/auth_service.dart';
import 'package:boilerplate/presentation/login/forgot_pwd.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:boilerplate/utils/validator/txt_validator.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/presentation/signup/signupType.dart';
import 'package:boilerplate/main.dart';
import 'package:boilerplate/constants/text.dart';
import 'package:provider/provider.dart';

class ChangePwdPage extends StatefulWidget {
  @override
  State<ChangePwdPage> createState() => _ChangePwdPageState();
}

class _ChangePwdPageState extends State<ChangePwdPage> {
  final AuthService _authApi = getIt<AuthService>();
  final _formKey = GlobalKey<FormState>();
  final _oldPass = TextEditingController();
  final _newPass = TextEditingController();
  final _newPass2 = TextEditingController();
  final _miscStore = getIt<MiscStore>();

  void _handleLogin() {
    if (_formKey.currentState!.validate() == false) {
      return;
    }
    _authApi.changePassword(
      oldPwd: _oldPass.text,
      newPwd: _newPass.text,
      listener: (res) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res.statusCode == 200
                ? "Update completed"
                : 'Update fail code ${res.statusCode}'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('StudentHub'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      _miscStore.isEnglish
                          ? AppStrings.changePwd_en
                          : AppStrings.changePwd_vn,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        inputFile(
                          label: _miscStore.isEnglish
                              ? AppStrings.oldPwd_en
                              : AppStrings.oldPwd_vn,
                          obscureText: true,
                          controller: _oldPass,
                        ),
                        SizedBox(height: 16),
                        inputFile(
                          label: _miscStore.isEnglish
                              ? AppStrings.newPwd_en
                              : AppStrings.newPwd_vn,
                          obscureText: true,
                          controller: _newPass,
                          validator: TextValidator.strongPasswordValidator,
                        ),
                        SizedBox(height: 16),
                        inputFile(
                          label: _miscStore.isEnglish
                              ? AppStrings.confirmNewPwd_en
                              : AppStrings.confirmNewPwd_vn,
                          obscureText: true,
                          controller: _newPass2,
                          validator: (v) {
                            return _newPass.text == _newPass2.text
                                ? null
                                : _miscStore.isEnglish
                                    ? AppStrings.passwordNotMatch_en
                                    : AppStrings.passwordNotMatch_vn;
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: _handleLogin,
                    color: Color(0xff0095FF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Change password",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 100),
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.fitHeight),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

// we will be creating a widget for text field
Widget inputFile(
    {required String label,
    bool obscureText = false,
    TextEditingController? controller,
    String? Function(String?)? validator}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    validator: validator ?? TextValidator.txtIsNotEmptyValidator,
    decoration: InputDecoration(
      labelText: label,
      errorMaxLines: 2,
      errorStyle: TextStyle(
        fontSize: 12,
        fontFamily: "arial",
        color: Colors.red,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          width: 1.0,
        ),
      ),
    ),
  );
}
