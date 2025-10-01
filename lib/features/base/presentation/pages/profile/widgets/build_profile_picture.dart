part of "profile_widgets_imports.dart";

class BuildProfilePicture extends StatelessWidget {
  final String photo;
  final ProfileController controller;
  const BuildProfilePicture(
      {super.key, required this.photo, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ObsValueConsumer(
          observable: controller.editCubit,
          builder: (context, isEdit) {
            return 
            // InkWell(
              // onTap: isEdit ? () => controller.getImage(context) : () {},
              // child: 
              Stack(
                alignment: FractionalOffset.bottomRight,
                children: [
                  Container(
                    width: 100.r,
                    height: 100.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: context.colors.primary, width: 3.r),
                    ),
                    child: Center(
                      child: ObsValueConsumer<File?>(
                          observable: controller.imageCubit,
                          builder: (context, value) {
                            if (value != null) {
                              return Container(
                                height: 90.r,
                                width: 90.r,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: FileImage(File(value.path)),
                                      fit: BoxFit.cover,
                                    )),
                              );
                            } else {
                              return Visibility(
                                visible: photo == "",
                                replacement: CachedImage(
                                  url: photo,
                                  height: 90.r,
                                  width: 90.r,
                                  fit: BoxFit.cover,
                                  borderRadius: BorderRadius.circular(90).r,
                                ),
                                child: Image.asset(
                                  Res.avatar,
                                  width: 90.r,
                                  height: 90.r,
                                  fit: BoxFit.fill,
                                ),
                              );
                            }
                          }),
                    ),
                  ),
                  // Visibility(
                  //   visible: isEdit,
                  //   child: Container(
                  //     height: 35.r,
                  //     width: 35.r,
                  //     decoration: BoxDecoration(
                  //       color: context.colors.primary,
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: Center(
                  //       child: Icon(
                  //         CupertinoIcons.photo_camera_solid,
                  //         size: 20.r,
                  //         color: context.colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              // ),
            );
          }),
    );
  }
}
