import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class MainState extends GetXState {
  final Logger logger = Get.find<Logger>();
  final RxInt rows = 6.obs;
  final RxList<List<Cell>> cells = <List<Cell>>[].obs;
  final Rx<Pointer> pointer = Pointer(x: 0, y: 0).obs;
  void gen_cells() {
    final random = Random();
    List<List<Cell>> temp = [];
    for (int x = 1; x <= rows.value; x++) {
      List<Cell> l = [];
      for (int y = 1; y <= rows.value; y++) {
        logger.wtf('x:$x, y:$y');
        l.add(Cell(
          isenabled: random.nextBool(),
          x: x,
          y: y,
          cellid: (y - 1) * rows.value + x,
        ));
      }
      temp.add(l);
    }
    cells.value = temp;
  }

  Future<void> is_finished() async {
    final List<List<Cell>> ll = cells;
    for (List<Cell> y in ll) {
      for (Cell x in y) {
        if (!x.isenabled) {
          return;
        }
      }
    }
    Get.back();
    Get.showSnackbar(const GetSnackBar(
      title: "Finished!",
      messageText: Text("お疲れ様です!"),
      animationDuration: Duration(milliseconds: 250),
      duration: Duration(milliseconds: 1500),
    ));
  }

  Future<void> update(ways way) async {
    final Pointer now = pointer.value;
    logger.d(way);
    int x = now.x;
    int y = now.y;
    if (way == ways.right) x++;
    if (way == ways.left) x--;
    if (way == ways.down) y++;
    if (way == ways.up) y--;
    if (0 > x || x >= rows.value || 0 > y || y >= rows.value) {
      //Error!!!
      logger.w("error x:$x, y:$y");
      return;
    } else {
      //続行
      pointer.value = Pointer(x: x, y: y);
      cells[y][x].isenabled = !cells[y][x].isenabled;
      logger.d(pointer);
    }
    await is_finished();
  }
}

class Cell {
  bool isenabled;
  int x;
  int y;
  int cellid;
  Cell({
    required this.isenabled,
    required this.x,
    required this.y,
    required this.cellid,
  });
}

class Pointer {
  int x;
  int y;
  Pointer({
    required this.x,
    required this.y,
  });
}

enum ways {
  right,
  left,
  up,
  down,
}
