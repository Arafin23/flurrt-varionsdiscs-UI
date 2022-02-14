import 'dart:math';

import 'package:flutter/material.dart';

class DiscsData {
  static final _rng = Random();

  final double size;
  final Color color;
  final Alignment alignment;

  DiscsData()
      : size = _rng.nextDouble() * 40 + 10,
        color = Color.fromARGB(
          _rng.nextInt(200),
          _rng.nextInt(255),
          _rng.nextInt(255),
          _rng.nextInt(255),
        ),
        alignment = Alignment(
          _rng.nextDouble() * 2 - 1,
          _rng.nextDouble() * 2 - 1,
        );
}

void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Color(0xFF15202D),
          child: SizedBox(
            child: VarionsDiscs(50),
          ),
        ),
      ),
    ),
  );
}

class VarionsDiscs extends StatefulWidget {
  final int numberOfDiscs;

  VarionsDiscs(this.numberOfDiscs);

  @override
  _VarionsDiscsState createState() => _VarionsDiscsState();
}

class _VarionsDiscsState extends State<VarionsDiscs> {
  final _discs = <DiscsData>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _makeDiscs();
  }

  void _makeDiscs() {
    _discs.clear();
    for (int i = 0; i < widget.numberOfDiscs; i++) {
      _discs.add(DiscsData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text(
            'Click a Disc',
            style: TextStyle(
              color: Colors.white,
              fontSize: 50,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() {
            _makeDiscs();
          }),
          child: Stack(
            children: [
              for (final disc in _discs)
                Positioned.fill(
                  child: AnimatedAlign(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    alignment: disc.alignment,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                        color: disc.color,
                        shape: BoxShape.circle,
                      ),
                      height: disc.size,
                      width: disc.size,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
