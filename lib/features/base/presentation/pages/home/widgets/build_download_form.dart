part of "home_widgets_imports.dart";

class BuildDownloadForm extends StatelessWidget {
  final HomeController controller;
  final String memberPlanId;
  const BuildDownloadForm(
      {super.key, required this.controller, required this.memberPlanId});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.white,
          borderRadius: BorderRadius.circular(20).r,
        ),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24).r,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Start date",
                          style: AppTextStyle.s14_w800(
                              color: context.colors.black)),
                      GenericTextField(
                        onTab: () => controller.showDateBicker(context, "start"),
                        controller: controller.startController,
                        fieldTypes: FieldTypes.clickable,
                        type: TextInputType.text,
                        action: TextInputAction.next,
                        validate: (value) => value?.validateEmpty(),
                        hint: "From",
                        margin: const EdgeInsets.symmetric(vertical: 8).r,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            Res.calendar,
                            height: 20.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gaps.hGap8,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("End date",
                          style: AppTextStyle.s14_w800(
                              color: context.colors.black)),
                      GenericTextField(
                        onTab: () => controller.showDateBicker(context, "end"),
                        controller: controller.endController,
                        fieldTypes: FieldTypes.clickable,
                        type: TextInputType.text,
                        action: TextInputAction.next,
                        validate: (value) => value?.validateEmpty(),
                        hint: "To",
                        margin: const EdgeInsets.symmetric(vertical: 8).r,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            Res.calendar,
                            height: 20.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20).r,
              child: AppTextButton.maxCustom(
                onPressed: () => controller.downloadPayment(context,
                    memberPlanId: memberPlanId),
                txtColor: context.colors.white,
                textSize: 14.sp,
                maxHeight: 50.h,
                text: "Download",
                bgColor: context.colors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
