import 'package:flutter/widgets.dart';

class CountUp extends StatefulWidget {
  final double begin;
  final double end;
  final int precision;
  final Curve curve;
  final Duration duration;
  final TextStyle style;
  final TextAlign textAlign;
  final TextDirection textDirection;
  // final Locale locale;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int maxLines;
  final String semanticsLabel;
  final String separator;
  final String prefix;
  final String suffix;

  const CountUp({
    Key? key,
    required this.begin,
    required this.end,
    this.precision = 0,
    this.curve = Curves.linear,
    this.duration = const Duration(milliseconds: 250),
    required this.style,
    this.textAlign = TextAlign.left,
    this.textDirection = TextDirection.ltr,
    this.softWrap = false,
    this.overflow = TextOverflow.fade,
    this.textScaleFactor = 1.0,
    this.maxLines = 1,
    this.semanticsLabel = '',
    this.separator = '',
    this.prefix = '',
    this.suffix = '',
    // this.locale = Localiz,
  }) : super(key: key);

  @override
  _CountUpState createState() => _CountUpState();
}

class _CountUpState extends State<CountUp> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double _latestBegin;
  late double _latestEnd;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _latestBegin = widget.begin;
    _latestEnd = widget.end;
  }

  @override
  Widget build(BuildContext context) {
    CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: _controller, curve: widget.curve);
    _animation = Tween<double>(begin: widget.begin, end: widget.end)
        .animate(curvedAnimation);

    if (widget.begin != _latestBegin || widget.end != _latestEnd) {
      _controller.reset();
    }

    _latestBegin = widget.begin;
    _latestEnd = widget.end;
    _controller.forward();

    return _CountUpAnimatedText(
      key: UniqueKey(),
      animation: _animation,
      precision: widget.precision,
      style: widget.style,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      // locale: widget.locale,
      softWrap: widget.softWrap,
      overflow: widget.overflow,
      textScaleFactor: widget.textScaleFactor,
      maxLines: widget.maxLines,
      semanticsLabel: widget.semanticsLabel,
      separator: widget.separator,
      prefix: widget.prefix,
      suffix: widget.suffix,
    );
  }
}

class _CountUpAnimatedText extends AnimatedWidget {
  final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

  final Animation<double> animation;
  final int precision;
  final TextStyle style;
  final TextAlign textAlign;
  final TextDirection textDirection;
  // final Locale locale;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int maxLines;
  final String semanticsLabel;
  final String separator;
  final String prefix;
  final String suffix;

  _CountUpAnimatedText({
    Key? key,
    required this.animation,
    required this.precision,
    required this.style,
    required this.textAlign,
    required this.textDirection,
    // required this.locale,
    required this.softWrap,
    required this.overflow,
    required this.textScaleFactor,
    required this.maxLines,
    required this.semanticsLabel,
    required this.separator,
    required this.prefix,
    required this.suffix,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) => Text(
        '$prefix ' + animation.value.toStringAsFixed(precision).replaceAllMapped(reg, (Match match) => '${match[1]}$separator') + suffix,
        style: style,
        textAlign: textAlign,
        textDirection: textDirection,
        // locale: this.locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
      );
}