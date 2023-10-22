class ModuleModel {
  int? modulesId;
  int? subjects;
  String? moduleName;
  String? slugModules;
  bool? isActive;
  String? createdDate;
  String? updatedDate;

  ModuleModel(
      {this.modulesId,
      this.subjects,
      this.moduleName,
      this.slugModules,
      this.isActive,
      this.createdDate,
      this.updatedDate});

  ModuleModel.fromJson(Map<String, dynamic> json) {
    modulesId = json['modules_id'];
    subjects = json['subjects'];
    moduleName = json['module_name'];
    slugModules = json['slug_modules'];
    isActive = json['is_active'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['modules_id'] = this.modulesId;
    data['subjects'] = this.subjects;
    data['module_name'] = this.moduleName;
    data['slug_modules'] = this.slugModules;
    data['is_active'] = this.isActive;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    return data;
  }
}
