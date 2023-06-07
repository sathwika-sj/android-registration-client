import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:registration_client/provider/app_language.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registration_client/const/utils.dart';

class UsernameComponent extends StatelessWidget {
  UsernameComponent({
    Key? key,
    required this.onTap,
    required this.languages,
    required this.mp,
    required this.onChanged,
    required this.isDisabled,
    required this.isMobile,
  }) : super(key: key);

  final List<String> languages;
  final Map<String, String> mp;
  final VoidCallback onTap;
  final Function onChanged;
  final bool isDisabled;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final appLanguage = Provider.of<AppLanguage>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 17.h,
          child: Text(
            AppLocalizations.of(context)!.language,
            style: Utils.mobileTextfieldHeader,
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        _getLanguageDropdownButton(context),
        SizedBox(
          height: 30.h,
        ),
        Container(
          // height: 17.h,
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.username,
                style: Utils.mobileTextfieldHeader,
              ),
              const Text(
                ' *',
                style: TextStyle(color: Utils.mandatoryField),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 11.h,
        ),
        Container(
          height: 52.h,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(
            horizontal: 17.w,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.h,
              color: Utils.appGreyShade,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          child: TextField(
            // controller: usernameController,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.enter_username,
              hintStyle: Utils.mobileTextfieldHintText,
              border: InputBorder.none,
            ),
            onChanged: (v) {
              onChanged(v);
            },
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        InkWell(
          onTap: !isDisabled ? onTap : null,
          child: Container(
            height: 52.h,
            decoration: BoxDecoration(
              color: !isDisabled ? Utils.appSolidPrimary : Utils.appGreyShade,
              border: Border.all(
                width: 1.w,
                color: !isDisabled ? Utils.appBlueShade1 : Utils.appGreyShade,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.next_button,
                style: Utils.mobileButtonText,
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Text(
              mp[item]!,
              style: Utils.mobileDropdownText,
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<double> _getCustomItemsHeights() {
    List<double> _itemsHeights = [];
    for (var i = 0; i < (languages.length * 2) - 1; i++) {
      if (i.isEven) {
        _itemsHeights.add(52.h);
      }
      if (i.isOdd) {
        _itemsHeights.add(4.h);
      }
    }
    return _itemsHeights;
  }

  _getLanguageDropdownButton(BuildContext context) {
    final appLanguage = Provider.of<AppLanguage>(context, listen: false);
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        items: _addDividersAfterItems(languages),
        value: context.watch<AppLanguage>().selectedLanguage,
        onChanged: (newValue) {
          context.read<AppLanguage>().selectedLanguage = newValue!;
          appLanguage.changeLanguage(Locale(newValue));
        },
        buttonStyleData: ButtonStyleData(
          height: 52.h,
          width: isMobile ? 318.w : 384.w,
          padding: EdgeInsets.only(
            left: 17.w,
            right: (14.42).w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              width: 1.h,
              color: Utils.appGreyShade,
            ),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 164.h,
          decoration: BoxDecoration(
            color: Utils.appWhite,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              width: 1.h,
              color: Utils.appGreyShade,
            )
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          customHeights: _getCustomItemsHeights(),
        ),
        iconStyleData: const IconStyleData(
            icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          color: Utils.appGreyShade,
        )),
      ),
    );
  }
}
