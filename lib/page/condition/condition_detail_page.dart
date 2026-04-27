import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/condition/condition_detail_view_model.dart';
import 'package:foxy/page/condition/condition_view.dart';
import 'package:foxy/widget/tab.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class ConditionDetailPage extends StatefulWidget {
  final Map<String, dynamic>? credential;

  const ConditionDetailPage({super.key, this.credential});

  @override
  State<ConditionDetailPage> createState() => _ConditionDetailPageState();
}

class _ConditionDetailPageState extends State<ConditionDetailPage> {
  final viewModel = GetIt.instance.get<ConditionDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    final isNew = widget.credential == null;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text(
            isNew ? '新建条件' : '条件详情',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        FoxyTab(
          tabs: [Text('条件')],
          contents: [
            ConditionView(credential: widget.credential),
          ],
        ),
      ],
    );
  }
}
