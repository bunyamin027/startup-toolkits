import 'package:flutter/widgets.dart';

/// True at the larger Dynamic Type sizes (about 135% and up), where
/// side-by-side layouts switch to stacked ones and sticky bars scroll.
bool largeText(BuildContext context) =>
    MediaQuery.textScalerOf(context).scale(16) >= 16 * 1.35;
