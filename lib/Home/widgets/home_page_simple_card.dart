import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as transition;

class SimpleCard extends StatefulWidget {
  final dynamic page;
  final String title;
  final String image;
  final Function? fun;
  final Color? color;
  final bool disabled;
  final bool mediumOpacity;
  final bool isSecondary;
  final bool esPermitido;
  const SimpleCard({
    required this.page,
    required this.title,
    required this.image,
    required this.disabled,
    this.mediumOpacity = false,
    this.color,
    this.fun,
    this.isSecondary = false,
    super.key,
    this.esPermitido = true,
  });

  @override
  State<SimpleCard> createState() => SimpleCardState();
}

class SimpleCardState extends State<SimpleCard> {
  bool isElevated = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    if (!widget.isSecondary) {
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        setState(() {
          isElevated = !isElevated;
        });
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.esPermitido) {
      return const SizedBox();
    }

    double opacity = !widget.disabled ? 1.0 : 0.1;
    if (widget.mediumOpacity) {
      opacity = !widget.disabled ? 1.0 : 0.6;
    }
    if (!widget.disabled) {
      timer?.cancel();
      isElevated = false;
    }
    return Opacity(
      opacity: opacity,
      child: SizedBox(
        width: 148.0,
        child: Card(
          color: widget.color,
          elevation: isElevated ? 10.0 : 1,
          shadowColor: isElevated
              ? Colors.red
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () async {
              if (!widget.disabled && widget.page != null) {
                await FirebaseAnalytics.instance.logSelectContent(
                  contentType: "page",
                  itemId: widget.title,
                );
                Get.to(
                  widget.page,
                  transition: transition.Transition.rightToLeft,
                );
              }
              if (widget.fun != null) {
                widget.fun!();
              }
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    widget.image,
                    width: 50,
                    height: 50,
                  ),
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
