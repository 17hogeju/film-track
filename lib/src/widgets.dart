import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:flutter/services.dart';

class Header extends StatelessWidget {
  const Header(this.heading, {super.key});
  final String heading;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          heading,
          style: const TextStyle(fontSize: 24),
        ),
      );
}

class Paragraph extends StatelessWidget {
  const Paragraph(this.content, {super.key});
  final String content;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          content,
          style: const TextStyle(fontSize: 18),
        ),
      );
}

class IconAndDetail extends StatelessWidget {
  const IconAndDetail(this.icon, this.detail, {super.key});
  final IconData icon;
  final String detail;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(
              detail,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      );
}

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed, super.key});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.deepPurple)),
        onPressed: onPressed,
        child: child,
      );
}

// TODO: Input validation - verify input is currency
class BudgetInputField extends StatelessWidget {
  BudgetInputField({super.key});
  double budget = 0;

  @override
  Widget build(BuildContext context) => ListTile(
        subtitle: Column(
          children: <Widget>[
            const Text(
              'Budget',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: budget.toString()),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
              ],
              onSubmitted: (value) => budget = double.parse(value),
            ),
          ],
        ),
      );
}

class SubscriptionsDropDown extends StatelessWidget {
  SubscriptionsDropDown({super.key});
  List<String> subscriptions = [];

  @override
  Widget build(BuildContext context) => ListTile(
        subtitle: Column(
          children: <Widget>[
            const Text(
              'Subscriptions',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropDownMultiSelect(
                onChanged: (List<String> x) {
                  subscriptions = x;
                },
                options: const ['Netflix', 'Hulu'],
                selectedValues: subscriptions,
                whenEmpty: "Select your subscriptions")
          ],
        ),
      );
}
