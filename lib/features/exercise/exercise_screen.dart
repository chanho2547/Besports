import 'dart:io';
import 'dart:typed_data';
import 'package:app_settings/app_settings.dart';
import 'package:besports/features/bluetooth/bluetooth_screen.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class ExerciseScreen extends StatefulWidget {
  final String id;
  final String pw;

  const ExerciseScreen({
    super.key,
    required this.id,
    required this.pw,
  });

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  Color buttonColor = Colors.blue;
  Color pressedButtonColor = Colors.blue.shade100;
  String id = "Not Yet input ID";

  @override
  void initState() {
    super.initState();
    id = widget.id; // initState 메서드에서 widget.id를 사용하여 id를 초기화합니다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onNFCButtonPressedDown(); // 첫 프레임이 그려진 후에 onNFCButtonPressedDown 함수를 호출합니다.
    });
  }

  String _handleNFCMessage(NfcTag tag) {
    try {
      Map tagData = tag.data;
      Map tagNdef = tagData['ndef'];
      Map cachedMessage = tagNdef['cachedMessage'];
      Map records = cachedMessage['records'][0];
      Uint8List payload = records['payload'];
      String payloadAsString = String.fromCharCodes(payload);

      return payloadAsString;
    } catch (e) {
      throw "NFC 데이터를 가져올 수 없습니다.";
    }
  }

  Future<void> onNFCButtonPressedDown() async {
    if (Platform.isAndroid) {
      await showDialog(
        context: context,
        builder: (context) => _AndroidSessionDialog(
            "$id 님, 기기를 NFC 가까이에 가져다주세요.", _handleNFCMessage),
      );
    }
    if (!(await NfcManager.instance.isAvailable())) {
      if (Platform.isAndroid) {
        if (!mounted) return;
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("오류"),
            content: const Text(
              "NFC를 지원하지 않는 기기이거나 일시적으로 비활성화 되어 있습니다.",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);

                  AppSettings.openNFCSettings();
                },
                child: const Text("설정", style: TextStyle(color: Colors.blue)),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("확인", style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        );

        return;
      }

      throw "NFC를 지원하지 않는 기기이거나 일시적으로 비활성화 되어 있습니다.";
    }

    setState(() {
      buttonColor = pressedButtonColor;
    });
  }

  // void onNFCButtonPressedUp() {
  //   setState(() {
  //     buttonColor = Colors.blue;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: const [
                SizedBox(
                  height: 100,
                ),
                // Text(
                //   "$id 님\n반갑습니다!",
                //   style: const TextStyle(
                //     fontSize: 30,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // GestureDetector(
                //   onTapDown: (details) async {
                //     onNFCButtonPressedDown();
                //   },
                //   onTapUp: (details) {
                //     onNFCButtonPressedUp();
                //   },
                //   child: Container(
                //     width: 300,
                //     height: 300,
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: buttonColor,
                //     ),
                //     child: const Center(
                //       child: Text(
                //         "NFC 연결 임시버튼",
                //         style: TextStyle(
                //           fontSize: 30,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const BluetoothConnection(),
                //       ),
                //     );
                //   },
                //   child: const Text("To TMP Page"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AndroidSessionDialog extends StatefulWidget {
  const _AndroidSessionDialog(this.alertMessage, this._handleNFCMessage);

  final String alertMessage;

  // final String Function(NfcTag tag) handleTag;

  final String Function(NfcTag tag) _handleNFCMessage;

  @override
  State<StatefulWidget> createState() => _AndroidSessionDialogState();
}

class _AndroidSessionDialogState extends State<_AndroidSessionDialog> {
  String? _alertMessage;
  String? _errorMessage;

  String? _result;

  @override
  void initState() {
    super.initState();

    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        try {
          _result = widget._handleNFCMessage(tag);

          //setState(() => _alertMessage = "NFC 태그를 인식하였습니다.");

          if (!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              // builder: (context) => BluetoothConnection(),
              builder: (context) => BluetoothScreen(
                tmp: _result!,
              ),
            ),
          );
        } catch (e) {
          await NfcManager.instance.stopSession();

          setState(() => _errorMessage = '$e');
        }
      },
    ).catchError((e) => setState(() => _errorMessage = '$e'));
  }

  @override
  void dispose() {
    NfcManager.instance.stopSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        _errorMessage?.isNotEmpty == true
            ? "오류"
            : _alertMessage?.isNotEmpty == true
                ? "성공"
                : "준비",
      ),
      content: Text(
        _errorMessage?.isNotEmpty == true
            ? _errorMessage!
            : _alertMessage?.isNotEmpty == true
                ? _alertMessage!
                : widget.alertMessage,
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
              _errorMessage?.isNotEmpty == true
                  ? "확인"
                  : _alertMessage?.isNotEmpty == true
                      ? "완료"
                      : "취소",
              style: const TextStyle(color: Colors.blue)),
          onPressed: () => Navigator.of(context).pop(_result),
        ),
      ],
    );
  }
}
