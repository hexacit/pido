class TimeLeft{

 final Duration duration;
  TimeLeft({
   required this.duration,
});

  String get secondsLeft{
    int secLeft=
    duration.inSeconds - (minutesLeft * 60);
    String s = secLeft.toString().length <= 2
        ? secLeft.toString()
        : secLeft.toString().substring(secLeft.toString().length - 2);
    return s;

  }
 int get minutesLeft{
   return duration.inMinutes - (daysLeft * 24 * 60) - (hoursLeft * 60);
 }
 int get hoursLeft{
    return duration.inHours - (daysLeft*24);
 }
 int get daysLeft{
    return duration.inDays;
 }


}