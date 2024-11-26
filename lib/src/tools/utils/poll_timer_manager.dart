class PollTimerManager {
  static Duration calculateRemainingTime(DateTime startDate, DateTime endDate) {
    final now = DateTime.now();
    return startDate.isAfter(now) ? startDate.difference(now) : endDate.difference(now);
  }

  static String formatTimer(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
