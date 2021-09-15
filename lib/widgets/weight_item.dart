import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plendify/Models/weight.dart';
import 'package:plendify/values/values.dart';

class WeightItem extends StatelessWidget {
  final Weight weight;
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapDelete;
  const WeightItem(
      {Key? key, required this.weight, this.onTapEdit, this.onTapDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 80,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.SIZE_16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 6.0,
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5.0)
            ]),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Weight: ${weight.value}",
                          style: AppTextStyles.paragraph
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text("CreatedAt: ${weight.reference.toString()}",
                          style: AppTextStyles.paragraph)
                    ]),
              ),
            ),
            Expanded(
                flex: 1,
                child: Column(children: [
                  Expanded(
                      child: InkWell(
                    onTap: onTapEdit,
                    child: Container(
                        color: AppColors.primaryColor,
                        child: Center(
                            child: Text("Edit",
                                style: AppTextStyles.paragraph
                                    .copyWith(color: AppColors.whiteColor)))),
                  )),
                  Expanded(
                    child: InkWell(
                      onTap: onTapDelete,
                      child: Container(
                          color: Colors.red,
                          child: Center(
                              child: Text("Delete",
                                  style: AppTextStyles.paragraph
                                      .copyWith(color: AppColors.whiteColor)))),
                    ),
                  )
                ]))
          ],
        ));
  }
}
