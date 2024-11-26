// ignore_for_file: must_be_immutable

library custom_poll;

import 'dart:async';

import 'package:custom_poll/src/tools/model/vote_data_model.dart';
import 'package:custom_poll/src/tools/style.dart';
import 'package:custom_poll/src/tools/utils/poll_timer_manager.dart';
import 'package:custom_poll/src/view_only_poll_widget.dart';
import 'package:custom_poll/src/widget/poll_options_widget.dart';
import 'package:flutter/material.dart';

export 'package:custom_poll/src/tools/date_style.dart';
export 'package:custom_poll/src/tools/model/vote_data_model.dart';
export 'package:custom_poll/src/tools/option_style.dart';
export 'package:custom_poll/src/tools/style.dart';
export 'package:custom_poll/src/tools/title_style.dart';
export 'package:custom_poll/src/tools/votes_text_style.dart';

/// A customizable widget for displaying and interacting with a poll.
///
/// This widget allows users to vote on options and displays the results
/// with various customization options.
class CustomPoll extends StatefulWidget {
  /// Whether users can reselect an option after voting.
  final bool allowReselection;

  /// The title of the poll.
  final String title;

  /// The list of options for the poll.
  final List<String> options;

  /// The initial votes for each option.
  ///
  /// The keys of the map represent the index of the option in the `options` list,
  /// and the values represent the number of votes for that option.
  final Map<int, int> initialVotes;

  /// The decoration applied to the background of the poll.
  final Decoration? backgroundDecoration;

  /// Whether to display the percentage of votes for each option.
  final bool showPercentages;

  /// The start date of the poll.
  final DateTime startDate;

  /// The end date of the poll.
  final DateTime endDate;

  /// The height between the title and the options.
  final double? heightBetweenTitleAndOptions;

  /// The text displayed next to the vote count.
  final String? votesText;

  /// The name of the user who created the poll.
  final String? createdBy;

  /// The name of the user who is allowed to vote.
  final String? userToVote;

  /// Whether the poll is private.
  final bool private;
  /// The widget to display while the poll is loading.
  final Widget? loadingWidget;

  /// A callback function that is called when an option is selected.
  ///
  /// The function takes the index of the selected option as an argument.
  final Function(int) onOptionSelected;

  /// The styles to apply to the poll.
  final Styles? allStyle;

  /// The maximum number of options allowed in the poll.
  final num? maximumOptions;

  /// A stream controller for handling vote updates.
  final StreamController<VoteData>? voteStream;

  /// The height of the poll widget.
  final double? height;

  /// The width of the poll widget.
  final double? width;

  /// The total number of votes cast in the poll.
  int totalVotes;

  /// Whether to show a timer for the poll duration.
  late final bool showTimer;

  /// A getter for the current votes.
  Map<int, int> get votes => initialVotes;

  /// A setter for updating the votes.
  ///
  /// This method clears the existing votes and adds the new votes.
  set votes(Map<int, int> newVotes) {
    initialVotes.clear();
    initialVotes.addAll(newVotes);
  }

  /// Creates a new `CustomPoll` widget.
  ///
  /// The [title], [options], [votes], [totalVotes], [startDate], and [endDate]
  /// parameters are required.
  ///
  /// The [showPercentages] parameter defaults to `true`.
  ///
  /// The [maximumOptions] parameter defaults to `20`.
  ///
  /// The other parameters are optional and can be used to customize the
  /// appearance and behavior of the poll.

  CustomPoll({
    super.key,
    required this.title,
    required this.options,
    required Map<int, int> votes,
    required this.totalVotes,
    required this.startDate,
    required this.endDate,
    this.showPercentages = true,
    this.maximumOptions = 20,
    this.backgroundDecoration,
    this.allowReselection = false,
    this.heightBetweenTitleAndOptions = 10,
    this.votesText = 'Votes',
    this.createdBy,
    this.userToVote,
    this.private = false,
    this.loadingWidget,
    this.voteStream,
    this.allStyle,
    this.height,
    this.width,
    this.showTimer = false,
    required this.onOptionSelected,
  })  : initialVotes = Map<int, int>.from(votes),
        assert(options.length <= maximumOptions!, 'Maximum $maximumOptions options allowed'),
        assert(maximumOptions != null && maximumOptions > 0, 'maximumOptions must be greater than zero.');


