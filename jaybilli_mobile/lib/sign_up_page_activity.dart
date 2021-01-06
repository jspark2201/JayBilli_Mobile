import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';

class SignUpPageActivity extends StatefulWidget {
  @override
  _SignUpPageActivityState createState() => _SignUpPageActivityState();
}

class _SignUpPageActivityState extends State<SignUpPageActivity> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _idController = TextEditingController(text: '');
  TextEditingController _pwController = TextEditingController(text: '');
  TextEditingController _confirmPwController = TextEditingController(text: '');
  TextEditingController _emailController = TextEditingController(text: '');
  TextEditingController _phoneNumberController =
      TextEditingController(text: '');
  TextEditingController _SmsCodeController = TextEditingController(text: '');

  Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Center(child: Text('회원가입')),
              actions: [
                SizedBox(
                  width: 56.0,
                )
              ],
            ),
            body: SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text('약관동의'),
                    Container(width: _size.width, height: 1, color: Colors.grey,),
                    signUpForm()
                  ],
                ),
              ),
            )),
          );
        });
  }

  Widget signUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '아이디',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _idController,
            style: TextStyle(fontSize: 14),
            decoration: getTextFieldDecor('아이디'),
            validator: (String value) {
              if (value.isEmpty || value.contains(' ')) {
                return '올바른 형식으로 입력해주세요.(공백 제외)';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '비밀번호',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _pwController,
            obscureText: true,
            style: TextStyle(fontSize: 14),
            decoration: getTextFieldDecor('비밀번호'),
            validator: (String value) {
              if (value.isEmpty || value.contains(' ') || value.length < 6) {
                return '올바른 형식의 비밀번호를 입력해 주세요.\n(공백 제외, 6글자 이상)';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '비밀번호 확인',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _confirmPwController,
            obscureText: true,
            style: TextStyle(fontSize: 14),
            decoration: getTextFieldDecor('비밀번호 확인'),
            validator: (String value) {
              if (_pwController.text != _confirmPwController.text) {
                return '동일한 비밀번호를 입력해 주세요.';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '이메일',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _emailController,
            style: TextStyle(fontSize: 14),
            decoration: getTextFieldDecor('이메일'),
            validator: (String value) {
              if (!isValidEmail()) {
                return '올바른 형식의 이메일을 입력해 주세요.';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '휴대폰 번호',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: _size.width / 1.5,
                child: TextFormField(
                  controller: _phoneNumberController,
                  style: TextStyle(fontSize: 14),
                  decoration: getTextFieldDecor('휴대폰 번호( - 제외 )'),
                  validator: (String value) {
                    if (value.isEmpty ||
                        value.contains(' ') ||
                        value.contains('-')) {
                      return '올바른 형식의 번호를 입력해 주세요.';
                    }
                    return null;
                  },
                ),
              ),
              RaisedButton(
                color: Colors.green,
                onPressed: () {
                  print('인증버튼 눌림');
                },
                child: Text(
                  '인증',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text('인증 코드',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _SmsCodeController,
            style: TextStyle(fontSize: 14),
            decoration: getTextFieldDecor('인증 코드'),
            validator: (String value) {
              if (value.isEmpty) {
                return '인증코드를 입력해 주세요.';
              }
              return null;
            },
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: RaisedButton(
              color: Colors.blue,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  // _register;
                }
              },
              child: Text(
                '가입하기',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  get _register async {
    String errorMessage;
    try {
      final AuthResult _result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _pwController.text);
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (context) => SignUpCompletePage()));
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          showToast('이미 사용하고 있는 아이디입니다.');
          errorMessage = "An undefined Error happened.";
      }
    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  InputDecoration getTextFieldDecor(String hint) {
    return InputDecoration(
        hintText: hint,
        errorStyle: TextStyle(fontSize: 14, color: Colors.red),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[300],
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[300],
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        fillColor: Colors.grey[100],
        filled: true);
  }

  bool isValidEmail() {
    bool valid = EmailValidator.validate(_emailController.text);
    return valid;
  }
}
