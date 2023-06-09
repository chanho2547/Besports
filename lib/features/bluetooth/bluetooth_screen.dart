import 'package:besports/features/bluetooth/ui/device_list.dart';
import 'package:flutter/material.dart';

// 거의 바로 넘어가는 페이지 이다

class BluetoothScreen extends StatefulWidget {
  final dynamic tmp;

  const BluetoothScreen({Key? key, required this.tmp}) : super(key: key);

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onTapNext(widget.tmp.toString().substring(3));
    });
  }

  void onTapNext(String tmp) {
    Navigator.push(
      context,
      MaterialPageRoute(
        // DeivceListScreen으로 넘어간다, 예제의 기본 화면이다
        builder: (context) => DeviceListScreen(
          tmp: tmp,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('블루투스 테스트 페이지')),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "인식된 블루투스 주소",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(widget.tmp.toString().substring(3)),
            // make two buttons
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              child: const Text("NEXT"),
              onPressed: () {
                onTapNext(widget.tmp.toString().substring(3));
              },
            ),
          ],
        ),
      ),
    );
  }
}
