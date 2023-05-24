import 'dart:async';
import 'dart:convert';

import 'package:besports/features/bluetooth/ble/ble_device_interactor.dart';
import 'package:besports/features/exercise/count_model.dart';
import 'package:besports/features/exercise/exercise_count_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';

class CharacteristicInteractionDialog extends StatelessWidget {
  const CharacteristicInteractionDialog({
    required this.characteristic,
    Key? key,
  }) : super(key: key);
  final QualifiedCharacteristic characteristic;

  @override
  Widget build(BuildContext context) => Consumer<BleDeviceInteractor>(
      builder: (context, interactor, _) => _CharacteristicInteractionDialog(
            characteristic: characteristic,
            readCharacteristic: interactor.readCharacteristic,
            writeWithResponse: interactor.writeCharacterisiticWithResponse,
            writeWithoutResponse:
                interactor.writeCharacterisiticWithoutResponse,
            subscribeToCharacteristic: interactor.subScribeToCharacteristic,
          ));
}

class _CharacteristicInteractionDialog extends StatefulWidget {
  const _CharacteristicInteractionDialog({
    required this.characteristic,
    required this.readCharacteristic,
    required this.writeWithResponse,
    required this.writeWithoutResponse,
    required this.subscribeToCharacteristic,
    Key? key,
  }) : super(key: key);

  final QualifiedCharacteristic characteristic;
  final Future<List<int>> Function(QualifiedCharacteristic characteristic)
      readCharacteristic;
  final Future<void> Function(
          QualifiedCharacteristic characteristic, List<int> value)
      writeWithResponse;

  final Stream<List<int>> Function(QualifiedCharacteristic characteristic)
      subscribeToCharacteristic;

  final Future<void> Function(
          QualifiedCharacteristic characteristic, List<int> value)
      writeWithoutResponse;

  @override
  _CharacteristicInteractionDialogState createState() =>
      _CharacteristicInteractionDialogState();
}

class _CharacteristicInteractionDialogState
    extends State<_CharacteristicInteractionDialog> {
  int count = 0;
  late String readOutput;
  late String writeOutput;
  late String subscribeOutput;
  late TextEditingController textEditingController;
  late StreamSubscription<List<int>>? subscribeStream;
  CountModel countModel = CountModel();

  @override
  void initState() {
    readOutput = '';
    writeOutput = '';
    subscribeOutput = '';
    textEditingController = TextEditingController();

    // 켜자마자 구독 시작
    subscribeCharacteristic();

    // 이 화면 오자마자 운동 시작
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ExersiseCountScreen()),
    );
    super.initState();
  }

  @override
  void dispose() {
    subscribeStream?.cancel();
    super.dispose();
  }

  Future<void> subscribeCharacteristic() async {
    // Access the current instance of CountModel.
    CountModel countModel = Provider.of<CountModel>(context, listen: false);

    subscribeStream =
        widget.subscribeToCharacteristic(widget.characteristic).listen((event) {
      setState(() {
        print("subscribe button pressed, what I was finding");
        //print('event: $event');
        print(utf8.decode(event));
        // stay this way for now, but we need to figure out how to get the data from the event

        subscribeOutput = event.toString();
        count++;
        //CountModel().incrementCount(count);
        countModel.incrementCount(count);
        print("subscribeOutput: $subscribeOutput");
      });
    });
    setState(() {
      subscribeOutput = 'Notification set';
    });
  }

  Future<void> readCharacteristic() async {
    final result = await widget.readCharacteristic(widget.characteristic);

    final tmp = utf8.decode(result);

    setState(() {
      readOutput = tmp.toString();
    });
  }

  List<int> _parseInput() => textEditingController.text
      .split(',')
      .map(
        int.parse,
      )
      .toList();

  Future<void> writeCharacteristicWithResponse() async {
    await widget.writeWithResponse(widget.characteristic, _parseInput());
    setState(() {
      writeOutput = 'Ok';
    });
  }

  Future<void> writeCharacteristicWithoutResponse() async {
    await widget.writeWithoutResponse(widget.characteristic, _parseInput());
    setState(() {
      writeOutput = 'Done';
    });
  }

  Widget sectionHeader(String text) => Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      );

  List<Widget> get writeSection => [
        sectionHeader('Write characteristic'),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            controller: textEditingController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Value',
            ),
            // keyboardType: const TextInputType.numberWithOptions(
            //   decimal: true,
            //   signed: false,
            // ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: writeCharacteristicWithResponse,
              child: const Text('With response'),
            ),
            ElevatedButton(
              onPressed: writeCharacteristicWithoutResponse,
              child: const Text('Without response'),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 8.0),
          child: Text('Output: $writeOutput'),
        ),
      ];

  List<Widget> get readSection => [
        sectionHeader('Read characteristic'),
        SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: readCharacteristic,
                child: const Text('Read'),
              ),
              Text('Output: $readOutput'),
            ],
          ),
        ),
      ];

  List<Widget> get subscribeSection => [
        sectionHeader('Subscribe / notify'),
        Consumer<CountModel>(
          builder: (context, countModel, _) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  subscribeCharacteristic();
                  //countModel.incrementCount(); // increment count
                },
                child: const Text('Subscribe'),
              ),
              //Text('Output: $subscribeOutput'),
              Text('Count: $count'), // display count
            ],
          ),
        ),
      ];

  Widget get divider => const Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Divider(thickness: 2.0),
      );

  @override
  Widget build(BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text(
                'Select an operation',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  widget.characteristic.characteristicId.toString(),
                ),
              ),
              divider,
              ...readSection,
              divider,
              ...writeSection,
              divider,
              ...subscribeSection,
              divider,
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('close')),
                ),
              )
            ],
          ),
        ),
      );
}
