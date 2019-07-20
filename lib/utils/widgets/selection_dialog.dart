import 'package:flutter/material.dart';

/// Created by Huan.Huynh on 2019-07-12.
///
/// Copyright © 2019 teqnological. All rights reserved.

class SelectionDialog<T> extends StatefulWidget {

  final List<T> data;
  final IndexedWidgetBuilder builder;
  final double itemHeight;

  const SelectionDialog({
    Key key,
    @required this.data,
    @required this.builder,
    this.itemHeight = 100,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => SelectionDialogState();
}

class SelectionDialogState extends State<SelectionDialog>
  with TickerProviderStateMixin {

  // Animation
  AnimationController controller;
  Animation<double> opacityAnimation;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    opacityAnimation = Tween<double>(begin: 0.0, end: 0.4).animate(
      CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    scaleAnimation =
      CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final realHeight = widget.data.length * widget.itemHeight;
    final height = MediaQuery.of(context).size.height * 0.7;
    return Material(
      color: Colors.black.withOpacity(opacityAnimation.value),
      child: Center(
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            width: MediaQuery
              .of(context)
              .size
              .width * 0.8,
            height: realHeight > height ? height : realHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Color(0x19000000),
                  offset: Offset(0, 6),
                  blurRadius: 15,
                  spreadRadius: 0
                )
              ],
            ),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () => Navigator.of(context).pop(widget.data[index]),
                  child: widget.builder(context, index),
                );
              },
              separatorBuilder: (context, index) => Divider(height: 0.3, color: Colors.grey, indent: 8,),
              itemCount: widget.data.length
            ),
          ),
        ),
      )
    );
  }
}