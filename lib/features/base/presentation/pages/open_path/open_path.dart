part of "open_path_imports.dart";

@RoutePage(name: "OpenPathRoute")
class OpenPathPage extends StatefulWidget {
  const OpenPathPage({super.key});

  @override
  State<OpenPathPage> createState() => _OpenPathPageState();
}

class _OpenPathPageState extends State<OpenPathPage> {
  final c = OpenPathController();

  @override
  Widget build(BuildContext context) {
    final theme = context.colors;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: const DefaultAppBar(
        title: 'Digital Card',
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_open_rounded, size: 96.h, color: theme.primary),
            Gaps.vGap32,

            /// ── Reactive status text ──────────────────────────────────────
            ObsValueConsumer(
              observable: c.isBusy,
              builder: (_, busy) => Text(
                busy
                    ? 'Working… please wait'
                    : c.credentialObs.getValue() != null
                        ? 'Digital Card ready 🎉'
                        : 'Press the button to activate your Digital Card',
                style:
                    AppTextStyle.s18_w500(color: context.colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Gaps.vGap24,

            /// ── Error banner, if any ─────────────────────────────────────
            ObsValueConsumer(
              observable: c.errorObs,
              builder: (_, msg) => msg == null
                  ? const SizedBox.shrink()
                  : Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: context.colors.appBarColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        msg,
                        style: AppTextStyle.s14_w400(color: context.colors.appBarColor),
                      ),
                    ),
            ),

            const Spacer(),

            /// ── Activate / Unprovision button ───────────────────────────
            ObsValueConsumer(
              observable: c.credentialObs,
              builder: (_, credential) {
                final activated = credential != null;
                return AppTextButton.maxCustom(
                  onPressed: c.isBusy.getValue()
                      ? null
                      : activated
                          ? c.unprovision
                          : c.onActivatePressed,
                  text: activated ? 'Unprovision' : 'Activate Digital Card',
                  bgColor: theme.secondary,
                  txtColor: theme.white,
                  textSize: 15.sp,
                  maxHeight: 52.h,
                );
              },
            ),
            Gaps.vGap12,

            /// ── Tiny loading spinner under the button ────────────────────
            ObsValueConsumer(
              observable: c.isBusy,
              builder: (_, busy) => busy
                  ? const SizedBox(
                      height: 20, width: 20, child: CircularProgressIndicator())
                  : const SizedBox.shrink(),
            ),

            /// ── Credential details card (ID + type) ─────────────────────
            ObsValueConsumer(
              observable: c.credentialObs,
              builder: (_, credential) => credential == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Card(
                        elevation: 2,
                        child: ListTile(
                          leading: const Icon(Icons.badge_rounded),
                          title: Text(
                            'Credential ID: ${credential['credentialId']}',
                            style:
                                AppTextStyle.s16_w500(color: theme.black),
                          ),
                          subtitle: Text(
                            'Type: ${credential['type']}',
                            style:
                                AppTextStyle.s14_w400(color: theme.black),
                          ),
                        ),
                      ),
                    ),
            ),
            
            Gaps.vGap16,
            
            /// ── Debug button ─────────────────────────────────────────────
            AppTextButton.maxCustom(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OpenpathDebugScreen(),
                  ),
                );
              },
              text: 'Debug SDK',
              bgColor: Colors.grey[600]!,
              txtColor: theme.white,
              textSize: 13.sp,
              maxHeight: 40.h,
            ),
          ],
        ),
      ),
    );
  }
}
