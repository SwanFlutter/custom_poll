import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A widget for displaying a poll in a view-only mode.
///
/// This widget presents the poll results without allowing user interaction.
/// It provides various customization options for styling and displaying
/// the poll data.
class ViewOnlyPollWidget extends StatelessWidget {
  /// Whether reselection of options is allowed (not applicable in view-only mode).
  final bool allowReselection;

  /// The title of the poll.
  final String title;

  /// The list of options for the poll.
  final List<String> options;

  /// The votes for each option, represented as a map of option index to vote count.
  final Map<int, int> votes;

  /// The total number of votes cast in the poll.
  final int totalVotes;

  /// Whether to display the percentage of votes for each option.
  final bool showPercentages;

  /// The start date of the poll.
  final DateTime startDate;

  /// The end date of the poll.
  final DateTime endDate;

  /// The height between the title and the options.
  final double? heightBetweenTitleAndOptions;

  /// The height between each option.
  final double? heightBetweenOptions;

  /// The text displayed next to the vote count.
  final String? votesText;

  /// The text style for the votes text.
  final TextStyle? votesTextStyle;

  /// An optional widget to display metadata about the poll.
  final Widget? metaWidget;

  /// The name of the user who created the poll.
  final String? createdBy;

  /// The name of the user who is allowed to vote.
  final String? userToVote;

  /// The height of each poll option.
  final double? pollOptionsHeight;

  /// The width of each poll option.
  final double? pollOptionsWidth;

  /// The border for each poll option.
  final BoxBorder? pollOptionsBorder;

  /// The border radius for each poll option.
  final BorderRadius? pollOptionsBorderRadius;

  /// The fill color for each poll option.
  final Color? pollOptionsFillColor;

  /// The splash color for each poll option.
  final Color? pollOptionsSplashColor;

  /// The border for voted poll options.
  final BoxBorder? votedPollOptionsBorder;

  /// The radius for voted poll options.
  final Radius? votedPollOptionsRadius;

  /// The background color for voted poll options.
  final Color? votedBackgroundColor;

  /// The progress color for voted poll options.
  final Color? votedProgressColor;

  /// The leading progress color for voted poll options.
  final Color? leadingVotedProgessColor;

  /// The color for vote in progress.
  final Color? voteInProgressColor;

  /// The checkmark widget for voted poll options.
  final Widget? votedCheckmark;

  /// The text style for the percentage of voted poll options.
  final TextStyle? votedPercentageTextStyle;

  /// The animation duration for voted poll options.
  final int votedAnimationDuration;

  /// The widget to display while the poll is loading.
  final Widget? loadingWidget;

  /// Creates a new `ViewOnlyPollWidget`.
  const ViewOnlyPollWidget({
    super.key,
    required this.title,
    required this.options,
    required this.votes,
    required this.totalVotes,
    this.showPercentages = true,
    required this.startDate,
    required this.endDate,
    this.allowReselection = false,
    this.heightBetweenTitleAndOptions = 10,
    this.heightBetweenOptions = 12,
    this.votesText = 'Votes',
    this.votesTextStyle,
    this.metaWidget,
    this.createdBy,
    this.userToVote,
    this.pollOptionsHeight = 48,
    this.pollOptionsWidth,
    this.pollOptionsBorderRadius,
    this.pollOptionsFillColor = Colors.white,
    this.pollOptionsSplashColor = Colors.grey,
    this.pollOptionsBorder,
    this.votedPollOptionsBorder,
    this.votedPollOptionsRadius,
    this.votedBackgroundColor = const Color(0xffEEF0EB),
    this.votedProgressColor = const Color(0xff84D2F6),
    this.leadingVotedProgessColor = const Color(0xff0496FF),
    this.voteInProgressColor = const Color(0xffEEF0EB),
    this.votedCheckmark,
    this.votedPercentageTextStyle,
    this.votedAnimationDuration = 1000,
    this.loadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm');
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poll Title
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: heightBetweenTitleAndOptions),

            // Poll Options
            ...options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              final optionVotes = votes[index] ?? 0;
              final percentage = totalVotes > 0 ? (optionVotes / totalVotes * 100) : 0;

              return Padding(
                padding: EdgeInsets.only(bottom: heightBetweenOptions ?? 12),
                child: Container(
                  height: pollOptionsHeight,
                  decoration: BoxDecoration(
                    color: pollOptionsFillColor,
                    borderRadius: pollOptionsBorderRadius ?? BorderRadius.circular(8),
                    border: pollOptionsBorder ?? Border.all(color: Colors.grey, width: 1.0),
                  ),
                  child: Stack(
                    children: [
                      // Progress Background
                      FractionallySizedBox(
                        widthFactor: percentage / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: pollOptionsBorderRadius ?? BorderRadius.circular(8),
                            color: votedProgressColor?.withOpacity(0.3) ?? Colors.blue.withOpacity(0.3),
                          ),
                        ),
                      ),
                      // Option Text and Percentage
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Option Text
                                Text(
                                  option,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                // Percentage
                                if (showPercentages)
                                  Text(
                                    '${percentage.toStringAsFixed(1)}%',
                                    style: votedPercentageTextStyle ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const Divider(height: 24),

            // Meta Information
            if (metaWidget != null) metaWidget!,
            const SizedBox(height: 8),

            // Total Votes and Dates
            Text(
              '$totalVotes $votesText',
              style: votesTextStyle ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
            ),
            Text(
              'Start : ${dateFormat.format(startDate)}',
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
            Text(
              'Ends : ${dateFormat.format(endDate)}',
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
