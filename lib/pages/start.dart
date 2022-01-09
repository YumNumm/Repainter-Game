import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:repainter/class/MainState.dart';

class StartPage extends StatelessWidget {
  StartPage({Key? key}) : super(key: key);
  final MainState state = Get.find<MainState>();
  final Logger logger = Get.find<Logger>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [],
        title: const Text("Repainter - Start"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            maxLength: 2,
            keyboardType: TextInputType.number,
            onChanged: (value) => state.rows.value = (int.tryParse(value) ?? 1),
          ),
          FloatingActionButton.extended(
            onPressed: () async {
              state.gen_cells();
              state.pointer.value = Pointer(x: 0, y: 0);
              logger.w(state.cells.length);
              logger.w(state.cells[0].length);
              Get.toNamed('/main');
            },
            label: const Text("開始!"),
            icon: const Icon(Icons.navigate_next),
          )
        ],
      )),
    );
  }
}
