import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pawtrol/src/shared/theme/app_colors.dart';

class SliderButton extends StatefulWidget {
  final double height = 64;
  final animationDuration = const Duration(milliseconds: 300);
  final String? text;
  final Function() onSlided;
  final bool enabled;
  final SliderButtonController? controller;
  const SliderButton({
    required this.onSlided,
    this.text,
    this.controller,
    this.enabled = true,
    super.key,
  });

  @override
  State<SliderButton> createState() => _SliderButtonState();
}

class SliderButtonController extends ChangeNotifier {
  void reset() {
    notifyListeners();
  }
}

class _SliderButtonState extends State<SliderButton>
    with TickerProviderStateMixin {
  double _sliderRelativePosition = 0.0;
  double _startedDraggingAtX = 0.0;
  late final AnimationController _animationController;
  late final Animation _sliderAnimation;
  late final AnimationController _arrowAnimationController;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller!.addListener(reset);
    }
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _sliderAnimation = CurveTween(curve: Curves.easeInQuad)
        .animate(_animationController);

    _animationController.addListener(() {
      setState(() {
        _sliderRelativePosition = _sliderAnimation.value;
      });
    });

    _arrowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _arrowAnimationController.dispose();
    super.dispose();
  }

  @override
  void reset() {
    _animationController.reverse(from: _sliderRelativePosition);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(_radius),
        border: _border,
      ),
      child: LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          final sliderRadius = widget.height / 2;
          final sliderMaxX = constraints.maxWidth - 2 * sliderRadius;
          final sliderPosX = sliderMaxX * _sliderRelativePosition;
          return Stack(
            children: [
              _buildBackground(
                width: constraints.maxWidth,
                backgroundSplitX: sliderPosX + sliderRadius,
              ),
              _buildText(
                width: constraints.maxWidth,
                backgroundSplitX: sliderPosX + sliderRadius,
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: _buildAnimatedArrows(),
                  ),
                ),
              ),

              _buildSlider(sliderMaxX: sliderMaxX, sliderPositionX: sliderPosX),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBackground({
    required double width,
    required double backgroundSplitX,
  }) {
    return Row(
      children: [
        Container(
          height: widget.height,
          width: backgroundSplitX,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: _radius,
              bottomLeft: _radius,
            ),
            color: Colors.white,
          ),
        ),
        ClipRRect(
          child: BackdropFilter(
            // Controls the intensity of the flutter container blur
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),

            child: Container(
              width: width - backgroundSplitX,
              height: widget.height,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.only(
                  topRight: _radius,
                  bottomRight: _radius,
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildText({required double width, required double backgroundSplitX}) {
    if (widget.text == null) {
      return const SizedBox();
    }
    final split = (backgroundSplitX / width).clamp(0.0, 1.0);

    return Stack(
      children: [
        SizedBox(
          width: width,
          height: widget.height,
          child: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: const [
                  AppColors.primaryColor,
                  AppColors.primaryColor,
                  Colors.white,
                  Colors.white,
                ],
                stops: [0.0, split, split, 1.0],
              ).createShader(bounds);
            },
            child: Center(
              child: Text(
                widget.text!,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSlider({
    required double sliderMaxX,
    required double sliderPositionX,
  }) {
    return Positioned(
      left: sliderPositionX,
      child: GestureDetector(
        onHorizontalDragStart: (start) {
          if (!widget.enabled) {
            return;
          }
          _startedDraggingAtX = sliderPositionX;
          _animationController.stop();
        },
        onHorizontalDragUpdate: (update) {
          if (!widget.enabled) {
            return;
          }
          final newSliderPositionX =
              _startedDraggingAtX + update.localPosition.dx;
          final newSliderRelativePosition = newSliderPositionX / sliderMaxX;
          setState(() {
            _sliderRelativePosition = max(0, min(1, newSliderRelativePosition));
          });
        },
        onHorizontalDragEnd: (end) {
          if (!widget.enabled) {
            return;
          }
          if (_sliderRelativePosition == 1.0) {
            widget.onSlided();
          } else {
            reset();
          }
        },
        child: Container(
          height: widget.height,
          width: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(_radius),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_forward_rounded, color: AppColors.primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedArrows() {
    return AnimatedBuilder(
      animation: _arrowAnimationController,
      builder: (context, child) {
        final progress = _arrowAnimationController.value;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final phase = (progress - index * 0.25 + 1.0) % 1.0;

            final opacity = 0.25 + 0.75 * sin(phase * pi);

            return Opacity(
              opacity: opacity.clamp(0.25, 1.0),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 12,
              ),
            );
          }),
        );
      },
    );
  }

  Radius get _radius => Radius.circular(widget.height);
  Border get _border => Border.all(color: Colors.white.withValues(alpha: 0.2));
}
