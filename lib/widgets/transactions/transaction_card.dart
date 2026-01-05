import 'package:flutter/material.dart';

import '../../models/transaction.dart' as models;
import '../../utils/formatters.dart';

class TransactionCard extends StatelessWidget {
  final models.Transaction transaction;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TransactionCard({
    super.key,
    required this.transaction,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.isIncome;
    final color = isIncome ? Colors.green : Colors.red;
    final icon = isIncome ? Icons.arrow_upward : Icons.arrow_downward;
    final sign = isIncome ? '+' : '-';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(icon, color: color),
          ),
          title: Text(
            transaction.description,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            '${transaction.category} • ${Formatters.date(transaction.date)}',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$sign ${Formatters.currency(transaction.amount)}',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.grey),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
