class NoteModel {
  int? notesId;
  int? module;
  int? accessType;
  String? title;
  String? description;
  String? pdf;
  String? createdDate;
  String? updatedDate;
  String? slugNotes;
  bool? isActive;

  NoteModel(
      {this.notesId,
      this.module,
      this.accessType,
      this.title,
      this.description,
      this.pdf,
      this.createdDate,
      this.updatedDate,
      this.slugNotes,
      this.isActive});

  NoteModel.fromJson(Map<String, dynamic> json) {
    notesId = json['notes_id'];
    module = json['module'];
    accessType = json['access_type'];
    title = json['title'];
    description = json['description'];
    pdf = json['pdf'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    slugNotes = json['slug_notes'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notes_id'] = this.notesId;
    data['module'] = this.module;
    data['access_type'] = this.accessType;
    data['title'] = this.title;
    data['description'] = this.description;
    data['pdf'] = this.pdf;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['slug_notes'] = this.slugNotes;
    data['is_active'] = this.isActive;
    return data;
  }
}
