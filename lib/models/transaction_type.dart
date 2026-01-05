enum TransactionType {
  income('income', 'Receita'),
  expense('expense', 'Despesa');

  const TransactionType(this.value, this.label);

  final String value;
  final String label;

  static TransactionType fromValue(String value) {
    return values.firstWhere(
      (t) => t.value == value,
      orElse: () => TransactionType.expense,
    );
  }

  bool get isIncome => this == TransactionType.income;
  bool get isExpense => this == TransactionType.expense;
}
