enum TransactionCategory {
  salario('Salário', 'income'),
  freelance('Freelance', 'income'),
  investimentos('Investimentos', 'income'),
  presente('Presente', 'income'),

  alimentacao('Alimentação', 'expense'),
  transporte('Transporte', 'expense'),
  moradia('Moradia', 'expense'),
  saude('Saúde', 'expense'),
  educacao('Educação', 'expense'),
  lazer('Lazer', 'expense'),
  roupas('Roupas', 'expense'),

  outros('Outros', 'both');

  const TransactionCategory(this.label, this.type);

  final String label;
  final String type;

  static List<TransactionCategory> get all => values;

  static List<String> get allLabels => values.map((c) => c.label).toList();

  static List<TransactionCategory> byType(String transactionType) {
    return values
        .where((c) => c.type == transactionType || c.type == 'both')
        .toList();
  }

  static List<String> labelsByType(String transactionType) {
    return byType(transactionType).map((c) => c.label).toList();
  }

  static TransactionCategory fromLabel(String label) {
    return values.firstWhere(
      (c) => c.label == label,
      orElse: () => TransactionCategory.outros,
    );
  }
}
