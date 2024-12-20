import 'package:custom_poll/src/tools/date_style.dart';
import 'package:custom_poll/src/tools/option_style.dart';
import 'package:custom_poll/src/tools/show_time_style.dart';
import 'package:custom_poll/src/tools/title_style.dart';
import 'package:custom_poll/src/tools/votes_text_style.dart';

/// The `Styles` class in Dart contains properties for different text styles used in a user interface
/// design.
class Styles {
  final TitleStyle? titleStyle;
  final DateStyle? dateStyle;
  final VotesTextStyle? votesTextStyle;
  final OptionStyle? optionStyle;
  final ShowTimeStyle? showTimeStyle;
  Styles({
    this.titleStyle,
    this.dateStyle,
    this.votesTextStyle,
    this.optionStyle,
    this.showTimeStyle,
  });
}
