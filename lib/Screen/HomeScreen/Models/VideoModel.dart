class VideoModel {
  int? videoUniqueId;
  int? module;
  int? accessType;
  String? videoId;
  String? title;
  String? description;
  String? createdDate;
  String? updatedDate;
  String? slugVideos;
  bool? isActive;

  VideoModel(
      {this.videoUniqueId,
      this.module,
      this.accessType,
      this.videoId,
      this.title,
      this.description,
      this.createdDate,
      this.updatedDate,
      this.slugVideos,
      this.isActive});

  VideoModel.fromJson(Map<String, dynamic> json) {
    videoUniqueId = json['video_unique_id'];
    module = json['module'];
    accessType = json['access_type'];
    videoId = json['video_id'];
    title = json['title'];
    description = json['description'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    slugVideos = json['slug_videos'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson({bool update = true}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (videoUniqueId != null) data['video_unique_id'] = this.videoUniqueId;
    data['module'] = this.module;
    data['access_type'] = this.accessType;
    data['video_id'] = this.videoId;
    data['title'] = this.title;
    data['description'] = this.description;
    if (update) data['created_date'] = this.createdDate;
    if (update) data['updated_date'] = this.updatedDate;
    // data['slug_videos'] = this.slugVideos;
    data['is_active'] = this.isActive;
    return data;
  }
}
