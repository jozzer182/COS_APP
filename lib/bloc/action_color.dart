import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'main__bl.dart';
import 'main_bloc.dart';

onThemeChange(event, emit, MainState Function() supraState) async {
  LocalStorage storage = localStorage;
  await initLocalStorage();
  storage.setItem('isDark', (!supraState().isDark).toString());
  emit(supraState().copyWith(isDark: !supraState().isDark));
}

onThemeColorChange(event, emit, MainState Function() supraState) async {
  Color c = event.color;
  LocalStorage storage = localStorage;
  await initLocalStorage();
  String hexColor = '#${c.value.toRadixString(16).padLeft(8, '0')}';
  storage.setItem('themeColor', hexColor);
  // print(event.color);
  emit(supraState().copyWith(themeColor: event.color));
}

themeLoader(Bl bl) async {
  LocalStorage storage = localStorage;
  await initLocalStorage();
  // SharedPreferences shared = await SharedPreferences.getInstance();
  String? testRead = storage.getItem('isDark');
  if (testRead == null || testRead == '') {
    bl.emit(bl.state().copyWith(isDark: false));
    return;
  }
  // print('testRead: $testRead');
  bl.emit(bl.state().copyWith(isDark: (testRead == 'false') ? false : true));
}

themeColorLoader(Bl bl) async {
  LocalStorage storage = localStorage;
  await initLocalStorage();
  // SharedPreferences shared = await SharedPreferences.getInstance();
  String? hexColor = storage.getItem('themeColor');
  Color color =
      hexColor != null
          ? Color(int.parse(hexColor.replaceFirst('#', ''), radix: 16))
          : Colors.blue;

  // Color testcolorStrgin = Color.fromARGB(alpha, red, green, blue);
  // print(testcolorStrgin);
  bl.emit(bl.state().copyWith(themeColor: color));
}
