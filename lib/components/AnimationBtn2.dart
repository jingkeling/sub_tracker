import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimationBtn2 extends HookWidget {
  const AnimationBtn2({
    super.key,
    required this.onTap,
    required this.child,
    this.scaleRatio = 0.95,
    this.scaleDuration = const Duration(milliseconds: 100),
    this.enableHapticFeedback = true,
    this.isSpread = false,
    this.spreadColor = Colors.white,
  });

  /// 要执行的 必选
  final GestureTapCallback onTap;

  /// 内容
  final Widget child;

  /// 缩放比例
  final double scaleRatio;

  /// 缩放动画时长
  final Duration scaleDuration;

  /// 是否开启震动
  final bool enableHapticFeedback;

  final bool isSpread;
  final Color spreadColor;

  @override
  Widget build(BuildContext context) {
    final spread = useState<bool>(isSpread);

    // (主动动画)按钮缩放动画
    final btnController = useAnimationController(duration: scaleDuration);
    final btnAnimation = useAnimation(Tween(begin: 1.0, end: scaleRatio).animate(btnController)); // 按钮缩放

    // （自动动画）扩散动画
    final spController = useAnimationController(duration: const Duration(milliseconds: 950));
    final spAnimation = useAnimation(Tween(begin: 1.0, end: 1.1).animate(spController)); // 波纹缩放
    final opAnimation = useAnimation(Tween(begin: 0.75, end: 0.5).animate(spController)); // 透明度

    useEffect(() {
      btnController.addStatusListener((status) {
        // 按钮缩放动画结束后，执行震动
        if (status == AnimationStatus.dismissed) {
          if (enableHapticFeedback) HapticFeedback.lightImpact();
        }
      });
      spController.addStatusListener((status) {
        // 波纹扩散动画结束后，重置并重新开始
        if (status == AnimationStatus.completed) {
          spController.reset();
          spController.forward();
        }
      });
      spController.forward();
      return null;
    }, []);

    useEffect(() {
      if (spread.value != isSpread) {
        spread.value = isSpread;
      }
      return null;
    }, [isSpread]);

    return Stack(
      children: <Widget>[
        if (spread.value == true)
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: AnimatedBuilder(
              animation: spController,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: spreadColor,
                ),
              ),
              builder: (context, child) {
                return Transform.scale(
                  scale: spAnimation,
                  child: Opacity(
                    opacity: opAnimation,
                    child: child,
                  ),
                );
              },
            ),
          ),
        GestureDetector(
            onTap: () {
              onTap();
            },
            onPanDown: (details) {
              btnController.forward();
            },
            // 按下后，手指划出松开触发
            onPanEnd: (details) {
              if (btnController.status != AnimationStatus.reverse) btnController.reverse();
            },
            // 按下后，正常手指松开触发、页面滑动触发
            onPanCancel: () {
              if (btnController.status != AnimationStatus.reverse) btnController.reverse();
            },
            child: AnimatedBuilder(
              animation: btnController,
              child: child,
              builder: (context, child) {
                return Transform.scale(
                  scale: btnAnimation,
                  child: child,
                );
              },
            )),
      ],
    );
  }
}
