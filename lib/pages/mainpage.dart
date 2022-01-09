import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:repainter/class/MainState.dart';

var globalKey = GlobalKey();

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final Logger logger = Get.find<Logger>();
  final MainState state = Get.find<MainState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: const <Widget>[],
          title: const Text("Repainter"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: min(Get.height, Get.width),
              width: min(Get.height, Get.width),
              child: Container(
                margin: EdgeInsets.all((state.rows.value > 15) ? 10 : 1),
                child: GridView.count(
                  crossAxisCount: state.rows.value,
                  mainAxisSpacing: (state.rows.value > 15) ? 0.1 : 1,
                  crossAxisSpacing: (state.rows.value > 15) ? 0.1 : 1,
                  children: List.generate(
                      state.cells.length * state.cells[0].length, (index) {
                    final x = index % state.rows.value;
                    final y = index ~/ state.rows.value;
                    logger.d('x:$x, y:$y');
                    return Obx(() => Card(
                          elevation: (state.cells[y][x].isenabled) ? 8 : 0,
                          shadowColor: (state.cells[y][x].isenabled)
                              ? Colors.blueAccent
                              : Colors.white,
                          color: (state.cells[y][x].isenabled)
                              ? Colors.blueAccent
                              : Colors.grey,
                          child: Container(),
                          shape: RoundedRectangleBorder(
                              side: ((x == state.pointer.value.x) &&
                                      (y == state.pointer.value.y))
                                  ? const BorderSide(
                                      color: Colors.greenAccent,
                                      width: 4,
                                    )
                                  : BorderSide.none,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                        ));
                  }, growable: false),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () async => await state.update(ways.up),
              child: const Text("↑"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () async => await state.update(ways.left),
                  child: const Text("←"),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                ),
                FloatingActionButton(
                  onPressed: () async => await state.update(ways.right),
                  child: const Text("→"),
                ),
              ],
            ),
            FloatingActionButton(
              onPressed: () async => await state.update(ways.down),
              child: const Text("↓"),
            ),
          ],
        ));
  }
}
