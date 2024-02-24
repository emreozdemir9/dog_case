import 'package:dogs_case/constants/colors.dart';
import 'package:dogs_case/constants/string_utils.dart';
import 'package:flutter/material.dart';

class HomeWidgets {
  static Widget searchBar(BuildContext context,
      ScrollController scrollController, onChanged, onSubmitted) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 4,
              decoration: ShapeDecoration(
                color: const Color(0xFFE5E5EA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  child: TextField(
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.search,
                    maxLines: null,
                    expands: true,
                    onChanged: onChanged,
                    onSubmitted: onSubmitted,
                    decoration: const InputDecoration(
                      suffixIconColor: Colors.white,
                      border: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      hintText: 'Search',
                    ),
                  ),
                ),
              ),
            ),
            // Your other content here
          ],
        ),
      ),
    );
  }

  static Widget searchBarUI(String? text, {onTap}) {
    return Positioned(
      bottom: 120,
      right: 0,
      left: 0,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 64,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.mainGrey, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Text(
            text == null || text == '' ? StringUtils.search : text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: text == StringUtils.search
                    ? const Color(0xFF3C3C43)
                    : Colors.black.withOpacity(0.64)),
          ),
        ),
      ),
    );
  }
}
