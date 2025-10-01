part of "session_widgets_imports.dart";

class BuildSessionButton extends StatelessWidget {
  final SessionController controller;
  final TrainerModel trainer;
  const BuildSessionButton(
      {super.key,
      required this.controller,
      required this.trainer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20).r,
      child: AppTextButton.maxCustom(
        text: "Book a PT Session",
        onPressed: () => controller.bookPTSession(context, trainer: trainer),
        bgColor: context.colors.secondary,
        txtColor: context.colors.white,
        textSize: 14.sp,
        maxHeight: 50.h,
      ),
    );
  }
}
