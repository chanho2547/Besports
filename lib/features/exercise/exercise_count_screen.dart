import 'package:besports/features/exercise/count_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExersiseCountScreen extends StatefulWidget {
  const ExersiseCountScreen({super.key});

  @override
  State<ExersiseCountScreen> createState() => _ExersiseCountScreenState();
}

class _ExersiseCountScreenState extends State<ExersiseCountScreen> {
  //Timer? _timer;

  // @override
  // void setState(VoidCallback fn) {
  //   // TODO: implement setState
  //   print("initState is called");
  //   super.setState(fn);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Count Screen'),
      ),
      body: Center(
        child: Consumer<CountModel>(
          builder: (context, countModel, _) => Text(
            'Count: ${countModel.count} \n\n ',
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
