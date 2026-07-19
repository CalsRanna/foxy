import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/currency_type/currency_type_detail_view_model.dart';
import 'package:foxy/page/currency_type/currency_type_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

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
  void initState() {
    super.initState();
    viewModel.initSignals(key: widget.currencyTypeKey);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((_) {
      final key = viewModel.persistedKey.value;
      final name = key == null ? '新建货币' : '货币 #$key';
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          FoxyTab(
            tabs: const [Text('货币')],
            contents: [CurrencyTypeView(viewModel: viewModel)],
          ),
        ],
      );
    });
  }
}
