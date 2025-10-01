// part of "details_widgets_imports.dart";

// class BuildMemberPlans extends StatelessWidget {
//   final DetailsController controller;
//   const BuildMemberPlans({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<GenericBloc<List<ActivePlanModel>>,
//             GenericState<List<ActivePlanModel>>>(
//         bloc: controller.plansCubit,
//         builder: (context, state) {
//           if (state is GenericUpdateState) {
//             return Container(
//               height: 300,
//               width: Dimens.screenWidth,
//               color: context.colors.black,
//               child: Padding(
//                 padding: const EdgeInsets.all(16).r,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     ListView.separated(
//                       shrinkWrap: true,
//                         itemBuilder: (context, index) => MemberPlanCard(
//                             onTap: () {
//                               controller.plansCubit.setValue(state.data[index]);
//                             },
//                             plan: state.data[index], isSelected: null,),
//                         separatorBuilder: (context, index) => Gaps.vGap8,
//                         itemCount: state.data.length)
//                   ],
//                 ),
//               ),
//             );
//           } else {
//             return Container(
//               height: 300,
//               width: Dimens.screenWidth,
//               color: context.colors.black,);
//           }
//         });
//   }
// }
