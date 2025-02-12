enum AppAccessibilityMode {
  off,
  on;

  AppAccessibilityMode toggled() {
    return this == AppAccessibilityMode.off ? AppAccessibilityMode.on : AppAccessibilityMode.off;
  }
}