class BankData {
  Data? data;

  BankData({this.data});

  BankData.fromJson(Map json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map toJson() {
    final Map data = {};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Accounting>? accounting;
  List<Accounting>? bank;

  Data({this.accounting, this.bank});

  Data.fromJson(Map json) {
    if (json['accounting'] != null) {
      accounting = <Accounting>[];
      json['accounting'].forEach((v) {
        accounting!.add(Accounting.fromJson(v));
      });
    }
    if (json['bank'] != null) {
      bank = <Accounting>[];
      json['bank'].forEach((v) {
        bank?.add(Accounting.fromJson(v));
      });
    }
  }

  Map toJson() {
    final Map data = {};
    if (accounting != null) {
      data['accounting'] = accounting!.map((v) => v.toJson()).toList();
    }
    if (bank != null) {
      data['bank'] = bank!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Accounting {
  List<Detail>? detail;
  String? title;

  Accounting({this.detail, this.title});

  Accounting.fromJson(Map json) {
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail!.add(Detail.fromJson(v));
      });
    }
    title = json['title'];
  }

  Map toJson() {
    final Map data = {};
    if (detail != null) {
      data['detail'] = detail!.map((v) => v.toJson()).toList();
    }
    data['title'] = title;
    return data;
  }
}

class Detail {
  List<DataList>? dataList;
  String? image;
  String? title;

  Detail({this.dataList, this.image, this.title});

  Detail.fromJson(Map json) {
    if (json['dataList'] != null) {
      dataList = <DataList>[];
      json['dataList'].forEach((v) {
        dataList!.add(DataList.fromJson(v));
      });
    }
    image = json['image'];
    title = json['title'];
  }

  Map toJson() {
    final Map data = {};
    if (dataList != null) {
      data['dataList'] = dataList!.map((v) => v.toJson()).toList();
    }
    data['image'] = image;
    data['title'] = title;
    return data;
  }
}

class DataList {
  String? desc;
  String? isBookmark;
  String? title;

  DataList({this.desc, this.isBookmark, this.title});

  DataList.fromJson(Map json) {
    desc = json['desc'];
    isBookmark = json['isBookmark'];
    title = json['title'];
  }

  Map toJson() {
    final Map data = {};
    data['desc'] = desc;
    data['isBookmark'] = isBookmark;
    data['title'] = title;
    return data;
  }
}


// To parse this JSON data, do
//
//     final bankData = bankDataFromJson(jsonString);
