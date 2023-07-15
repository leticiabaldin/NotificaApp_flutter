import 'package:flutter/material.dart';
import '../entities/occurrence.dart';

class OccurrenceListTile extends StatelessWidget {
  const OccurrenceListTile({Key? key, required this.occurrence})
      : super(key: key);

  final Occurrence occurrence;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: occurrence.type == Options.open
          ? const Icon(
              Icons.pending_actions_outlined,
              size: 32,
            )
          : const Icon(
              Icons.check_circle_outline,
              size: 32,
            ),
      title: Text(
        occurrence.title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        'Status: ${occurrence.type == Options.open ? 'Em aberto' : 'Resolvida'}',
      ),
    );
  }
}
