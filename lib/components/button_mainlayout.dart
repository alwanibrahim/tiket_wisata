import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

SalomonBottomBarItem buttonMainlayout({
  required Icon icon,
  required String teks,
  required Color color,
}) {
  return SalomonBottomBarItem(
    icon: icon,
    title: Text(teks),
    selectedColor: color,
  );
}
