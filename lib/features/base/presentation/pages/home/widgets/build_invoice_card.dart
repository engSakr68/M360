part of "home_widgets_imports.dart";

class MemberInvoiceCard extends StatelessWidget {
  final InvoiceModel invoice;
  final bool isSelected;
  final VoidCallback onTap;
  const MemberInvoiceCard(
      {super.key,
      required this.invoice,
      required this.onTap,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16).r,
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.primary.withValues(alpha: 0.1)
              : context.colors.greyWhite,
          border: Border.all(
              color: isSelected
                  ? context.colors.primary
                  : context.colors.greyWhite),
          borderRadius: BorderRadius.circular(10).r,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat("dd/MM/yyyy")
                      .format(DateTime.parse(invoice.scheduledDate!)),
                  style:
                      AppTextStyle.s14_w800(color: context.colors.blackOpacity),
                ),
                Text(
                  invoice.oinvoiceState == "successful"
                      ? invoice.oinvoiceState!.capitalize()
                      : invoice.amount == "0.00"
                          ? "Void"
                          : invoice.oinvoiceState == null
                              ? "Scheduled"
                              : invoice.oinvoiceState!.capitalize(),
                  style: AppTextStyle.s12_w600(
                      color: invoice.oinvoiceState == "successful"
                          ? Colors.green
                          : invoice.amount == "0.00"
                              ? Colors.deepOrangeAccent
                              : invoice.oinvoiceState == null ||
                                      invoice.oinvoiceState == "pending" ||
                                      invoice.oinvoiceState == "scheduled"
                                  ? context.colors.blackOpacity
                                  : invoice.oinvoiceState == "refunded"
                                      ? Colors.deepOrangeAccent
                                      : Colors.red),
                ),
              ],
            ),
            Gaps.vGap8,
            Text(
              "Amount: \$${invoice.amount}",
              style: AppTextStyle.s12_w600(color: context.colors.blackOpacity),
            ),
          ],
        ),
      ),
    );
  }
}
