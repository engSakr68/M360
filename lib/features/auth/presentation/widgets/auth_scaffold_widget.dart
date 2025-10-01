import 'package:flutter/material.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/features/auth/presentation/widgets/auth_drawer_widget.dart';

class AuthScaffoldWidget extends StatefulWidget {
  final PreferredSizeWidget appBar;
  final Widget body;
  final Key? scaffoldKey;

  const AuthScaffoldWidget(
      {super.key, required this.appBar, required this.body, this.scaffoldKey});

  @override
  State<AuthScaffoldWidget> createState() => _AuthScaffoldWidgetState();
}

class _AuthScaffoldWidgetState extends State<AuthScaffoldWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      key: widget.scaffoldKey,
      drawer: const AuthDrawerWidget(),
      appBar: widget.appBar,
      body: widget.body,
    );
  }
}
