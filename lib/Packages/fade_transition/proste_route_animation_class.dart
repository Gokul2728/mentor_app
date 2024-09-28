import 'package:flutter/material.dart';
import 'proste_route_animation_type.dart';

/// Using FadeTransition to realize route animation
/// [route] is Required parameters, other is Optional parameters

class FadeRouteAnimation extends PageRouteBuilder {
  /// route page
  Widget route;

  /// page enter animation duartion time
  Duration duration;

  /// page exit animation duration time
  Duration reverseDuration;

  /// page animation curve
  Curve curve;

  FadeRouteAnimation(
    this.route, {
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration = const Duration(milliseconds: 300),
    this.curve = Curves.linear,
  }) : super(
          pageBuilder: (context, animate, _) => route,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, anim, child) {
            Animation<double> animated = Tween<double>(begin: 0.0, end: 1.0)
                .chain(CurveTween(curve: curve))
                .animate(animation);
            return FadeTransition(opacity: animated, child: child);
          },
        );
}

/// Using SlideTransition to realize route animation
/// [route] is Required parameters, other is Optional parameters
class SlideRouteAnimation extends PageRouteBuilder {
  /// route page
  Widget route;

  /// page enter animation duartion time
  Duration duration;

  /// page exit animation duration time
  Duration reverseDuration;

  /// page animation slide direction
  ProsteSlideMode mode;

  /// Use fade effect in animation execution
  bool useFade;

  /// page animation curve
  Curve curve;

  SlideRouteAnimation(
    this.route, {
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration = const Duration(milliseconds: 300),
    this.mode = ProsteSlideMode.fromRight,
    this.useFade = false,
    this.curve = Curves.linear,
  }) : super(
          pageBuilder: (context, _, __) => route,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (contex, animation, _, child) {
            Animation<Offset> position;
            switch (mode) {
              case ProsteSlideMode.fromRight:
                position = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                    .chain(CurveTween(curve: curve))
                    .animate(animation);
                break;
              case ProsteSlideMode.fromLeft:
                position =
                    Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
                        .chain(CurveTween(curve: curve))
                        .animate(animation);
                break;
              case ProsteSlideMode.fromBottom:
                position = Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0))
                    .chain(CurveTween(curve: curve))
                    .animate(animation);
                break;
              case ProsteSlideMode.fromTop:
                position =
                    Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
                        .chain(CurveTween(curve: curve))
                        .animate(animation);
                break;
            }
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
          },
        );
}

/// Using ScaleTransition to realize route animation
/// [route] is Required parameters, other is Optional parameters
class ScaleRouteAnimation extends PageRouteBuilder {
  /// route page
  Widget route;

  /// page enter animation duartion time
  Duration duration;

  /// page exit animation duration time
  Duration reverseDuration;

  /// Use fade effect in animation execution
  bool useFade;

  /// determine the starting position of animation execution
  Alignment alignment;

  /// page animation curve
  Curve curve;

  ScaleRouteAnimation(
    this.route, {
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration = const Duration(milliseconds: 300),
    this.useFade = false,
    this.alignment = Alignment.center,
    this.curve = Curves.linear,
  }) : super(
          pageBuilder: (context, _, __) => route,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, _, child) {
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
          },
        );
}

/// Using RotationTransition to realize route animation
/// [route] is Required parameters, other is Optional parameters
class RotationRouteAnimation extends PageRouteBuilder {
  /// route page
  Widget route;

  /// page enter animation duartion time
  Duration duration;

  /// page exit animation duration time
  Duration reverseDuration;

  /// determine the starting position of animation execution
  Alignment alignment;

  /// Use fade effect in animation execution
  bool useFade;

  /// page animation curve
  Curve curve;

  RotationRouteAnimation(
    this.route, {
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration = const Duration(milliseconds: 300),
    this.alignment = Alignment.bottomCenter,
    this.useFade = false,
    this.curve = Curves.linear,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => route,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, _, child) {
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
          },
        );
}

/// Using SizeRouteTransition to realize route animation
/// [route] is Required parameters, other is Optional parameters
class SizeRouteAnimation extends PageRouteBuilder {
  /// route page
  Widget route;

  /// page enter animation duartion time
  Duration duration;

  /// page exit animation duration time
  Duration reverseDuration;

  /// Use fade effect in animation execution
  bool useFade;

  /// determine the starting position of animation execution
  Alignment alignment;

  /// Determine animation execution spindle position
  Axis axis;

  /// page animation curve
  Curve curve;

  SizeRouteAnimation(
    this.route, {
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration = const Duration(milliseconds: 300),
    this.useFade = false,
    this.alignment = Alignment.bottomCenter,
    this.axis = Axis.vertical,
    this.curve = Curves.linear,
  }) : super(
          pageBuilder: (context, _, __) => route,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, _, child) {
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
          },
        );
}