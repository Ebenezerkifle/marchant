import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import '../../../../models/category_model.dart';
import 'mydetail_viewmodel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_text_style.dart';
import '../../../common/ui_helpers.dart';
import '../../widgets/custome_app_bar.dart';
import '../../widgets/custome_button.dart';
import '../../widgets/custome_form_field.dart';
import '../../widgets/input_field.dart';

class MydetailView extends StackedView<MydetailViewModel> {
  const MydetailView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, MydetailViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            CustomeAppBar(title: viewModel.title),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: middleSize),
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      children: [
                        verticalSpaceLarge,
                        CustomeFormField(
                          title: 'First Name',
                          widget: InputField(
                            validator: (value) => viewModel.validateText(
                                value ?? '',
                                viewModel.firstNameController,
                                viewModel.fristName),
                            controller: viewModel.firstNameController,
                            hint: '',
                            // error: viewModel.formError
                            //     .containsKey(viewModel.firstNameController),
                            prefixIcon: Icon(
                              FontAwesomeIcons.user,
                              color: kcPrimaryColorDark,
                              size: viewModel.iconSize,
                            ),
                          ),
                        ),
                        verticalSpaceMedium,
                        CustomeFormField(
                          title: 'Last Name',
                          widget: InputField(
                            validator: (value) => viewModel.validateText(
                                value ?? '',
                                viewModel.lastNameController,
                                viewModel.lastName),
                            controller: viewModel.lastNameController,
                            hint: '',
                            // error: viewModel.formError
                            //     .containsKey(viewModel.lastNameController),
                            prefixIcon: Icon(
                              FontAwesomeIcons.user,
                              color: kcPrimaryColorDark,
                              size: viewModel.iconSize,
                            ),
                          ),
                        ),
                        verticalSpaceMedium,
                        // Phone number field
                        CustomeFormField(
                          title: 'Phone Number',
                          widget: InputField(
                            validator: (value) => viewModel.validatePhoneNumber(
                                value ?? '', viewModel.phoneNumController),
                            controller: viewModel.phoneNumController,
                            error: viewModel.formError
                                .containsKey(viewModel.phoneNumController),
                            inputType: TextInputType.phone,
                            charLength: 10,
                            inputFormatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            prefixIcon: Icon(
                              FontAwesomeIcons.phone,
                              color: kcPrimaryColorDark,
                              size: viewModel.iconSize,
                            ),
                            hint: viewModel.phoneNumFieldHint,
                          ),
                        ),
                        verticalSpaceMedium,
                        CustomeFormField(
                          title: 'Location',
                          widget: InputField(
                            validator: (value) => viewModel.validateText(
                                value ?? '',
                                viewModel.locationController,
                                viewModel.location),
                            controller: viewModel.locationController,
                            hint: '',
                            // error: viewModel.formError
                            //     .containsKey(viewModel.firstNameController),
                            prefixIcon: Icon(
                              FontAwesomeIcons.locationPinLock,
                              color: kcPrimaryColorDark,
                              size: viewModel.iconSize,
                            ),
                          ),
                        ),
                        verticalSpaceMedium,
                        CustomeFormField(
                          title: 'Tin',
                          widget: InputField(
                            validator: (value) => viewModel.validateText(
                                value ?? '',
                                viewModel.tinController,
                                viewModel.tin),
                            controller: viewModel.tinController,
                            hint: '',
                            // error: viewModel.formError
                            //     .containsKey(viewModel.firstNameController),
                            prefixIcon: Icon(
                              FontAwesomeIcons.receipt,
                              color: kcPrimaryColorDark,
                              size: viewModel.iconSize,
                            ),
                          ),
                        ),
                        verticalSpaceMedium,
                        CustomeFormField(
                          title: 'City',
                          widget: InputField(
                            validator: (value) => viewModel.validateText(
                                value ?? '',
                                viewModel.cityController,
                                viewModel.city),
                            controller: viewModel.cityController,
                            hint: '',
                            // error: viewModel.formError
                            //     .containsKey(viewModel.firstNameController),
                            prefixIcon: Icon(
                              FontAwesomeIcons.city,
                              color: kcPrimaryColorDark,
                              size: viewModel.iconSize,
                            ),
                          ),
                        ),
                        verticalSpaceMedium,
                        CustomeFormField(
                          title: 'Sub City',
                          widget: InputField(
                            validator: (value) => viewModel.validateText(
                                value ?? '',
                                viewModel.subCityController,
                                viewModel.fristName),
                            controller: viewModel.subCityController,
                            hint: '',
                            // error: viewModel.formError
                            //     .containsKey(viewModel.firstNameController),
                            prefixIcon: Icon(
                              FontAwesomeIcons.city,
                              color: kcPrimaryColorDark,
                              size: viewModel.iconSize,
                            ),
                          ),
                        ),
                        verticalSpaceMedium,
                        CustomeFormField(
                          title: 'Woreda',
                          widget: InputField(
                            validator: (value) => viewModel.validateText(
                                value ?? '',
                                viewModel.woredaController,
                                viewModel.woreda),
                            controller: viewModel.woredaController,
                            hint: '',
                            // error: viewModel.formError
                            //     .containsKey(viewModel.firstNameController),
                            prefixIcon: Icon(
                              FontAwesomeIcons.city,
                              color: kcPrimaryColorDark,
                              size: viewModel.iconSize,
                            ),
                          ),
                        ),
                        verticalSpaceMedium,
                        CustomeFormField(
                          title: 'ID Number',
                          widget: InputField(
                            validator: (value) => viewModel.validateText(
                                value ?? '',
                                viewModel.idNumberController,
                                viewModel.idNumber),
                            controller: viewModel.idNumberController,
                            hint: '',
                            // error: viewModel.formError
                            //     .containsKey(viewModel.firstNameController),
                            prefixIcon: Icon(
                              FontAwesomeIcons.idCard,
                              color: kcPrimaryColorDark,
                              size: viewModel.iconSize,
                            ),
                          ),
                        ),

                        verticalSpaceMedium,
                        // Category dropdown field
                        if (viewModel.role == "Retailer") ...[
                          CustomeFormField(
                            title: 'Top Category',
                            widget: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownButtonFormField<String>(
                                  value: viewModel.selectedCategory,
                                  hint: const Text('Choose category'),
                                  onChanged: viewModel.setSelectedCategory,
                                  items: viewModel.topCategories.values
                                      .map((Category category) {
                                    return DropdownMenuItem<String>(
                                      value: category.id,
                                      child: Text(category.name ?? ''),
                                    );
                                  }).toList(),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                  ),
                                ),
                                if (viewModel.formError.containsKey('category'))
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      viewModel.formError['category']!,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          verticalSpaceMedium,
                        ],
                        // error message widget
                        viewModel.formError.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  verticalSpaceSmall,
                                  Text(
                                    viewModel.formError.entries.first.value,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.withColor(
                                      color: kcDanger,
                                      style: AppTextStyle.thinSmall,
                                    ),
                                  ),
                                  verticalSpaceSmall,
                                ],
                              )
                            : verticalSpaceMedium,
                        CustomeButton(
                          text: 'Change',
                          onTap: viewModel.onSubmit,
                          width: double.infinity,
                          btnColor: kcPrimaryColorDark,
                          loading: viewModel.isBusy,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  MydetailViewModel viewModelBuilder(BuildContext context) =>
      MydetailViewModel();
}
