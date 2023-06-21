import 'package:flutter/material.dart';

import 'flex_padded.dart';

class FormBody extends StatelessWidget {
  const FormBody({
    super.key,
    required this.formKey,
    required this.children,
    this.centered = false,
    this.actions = const [],
    this.gap = 8.0,
    this.safeArea = true,
    this.padding = const EdgeInsets.all(16.0),
    this.mainAxisAlign = MainAxisAlignment.center,
    this.crossAxisAlign = CrossAxisAlignment.stretch,
    this.mainAxisSize = MainAxisSize.min,
    this.autovalidateMode,
  });

  final List<Widget> children;

  final List<Widget> actions;

  final EdgeInsets padding;

  final double gap;

  final GlobalKey<FormState> formKey;

  final MainAxisAlignment mainAxisAlign;

  final CrossAxisAlignment crossAxisAlign;

  final MainAxisSize mainAxisSize;

  final bool centered;

  final bool safeArea;

  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    Widget current = SingleChildScrollView(
      child: Padding(
        padding: padding,
        child: ColumnPadded(
          gap: gap,
          mainAxisAlignment: mainAxisAlign,
          crossAxisAlignment: crossAxisAlign,
          mainAxisSize: mainAxisSize,
          children: children,
        ),
      ),
    );

    if (centered) current = Center(child: current);

    current = Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: actions.isEmpty
              ? current
              : Column(
                  children: [
                    Expanded(child: current),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RowPadded(
                        children: [
                          for (final action in actions) Expanded(child: action),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );

    if (safeArea) current = SafeArea(child: current);

    return current;
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ColumnPadded(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
