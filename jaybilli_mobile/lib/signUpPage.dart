import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _idController = TextEditingController(text: '');
  TextEditingController _pwController = TextEditingController(text: '');

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: signUpForm(),
              ),
            ),
          );
        });
  }

  Widget signUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
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
            height: 40,
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
            height: 40,
          ),
          Center(
            child: RaisedButton(
              color: Colors.blue,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _register;
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
      final AuthResult result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _idController.text + '@gmail.com',
              password: _pwController.text);

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => SignUpCompletePage()));
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

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}

class SignUpCompletePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              '가입 완료',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 50,
            ),
            Center(
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  '확인',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
