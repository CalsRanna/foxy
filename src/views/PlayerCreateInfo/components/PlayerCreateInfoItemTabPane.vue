<template>
  <div>
    <div v-show="!creating">
      <el-card style="margin-top: 1px">
        <el-button type="primary" @click="create">新增</el-button>
        <el-button @click="copy" :disabled="disabled">复制</el-button>
        <el-button type="danger" @click="destroy" :disabled="disabled">
          删除
        </el-button>
      </el-card>
      <el-card style="margin-top: 16px">
        <el-table
          :data="playerCreateInfoItems"
          highlight-current-row
          :max-height="calculateMaxHeight()"
          class="hide-when-overflow tight-table"
          @current-change="select"
          @row-dblclick="show"
        >
          <el-table-column label="物品">
            <item-template-name
              slot-scope="scope"
              :itemTemplate="scope.row"
            ></item-template-name>
          </el-table-column>
          <el-table-column prop="amount" label="数量" />
          <el-table-column prop="Note" label="Note" />
        </el-table>
      </el-card>
    </div>
    <div v-show="creating">
      <el-form
        :model="playerCreateInfoItem"
        label-position="right"
        label-width="120px"
      >
        <div
          :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }"
        >
          <el-card
            style="margin-top: 1px"
            :body-style="{ padding: '22px 20px 0 20px' }"
          >
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="种族">
                  <el-select
                    v-model="playerCreateInfoItem.race"
                    placeholder="race"
                  >
                    <el-option
                      v-for="race in chrRaces"
                      :key="`race-${race.ID}`"
                      :label="race.Name_Lang_zhCN"
                      :value="race.ID"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="职业">
                  <el-select
                    v-model="playerCreateInfoItem.class"
                    placeholder="class"
                  >
                    <el-option
                      v-for="c in chrClasses"
                      :key="`class-${c.ID}`"
                      :label="c.Name_Lang_zhCN"
                      :value="c.ID"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card
            style="margin-top: 16px"
            :body-style="{ padding: '22px 20px 0 20px' }"
          >
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="物品">
                  <item-template-selector
                    v-model="playerCreateInfoItem.itemid"
                    placeholder="itemid"
                  ></item-template-selector>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="数量">
                  <el-input-number
                    v-model="playerCreateInfoItem.amount"
                    controls-position="right"
                    placeholder="amount"
                  />
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="Note">
                  <el-input
                    v-model="playerCreateInfoItem.Note"
                    placeholder="Note"
                  />
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
        </div>
        <el-card style="margin-top: 16px">
          <el-button type="primary" :loading="loading" @click="store">
            保存
          </el-button>
          <el-button @click="cancel">返回</el-button>
        </el-card>
      </el-form>
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
import ItemTemplateName from "@/components/ItemTemplateName";
import ItemTemplateSelector from "@/components/ItemTemplateSelector";

export default {
  data() {
    return {
      initing: false,
      creating: false,
      editing: false,
      currentRow: undefined,
      loading: false,
    };
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("initiator", ["chrRaces", "chrClasses"]),
    ...mapState("playerCreateInfo", ["playerCreateInfo"]),
    ...mapState("playerCreateInfoItem", [
      "playerCreateInfoItems",
      "playerCreateInfoItem",
    ]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        race: this.playerCreateInfo.race,
        class: this.playerCreateInfo.class,
        itemid:
          this.currentRow != undefined ? this.currentRow.itemid : undefined,
      };
    },
  },
  methods: {
    ...mapActions("playerCreateInfoItem", [
      "searchPlayerCreateInfoItems",
      "storePlayerCreateInfoItem",
      "findPlayerCreateInfoItem",
      "updatePlayerCreateInfoItem",
      "destroyPlayerCreateInfoItem",
      "createPlayerCreateInfoItem",
      "copyPlayerCreateInfoItem",
    ]),
    calculateMaxHeight() {
      return this.creating ? this.clientHeight - 307 : this.clientHeight - 349;
    },
    async create() {
      this.creating = true;
      this.editing = false;
      await this.createPlayerCreateInfoItem({
        race: this.playerCreateInfo.race,
        class: this.playerCreateInfo.class,
      });
    },
    async store() {
      this.loading = true;
      try {
        if (!this.editing) {
          await this.storePlayerCreateInfoItem(this.playerCreateInfoItem);
          this.$notify({
            title: "保存成功",
            position: "top-right",
            type: "success",
          });
          await this.searchPlayerCreateInfoItems({
            race: this.playerCreateInfo.race,
            class: this.playerCreateInfo.class,
          });
          this.creating = false;
          this.editing = false;
        } else {
          await this.updatePlayerCreateInfoItem({
            credential: this.credential,
            playerCreateInfoItem: this.playerCreateInfoItem,
          });
          this.$notify({
            title: "修改成功",
            position: "top-right",
            type: "success",
          });
          await this.searchPlayerCreateInfoItems({
            race: this.playerCreateInfo.race,
            class: this.playerCreateInfo.class,
          });
          this.creating = false;
          this.editing = false;
        }
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
    cancel() {
      this.creating = false;
    },
    copy() {
      this.$confirm("此操作不会复制关联表数据，确认继续？", "确认复制", {
        confirmButtonText: "确认",
        cancelButtonText: "取消",
        type: "info",
        dangerouslyUseHTMLString: true,
        beforeClose: async (action, instance, done) => {
          if (action === "confirm") {
            instance.confirmButtonLoading = true;
            try {
              await this.copyPlayerCreateInfoItem(this.credential);
              await this.searchPlayerCreateInfoItems({
                race: this.playerCreateInfo.race,
                class: this.playerCreateInfo.class,
              });
              this.$notify({
                title: "复制成功",
                position: "top-right",
                type: "success",
              });
              instance.confirmButtonLoading = false;
              done();
            } catch (error) {
              instance.confirmButtonLoading = false;
              done();
            }
          } else {
            done();
          }
        },
      });
    },
    destroy() {
      this.$confirm(
        "此操作将永久删除该数据，确认继续？<br><small>为避免误操作，不提供删除关联表数据功能。</small>",
        "确认删除",
        {
          confirmButtonText: "确认",
          cancelButtonText: "取消",
          type: "info",
          dangerouslyUseHTMLString: true,
          beforeClose: async (action, instance, done) => {
            if (action === "confirm") {
              try {
                await this.destroyPlayerCreateInfoItem(this.credential);
                await this.searchPlayerCreateInfoItems({
                  race: this.playerCreateInfo.race,
                  class: this.playerCreateInfo.class,
                });
                this.$notify({
                  title: "删除成功",
                  position: "top-right",
                  type: "success",
                });
                instance.confirmButtonLoading = false;
                done();
              } catch (error) {
                instance.confirmButtonLoading = false;
                done();
              }
            } else {
              done();
            }
          },
        }
      );
    },
    select(row) {
      this.currentRow = row;
    },
    async show(row) {
      this.creating = true;
      this.editing = true;
      await this.findPlayerCreateInfoItem({
        race: this.playerCreateInfo.race,
        class: this.playerCreateInfo.class,
        itemid: row.itemid,
      });
    },
    async init() {
      this.initing = true;
      await this.searchPlayerCreateInfoItems({
        race: this.playerCreateInfo.race,
        class: this.playerCreateInfo.class,
      });
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: { ItemTemplateName, ItemTemplateSelector },
};
</script>
