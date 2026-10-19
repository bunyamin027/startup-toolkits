import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_tokens.dart';
import '../../project/project.dart';
import '../../project/project_providers.dart';
import '../../tools/tool_def.dart';

const _numericFields = {
  ProjectField.cash,
  ProjectField.monthlyExpenses,
  ProjectField.monthlyRevenue,
};

const _longFields = {
  ProjectField.problem,
  ProjectField.solution,
  ProjectField.traction,
  ProjectField.team,
};

const fieldHints = {
  ProjectField.startupName: 'e.g. Nimbly',
  ProjectField.oneLiner: 'What you do, for whom, in one sentence',
  ProjectField.problem: 'The pain your customers feel today',
  ProjectField.solution: 'How you remove that pain',
  ProjectField.targetCustomer: 'Who has the problem most',
  ProjectField.marketSize: r'e.g. $4B serviceable market',
  ProjectField.traction: 'Users, revenue, growth',
  ProjectField.ask: r'e.g. $750k pre-seed',
  ProjectField.team: 'Founders and key roles',
  ProjectField.contactEmail: 'founders@yourstartup.com',
  ProjectField.cash: 'Cash in the bank today',
  ProjectField.monthlyExpenses: 'Total spend per month',
  ProjectField.monthlyRevenue: 'Revenue per month',
};

Future<void> showSheet(BuildContext context, Widget child) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: context.tokens.surface1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.card),
        ),
      ),
      builder: (_) => child,
    );

/// Edits one project field. Tools pick the new value up next time they open.
class ProjectFieldSheet extends ConsumerStatefulWidget {
  const ProjectFieldSheet({super.key, required this.field});

  final ProjectField field;

  @override
  ConsumerState<ProjectFieldSheet> createState() => _ProjectFieldSheetState();
}

class _ProjectFieldSheetState extends ConsumerState<ProjectFieldSheet> {
  late final _controller = TextEditingController(
    text: ref.read(projectProvider)[widget.field],
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    ref
        .read(projectProvider.notifier)
        .setField(widget.field, _controller.text.trim());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final f = widget.field;
    final numeric = _numericFields.contains(f);
    final long = _longFields.contains(f);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpace.edge,
          20,
          AppSpace.edge,
          20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              f.label,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontSize: 22),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              autofocus: true,
              minLines: long ? 3 : 1,
              maxLines: long ? 6 : 1,
              keyboardType: numeric
                  ? const TextInputType.numberWithOptions(decimal: true)
                  : f == ProjectField.contactEmail
                  ? TextInputType.emailAddress
                  : long
                  ? TextInputType.multiline
                  : TextInputType.text,
              inputFormatters: numeric
                  ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))]
                  : null,
              textCapitalization: f == ProjectField.contactEmail
                  ? TextCapitalization.none
                  : TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: fieldHints[f],
                prefixText: numeric ? r'$ ' : null,
              ),
              onSubmitted: long ? null : (_) => _save(),
            ),
            const SizedBox(height: 20),
            FilledButton(onPressed: _save, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}

/// Picks the onboarding goal again; Home's suggestions follow it.
class GoalSheet extends ConsumerWidget {
  const GoalSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(projectProvider.select((p) => p.goal));
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpace.edge,
          20,
          AppSpace.edge,
          12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'What are you building toward?',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontSize: 22),
            ),
            const SizedBox(height: 12),
            for (final g in Goal.values)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(goalIcon(g), color: context.tokens.accent),
                title: Text(g.label),
                trailing: g == current
                    ? Icon(Icons.check_rounded, color: context.tokens.accent)
                    : null,
                onTap: () {
                  ref.read(projectProvider.notifier).setGoal(g);
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }
}

IconData goalIcon(Goal goal) => switch (goal) {
  Goal.raiseFunding => Icons.rocket_launch_outlined,
  Goal.firstCustomers => Icons.groups_outlined,
  Goal.setUpCompany => Icons.business_outlined,
  Goal.launchApp => Icons.phone_iphone,
};
