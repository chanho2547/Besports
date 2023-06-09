import 'package:besports/features/bluetooth/ui/ble_status_screen.dart';
import 'package:besports/features/bluetooth/ui/device_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';

class BluetoothConnection extends StatelessWidget {
  const BluetoothConnection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<BleStatus?>(
        builder: (_, status, __) {
          if (status == BleStatus.ready) {
            return const DeviceListScreen(tmp: "tmp");
          } else {
            return BleStatusScreen(status: status ?? BleStatus.unknown);
          }
        },
      );
}
