import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khunt_parivar_mataji_madh/Network/models/receipt_history_models/get_receipt_history_model.dart';
import 'package:khunt_parivar_mataji_madh/Network/services/receipt_history_services/receipt_history_service.dart';

class ReceiptHistoryController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  TextEditingController searchCharityController = TextEditingController();
  TextEditingController searchExpenseController = TextEditingController();

  RxList<ExpenseList> expenseList = RxList();
  RxList<ExpenseList> searchedExpenseList = RxList();
  RxList<Receipt> charityList = RxList();
  RxList<Receipt> searchedCharityList = RxList();

  RxBool isGetHistoryLoading = false.obs;
  RxBool isGetInvoicesLoading = false.obs;
  RxBool isRefreshing = false.obs;
  RxDouble ceilValueForRefresh = 0.0.obs;

  @override
  void onInit() async {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);

    await getReceiptHistoryApiCall();
  }

  Future<void> getReceiptHistoryApiCall({bool isLoading = true}) async {
    try {
      isRefreshing(!isLoading);
      isGetHistoryLoading(isLoading);
      final response = await ReceiptHistoryService.getReceiptHistoryService();

      if (response.isSuccess) {
        GetReceiptHistoryModel receiptHistoryModel = GetReceiptHistoryModel.fromJson(response.response?.data);

        charityList.clear();
        searchedCharityList.clear();
        expenseList.clear();
        searchedExpenseList.clear();

        charityList.addAll(receiptHistoryModel.data?.receipt ?? []);
        searchedCharityList.addAll(receiptHistoryModel.data?.receipt ?? []);
        expenseList.addAll(receiptHistoryModel.data?.expenseList ?? []);
        searchedExpenseList.addAll(receiptHistoryModel.data?.expenseList ?? []);
      }
    } finally {
      isRefreshing(false);
      isGetHistoryLoading(false);
    }
  }

  Future<void> searchCharityName(String searchedValue) async {
    searchedCharityList.clear();
    if (searchedValue.isNotEmpty) {
      searchedCharityList.addAll(charityList.where((element) => element.name?.toLowerCase().contains(searchedValue.toLowerCase()) == true));
    } else {
      searchedCharityList.addAll(charityList);
    }
  }

  Future<void> searchExpenseName(String searchedValue) async {
    searchedExpenseList.clear();
    if (searchedValue.isNotEmpty) {
      expenseList.addAll(expenseList.where((element) => element.name?.toLowerCase().contains(searchedValue.toLowerCase()) == true));
    } else {
      expenseList.addAll(expenseList);
    }
  }
}
