import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/shipping_calculator_screen/shipping_calculator_view.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/widget/app_bar_widget.dart';
import 'package:my_cart_express/order_tracking_app/widget/input_text_field.dart';
import 'package:my_cart_express/order_tracking_app/widget/validator.dart';

import 'shipping_calculator_model.dart';
import 'shipping_calculator_presenter.dart';

class ShippingCalculatorScreen extends StatefulWidget {
  const ShippingCalculatorScreen({super.key});

  @override
  State<ShippingCalculatorScreen> createState() =>
      _ShippingCalculatorScreenState();
}

class _ShippingCalculatorScreenState extends State<ShippingCalculatorScreen>
    implements ShippingCalculatorView {
  late ShippingCalculatorModel _model;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ShippingCalculatorPresenter presenter =
      BasicShippingCalculatorPresenter();

  @override
  void initState() {
    presenter.updateView = this;
    if (_model.rateGroupList.isEmpty || _model.categoriesList.isEmpty) {
      presenter.getGropDetails(context);
    }
    super.initState();
  }

  @override
  void refreshModel(ShippingCalculatorModel loginRegistrationModel) {
    if (mounted) {
      setState(() {
        _model = loginRegistrationModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: primary,
        child: Column(
          children: [
            appBarWithAction(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: offWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: bodyView(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bodyView(context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shipping Calculator',
              style: regularText18,
            ),
            height15,
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: greyColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Estimate the cost of shipping your package',
                  ),
                  height15,
                  Text(
                    'Category',
                    style: regularText14,
                  ),
                  height10,
                  TextFormFieldWidget(
                    hintText: 'Select Category',
                    controller: _model.category,
                    readOnly: true,
                    onTap: () {
                      selectCategoryGroup(context: context);
                    },
                    suffixIcon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: primary,
                    ),
                    validator: (value) =>
                        Validators.validateText(value, 'Category'),
                  ),
                  height15,
                  Text(
                    'Value (USD)',
                    style: regularText14,
                  ),
                  height10,
                  TextFormFieldWidget(
                    hintText: 'Total cost at check out',
                    controller: _model.value,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        Validators.validateText(value, 'Value'),
                  ),
                  height15,
                  Text(
                    'Estimated weight (LBS)',
                    style: regularText14,
                  ),
                  height10,
                  TextFormFieldWidget(
                    hintText: 'Est. weight from supplier',
                    controller: _model.estimated,
                    keyboardType: TextInputType.number,
                    validator: (value) => Validators.validateText(
                      value,
                      'Estimated weight',
                    ),
                  ),
                  height15,
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          presenter.resetClick();
                        },
                        child: const Text(
                          'RESET',
                        ),
                      ),
                      width15,
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(success),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            presenter.calculateData(context);
                          }
                        },
                        child: const Text(
                          'CALCULATE',
                        ),
                      ),
                    ],
                  ),
                  height15,
                  resultView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget resultView() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: greyColor.withOpacity(0.2),
            border: Border.all(
              color: offWhite,
            ),
          ),
          child: Row(
            children: [
              Text(
                'Estimated Cost : ',
                style: regularText16.copyWith(
                  color: primary,
                ),
              ),
              const Spacer(),
              Text(
                _model.resultData?.isNotEmpty == true
                    ? (_model.resultData?['amount'] ?? '')
                    : '\$0.0',
                style: regularText18.copyWith(
                  color: success,
                ),
              ),
            ],
          ),
        ),
        height15,
        Row(
          children: [
            Text(
              ' Freight Charges : ',
              style: regularText14.copyWith(
                color: primary,
              ),
            ),
            Text(
              _model.resultData?.isNotEmpty == true
                  ? (_model.resultData?['freight_cost'] ?? '')
                  : '\$0.0',
              style: regularText14,
            ),
          ],
        ),
        height5,
        Row(
          children: [
            Text(
              ' Inbound Charge : ',
              style: regularText14.copyWith(
                color: primary,
              ),
            ),
            Text(
              _model.resultData?.isNotEmpty == true
                  ? (_model.resultData?['clearance_fee_jmd'] ?? '')
                  : '\$0.0',
              style: regularText14,
            ),
          ],
        ),
        // height5,
        // Row(
        //   children: [
        //     Text(
        //       ' Processing fee : ',
        //       style: regularText14.copyWith(
        //         color: primary,
        //       ),
        //     ),
        //     Obx(() => Text(
        //           controller.resultData.isNotEmpty
        //               ? controller.resultData['processing_fee']
        //               : '\$0.0',
        //           style: regularText14,
        //         )),
        //   ],
        // ),
        height5,
        Row(
          children: [
            Text(
              ' Tax : ',
              style: regularText14.copyWith(
                color: primary,
              ),
            ),
            Text(
              _model.resultData?.isNotEmpty == true
                  ? (_model.resultData?['tax'] ?? '')
                  : '\$0.0',
              style: regularText14,
            ),
          ],
        ),
        height15,
        Text(
          '*THE PRICES INDICATED ARE ESTIMATE & ARE SUBJECT CHARGE',
          style: regularText14.copyWith(
            letterSpacing: 0.2,
            color: error,
          ),
        ),
      ],
    );
  }

  void selectCategoryGroup({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  magnification: 1.33,
                  squeeze: 1.2,
                  useMagnifier: true,
                  looping: true,
                  onSelectedItemChanged: (int i) {
                    presenter.onSelectedItemChanged(i);
                  },
                  children: List.generate(
                    _model.categoriesList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _model.categoriesList[index]['cat_name'],
                        style: mediumText18.copyWith(
                          color: primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    maximumSize: Size(MediaQuery.of(context).size.width, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {
                    presenter.selectCategory(context);
                  },
                  child: const Text(
                    'SELECT',
                    style: TextStyle(
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              height10,
            ],
          ),
        );
      },
    );
  }
}
