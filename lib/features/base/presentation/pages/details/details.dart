part of "details_imports.dart";

@RoutePage(name: "DetailsRoute")
class Details extends StatefulWidget {
  final ClassModel details;
  const Details({super.key, required this.details});

  @override
  State<StatefulWidget> createState() => _DetailsState();
}

class _DetailsState extends State<Details> with TickerProviderStateMixin {
  DetailsController controller = DetailsController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: "Book a class", centerTitle: true,),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20).r,
        children: [
          BuildClassHeader(details: widget.details),
          BuildClassDetails(details: widget.details),
          BuildClassPrice(details: widget.details),
          BuildClassButton(controller: controller, details: widget.details),
        ],
        ),
    );
  }
}
