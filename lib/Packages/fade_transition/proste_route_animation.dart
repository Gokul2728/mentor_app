library proste_route_animation;

import 'package:flutter/material.dart';
import 'proste_route_animation_class.dart';
import 'proste_route_animation_type.dart';

/// Route animation by using flutter's transition widget
///
/// Notice that using the constructor method can not control the routing time,
/// other static functions can control the entry and exit time.
///
/// [duration] can control route entry time
/// [reverseDuration] can control route exit time
/// [useFade] let the route animation also include fade effects, it is only [ProsteAnimationMode.fade] wont not use.
/// [alignment] determine the starting position of the animation, it is [ProsteAnimationMode.fade] and [Animation.slide...] wont not use.
/// [axis] determine the axis of the animation, is only [ProsteAnimationMode.size] use.
/// [curve] is all mode can use.
class ProsteRouteAnimation extends MaterialPageRoute {
  WidgetBuilder builder;

  /// Confirm animation type
  ProsteAnimationMode mode;

  /// Execute animation is whether to execute fade animation at the same time
  bool useFade;

  /// Determine the starting position of animation execution
  Alignment alignment;

  /// Determine animation execution spindle position
  Axis axis;

  /// Determine animation curve
  Curve curve;

  ProsteRouteAnimation({
    required this.builder,
    ProsteAnimationMode mode = ProsteAnimationMode.fade,
    bool useFade = false,
    Alignment alignment = Alignment.bottomCenter,
    Axis axis = Axis.vertical,
    Curve curve = Curves.linear,
    bool maintainState = true,
    bool fullscreenDialog = false,
  })  : mode = mode,
        useFade = useFade,
        alignment = alignment,
        axis = axis,
        curve = curve,
        super(
          builder: builder,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        );

  /// Rewriting the method of realizing route animation
  @override
  Widget buildTransitions(context, animation, secondaryAnimation, child) {
    switch (mode) {
      case ProsteAnimationMode.slideFromLeft:
        Animation<Offset> position =
            Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
                .chain(CurveTween(curve: curve))
                .animate(animation);

        Widget transitionWidget = SlideTransition(
          position: position,
          child: child,
        );
        if (useFade) {
          return FadeTransition(
            opacity: animation,
            child: transitionWidget,
          );
        }
        return transitionWidget;
      case ProsteAnimationMode.slideFromRight:
        Animation<Offset> position =
            Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                .chain(CurveTween(curve: curve))
                .animate(animation);

        Widget transitionWidget = SlideTransition(
          position: position,
          child: child,
        );
        if (useFade) {
          return FadeTransition(
            opacity: animation,
            child: transitionWidget,
          );
        }
        return transitionWidget;
      case ProsteAnimationMode.slideFromBottom:
        Animation<Offset> position =
            Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0))
                .chain(CurveTween(curve: curve))
                .animate(animation);

        Widget transitionWidget = SlideTransition(
          position: position,
          child: child,
        );
        if (useFade) {
          return FadeTransition(
            opacity: animation,
            child: transitionWidget,
          );
        }
        return transitionWidget;
      case ProsteAnimationMode.slideFromTop:
        Animation<Offset> position =
            Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
                .chain(CurveTween(curve: curve))
                .animate(animation);

        Widget transitionWidget = SlideTransition(
          position: position,
          child: child,
        );
        if (useFade) {
          return FadeTransition(
            opacity: animation,
            child: transitionWidget,
          );
        }
        return transitionWidget;
      case ProsteAnimationMode.scale:
        Animation<double> animated = Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: curve))
            .animate(animation);
        Widget transitionWidget = ScaleTransition(
          scale: animated,
          alignment: alignment,
          child: child,
        );
        if (useFade) {
          return FadeTransition(
            opacity: animated,
            child: transitionWidget,
          );
        }
        return transitionWidget;
      case ProsteAnimationMode.rotation:
        Animation<double> turns = Tween(begin: 1.2, end: 1.0)
            .chain(CurveTween(curve: curve))
            .animate(animation);
        Widget transitionChild = RotationTransition(
          turns: turns,
          child: child,
          alignment: alignment,
        );
        if (useFade) {
          return FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0)
                .chain(CurveTween(curve: curve))
                .animate(animation),
            child: transitionChild,
          );
        }
        return transitionChild;
      case ProsteAnimationMode.size:
        Animation<double> animated = Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: curve))
            .animate(animation);

        Widget transitionChild = Align(
          alignment: alignment,
          child: SizeTransition(
            sizeFactor: animated,
            child: child,
            axis: axis,
          ),
        );
        if (useFade) {
          return FadeTransition(
            opacity: animated,
            child: transitionChild,
          );
        }

        return transitionChild;
      case ProsteAnimationMode.fade:
      default:
        Animation<double> animated = Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: curve))
            .animate(animation);
        return FadeTransition(opacity: animated, child: child);
    }
  }

  /// static function, in order to realize fade animation
  /// route is required, else params had defalut value
  static Route fadeRoute({
    required Widget route,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    Curve curve = Curves.linear,
  }) {
    return FadeRouteAnimation(
      route,
      duration: duration,
      reverseDuration: reverseDuration,
      curve: curve,
    );
  }

  /// static function, in order to realize slide animation
  /// route is required, else params had defalut value
  static Route slideRoute({
    required Widget route,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    ProsteSlideMode mode = ProsteSlideMode.fromRight,
    bool useFade = false,
    Curve curve = Curves.linear,
  }) {
    return SlideRouteAnimation(
      route,
      duration: duration,
      reverseDuration: reverseDuration,
      mode: mode,
      useFade: useFade,
      curve: curve,
    );
  }

  /// static function, in order to realize scale animation
  /// route is required, else params had defalut value
  static Route scaleRoute({
    required Widget route,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    bool useFade = false,
    Alignment alignment = Alignment.center,
    Curve curve = Curves.linear,
  }) {
    return ScaleRouteAnimation(
      route,
      duration: duration,
      reverseDuration: reverseDuration,
      useFade: useFade,
      alignment: alignment,
      curve: curve,
    );
  }

  /// static function, in order to realize rotation animation
  /// route is required, else params had defalut value
  static Route rotationRoute({
    required Widget route,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    bool useFade = false,
    Alignment alignment = Alignment.bottomCenter,
    Curve curve = Curves.linear,
  }) {
    return RotationRouteAnimation(
      route,
      duration: duration,
      reverseDuration: reverseDuration,
      useFade: useFade,
      alignment: alignment,
      curve: curve,
    );
  }

  /// static function, in order to realize size change animation
  /// route is required, else params had defalut value
  static Route sizeRoute({
    required Widget route,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    bool useFade = false,
    Alignment alignment = Alignment.bottomCenter,
    Axis axis = Axis.vertical,
    Curve curve = Curves.linear,
  }) {
    return SizeRouteAnimation(
      route,
      duration: duration,
      reverseDuration: reverseDuration,
      useFade: useFade,
      alignment: alignment,
      axis: axis,
      curve: curve,
    );
  }
}
