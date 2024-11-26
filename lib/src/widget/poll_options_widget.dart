import 'package:custom_poll/custom_poll.dart';
import 'package:flutter/material.dart';

class PollOptionWidget extends StatefulWidget {
  final CustomPoll dynamicPoll;
  final String option;
  final int votes;
  final int totalVotes;
  final VoidCallback onTap;
  final bool isSelected;
  final bool hasVoted;
  final int index;

  const PollOptionWidget({
    super.key,
    required this.dynamicPoll,
    required this.option,
    required this.votes,
    required this.totalVotes,
    required this.onTap,
    required this.index,
    required this.hasVoted,
    this.isSelected = false,
  });

  @override
  State<PollOptionWidget> createState() => _PollOptionWidgetState();
}

class _PollOptionWidgetState extends State<PollOptionWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.dynamicPoll.allStyle?.optionStyle?.animationDuration ?? const Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 0, end: _getPercentage()).animate(_controller);
    _controller.forward();
  }

  @override
  void didUpdateWidget(PollOptionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.votes != widget.votes || oldWidget.totalVotes != widget.totalVotes) {
      _animation = Tween<double>(begin: _animation.value, end: _getPercentage()).animate(_controller);
      _controller.forward(from: 0);
    }
  }

  double _getPercentage() {
    return widget.totalVotes > 0 ? widget.votes / widget.totalVotes : 0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final optionStyle = widget.dynamicPoll.allStyle?.optionStyle;
    bool isVotingTime = DateTime.now().isAfter(widget.dynamicPoll.startDate) && DateTime.now().isBefore(widget.dynamicPoll.endDate);
    bool isTimerFinished = DateTime.now().isAfter(widget.dynamicPoll.endDate);

    if (DateTime.now().isBefore(widget.dynamicPoll.startDate)) {
      //  debugPrint('Voting has not started yet');
      isVotingTime = false;
      //   debugPrint("isVotingTime: $isVotingTime");
    } else if (DateTime.now().isAfter(widget.dynamicPoll.endDate)) {
      //  debugPrint('Voting has finished');
      isTimerFinished = true;
      //  debugPrint("isTimerFinished: $isTimerFinished");
    } else {
      debugPrint('Voting is ongoing');
    }
    bool isClickable = isVotingTime && !isTimerFinished;
    return AbsorbPointer(
      absorbing: !isClickable,
      child: GestureDetector(
        onTap: isClickable ? widget.onTap : null,
        child: Opacity(
          opacity: isClickable ? 1.0 : 0.6,
          child: Container(
            height: optionStyle?.height ?? 36,
            width: optionStyle?.width ?? double.infinity,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: optionStyle?.borderRadius ?? BorderRadius.circular(8),
              border: Border.all(
                color: widget.isSelected ? optionStyle?.selectedBorderColor ?? Colors.blue : optionStyle?.unselectedBorderColor ?? Colors.grey,
                width: optionStyle?.borderWidth ?? 2.0,
              ),
              color: optionStyle?.fillColor ?? Colors.white,
            ),
            child: Stack(
              children: [
                if (widget.hasVoted && !widget.dynamicPoll.private) // Only show progress bar if not private
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return FractionallySizedBox(
                        widthFactor: _animation.value,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            borderRadius: optionStyle?.borderRadius ?? BorderRadius.circular(8),
                            color: widget.isSelected
                                ? optionStyle?.leadingVotedProgessColor!.withOpacity(optionStyle.opacityLeadingVotedProgessColor ?? 0.2) ?? Colors.blue.withOpacity(0.2)
                                : optionStyle?.votedBackgroundColor?.withOpacity(0.8) ?? Colors.blue.withOpacity(0.8),
                            border: Border.all(
                              color: widget.isSelected ? optionStyle?.voteBorderProgressColor ?? Colors.blue : Colors.transparent,
                              width: optionStyle?.progressBorderWidth ?? 1.0, // Set progress bar border width
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (widget.isSelected && optionStyle?.votedCheckmark != null) optionStyle!.votedCheckmark,
                          const SizedBox(width: 5),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.40,
                            child: Text(
                              widget.option,
                              style: TextStyle(
                                fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal,
                                color: widget.isSelected ? optionStyle?.textSelectColor ?? Colors.blue.withOpacity(0.8) : Colors.black,
                              ),
                              softWrap: true,
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const Spacer(),
                          if (widget.hasVoted && !widget.dynamicPoll.private) // Only show percentage if not private
                            AnimatedOpacity(
                              opacity: widget.hasVoted ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 500),
                              child: AnimatedBuilder(
                                animation: _animation,
                                builder: (context, child) {
                                  return Text(
                                    '${(_animation.value * 100).toStringAsFixed(1)}%',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: widget.isSelected ? optionStyle?.textSelectColor ?? Colors.blue.withOpacity(0.8) : optionStyle?.otherTextPercentColor,
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}