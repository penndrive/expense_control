class Expenses {
  List<CreditCard> credit_cards = <CreditCard>[];
  List<CashExpense> cash_expense = <CashExpense>[];
  List<FixedExpense> living_cost = <FixedExpense>[];
  List<FixedExpense> streaming = <FixedExpense>[];
}

class CreditCard {
  DateTime lastThursdayOfMonth(int year, int month, int thursdaysBeforeEnd) {
    if (thursdaysBeforeEnd < 1 || thursdaysBeforeEnd > 5) {
      throw ArgumentError('Number of Thursdays should be between 1 and 5.');
    }

    // Find the last day of the month
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);

    // Find the last Thursday before the end of the month
    DateTime lastThursday = DateTime(year);
    int thursdayCount = 0;
    for (int i = lastDayOfMonth.day; i >= 1; i--) {
      DateTime currentDate = DateTime(year, month, i);
      if (currentDate.weekday == DateTime.thursday) {
        thursdayCount++;
        lastThursday = DateTime(
            currentDate.year, currentDate.month, currentDate.day, 23, 59, 59);
      }
      if (thursdayCount == thursdaysBeforeEnd) {
        break;
      }
    }

    return lastThursday;
  }

  int monthComputer(int year, int month) {
    if (DateTime.now()
        .isBefore(lastThursdayOfMonth(year, month, thursdaysBeforeEnd))) {
      month = month + 1;
    } else {
      month = month + 2;
    }
    return month;
  }

  int credit_limit = 0;
  int thursdaysBeforeEnd = 0;
  List<List<CreditCardMonth>> months = [[]];

  addOnepayment(String reference, String description, int amount) {
    int year = DateTime.now().year;
    int month = monthComputer(
      year,
      DateTime.now().month,
    );
    months[year][month].one_payments.add(
          OnePayment(
            reference,
            description,
            amount,
            DateTime.now(),
          ),
        );
  }

  addInstallments(
      String reference, String description, int amount, int installments) {
    int year = DateTime.now().year;
    int month = monthComputer(
      year,
      DateTime.now().month,
    );
    for (var i = 1; i < installments; i++) {
      months[year][month].installments.add(
            Installments(
              reference,
              description,
              amount,
              installments,
              i,
              DateTime.now(),
            ),
          );
    }
  }
}

class CreditCardMonth {
  List<OnePayment> one_payments = <OnePayment>[];
  List<Installments> installments = <Installments>[];
  DateTime due_date = DateTime(2023, 2, 3, 4, 5, 1, 1);
  DateTime closing_date = DateTime(2023, 2, 3, 4, 5, 1, 1);
}

class Installments {
  String reference;
  String description;
  int amount;
  int total_installments;
  int one_of;
  DateTime date_time;
  Installments(this.reference, this.description, this.amount,
      this.total_installments, this.one_of, this.date_time);
}

class OnePayment {
  String reference;
  String description;
  int amount;
  DateTime date_time;
  OnePayment(this.reference, this.description, this.amount, this.date_time);
}

class CashExpense {}

class FixedExpense {}
