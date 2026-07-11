import 'package:flutter/material.dart';
import 'package:foxy/page/item_set/item_set_detail_view_model.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class ItemSetView extends StatefulWidget {
  final int? entry;
  const ItemSetView({super.key, this.entry});

  @override
  State<ItemSetView> createState() => _ItemSetViewState();
}

class _ItemSetViewState extends State<ItemSetView> {
  final viewModel = GetIt.instance.get<ItemSetDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(id: widget.entry);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          _buildBasicInfo(),
          _buildNameText(),
          _buildItemIds(),
          _buildSetSpellIds(),
          _buildSetThresholds(),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildBasicInfo() {
    return FoxyFormSection(
      title: '基本信息',
      children: [
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: FoxyFormItem(
                label: '编号',
                child: FoxyNumberInput<int>(
                  placeholder: 'ID',
                  controller: viewModel.idController,
                  readOnly: true,
                ),
              ),
            ),
            Expanded(
              child: FoxyFormItem(
                label: '需求技能',
                child: FoxyNumberInput<int>(
                  placeholder: 'RequiredSkill',
                  controller: viewModel.requiredSkillController,
                ),
              ),
            ),
            Expanded(
              child: FoxyFormItem(
                label: '需求技能等级',
                child: FoxyNumberInput<int>(
                  placeholder: 'RequiredSkillRank',
                  controller: viewModel.requiredSkillRankController,
                ),
              ),
            ),
            Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _buildNameText() {
    return FoxyFormSection(
      title: '名称文本',
      children: [
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: FoxyFormItem(
                label: '名称',
                child: Watch((_) {
                  final id = viewModel.itemSet.value.id;
                  return FoxyLocalePicker(
                    entry: id == 0 ? null : id,
                    controller: viewModel.nameLangZhCNController,
                    title: '套装名称本地化',
                    placeholder: 'Name_lang_zhCN',
                    delegate: FoxyLocalePickerDelegates.dbcItemSetName,
                    onSaved: viewModel.applyNameLocales,
                  );
                }),
              ),
            ),
            const Expanded(child: SizedBox()),
            const Expanded(child: SizedBox()),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _buildItemIds() {
    return _buildPickerSection(
      title: '套装物品',
      count: 17,
      delegate: FoxyEntityPickerDelegates.itemTemplate,
      controllers: viewModel.itemIdControllers,
      labelPrefix: '物品',
      placeholderPrefix: 'ItemID',
    );
  }

  Widget _buildSetSpellIds() {
    return _buildPickerSection(
      title: '套装法术',
      count: 8,
      delegate: FoxyEntityPickerDelegates.spell,
      controllers: viewModel.setSpellIdControllers,
      labelPrefix: '法术',
      placeholderPrefix: 'SetSpellID',
    );
  }

  /// 按每行 4 个构建编号选择器网格，不足 4 个的位置用空白占位。
  Widget _buildPickerSection<T>({
    required String title,
    required int count,
    required FoxyEntityPickerDelegate<T> delegate,
    required List<TextEditingController> controllers,
    required String labelPrefix,
    required String placeholderPrefix,
  }) {
    final rowCount = (count + 3) ~/ 4;
    return FoxyFormSection(
      title: title,
      children: [
        for (int r = 0; r < rowCount; r++)
          Row(
            spacing: 8,
            children: [
              for (int c = 0; c < 4; c++)
                Expanded(
                  child: (r * 4 + c < count)
                      ? FoxyFormItem(
                          label: '$labelPrefix${r * 4 + c}',
                          child: FoxyEntityPicker<T>(
                            delegate: delegate,
                            controller: controllers[r * 4 + c],
                            placeholder: '$placeholderPrefix${r * 4 + c}',
                          ),
                        )
                      : const SizedBox(),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildSetThresholds() {
    return FoxyFormSection(
      title: '触发阈值',
      children: [
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: FoxyFormItem(
                label: '门槛0',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetThreshold0',
                  controller: viewModel.setThreshold0Controller,
                ),
              ),
            ),
            Expanded(
              child: FoxyFormItem(
                label: '门槛1',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetThreshold1',
                  controller: viewModel.setThreshold1Controller,
                ),
              ),
            ),
            Expanded(
              child: FoxyFormItem(
                label: '门槛2',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetThreshold2',
                  controller: viewModel.setThreshold2Controller,
                ),
              ),
            ),
            Expanded(
              child: FoxyFormItem(
                label: '门槛3',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetThreshold3',
                  controller: viewModel.setThreshold3Controller,
                ),
              ),
            ),
          ],
        ),
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: FoxyFormItem(
                label: '门槛4',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetThreshold4',
                  controller: viewModel.setThreshold4Controller,
                ),
              ),
            ),
            Expanded(
              child: FoxyFormItem(
                label: '门槛5',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetThreshold5',
                  controller: viewModel.setThreshold5Controller,
                ),
              ),
            ),
            Expanded(
              child: FoxyFormItem(
                label: '门槛6',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetThreshold6',
                  controller: viewModel.setThreshold6Controller,
                ),
              ),
            ),
            Expanded(
              child: FoxyFormItem(
                label: '门槛7',
                child: FoxyNumberInput<int>(
                  placeholder: 'SetThreshold7',
                  controller: viewModel.setThreshold7Controller,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        ShadButton(onPressed: () => viewModel.save(context), child: Text('保存')),
        const SizedBox(width: 8),
        ShadButton.ghost(onPressed: () => viewModel.pop(), child: Text('取消')),
      ],
    );
  }
}
