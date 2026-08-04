import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/page/currency_type/currency_type_view.dart';
import 'package:foxy/view_model/currency_type_detail_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class CurrencyTypeDetailPage extends StatefulWidget {
  final int? currencyTypeKey;

  const CurrencyTypeDetailPage({super.key, this.currencyTypeKey});

  @override
  State<CurrencyTypeDetailPage> createState() => _CurrencyTypeDetailPageState();
}

class _CurrencyTypeDetailPageState extends State<CurrencyTypeDetailPage> {
  final viewModel = GetIt.instance.get<CurrencyTypeDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            '货币详情',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        FoxyTab(
          tabs: const [Text('货币')],
          contents: [CurrencyTypeView(viewModel: viewModel)],
        ),
      ],
    );
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals(key: widget.currencyTypeKey);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：${foxyErrorMessage(error)}');
    }
  }
}
