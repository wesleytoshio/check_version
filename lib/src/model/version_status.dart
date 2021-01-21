class VersionStatus {
  /// Aplication ID.
  String packageName;

  /// Recent version in store.
  String storeVersion;

  /// Current device version.
  String currentVersion;

  /// Store url.
  String storeURL;

  VersionStatus(
      {this.packageName,
      this.storeVersion,
      this.currentVersion,
      this.storeURL});

  bool get hasUpdate =>
      (this.storeVersion != null && this.currentVersion != null) ??
      this.storeVersion != this.currentVersion;
}
