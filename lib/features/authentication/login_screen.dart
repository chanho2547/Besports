import 'package:besports/features/exercise/exercise_screen.dart';
import 'package:flutter/material.dart';

const Color myGreen = Color.fromRGBO(50, 210, 0, 1);
const Color myBlack = Color.fromRGBO(28, 29, 27, 1);
const Color myDarkGray = Color.fromRGBO(45, 49, 44, 1);
const Color myLightGray = Color.fromRGBO(181, 181, 181, 1);

late String id;
late String pw;
late bool autoLogin;
late bool clickedFindPw;
late bool clickedJoin;
late bool clickedLogin;

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: myBlack,
        body: Column(
          children: <Widget>[
            // Flex 총합 15
            // 상단 사이즈드 박스
            Flexible(
              flex: 2,
              child: Container(
                color: myBlack,
              ),
            ),

            // 로고 이미지
            Container(
              //make padding top

              // add image as a child
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0, 60, 0, 30),
                child: Image(
                  image: AssetImage('./images/logo_1.png'),
                  width: 280,
                ),
              ),
            ),

            // 문구
            Container(
              // make Text color white
              child: const Text(
                '당신의 건강을 위해 비스포츠는 함께합니다',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
            ),

            // 중간 사이즈드 박스 (가변)
            const MyFlexible(),

            // 아이디 입력창
            Padding(
              padding: const EdgeInsets.all(10),
              child: FractionallySizedBox(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      // make InputDecoration border rounded

                      // make input box background color as myDarkGray
                      filled: true,
                      fillColor: myDarkGray,
                      enabledBorder: OutlineInputBorder(
                        //make OutlineInputBorder border rounded
                        borderRadius: BorderRadius.all(Radius.circular(16)),

                        borderSide: BorderSide(
                          color: myDarkGray,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: myGreen,
                        ),
                      ),
                      // make input box hint text color as myGreen
                      hintText: '이메일',
                      hintStyle: TextStyle(
                        color: Colors.white60,
                      ),
                    ),
                    onChanged: (String value) {
                      id = value;
                    },
                  ),
                ),
              ),
            ),

            // 비밀번호 입력창
            Padding(
              padding: const EdgeInsets.all(10),
              child: FractionallySizedBox(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      // make InputDecoration border rounded

                      // make input box background color as myDarkGray
                      filled: true,
                      fillColor: myDarkGray,
                      enabledBorder: OutlineInputBorder(
                        //make OutlineInputBorder border rounded
                        borderRadius: BorderRadius.all(Radius.circular(16)),

                        borderSide: BorderSide(
                          color: myDarkGray,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: myGreen,
                        ),
                      ),
                      // make input box hint text color as myGreen
                      hintText: '패스워드',
                      hintStyle: TextStyle(
                        color: Colors.white60,
                      ),
                    ),
                    onChanged: (String value) {
                      pw = value;
                    },
                  ),
                ),
              ),
            ),

            // 자동 로그인, 비밀번호 찾기
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 10),
              child: FractionallySizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    // 자동 로그인
                    Text("자동 로그인",
                        style: TextStyle(
                            color: Color(0xff6bd20f),
                            fontWeight: FontWeight.w500,
                            fontFamily: "SpoqaHanSansNeo",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0),
                        textAlign: TextAlign.center),
                    // 비밀번호 찾기
                    Text("비밀번호 찾기",
                        style: TextStyle(
                            color: Color(0xffc2c2c2),
                            fontWeight: FontWeight.w400,
                            fontFamily: "SpoqaHanSansNeo",
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0),
                        textAlign: TextAlign.left)
                  ],
                ),
              ),
            ),

            // 로그인 버튼
            SizedBox(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: myGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ExerciseScreen(id: id, pw: pw)),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: const Text(
                        '로그인',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Flexible(
                flex: 1,
                child: // 비스포츠가 처음이신가요? 회원가입
                    RichText(
                        text: const TextSpan(children: [
                  TextSpan(
                      style: TextStyle(
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w400,
                          fontFamily: "SpoqaHanSansNeo",
                          fontStyle: FontStyle.normal,
                          fontSize: 12.0),
                      text: "비스포츠가 처음이신가요? "),
                  TextSpan(
                      style: TextStyle(
                          color: Color(0xff6bd20f),
                          fontWeight: FontWeight.w500,
                          fontFamily: "SpoqaHanSansNeo",
                          fontStyle: FontStyle.normal,
                          fontSize: 12.0),
                      text: "회원가입")
                ]))),
          ],
        ),
      ),

      //delete debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyFlexible extends StatefulWidget {
  const MyFlexible({Key? key}) : super(key: key);

  @override
  _MyFlexibleState createState() => _MyFlexibleState();
}

class _MyFlexibleState extends State<MyFlexible> {
  int _flexValue = 0;

  @override
  Widget build(BuildContext context) {
    if (isKeyboardVisible(context)) {
      _flexValue = 7;
    } else {
      _flexValue = 1;
    }

    return AnimatedFractionallySizedBox(
      duration: const Duration(milliseconds: 500),
      child: Flexible(
        flex: _flexValue,
        child: Container(
          color: myBlack,
        ),
      ),
    );
  }
}

bool isKeyboardVisible(BuildContext context) {
  return MediaQuery.of(context).viewInsets.bottom > 0;
}