  /// Creates a view-only poll widget.
  ///
  /// This widget displays the poll results without allowing users to vote.
  ///
  /// The [title], [options], [votes], and [totalVotes] parameters are required.
  ///
  /// The [showPercentages] parameter defaults to `true`.
  ///
  /// The other parameters are optional and can be used to customize the
  /// appearance of the poll.
  static Widget viewOnlyPollWidget({
    final bool allowReselection = false,
    required final String title,
    required final List<String> options,
    required final Map<int, int> votes,
    required final int totalVotes,
    final bool showPercentages = true,
    required final DateTime startDate,
    required final DateTime endDate,
    final double? heightBetweenTitleAndOptions = 10,
    final double? heightBetweenOptions = 12,
    final String? votesText = 'Votes',
    final TextStyle? votesTextStyle,
    final Widget? metaWidget,
    final String? createdBy,
    final String? userToVote,
    final double? pollOptionsHeight = 48,
    final double? pollOptionsWidth,
    final BorderRadius? pollOptionsBorderRadius,
    final Color? pollOptionsFillColor = Colors.white,
    final Color? pollOptionsSplashColor = Colors.grey,
    final BoxBorder? pollOptionsBorder,
    final BoxBorder? votedPollOptionsBorder,
    final Radius? votedPollOptionsRadius,
    final Color? votedBackgroundColor = const Color(0xffEEF0EB),
    final Color? votedProgressColor = const Color(0xff84D2F6),
    final Color? leadingVotedProgessColor = const Color(0xff0496FF),
    final Color? voteInProgressColor = const Color(0xffEEF0EB),
    final Widget? votedCheckmark,
    final TextStyle? votedPercentageTextStyle,
    final int votedAnimationDuration = 1000,
    final Widget? loadingWidget,
  }) {
    return ViewOnlyPollWidget(
      allowReselection: allowReselection,
      title: title,
      options: options,
      votes: votes,
      totalVotes: totalVotes,
      showPercentages: showPercentages,
      startDate: startDate,
      endDate: endDate,
      heightBetweenTitleAndOptions: heightBetweenTitleAndOptions,
      heightBetweenOptions: heightBetweenOptions,
      votesText: votesText,
      votesTextStyle: votesTextStyle,
      metaWidget: metaWidget,
      createdBy: createdBy,
      userToVote: userToVote,
      pollOptionsHeight: pollOptionsHeight,
      pollOptionsWidth: pollOptionsWidth,
      pollOptionsBorderRadius: pollOptionsBorderRadius,
      pollOptionsFillColor: pollOptionsFillColor,
      pollOptionsSplashColor: pollOptionsSplashColor,
      pollOptionsBorder: pollOptionsBorder,
      votedPollOptionsBorder: votedPollOptionsBorder,
      votedPollOptionsRadius: votedPollOptionsRadius,
      votedBackgroundColor: votedBackgroundColor,
      votedProgressColor: votedProgressColor,
      voteInProgressColor: voteInProgressColor,
      votedCheckmark: votedCheckmark,
      votedAnimationDuration: votedAnimationDuration,
      loadingWidget: loadingWidget,
    );
  }

  @override
  State<CustomPoll> createState() => _CustomPollState();
}

class _CustomPollState extends State<CustomPoll> {
  bool get hasVoted => selectedOption != null;

  late Duration remainingTime;
  Timer? _timer;
  String formattedTime = "00:00";
  Map<int, int> votes = {};
  int totalVotes = 0;
  int? selectedOption;

