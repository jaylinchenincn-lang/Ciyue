import "dart:async";

import "package:ciyue/src/generated/i18n/app_localizations.dart";
import "package:material_ui/material_ui.dart";
import "package:flutter/services.dart";
import "package:url_launcher/url_launcher.dart";

class CiyueError extends StatelessWidget {
  final Object error;

  const CiyueError({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final errorTitle = l10n?.error ?? "Error";
    final reportIssueText = l10n?.reportIssue ?? "Report Issue";
    final copyErrorText = l10n?.copyError ?? "Copy Error";
    final copiedText = l10n?.errorCopiedToClipboard ?? "Error copied to clipboard";

    return Scaffold(
      appBar: AppBar(title: Text(errorTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error.toString()),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                unawaited(
                  launchUrl(
                    Uri.parse("https://github.com/mumu-lhl/ciyue/issues"),
                  ),
                );
              },
              child: Text(reportIssueText),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                unawaited(
                  Clipboard.setData(ClipboardData(text: error.toString())),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(copiedText)),
                );
              },
              child: Text(copyErrorText),
            ),
          ],
        ),
      ),
    );
  }
}
