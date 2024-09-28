/// slide animtion type
enum ProsteSlideMode {
  /// page from left to right
  fromLeft,

  /// page from right to left
  fromRight,

  /// page from bottom to top
  fromBottom,

  /// page from top to bottom
  fromTop,
}
// constructor function to confirm the specific method
enum ProsteAnimationMode {
  /// animation use fade
  /// it can also be used ProsteRouteAnimation.fadeRoute(...)
  fade,

  /// animation use slide and page from left to right
  /// it can also be used ProsteRouteAnimation.slideRoute(mode: SlideMode.fromLeft, ...)
  slideFromLeft,

  /// animation use slide and page from right to left
  /// it can also be used ProsteRouteAnimation.slideRoute(mode: SlideMode.fromRight, ...)
  slideFromRight,

  /// animation use slide and page from bottom to top
  /// it can also be used ProsteRouteAnimation.slideRoute(mode: SlideMode.fromBottom, ...)
  slideFromBottom,

  /// animation use slide and page from top to bottom
  /// it can also be used ProsteRouteAnimation.slideRoute(mode: SlideMode.fromTop, ...)
  slideFromTop,

  /// animation use scale
  /// it can also be used ProsteRouteAnimation.scaleRoute(...)
  scale,

  /// animation use rotation
  /// it can also be used ProsteRouteAnimation.rotationRoute(...)
  rotation,

  /// animation use size
  /// it can also be used ProsteRouteAnimation.sizeRoute(...)
  size,
}