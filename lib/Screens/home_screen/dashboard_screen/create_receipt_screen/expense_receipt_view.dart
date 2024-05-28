import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_colors.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_strings.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_utils.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/dashboard_screen/create_receipt_screen/create_receipt_controller.dart';
import 'package:khunt_parivar_mataji_madh/Widgets/textfield_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ExpenseReceiptView extends GetView<CreateReceiptController> {
  const ExpenseReceiptView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(bottom: 10.h),
        child: Column(
          children: [
            SizedBox(height: 4.h),

            ///Amount
            TextFieldWidget(
              controller: controller.expenseAmountController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validator: controller.validateAmount,
              hintText: "₹ 100",
              maxLength: 10,
            ),
            SizedBox(height: 3.h),

            ///DefaultAmount
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///₹ 100
                  DefaultAmountWidget(
                    onPressed: () {
                      controller.expenseAmountController.text = "100";
                    },
                    text: "₹ 100",
                  ),

                  ///₹ 500
                  DefaultAmountWidget(
                    onPressed: () {
                      controller.expenseAmountController.text = "500";
                    },
                    text: "₹ 500",
                  ),

                  ///₹ 1000
                  DefaultAmountWidget(
                    onPressed: () {
                      controller.expenseAmountController.text = "1000";
                    },
                    text: "₹ 1000",
                  ),

                  ///₹ 2000
                  DefaultAmountWidget(
                    onPressed: () {
                      controller.expenseAmountController.text = "2000";
                    },
                    text: "₹ 2000",
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),

            ///Expense name
            TextFieldWidget(
              controller: controller.expenseNameController,
              textInputAction: TextInputAction.next,
              title: AppStrings.expenseName.tr,
              hintText: AppStrings.enterExpenseName.tr,
              validator: controller.validateExpenseName,
              maxLength: 30,
            ),
            SizedBox(height: 2.h),

            ///Expense note
            TextFieldWidget(
              controller: controller.expenseNoteController,
              textInputAction: TextInputAction.next,
              title: AppStrings.expenseNote.tr,
              hintText: AppStrings.enterExpenseNote.tr,
              validator: controller.validateExpenseNote,
              maxLength: 50,
            ),
            SizedBox(height: 2.h),

            ///Phone Number
            TextFieldWidget(
              controller: controller.expensePhoneNumberController,
              textInputAction: TextInputAction.next,
              title: AppStrings.phoneNumber.tr,
              hintText: AppStrings.enterPhoneNumber.tr,
              keyboardType: TextInputType.number,
              validator: controller.validatePhoneNumber,
              maxLength: 10,
            ),
            SizedBox(height: 2.h),

            ///Expense date
            TextFieldWidget(
              controller: controller.expenseDateController,
              textInputAction: TextInputAction.next,
              title: AppStrings.expenseDate.tr,
              hintText: AppStrings.selectExpenseDate.tr,
              validator: controller.validateExpenseDate,
              maxLength: 50,
              readOnly: true,
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateFormat('dd/MM/yyyy').parse(controller.expenseDateController.text.trim()),
                  firstDate: DateTime.now().add(
                    const Duration(days: -36500),
                  ),
                  lastDate: DateTime.now().add(
                    const Duration(days: 36500),
                  ),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: AppColors.SECONDARY_COLOR,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );

                if (selectedDate != null) {
                  controller.expenseDateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
                }
              },
            ),
            SizedBox(height: 2.h),

            ///Cash or Cheque
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ///Cash
                  GestureDetector(
                    onTap: () {
                      Utils.unfocus();
                      controller.isExpenseChequeSelected(false);
                    },
                    child: Row(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: AppColors.TERTIARY_COLOR,
                              width: 1.5,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(1.w),
                            child: AnimatedOpacity(
                              opacity: controller.isExpenseChequeSelected.isTrue ? 0 : 1,
                              duration: const Duration(
                                milliseconds: 300,
                              ),
                              child: Icon(
                                Icons.done_rounded,
                                color: AppColors.WHITE_COLOR,
                                size: 4.w,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          AppStrings.cash.tr,
                          style: TextStyle(
                            color: AppColors.PRIMARY_COLOR,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///Cheque
                  GestureDetector(
                    onTap: () {
                      Utils.unfocus();
                      controller.isExpenseChequeSelected(true);
                    },
                    child: Row(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: AppColors.TERTIARY_COLOR,
                              width: 1.5,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(1.w),
                            child: AnimatedOpacity(
                              opacity: controller.isExpenseChequeSelected.isTrue ? 1 : 0,
                              duration: const Duration(
                                milliseconds: 300,
                              ),
                              child: Icon(
                                Icons.done_rounded,
                                color: AppColors.WHITE_COLOR,
                                size: 4.w,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          AppStrings.cheque.tr,
                          style: TextStyle(
                            color: AppColors.PRIMARY_COLOR,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
            SizedBox(height: 2.h),

            ///Cheque number
            Obx(() {
              return AnimatedOpacity(
                opacity: controller.isExpenseChequeSelected.isTrue ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: Column(
                  children: [
                    TextFieldWidget(
                      controller: controller.expenseChequeNumberController,
                      title: AppStrings.chequeNumber.tr,
                      hintText: AppStrings.enterChequeNumber.tr,
                      validator: controller.validateChequeNumber,
                      maxLength: 10,
                      textInputAction: TextInputAction.next,
                      readOnly: controller.isExpenseChequeSelected.isFalse,
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget DefaultAmountWidget({required void Function()? onPressed, required String text}) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        elevation: 4,
        backgroundColor: AppColors.PRIMARY_COLOR,
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.SECONDARY_COLOR,
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
