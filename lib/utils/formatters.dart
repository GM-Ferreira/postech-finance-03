import 'package:intl/intl.dart';

class Formatters {
  static final _currency = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  static final _compactCurrency = NumberFormat.compactCurrency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  static final _date = DateFormat('dd/MM/yyyy', 'pt_BR');

  static final _dateExtended = DateFormat("d 'de' MMMM 'de' yyyy", 'pt_BR');

  static String currency(double value) {
    return _currency.format(value);
  }

  static String compactCurrency(double value) {
    return _compactCurrency.format(value);
  }

  static String date(DateTime date) {
    return _date.format(date);
  }

  static String dateExtended(DateTime date) {
    return _dateExtended.format(date);
  }

  static String initials(String text) {
    if (text.isEmpty) return 'U';

    final parts = text.trim().split(' ');

    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }

    return text.substring(0, 1).toUpperCase();
  }
}
