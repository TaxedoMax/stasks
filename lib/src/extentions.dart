extension CompareDates on DateTime{
  int compareWithoutTime(DateTime date2){
    int result;
    int yearDifference = year.compareTo(date2.year);
    int monthDifference = month.compareTo(date2.month);
    int dayDifference = day.compareTo(date2.day);

    if(yearDifference != 0) {
      result = yearDifference;
    } else if(monthDifference != 0) {
      result = monthDifference;
    } else if(dayDifference != 0) {
      result = dayDifference;
    } else{
      result = 0;
    }

    return result;
  }
}