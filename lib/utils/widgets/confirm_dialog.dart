import 'package:flutter/material.dart';

/// Created by Huan.Huynh on 2019-07-12.
///
/// Copyright © 2019 teqnological. All rights reserved.

class ConfirmDialog extends StatefulWidget {

  final Widget child;

  const ConfirmDialog({Key key,
    @required this.child,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ConfirmDialogState();
}

class ConfirmDialogState extends State<ConfirmDialog>
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
    return Material(
      color: Colors.black.withOpacity(opacityAnimation.value),
      child: Center(
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery
              .of(context)
              .size
              .width * 0.8,
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                widget.child,
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancel', style: TextStyle(color: Color(0xffb8b8b8), fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(width: 15,),
                    InkWell(
                      onTap: () => Navigator.of(context).pop('OK'),
                      child: Text(
                        'Confirm', style: TextStyle(color: Color(0xff46c3c1), fontWeight: FontWeight.bold),),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}