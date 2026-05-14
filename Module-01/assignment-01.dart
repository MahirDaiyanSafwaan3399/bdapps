import 'dart:io';

void main() {

  stdout.write('Enter your total monthly income: ');
  double income = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;

  Map<String, double?> expenses = {
    'Food': null,
    'Rent': null,
    'Transport': null,
    'Utilities': null,
  };

  print('\nPlease enter the amounts for the following categories:');

  for (var category in expenses.keys) {
    stdout.write('$category: ');
    String? input = stdin.readLineSync();
    

    if (input != null && input.isNotEmpty) {
      expenses[category] = double.tryParse(input);
    }
  }

  double totalExpenses = 0;
  expenses.forEach((category, amount) {

    totalExpenses += amount ?? 0.0;
  });

  double remainingBalance = income - totalExpenses;
  
  double savingsPercentage = income > 0 ? (remainingBalance / income) * 100 : 0.0;

  print('\n' + '=' * 30);
  print('       FINANCIAL SUMMARY');
  print('=' * 30);
  print('Total Income:      \$${income.toStringAsFixed(2)}');
  print('Total Expenses:    \$${totalExpenses.toStringAsFixed(2)}');
  print('------------------------------');
  print('Remaining Balance: \$${remainingBalance.toStringAsFixed(2)}');
  print('Savings Rate:      ${savingsPercentage.toStringAsFixed(1)}%');
  print('=' * 30);

  if (remainingBalance < 0) {
    print('Warning: You are over budget!');
  } else {
    print('Great job! You are living within your means.');
  }
}