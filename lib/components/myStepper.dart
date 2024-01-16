// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:musaneda/config/myColor.dart';

class MyStepper extends StatelessWidget {
  final double _width;
  final List<String> _child;
  final List<String> _titles;
  final int _curStep;
  final Color _activeColor;
  final Color _inactiveColor = MYColor.accent;
  final double lineWidth = 4.0;

  MyStepper({
    super.key,
    required List<String> child,
    required int curStep,
    required List<String> titles,
    required double width,
    required Color color,
  })  : _child = child,
        _titles = titles,
        _curStep = curStep,
        _width = width,
        _activeColor = color,
        assert(curStep > 0 == true && curStep <= child.length),
        assert(width > 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 32.0,
        left: 24.0,
        right: 24.0,
      ),
      width: _width,
      child: Column(
        children: <Widget>[
          Row(
            children: _iconViews(),
          ),
          const SizedBox(
            height: 10,
          ),
          if (_titles.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _titleViews(),
            ),
        ],
      ),
    );
  }

  List<Widget> _iconViews() {
    var list = <Widget>[];
    _child.asMap().forEach(
      (i, icon) {
        //colors according to state
        var circleColor = (i == 0 || _curStep >= i + 1 || _curStep == 4)
            ? _activeColor
            : _inactiveColor;

        var lineColor = _curStep > i + 1 ? _activeColor : _inactiveColor;

        var iconColor =
            (i == 0 || _curStep >= i + 1) ? MYColor.white : MYColor.black;

        list.add(
          //dot with icon view
          Container(
            width: 40.0,
            height: 40.0,
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: circleColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(25.0),
              ),
            ),
            child: Center(
              child: Text(
                icon,
                style: TextStyle(
                  color: iconColor,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        );

        //line between icons
        if (i != _child.length - 1) {
          list.add(
            Expanded(
              child: Container(
                height: lineWidth,
                color: lineColor,
              ),
            ),
          );
        }
      },
    );

    return list;
  }

  List<Widget> _titleViews() {
    var list = <Widget>[];
    _titles.asMap().forEach(
      (i, text) {
        list.add(
          Text(
            text,
            style: TextStyle(
              color:
                  (i == 0 || _curStep >= i + 1) ? _activeColor : MYColor.black,
              fontSize: 13,
              fontFamily: 'montserrat_regular',
            ),
          ),
        );
      },
    );
    return list;
  }
}
