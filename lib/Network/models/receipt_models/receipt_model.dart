import 'dart:convert';

/// code : "200"
/// msg : "PDF Generate Successfully..."
/// PATH : "https://mindwaveinfoway.com/KhuntParivar/AdminPanel/Receipt/1.pdf"

ReceiptModel receiptModelFromJson(String str) => ReceiptModel.fromJson(json.decode(str));
String receiptModelToJson(ReceiptModel data) => json.encode(data.toJson());

class ReceiptModel {
  ReceiptModel({
    String? code,
    String? msg,
    String? path,
  }) {
    _code = code;
    _msg = msg;
    _path = path;
  }

  ReceiptModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _path = json['PATH'];
  }
  String? _code;
  String? _msg;
  String? _path;
  ReceiptModel copyWith({
    String? code,
    String? msg,
    String? path,
  }) =>
      ReceiptModel(
        code: code ?? _code,
        msg: msg ?? _msg,
        path: path ?? _path,
      );
  String? get code => _code;
  String? get msg => _msg;
  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    map['PATH'] = _path;
    return map;
  }
}
