import 'dart:convert';

/// code : "200"
/// msg : "get Bill Successfully"
/// Data : {"Receipt":[{"bill_id":"1","name":"test","amount":"1000","address":"Gondal","type":"type","type1":"type1","type2":"type2","cash":"No","cheque_number":"123456789","cheque_date":"05/05/2024","bank":"Federal Bank","branch":"Kalawad Road","account_number":"11111","pan_number":"55555","phone":"9924515455","url":"https://mindwaveinfoway.com/KhuntParivar/AdminPanel/Receipt/1.pdf","datetime":"2024-05-08 08:23:06"}],"Expense List":[{"bill_id":"1","name":"test","amount":"1000","address":"Gondal","note":"Gondal","type":"type","type1":"type1","type2":"type2","cash":"No","cheque_number":"123456789","date":"05/05/2024","bank":"Federal Bank","branch":"Kalawad Road","account_number":"11111","pan_number":"55555","phone":"9924515455","url":"https://mindwaveinfoway.com/KhuntParivar/AdminPanel/Receipt/1.pdf","datetime":"2024-05-08 08:23:06"}]}

GetReceiptHistoryModel getReceiptHistoryModelFromJson(String str) => GetReceiptHistoryModel.fromJson(json.decode(str));
String getReceiptHistoryModelToJson(GetReceiptHistoryModel data) => json.encode(data.toJson());

class GetReceiptHistoryModel {
  GetReceiptHistoryModel({
    String? code,
    String? msg,
    Data? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  GetReceiptHistoryModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
  }
  String? _code;
  String? _msg;
  Data? _data;
  GetReceiptHistoryModel copyWith({
    String? code,
    String? msg,
    Data? data,
  }) =>
      GetReceiptHistoryModel(
        code: code ?? _code,
        msg: msg ?? _msg,
        data: data ?? _data,
      );
  String? get code => _code;
  String? get msg => _msg;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    if (_data != null) {
      map['Data'] = _data?.toJson();
    }
    return map;
  }
}

