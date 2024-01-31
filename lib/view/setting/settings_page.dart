import 'package:ecommerce_admin/core/components/custom_appbar.dart';
import 'package:ecommerce_admin/core/components/custom_button.dart';
import 'package:ecommerce_admin/core/components/custom_text_form_field.dart';
import 'package:ecommerce_admin/core/constants/constants.dart';
import 'package:ecommerce_admin/core/constants/dimensions.dart';
import 'package:ecommerce_admin/view/order/models/order_constant_model.dart';
import 'package:ecommerce_admin/view/order/provider/order_provider.dart';
import 'package:ecommerce_admin/core/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  static const String routeName = '/settingspage';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final _discountController = TextEditingController();
  final _vatController = TextEditingController();
  final _deliveryChargeController = TextEditingController();
  late OrderProvider orderProvider;

  @override
  void didChangeDependencies() {
    orderProvider = Provider.of<OrderProvider>(context);
    _discountController.text = orderProvider.orderConstantModel.discount.toString();
    _vatController.text = orderProvider.orderConstantModel.vat.toString();
    _deliveryChargeController.text = '${orderProvider.orderConstantModel.deliveryCharge} $currencySymbol';
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    _discountController.dispose();
    _vatController.dispose();
    _deliveryChargeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Settings'),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                CustomTextFormField(
                  controller: _discountController,
                  keyboardType: TextInputType.number,
                  labelText: 'Discount %',
                  prefixIcon: const Icon(Icons.discount),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: Dimensions.paddingMedium,),

                CustomTextFormField(
                  controller: _vatController,
                  keyboardType: TextInputType.number,
                  labelText: 'VAT %',
                  prefixIcon: const Icon(Icons.price_change),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: Dimensions.paddingMedium,),

                CustomTextFormField(
                  controller: _deliveryChargeController,
                  keyboardType: TextInputType.number,
                  labelText: 'Delivery Charge',
                  prefixIcon: const Icon(Icons.delivery_dining),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: Dimensions.paddingLarge,),

                CustomButton(
                  onPressed: (){
                    _saveInfo();
                  },
                  text: 'Save',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveInfo() {
    if(_formKey.currentState!.validate()){
      EasyLoading.show(status: 'Please wait');
      final model = OrderConstantModel(
        discount: num.parse(_discountController.text),
        vat: num.parse(_vatController.text),
        deliveryCharge: num.parse(_deliveryChargeController.text),
      );

      orderProvider.updateOrderConstants(model).then((value) {
        EasyLoading.dismiss();
        showMsg(context, "Updated Successfully");
      }).catchError((error) {
        EasyLoading.dismiss();
        showMsg(context, "Failed to update");
      });
    }
  }
}
