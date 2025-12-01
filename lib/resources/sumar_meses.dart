DateTime sumarMeses(DateTime fecha, int meses) {
  int years = meses ~/ 12;
  int month = fecha.month + meses % 12;
  if (month > 12) {
    years++;
    month -= 12;
  }
  return DateTime(fecha.year + years, month, 1);
}

int monthsBetween(DateTime startDate, DateTime endDate) {
  return (endDate.year - startDate.year) * 12 + endDate.month - startDate.month;
}