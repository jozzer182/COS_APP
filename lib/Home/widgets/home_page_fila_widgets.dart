import 'package:flutter/material.dart';

class FilaWidgets extends StatelessWidget {
  final List<Widget> children;
  final ScrollController _controller = ScrollController();
  FilaWidgets({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 74.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _controller,
        children: children,
      ),
    );
  }
}