  @override
  void initState() {
    super.initState();
    votes = Map<int, int>.from(widget.initialVotes);
    totalVotes = votes.values.fold(0, (sum, count) => sum + count);
    remainingTime = PollTimerManager.calculateRemainingTime(widget.startDate, widget.endDate);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds > 0) {
        setState(() {
          remainingTime -= const Duration(seconds: 1);
          formattedTime = PollTimerManager.formatTimer(remainingTime);
        });
      } else {
        timer.cancel();
        _timer = null;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Map<int, double> _calculatePercentages() {
    Map<int, double> percentages = {};
    widget.options.asMap().forEach((index, _) {
      double percentage = widget.totalVotes > 0 ? ((widget.votes[index] ?? 0) / widget.totalVotes) * 100 : 0.0;
      percentages[index] = double.parse(percentage.toStringAsFixed(1));
    });
    return percentages;
  }

  // به‌روزرسانی اطلاعات رای‌گیری
  void _updateVoteData() {
    final voteData = VoteData(
      totalVotes: widget.totalVotes,
      optionVotes: Map<int, int>.from(widget.votes),
      percentages: _calculatePercentages(),
      selectedOption: selectedOption,
    );

    widget.voteStream?.add(voteData);
  }

  void _selectOption(int index) {
    final now = DateTime.now();
    if (now.isBefore(widget.startDate) || now.isAfter(widget.endDate)) return;

    setState(() {
      Map<int, int> mutableVotes = Map<int, int>.from(widget.votes);

      if (!widget.allowReselection && selectedOption != null) {
        return;
      }

      if (selectedOption == index && widget.allowReselection) {
        selectedOption = null;
        mutableVotes[index] = (mutableVotes[index] ?? 0) - 1;
        widget.totalVotes--;
      } else if (selectedOption == null || widget.allowReselection) {
        if (selectedOption != null) {
          mutableVotes[selectedOption!] = (mutableVotes[selectedOption!] ?? 0) - 1;
        } else {
          widget.totalVotes++;
        }

        selectedOption = index;
        mutableVotes[index] = (mutableVotes[index] ?? 0) + 1;
      }

      widget.votes = mutableVotes;
      _updateVoteData();
    });

    widget.onOptionSelected(selectedOption ?? -1);
  }

  Decoration decoration = BoxDecoration(
    borderRadius: BorderRadius.circular(24.0),
    color: Colors.grey.shade200,
    border: Border.all(style: BorderStyle.none),
  );

  @override
  Widget build(BuildContext context) {
    final showTimeStyle = widget.allStyle?.showTimeStyle;

    return Stack(
      children: [
        Opacity(
          opacity: widget.showTimer ? 0.5 : 1.0,
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              height: widget.height != 0 ? widget.height : constraints.maxHeight * 0.4,
              width: widget.width != 0 ? widget.width : constraints.maxWidth * 0.8,
              decoration: widget.backgroundDecoration ?? decoration,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: widget.allStyle?.titleStyle!.alignment ?? Alignment.centerLeft,
                      child: SelectableText(
                        maxLines: widget.allStyle?.titleStyle!.maxLines,
                        minLines: widget.allStyle?.titleStyle!.minLines,
                        textAlign: widget.allStyle?.titleStyle!.textAlign ?? TextAlign.center,
                        textDirection: widget.allStyle?.titleStyle!.textDirection ?? TextDirection.ltr,
                        widget.title,
                        style: widget.allStyle?.titleStyle!.style ?? const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: widget.heightBetweenTitleAndOptions),
                    ...widget.options.asMap().entries.map((entry) {
                      int index = entry.key;
                      String option = entry.value;
                      return Padding(
                        padding: EdgeInsets.only(bottom: widget.allStyle?.optionStyle?.heightBetweenOptions ?? 8),
                        child: PollOptionWidget(
                          dynamicPoll: widget,
                          option: option,
                          votes: widget.votes[index] ?? 0,
                          totalVotes: widget.totalVotes,
                          onTap: () => _selectOption(index),
                          isSelected: selectedOption == index,
                          index: index,
                          hasVoted: hasVoted,
                        ),
                      );
                    }),
                    SizedBox(height: widget.allStyle?.votesTextStyle?.paddingTop ?? 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: widget.allStyle?.votesTextStyle?.alignment ?? Alignment.centerLeft,
                          child: Text(
                            '${widget.votesText} ${widget.totalVotes} ',
                            style: widget.allStyle?.votesTextStyle?.style ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: widget.allStyle?.votesTextStyle?.paddingBottom ?? 10),
                        constraints.maxWidth > 354
                            ? RowWidget(widget: widget)
                            : ColumnWidget(
                                widget: widget,
                                constraints: constraints,
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        if (widget.showTimer && remainingTime.inSeconds > 0)
          Positioned.fill(
            child: Align(
              alignment: widget.allStyle?.showTimeStyle?.alignment ?? Alignment.center,
              child: Container(
                height: showTimeStyle?.height,
                width: showTimeStyle?.width,
                padding: const EdgeInsets.all(16.0),
                decoration: showTimeStyle?.decoration ??
                    BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                child: Text(
                  '${widget.allStyle?.showTimeStyle?.text ?? "Start by :"} ${PollTimerManager.formatTimer(remainingTime)}',
                  style: widget.allStyle?.showTimeStyle?.style ?? const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class RowWidget extends StatelessWidget {
  const RowWidget({
    super.key,
    required this.widget,
  });

  final CustomPoll widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.allStyle?.dateStyle?.mainAxisAlignment ?? MainAxisAlignment.spaceEvenly,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.allStyle?.dateStyle?.textStart ?? 'Started by: ',
                children: [
                  TextSpan(
                    text: widget.startDate.toLocal().toString().split(' ')[0],
                  )
                ],
                style: widget.allStyle?.dateStyle?.textStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.allStyle?.dateStyle?.textStart ?? 'Ends by: ',
                children: [
                  TextSpan(
                    text: widget.endDate.toLocal().toString().split(' ')[0],
                  )
                ],
                style: widget.allStyle?.dateStyle?.textStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ColumnWidget extends StatelessWidget {
  const ColumnWidget({
    super.key,
    required this.widget,
    required this.constraints,
  });

  final CustomPoll widget;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: size.width * 0.23),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.allStyle?.dateStyle?.textStart ?? 'Started by: ',
                  children: [
                    TextSpan(
                      text: widget.startDate.toLocal().toString().split(' ')[0],
                    )
                  ],
                  style: widget.allStyle?.dateStyle?.textStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.allStyle?.dateStyle?.textStart ?? 'Ends by: ',
                  children: [
                    TextSpan(
                      text: widget.endDate.toLocal().toString().split(' ')[0],
                    )
                  ],
                  style: widget.allStyle?.dateStyle?.textStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
