import 'package:flutter/material.dart';
import 'package:pushit/features/account/widget/account_button.dart';

class TopAccountButtons extends StatelessWidget {
  const TopAccountButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'Your Orders', onTap: () {}),
            AccountButton(text: 'Turn Seller', onTap: () {}),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(text: 'Log Out', onTap: () {}),
            AccountButton(text: 'Your wish List', onTap: () {}),
          ],
        )
      ],
    );
  }
}
