class ProjectListDataEntity {
	ProjectListDataData data;
	int errorCode;
	String errorMsg;

	ProjectListDataEntity({this.data, this.errorCode, this.errorMsg});

	ProjectListDataEntity.fromJson(Map<String, dynamic> json) {
		data = json['data'] != null ? new ProjectListDataData.fromJson(json['data']) : null;
		errorCode = json['errorCode'];
		errorMsg = json['errorMsg'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['errorCode'] = this.errorCode;
		data['errorMsg'] = this.errorMsg;
		return data;
	}
}

class ProjectListDataData {
	bool over;
	int pageCount;
	int total;
	int curPage;
	int offset;
	int size;
	List<ProjectListDataDataData> datas;

	ProjectListDataData({this.over, this.pageCount, this.total, this.curPage, this.offset, this.size, this.datas});

	ProjectListDataData.fromJson(Map<String, dynamic> json) {
		over = json['over'];
		pageCount = json['pageCount'];
		total = json['total'];
		curPage = json['curPage'];
		offset = json['offset'];
		size = json['size'];
		if (json['datas'] != null) {
			datas = new List<ProjectListDataDataData>();(json['datas'] as List).forEach((v) { datas.add(new ProjectListDataDataData.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['over'] = this.over;
		data['pageCount'] = this.pageCount;
		data['total'] = this.total;
		data['curPage'] = this.curPage;
		data['offset'] = this.offset;
		data['size'] = this.size;
		if (this.datas != null) {
      data['datas'] =  this.datas.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class ProjectListDataDataData {
	int shareDate;
	String projectLink;
	String prefix;
	String origin;
	String link;
	String title;
	int type;
	int selfVisible;
	String apkLink;
	String envelopePic;
	int audit;
	int chapterId;
	int id;
	int courseId;
	String superChapterName;
	int publishTime;
	String niceShareDate;
	int visible;
	String niceDate;
	String author;
	int zan;
	String chapterName;
	int userId;
	List<ProjectListDataDataDatasTag> tags;
	int superChapterId;
	bool fresh;
	bool collect;
	String shareUser;
	String desc;

	ProjectListDataDataData({this.shareDate, this.projectLink, this.prefix, this.origin, this.link, this.title, this.type, this.selfVisible, this.apkLink, this.envelopePic, this.audit, this.chapterId, this.id, this.courseId, this.superChapterName, this.publishTime, this.niceShareDate, this.visible, this.niceDate, this.author, this.zan, this.chapterName, this.userId, this.tags, this.superChapterId, this.fresh, this.collect, this.shareUser, this.desc});

	ProjectListDataDataData.fromJson(Map<String, dynamic> json) {
		shareDate = json['shareDate'];
		projectLink = json['projectLink'];
		prefix = json['prefix'];
		origin = json['origin'];
		link = json['link'];
		title = json['title'];
		type = json['type'];
		selfVisible = json['selfVisible'];
		apkLink = json['apkLink'];
		envelopePic = json['envelopePic'];
		audit = json['audit'];
		chapterId = json['chapterId'];
		id = json['id'];
		courseId = json['courseId'];
		superChapterName = json['superChapterName'];
		publishTime = json['publishTime'];
		niceShareDate = json['niceShareDate'];
		visible = json['visible'];
		niceDate = json['niceDate'];
		author = json['author'];
		zan = json['zan'];
		chapterName = json['chapterName'];
		userId = json['userId'];
		if (json['tags'] != null) {
			tags = new List<ProjectListDataDataDatasTag>();(json['tags'] as List).forEach((v) { tags.add(new ProjectListDataDataDatasTag.fromJson(v)); });
		}
		superChapterId = json['superChapterId'];
		fresh = json['fresh'];
		collect = json['collect'];
		shareUser = json['shareUser'];
		desc = json['desc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['shareDate'] = this.shareDate;
		data['projectLink'] = this.projectLink;
		data['prefix'] = this.prefix;
		data['origin'] = this.origin;
		data['link'] = this.link;
		data['title'] = this.title;
		data['type'] = this.type;
		data['selfVisible'] = this.selfVisible;
		data['apkLink'] = this.apkLink;
		data['envelopePic'] = this.envelopePic;
		data['audit'] = this.audit;
		data['chapterId'] = this.chapterId;
		data['id'] = this.id;
		data['courseId'] = this.courseId;
		data['superChapterName'] = this.superChapterName;
		data['publishTime'] = this.publishTime;
		data['niceShareDate'] = this.niceShareDate;
		data['visible'] = this.visible;
		data['niceDate'] = this.niceDate;
		data['author'] = this.author;
		data['zan'] = this.zan;
		data['chapterName'] = this.chapterName;
		data['userId'] = this.userId;
		if (this.tags != null) {
      data['tags'] =  this.tags.map((v) => v.toJson()).toList();
    }
		data['superChapterId'] = this.superChapterId;
		data['fresh'] = this.fresh;
		data['collect'] = this.collect;
		data['shareUser'] = this.shareUser;
		data['desc'] = this.desc;
		return data;
	}
}

class ProjectListDataDataDatasTag {
	String name;
	String url;

	ProjectListDataDataDatasTag({this.name, this.url});

	ProjectListDataDataDatasTag.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['url'] = this.url;
		return data;
	}
}
