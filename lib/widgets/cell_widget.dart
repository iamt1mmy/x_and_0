import 'package:flutter/material.dart';

class CellWidget extends StatefulWidget {
  final String symbol;
  final double size;
  final Color neon;

  const CellWidget({required this.symbol, required this.size, required this.neon, super.key});

  @override
  State<CellWidget> createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 280));
    if (widget.symbol != '') _ctrl.forward();
  }

  @override
  void didUpdateWidget(covariant CellWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.symbol == '' && widget.symbol != '') {
      _ctrl.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.symbol == '') return const SizedBox.shrink();
    return ScaleTransition(
      scale: CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut),
      child: widget.symbol == 'X'
          ? ShaderMask(
              shaderCallback: (rect) => LinearGradient(colors: [widget.neon, Colors.white]).createShader(rect),
              child: Text('X', style: TextStyle(fontSize: widget.size, fontWeight: FontWeight.w900, color: Colors.white, shadows: [BoxShadow(color: widget.neon.withOpacity(0.7), blurRadius: 18)])),
            )
          : Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: widget.neon, width: widget.size * 0.12), boxShadow: [BoxShadow(color: widget.neon.withOpacity(0.18), blurRadius: 12)]),
            ),
    );
  }
}
