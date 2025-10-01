class DownloadParams {
  String? memberPlanId;
  String? from;
  String? to;
  String? path;

  DownloadParams({
    required this.from,
    required this.to,
    required this.memberPlanId,
    required this.path,
  });

  String header() {
    String header = "$memberPlanId/download-invoices?from=$from&to=$to";
    return header;
  }
}
