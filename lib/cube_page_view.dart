import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

enum CubeTransformStyle { inside, outside }

typedef CubeWidgetBuilder = CubeWidget Function(
    BuildContext context, int index, double pageNotifier);

class CubePageView extends StatefulWidget {
  final ValueChanged<int>? onPageChanged;

  final PageController? controller;

  final CubeWidgetBuilder? itemBuilder;

  final int? itemCount;

  final List<Widget>? children;

  final Axis scrollDirection;

  final CubeTransformStyle transformStyle;

  final ScrollPhysics? physics;

  const CubePageView({
    Key? key,
    this.onPageChanged,
    this.controller,
    required this.children,
    this.scrollDirection = Axis.horizontal,
    this.transformStyle = CubeTransformStyle.outside,
    this.physics,
  })  : itemBuilder = null,
        itemCount = null,
        super(key: key);

  const CubePageView.builder({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.onPageChanged,
    this.controller,
    this.scrollDirection = Axis.horizontal,
    this.transformStyle = CubeTransformStyle.outside,
    this.physics,
  })  : children = null,
        assert(itemBuilder != null),
        super(key: key);

  @override
  _CubePageViewState createState() => _CubePageViewState();
}

class _CubePageViewState extends State<CubePageView> {
  final _pageNotifier = ValueNotifier(0.0);
  late PageController _pageController;

  void _listener() {
    _pageNotifier.value = _pageController.page ?? 0;
  }

  @override
  void initState() {
    super.initState();

    _pageController = widget.controller ?? PageController();
    _pageNotifier.value = _pageController.initialPage.toDouble();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.addListener(_listener);
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_listener);
    // only dispose if created locally
    if (widget.controller == null) _pageController.dispose();
    _pageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<double>(
        valueListenable: _pageNotifier,
        builder: (_, value, child) => PageView.builder(
          scrollDirection: widget.scrollDirection,
          controller: _pageController,
          onPageChanged: widget.onPageChanged,
          physics: widget.physics ?? const ClampingScrollPhysics(),
          itemCount: widget.itemCount ?? widget.children?.length ?? 0,
          itemBuilder: (_, index) {
            if (widget.itemBuilder != null) {
              return widget.itemBuilder!(context, index, value);
            }
            return CubeWidget(
              index: index,
              pageNotifier: value,
              rotationDirection: widget.scrollDirection,
              transformStyle: widget.transformStyle,
              child: widget.children![index],
            );
          },
        ),
      ),
    );
  }
}

class CubeWidget extends StatelessWidget {
  final int index;

  final double pageNotifier;

  final Axis rotationDirection;

  final bool centerAligned;

  final CubeTransformStyle transformStyle;

  final Widget child;

  const CubeWidget({
    Key? key,
    required this.index,
    required this.pageNotifier,
    required this.child,
    this.rotationDirection = Axis.horizontal,
    this.centerAligned = false,
    this.transformStyle = CubeTransformStyle.outside,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final isLeaving = (index - pageNotifier) <= 0;
    final t = (index - pageNotifier);
    final rotation = lerpDouble(0, 30, t) ?? 0;
    final opacity = lerpDouble(0, 1, t.abs())?.clamp(0.0, 1.0) ?? 0;
    final transform = Matrix4.identity();
    final isPaging = opacity != 1.0;
    if (rotationDirection == Axis.horizontal) {
      transform.setEntry(3, 2, 0.003);
    } else {
      transform.setEntry(3, 2, 0.001);
    }


    if (transformStyle == CubeTransformStyle.outside) {
      if (rotationDirection == Axis.horizontal) {
        transform.rotateY(-degToRad(rotation));
      } else {
        transform.rotateX(degToRad(rotation));
      }
    } else {
      if (rotationDirection == Axis.horizontal) {
        transform.rotateY(degToRad(rotation));
      } else {
        transform.rotateX(-degToRad(rotation));
      }
    }

    AlignmentGeometry alignment;
    if (rotationDirection == Axis.horizontal) {
      alignment = isLeaving
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart;
    } else {
      alignment = !isLeaving
          ? AlignmentDirectional.topCenter
          : AlignmentDirectional.bottomCenter;
    }

    return Transform(
      alignment: alignment,
      transform: transform,
      child: Stack(children: [
        child,
        if (isPaging && !isLeaving)
          Positioned.fill(
            child: Opacity(
              opacity: opacity,
              child: Container(
                color: Colors.black87,
              ),
            ),
          ),
      ]),
    );
  }
}

double degToRad(double deg) => deg * (pi / 180.0);
