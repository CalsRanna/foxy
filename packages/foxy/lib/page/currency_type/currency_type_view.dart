import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/currency_type_detail_view_model.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class CurrencyTypeView extends StatelessWidget {
  final CurrencyTypeDetailViewModel viewModel;

  const CurrencyTypeView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final idInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
      ),
    );
    final itemIdInput = FoxyFormItem(
      label: '货币物品',
      child: FoxyEntityPicker(
        placeholder: 'ItemID',
        controller: viewModel.itemIdController,
        delegate: FoxyEntityPickerDelegates.itemTemplate,
      ),
    );
    final categoryIdInput = FoxyFormItem(
      label: '货币分类',
      child: FoxyEntityPicker(
        placeholder: 'CategoryID',
        controller: viewModel.categoryIdController,
        delegate: FoxyEntityPickerDelegates.currencyCategory,
      ),
    );
    final bitIndexInput = FoxyFormItem(
      label: '位索引',
      child: FoxyNumberInput<int>(
        placeholder: 'BitIndex',
        controller: viewModel.bitIndexController,
      ),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FoxyFormSection(
            title: '基本信息',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: idInput),
                  Expanded(child: itemIdInput),
                  Expanded(child: categoryIdInput),
                  Expanded(child: bitIndexInput),
                ],
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Watch(
                (_) => ShadButton(
                  enabled: !viewModel.submitting.value,
                  onPressed: () => _persist(context),
                  child: Text('保存'),
                ),
              ),
              ShadButton.ghost(onPressed: _goBack, child: Text('取消')),
            ],
          ),
        ],
      ),
    );
  }

  void _goBack() {
    GetIt.instance.get<RouterFacade>().goBack();
  }

  Future<void> _persist(BuildContext context) async {
    try {
      await viewModel.persist();
      if (!context.mounted) return;
      DialogUtil.instance.success('货币数据已保存');
    } catch (error) {
      if (!context.mounted) return;
      DialogUtil.instance.error('保存失败：${FoxyExceptions.message(error)}');
    }
  }
}
