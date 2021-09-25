<template>
  <div>
    <div v-show="!creating">
      <el-alert
        title="Please note you'll have to set PlayerStart.AllSpells to 1 in config,
          else this table will not have any effect."
        type="warning"
        @close="() => (this.hasAlert = false)"
        style="margin-top: 1px"
      >
      </el-alert>
      <el-card :style="{ marginTop: `${hasAlert ? 16 : 1}px` }">
        <el-button type="primary" @click="create">新增</el-button>
        <el-button @click="copy" :disabled="disabled">复制</el-button>
        <el-button type="danger" @click="destroy" :disabled="disabled">
          删除
        </el-button>
      </el-card>
      <el-card style="margin-top: 16px">
        <el-table
          :data="playerCreateInfoSpellCustoms"
          highlight-current-row
          :max-height="
            this.hasAlert ? calculateMaxHeight() - 53 : calculateMaxHeight()
          "
          class="hide-when-overflow tight-table"
          @current-change="select"
          @row-dblclick="show"
        >
          <el-table-column prop="Name_Lang_zhCN" label="名称" width="320px">
            <spell-name slot-scope="scope" :spell="scope.row"></spell-name>
          </el-table-column>
          <el-table-column
            prop="NameSubtext_Lang_zhCN"
            label="子名称"
            width="128px"
          />
          <el-table-column label="描述">
            <template slot-scope="scope">
              <spell-description
                :spell="scope.row"
                field="Description_Lang_zhCN"
              />
            </template>
          </el-table-column>
          <el-table-column prop="Note" label="Note" width="320px" />
        </el-table>
      </el-card>
    </div>
    <div v-show="creating">
      <el-form
        :model="playerCreateInfoSpellCustom"
        label-position="right"
        label-width="120px"
      >
        <div
          :style="{
            maxHeight: `${calculateMaxHeight()}px`,
            overflow: 'auto',
          }"
        >
          <el-card
            style="margin-top: 1px"
            :body-style="{ padding: '22px 20px 0 20px' }"
          >
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="种族掩码">
                  <flag-editor
                    title="种族掩码编辑器"
                    v-model="playerCreateInfoSpellCustom.racemask"
                    :flags="racemasks"
                    placeholder="racemask"
                  ></flag-editor>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="职业掩码">
                  <flag-editor
                    title="职业掩码编辑器"
                    v-model="playerCreateInfoSpellCustom.classmask"
                    :flags="classmasks"
                    placeholder="classmask"
                  ></flag-editor>
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
                <el-form-item label="技能">
                  <spell-selector
                    v-model="playerCreateInfoSpellCustom.Spell"
                    placeholder="itemid"
                  ></spell-selector>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="Note">
                  <el-input
                    v-model="playerCreateInfoSpellCustom.Note"
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
import FlagEditor from "@/components/FlagEditor";
import SpellName from "@/components/SpellName";
import SpellDescription from "@/components/SpellDescription";
import SpellSelector from "@/components/SpellSelector";

export default {
  data() {
    return {
      initing: false,
      creating: false,
      editing: false,
      currentRow: undefined,
      credential: null,
      loading: false,
      hasAlert: true,
    };
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("initiator", ["chrRaces", "chrClasses"]),
    ...mapState("playerCreateInfo", ["playerCreateInfo"]),
    ...mapState("playerCreateInfoSpellCustom", [
      "playerCreateInfoSpellCustoms",
      "playerCreateInfoSpellCustom",
    ]),
    racemasks() {
      return this.chrRaces.map((chrRace) => {
        return {
          index: chrRace.ID,
          flag: Math.pow(2, chrRace.ID - 1),
          name: chrRace.Name_Lang_zhCN,
          comment: chrRace.ClientFileString,
        };
      });
    },
    classmasks() {
      return this.chrClasses.map((chrClass) => {
        return {
          index: chrClass.ID,
          flag: Math.pow(2, chrClass.ID - 1),
          name: chrClass.Name_Lang_zhCN,
          comment: chrClass.Filename, // 不知道为什么变成了Filename，原field应该是FileName
        };
      });
    },
    disabled() {
      return this.currentRow == undefined;
    },
  },
  methods: {
    ...mapActions("playerCreateInfoSpellCustom", [
      "searchPlayerCreateInfoSpellCustoms",
      "storePlayerCreateInfoSpellCustom",
      "findPlayerCreateInfoSpellCustom",
      "updatePlayerCreateInfoSpellCustom",
      "destroyPlayerCreateInfoSpellCustom",
      "createPlayerCreateInfoSpellCustom",
      "copyPlayerCreateInfoSpellCustom",
    ]),
    calculateMaxHeight() {
      return this.creating ? this.clientHeight - 307 : this.clientHeight - 349;
    },
    async create() {
      this.creating = true;
      this.editing = false;
      await this.createPlayerCreateInfoSpellCustom({
        racemask: Math.pow(2, this.playerCreateInfo.race - 1),
        classmask: Math.pow(2, this.playerCreateInfo.class - 1),
      });
    },
    async store() {
      this.loading = true;
      try {
        if (!this.editing) {
          await this.storePlayerCreateInfoSpellCustom(
            this.playerCreateInfoSpellCustom
          );
          this.$notify({
            title: "保存成功",
            position: "top-right",
            type: "success",
          });
          await this.searchPlayerCreateInfoSpellCustoms({
            race: this.playerCreateInfo.race,
            class: this.playerCreateInfo.class,
          });
          this.creating = false;
          this.editing = false;
        } else {
          await this.updatePlayerCreateInfoSpellCustom({
            credential: this.credential,
            playerCreateInfoSpellCustom: this.playerCreateInfoSpellCustom,
          });
          this.$notify({
            title: "修改成功",
            position: "top-right",
            type: "success",
          });
          await this.searchPlayerCreateInfoSpellCustoms({
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
              await this.copyPlayerCreateInfoSpellCustom({
                racemask: this.currentRow.racemask,
                classmask: this.currentRow.classmask,
                Spell: this.currentRow.Spell,
              });
              await this.searchPlayerCreateInfoSpellCustoms({
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
                await this.destroyPlayerCreateInfoSpellCustom({
                  racemask: this.currentRow.racemask,
                  classmask: this.currentRow.classmask,
                  Spell: this.currentRow.Spell,
                });
                await this.searchPlayerCreateInfoSpellCustoms({
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
      this.credential = {
        racemask: row.racemask,
        classmask: row.classmask,
        Spell: row.Spell,
      };
      await this.findPlayerCreateInfoSpellCustom(this.credential);
    },
    async init() {
      this.initing = true;
      await this.searchPlayerCreateInfoSpellCustoms({
        race: this.playerCreateInfo.race,
        class: this.playerCreateInfo.class,
      });
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: { FlagEditor, SpellName, SpellDescription, SpellSelector },
};
</script>
