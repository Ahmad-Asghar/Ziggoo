import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PortionWidget extends StatelessWidget {
  final String icon;
  final String title;
  final bool hideDivider;
  final String route;
  final String? suffix;
  const PortionWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.route,
      this.hideDivider = false,
      this.suffix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(route),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Column(children: [
          Row(
              children: [
            CircleAvatar(
              radius: 17,
              backgroundColor: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset(icon, height: 14, width: 14)),
              ),
            ),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Expanded(
                child: Text(title,
                    style: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault))),
            suffix != null
                ? Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.error,
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusDefault),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeExtraSmall,
                        horizontal: Dimensions.paddingSizeSmall),
                    child: Text(suffix!,
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).cardColor)),
                  )
                : const Icon(Icons.chevron_right_rounded,color: Colors.grey,),
          ]),
          hideDivider ? const SizedBox() : const Divider(
            height: 20,
          )
        ]),
      ),
    );
  }
}