/// Receipt : [{"bill_id":"1","name":"test","amount":"1000","address":"Gondal","type":"type","type1":"type1","type2":"type2","cash":"No","cheque_number":"123456789","cheque_date":"05/05/2024","bank":"Federal Bank","branch":"Kalawad Road","account_number":"11111","pan_number":"55555","phone":"9924515455","url":"https://mindwaveinfoway.com/KhuntParivar/AdminPanel/Receipt/1.pdf","datetime":"2024-05-08 08:23:06"}]
/// Expense List : [{"bill_id":"1","name":"test","amount":"1000","address":"Gondal","note":"Gondal","type":"type","type1":"type1","type2":"type2","cash":"No","cheque_number":"123456789","date":"05/05/2024","bank":"Federal Bank","branch":"Kalawad Road","account_number":"11111","pan_number":"55555","phone":"9924515455","url":"https://mindwaveinfoway.com/KhuntParivar/AdminPanel/Receipt/1.pdf","datetime":"2024-05-08 08:23:06"}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    List<Receipt>? receipt,
    List<ExpenseList>? expenseList,
  }) {
    _receipt = receipt;
    _expenseList = expenseList;
  }

  Data.fromJson(dynamic json) {
    if (json['Receipt'] != null) {
      _receipt = [];
      json['Receipt'].forEach((v) {
        _receipt?.add(Receipt.fromJson(v));
      });
    }
    if (json['Expense List'] != null) {
      _expenseList = [];
      json['Expense List'].forEach((v) {
        _expenseList?.add(ExpenseList.fromJson(v));
      });
    }
  }
  List<Receipt>? _receipt;
  List<ExpenseList>? _expenseList;
  Data copyWith({
    List<Receipt>? receipt,
    List<ExpenseList>? expenseList,
  }) =>
      Data(
        receipt: receipt ?? _receipt,
        expenseList: expenseList ?? _expenseList,
      );
  List<Receipt>? get receipt => _receipt;
  List<ExpenseList>? get expenseList => _expenseList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_receipt != null) {
      map['Receipt'] = _receipt?.map((v) => v.toJson()).toList();
    }
    if (_expenseList != null) {
      map['Expense List'] = _expenseList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// bill_id : "1"
/// name : "test"
/// amount : "1000"
/// address : "Gondal"
/// note : "Gondal"
/// type : "type"
/// type1 : "type1"
/// type2 : "type2"
/// cash : "No"
/// cheque_number : "123456789"
/// date : "05/05/2024"
/// bank : "Federal Bank"
/// branch : "Kalawad Road"
/// account_number : "11111"
/// pan_number : "55555"
/// phone : "9924515455"
/// url : "https://mindwaveinfoway.com/KhuntParivar/AdminPanel/Receipt/1.pdf"
/// datetime : "2024-05-08 08:23:06"

ExpenseList expenseListFromJson(String str) => ExpenseList.fromJson(json.decode(str));
String expenseListToJson(ExpenseList data) => json.encode(data.toJson());

class ExpenseList {
  ExpenseList({
    String? billId,
    String? name,
    String? amount,
    String? address,
    String? note,
    String? type,
    String? type1,
    String? type2,
    String? cash,
    String? chequeNumber,
    String? date,
    String? bank,
    String? branch,
    String? accountNumber,
    String? panNumber,
    String? phone,
    String? url,
    String? datetime,
  }) {
    _billId = billId;
    _name = name;
    _amount = amount;
    _address = address;
    _note = note;
    _type = type;
    _type1 = type1;
    _type2 = type2;
    _cash = cash;
    _chequeNumber = chequeNumber;
    _date = date;
    _bank = bank;
    _branch = branch;
    _accountNumber = accountNumber;
    _panNumber = panNumber;
    _phone = phone;
    _url = url;
    _datetime = datetime;
  }

  ExpenseList.fromJson(dynamic json) {
    _billId = json['bill_id'];
    _name = json['name'];
    _amount = json['amount'];
    _address = json['address'];
    _note = json['note'];
    _type = json['type'];
    _type1 = json['type1'];
    _type2 = json['type2'];
    _cash = json['cash'];
    _chequeNumber = json['cheque_number'];
    _date = json['date'];
    _bank = json['bank'];
    _branch = json['branch'];
    _accountNumber = json['account_number'];
    _panNumber = json['pan_number'];
    _phone = json['phone'];
    _url = json['url'];
    _datetime = json['datetime'];
  }
  String? _billId;
  String? _name;
  String? _amount;
  String? _address;
  String? _note;
  String? _type;
  String? _type1;
  String? _type2;
  String? _cash;
  String? _chequeNumber;
  String? _date;
  String? _bank;
  String? _branch;
  String? _accountNumber;
  String? _panNumber;
  String? _phone;
  String? _url;
  String? _datetime;
  ExpenseList copyWith({
    String? billId,
    String? name,
    String? amount,
    String? address,
    String? note,
    String? type,
    String? type1,
    String? type2,
    String? cash,
    String? chequeNumber,
    String? date,
    String? bank,
    String? branch,
    String? accountNumber,
    String? panNumber,
    String? phone,
    String? url,
    String? datetime,
  }) =>
      ExpenseList(
        billId: billId ?? _billId,
        name: name ?? _name,
        amount: amount ?? _amount,
        address: address ?? _address,
        note: note ?? _note,
        type: type ?? _type,
        type1: type1 ?? _type1,
        type2: type2 ?? _type2,
        cash: cash ?? _cash,
        chequeNumber: chequeNumber ?? _chequeNumber,
        date: date ?? _date,
        bank: bank ?? _bank,
        branch: branch ?? _branch,
        accountNumber: accountNumber ?? _accountNumber,
        panNumber: panNumber ?? _panNumber,
        phone: phone ?? _phone,
        url: url ?? _url,
        datetime: datetime ?? _datetime,
      );
  String? get billId => _billId;
  String? get name => _name;
  String? get amount => _amount;
  String? get address => _address;
  String? get note => _note;
  String? get type => _type;
  String? get type1 => _type1;
  String? get type2 => _type2;
  String? get cash => _cash;
  String? get chequeNumber => _chequeNumber;
  String? get date => _date;
  String? get bank => _bank;
  String? get branch => _branch;
  String? get accountNumber => _accountNumber;
  String? get panNumber => _panNumber;
  String? get phone => _phone;
  String? get url => _url;
  String? get datetime => _datetime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bill_id'] = _billId;
    map['name'] = _name;
    map['amount'] = _amount;
    map['address'] = _address;
    map['note'] = _note;
    map['type'] = _type;
    map['type1'] = _type1;
    map['type2'] = _type2;
    map['cash'] = _cash;
    map['cheque_number'] = _chequeNumber;
    map['date'] = _date;
    map['bank'] = _bank;
    map['branch'] = _branch;
    map['account_number'] = _accountNumber;
    map['pan_number'] = _panNumber;
    map['phone'] = _phone;
    map['url'] = _url;
    map['datetime'] = _datetime;
    return map;
  }
}

