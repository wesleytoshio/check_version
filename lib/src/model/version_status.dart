class VersionStatus {
  /// Checks for updates.
  // bool hasUpdate;

  /// Recent version in store.
  String storeVersion;

  /// Current device version.
  String currentVersion;

  /// Store url.
  String storeURL;

  VersionStatus({this.storeVersion, this.currentVersion, this.storeURL});

  bool get hasUpdate =>
      (this.storeVersion != null && this.currentVersion != null) ??
      this.storeVersion != this.currentVersion;
}
