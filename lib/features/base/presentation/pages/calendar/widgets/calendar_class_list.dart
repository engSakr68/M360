part of "calendar_widgets_imports.dart";

class CalendarClassList extends StatelessWidget {
  final CalendarController controller;
  const CalendarClassList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // return ObsValueConsumer(
    //     observable: controller.loadingCubit,
    //     builder: (context, loadingState) {
          return RequesterConsumer(
            requester: controller.classesRequester,
            // listener: (context, state) {
            //   state.whenOrNull(success: (data, loading) {
            //     controller.loadingCubit.setValue(false);
            //   });
            // },
            successBuilder: (context, data) {
              return 
              // loadingState
              //     ? const CalendarClassLoading()
              //     : 
                  data!.isEmpty
                      ? const BuildEmptyList()
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16).r,
                          scrollDirection: Axis.vertical,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) => BuildClassCard(
                            details: data[index],
                            image: data[index].imageUrl ?? "",
                            title: data[index].title ?? "",
                            fullName: data[index].trainer ?? "",
                            time: DateTime.parse(data[index].end!)
                                .difference(DateTime.parse(data[index].start!))
                                .inMinutes
                                .toString(),
                            date: data[index].start ?? "",
                          ),
                          separatorBuilder: (BuildContext context, int index) =>
                              Gaps.vGap10,
                        );
            },
            loadingBuilder: (context) {
              return const CalendarClassLoading();
            },
            failureBuilder: (context, error, callback) {
              return FailureViewWidget(onTap: callback);
            },
          );
        // });
  }
}