/// bill_id : "1"
/// name : "test"
/// amount : "1000"
/// address : "Gondal"
/// type : "type"
/// type1 : "type1"
/// type2 : "type2"
/// cash : "No"
/// cheque_number : "123456789"
/// cheque_date : "05/05/2024"
/// bank : "Federal Bank"
/// branch : "Kalawad Road"
/// account_number : "11111"
/// pan_number : "55555"
/// phone : "9924515455"
/// url : "https://mindwaveinfoway.com/KhuntParivar/AdminPanel/Receipt/1.pdf"
/// datetime : "2024-05-08 08:23:06"

Receipt receiptFromJson(String str) => Receipt.fromJson(json.decode(str));
String receiptToJson(Receipt data) => json.encode(data.toJson());

class Receipt {
  Receipt({
    String? billId,
    String? name,
    String? amount,
    String? address,
    String? type,
    String? type1,
    String? type2,
    String? cash,
    String? chequeNumber,
    String? chequeDate,
    String? bank,
    String? branch,
    String? accountNumber,
    String? panNumber,
    String? phone,
    String? url,
    String? datetime,
  }) {
    _billId = billId;
    _name = name;
    _amount = amount;
    _address = address;
    _type = type;
    _type1 = type1;
    _type2 = type2;
    _cash = cash;
    _chequeNumber = chequeNumber;
    _chequeDate = chequeDate;
    _bank = bank;
    _branch = branch;
    _accountNumber = accountNumber;
    _panNumber = panNumber;
    _phone = phone;
    _url = url;
    _datetime = datetime;
  }

  Receipt.fromJson(dynamic json) {
    _billId = json['bill_id'];
    _name = json['name'];
    _amount = json['amount'];
    _address = json['address'];
    _type = json['type'];
    _type1 = json['type1'];
    _type2 = json['type2'];
    _cash = json['cash'];
    _chequeNumber = json['cheque_number'];
    _chequeDate = json['cheque_date'];
    _bank = json['bank'];
    _branch = json['branch'];
    _accountNumber = json['account_number'];
    _panNumber = json['pan_number'];
    _phone = json['phone'];
    _url = json['url'];
    _datetime = json['datetime'];
  }
  String? _billId;
  String? _name;
  String? _amount;
  String? _address;
  String? _type;
  String? _type1;
  String? _type2;
  String? _cash;
  String? _chequeNumber;
  String? _chequeDate;
  String? _bank;
  String? _branch;
  String? _accountNumber;
  String? _panNumber;
  String? _phone;
  String? _url;
  String? _datetime;
  Receipt copyWith({
    String? billId,
    String? name,
    String? amount,
    String? address,
    String? type,
    String? type1,
    String? type2,
    String? cash,
    String? chequeNumber,
    String? chequeDate,
    String? bank,
    String? branch,
    String? accountNumber,
    String? panNumber,
    String? phone,
    String? url,
    String? datetime,
  }) =>
      Receipt(
        billId: billId ?? _billId,
        name: name ?? _name,
        amount: amount ?? _amount,
        address: address ?? _address,
        type: type ?? _type,
        type1: type1 ?? _type1,
        type2: type2 ?? _type2,
        cash: cash ?? _cash,
        chequeNumber: chequeNumber ?? _chequeNumber,
        chequeDate: chequeDate ?? _chequeDate,
        bank: bank ?? _bank,
        branch: branch ?? _branch,
        accountNumber: accountNumber ?? _accountNumber,
        panNumber: panNumber ?? _panNumber,
        phone: phone ?? _phone,
        url: url ?? _url,
        datetime: datetime ?? _datetime,
      );
  String? get billId => _billId;
  String? get name => _name;
  String? get amount => _amount;
  String? get address => _address;
  String? get type => _type;
  String? get type1 => _type1;
  String? get type2 => _type2;
  String? get cash => _cash;
  String? get chequeNumber => _chequeNumber;
  String? get chequeDate => _chequeDate;
  String? get bank => _bank;
  String? get branch => _branch;
  String? get accountNumber => _accountNumber;
  String? get panNumber => _panNumber;
  String? get phone => _phone;
  String? get url => _url;
  String? get datetime => _datetime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bill_id'] = _billId;
    map['name'] = _name;
    map['amount'] = _amount;
    map['address'] = _address;
    map['type'] = _type;
    map['type1'] = _type1;
    map['type2'] = _type2;
    map['cash'] = _cash;
    map['cheque_number'] = _chequeNumber;
    map['cheque_date'] = _chequeDate;
    map['bank'] = _bank;
    map['branch'] = _branch;
    map['account_number'] = _accountNumber;
    map['pan_number'] = _panNumber;
    map['phone'] = _phone;
    map['url'] = _url;
    map['datetime'] = _datetime;
    return map;
  }
}
