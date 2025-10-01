part of 'profile_imports.dart';

@RoutePage()
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  final ProfileController controller = ProfileController();

  @override
  void initState() {
    controller.requestProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(
        controller: controller,
      ),
      backgroundColor: context.colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).r,
        child: RequesterConsumer(
          requester: controller.profileRequester,
          listener: (context, state) {
            state.whenOrNull(success: (data, loading) {
              controller.initProfileData(data!);
            });
          },
          successBuilder: (context, data) {
            controller.initProfileData(data!);
            return ListView(
              children: [
                BuildProfilePicture(
                  controller: controller,
                  photo: data.photoUrl,
                ),
                Gaps.vGap24,
                BuildProfileForm(
                  controller: controller,
                ),
                Gaps.vGap50,
                BuildProfileButton(
                  controller: controller,
                  profile: data,
                ),
                Gaps.vGap24,
              ],
            );
          },
          loadingBuilder: (context) {
            return BuildProfileLoading(
              controller: controller,
            );
          },
          failureBuilder: (context, error, callback) {
            return FailureViewWidget(onTap: callback);
          },
        ),
      ),
    );
  }
}
