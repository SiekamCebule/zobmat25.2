import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zobmat25_2/feature/navigation/domain/entity/navigation_entry.dart';
import 'package:zobmat25_2/feature/navigation/ui/bloc/navigation_cubit.dart';

class NavigationLinkTextButton extends StatelessWidget {
  const NavigationLinkTextButton({
    super.key,
    required this.text,
    this.textStyle,
    required this.navigationEntry,
  });

  final String text;
  final TextStyle? textStyle;
  final NavigationEntry navigationEntry;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
        overlayColor: Colors.transparent,
        minimumSize: Size.zero,
      ),
      onPressed: () {
        context.read<NavigationCubit>().goTo(navigationEntry);
      },
      child: Text(
        text,
        style:
            textStyle ??
            Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
