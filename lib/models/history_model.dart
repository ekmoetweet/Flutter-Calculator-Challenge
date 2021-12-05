class HistoryModel {
  List<HistoryItem> ?history;

  HistoryModel({this.history});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['History'] != null) {
      history =  [];
      json['History'].forEach((v) {
        history!.add(HistoryItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (history != null) {
      data['History'] = history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HistoryItem {
  late String time;
  late String calculation;

  HistoryItem({required this.time, required this.calculation});

  HistoryItem.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    calculation = json['calculation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = time;
    data['calculation'] = calculation;
    return data;
  }
}
