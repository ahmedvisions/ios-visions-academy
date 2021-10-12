class VideoInfo {
  String videoUrl;
  String thumbUrl;
  String coverUrl;
  dynamic aspectRatio;
  dynamic uploadedAt;
  String videoName;
  String courseName;
  dynamic chapter;

  VideoInfo(
      {this.videoUrl,
      this.thumbUrl,
      this.coverUrl,
      this.aspectRatio,
      this.uploadedAt,
      this.videoName,
      this.courseName,
      this.chapter});
}
