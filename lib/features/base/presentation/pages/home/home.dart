part of 'home_imports.dart';

@RoutePage()
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController controller = HomeController();

  @override
  void initState() {
    controller.requestActiveGym();
    controller.setPlatform();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.colors.primary,
        child: Icon(Icons.lock, color: context.colors.white,),
          onPressed: () => controller.generateOP()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20).r,
        children: [
          Gaps.vGap32,
          RequesterConsumer(
            requester: controller.activeGymRequester,
            listener: (context, state) {
              state.whenOrNull(
                success: (data, loading) {
                  controller.getUserGym(data?.firstOrNull);
                },
              );
            },
            successBuilder: (context, data) {
              return BaseBlocBuilder(
                  bloc: controller.gymCubit,
                  onSuccessWidget: (value) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => controller.onChooseGym(context, data),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Welcome",
                                style: AppTextStyle.s14_w800(
                                    color: context.colors.disableGray),
                              ),
                              Gaps.hGap4,
                              LimitedBox(
                                maxWidth: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  value?.name ?? "",
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.s14_w800(
                                      color: context.colors.primary),
                                ),
                              ),
                              Gaps.hGap8,
                              Icon(
                                Icons.arrow_drop_down_rounded,
                                color: context.colors.disableGray,
                                size: 25.r,
                              ),
                            ],
                          ),
                        ),
                        Gaps.vGap8,
                        RequesterConsumer(
                          requester: controller.profileRequester,
                          listener: (context, state) {
                            state.whenOrNull(success: (data, loading) {
                              controller.sessionsRequester = PTSessionRequester(
                                  controller.sessionParams(data!.memberId));
                              controller.requestSessions(data.memberId);
                            });
                          },
                          successBuilder: (context, profile) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BuildHomeTitle(profile: profile),
                                Gaps.vGap24,
                                BuildGymCard(
                                  controller: controller,
                                  profile: profile,
                                ),
                                Gaps.vGap16,
                                BuildClassList(controller: controller),
                                Gaps.vGap16,
                                BuildTrainerList(controller: controller),
                                Gaps.vGap32,
                              ],
                            );
                          },
                          loadingBuilder: (context) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextShimmer.random(),
                                Gaps.vGap8,
                                TextShimmer.random(),
                                Gaps.vGap24,
                                Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(20).r),
                                  child: BuildShimmerView(
                                    height: 150.h,
                                    width: Dimens.screenWidth,
                                  ),
                                ),
                                Gaps.vGap16,
                              ],
                            );
                          },
                          failureBuilder: (context, error, callback) {
                            return FailureViewWidget(onTap: callback);
                          },
                        ),
                      ],
                    );
                  });
            },
            loadingBuilder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextShimmer.random(),
                  Gaps.vGap8,
                  TextShimmer.random(),
                  Gaps.vGap24,
                  BuildShimmerView(
                    height: 150.h,
                    width: Dimens.screenWidth,
                  ),
                  Gaps.vGap16,
                ],
              );
            },
            failureBuilder: (context, error, callback) {
              return FailureViewWidget(onTap: callback);
            },
          ),
        ],
      ),
    );
  }
}
