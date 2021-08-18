<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/advance' }">
          高级
        </el-breadcrumb-item>
        <el-breadcrumb-item>关联掉落管理</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">关联掉落列表</h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-form :model="credential" @submit.native.prevent="search">
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input v-model="credential.Entry" placeholder="Entry"></el-input>
          </el-col>
          <el-col :span="6">
            <el-input v-model="credential.name" placeholder="name"></el-input>
          </el-col>
          <el-col :span="6">
            <el-button
              type="primary"
              native-type="submit"
              :loading="loading"
              @click="search"
            >
              查询
            </el-button>
            <el-button @click="reset">重置</el-button>
          </el-col>
        </el-row>
      </el-form>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-button type="primary" @click="create">新增</el-button>
      <el-button :disabled="disabled" @click="copy">复制</el-button>
      <el-button type="danger" :disabled="disabled" @click="destroy">
        删除
      </el-button>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-pagination
        layout="prev, pager, next"
        :current-page="pagination.page"
        :total="pagination.total"
        :page-size="advanceConfig.size"
        hide-on-single-page
        @current-change="paginate"
        style="margin-bottom: 16px"
      ></el-pagination>
      <el-table
        :data="referenceLootTemplates"
        highlight-current-row
        :max-height="calculateMaxHeight()"
        class="hide-when-overflow"
        @current-change="select"
        @row-dblclick="show"
      >
        <el-table-column
          prop="Entry"
          label="编号"
          width="80px"
        ></el-table-column>
        <el-table-column label="名称">
          <span slot-scope="scope">
            <template v-if="scope.row.Reference == 0">
              <item-template-name
                :itemTemplate="scope.row"
              ></item-template-name>
            </template>
            <template v-else>
              <el-tag>关联掉落</el-tag>
            </template>
          </span>
        </el-table-column>
        <el-table-column prop="Reference" label="关联"></el-table-column>
        <el-table-column prop="Chance" label="几率">
          <span slot-scope="scope">
            {{ `${scope.row.Chance}%` }}
          </span>
        </el-table-column>
        <el-table-column prop="QuestRequired" label="需要任务">
          <span slot-scope="scope">
            <el-tag type="success" v-if="scope.row.QuestRequired">
              需要
            </el-tag>
            <el-tag v-else>不需要</el-tag>
          </span>
        </el-table-column>
        <el-table-column prop="MinCount" label="最小数量"></el-table-column>
        <el-table-column prop="MaxCount" label="最大数量"></el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
import ItemTemplateName from "@/components/ItemTemplateName";

export default {
  data() {
    return {
      loading: false,
      currentRow: undefined,
    };
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("initiator", ["advanceConfig"]),
    ...mapState("referenceLootTemplate", [
      "refresh",
      "credential",
      "pagination",
      "referenceLootTemplates",
    ]),
    payload() {
      return {
        Entry: this.credential.Entry,
        name: this.credential.name,
        page: this.pagination.page,
        size: this.advanceConfig.size,
      };
    },
    disabled() {
      return this.currentRow == undefined ? true : false;
    },
  },
  methods: {
    ...mapActions("referenceLootTemplate", [
      "searchReferenceLootTemplates",
      "countReferenceLootTemplates",
      "paginateReferenceLootTemplates",
      "copyReferenceLootTemplate",
      "destroyReferenceLootTemplate",
      "resetCredential",
    ]),
    calculateMaxHeight() {
      return this.pagination.total > this.advanceConfig.size
        ? this.clientHeight - 440
        : this.clientHeight - 392;
    },
    async search() {
      this.loading = true;
      this.paginateReferenceLootTemplates({ page: 1 });
      await Promise.all([
        this.searchReferenceLootTemplates(this.payload),
        this.countReferenceLootTemplates(this.payload),
      ]);
      this.loading = false;
    },
    async reset() {
      await this.resetCredential();
    },
    create() {
      this.$router.push("/reference-loot/create");
    },
    copy() {
      this.$confirm("此操作不会复制关联表数据，确认继续？", "确认复制", {
        confirmButtonText: "确认",
        cancelButtonText: "取消",
        type: "info",
        dangerouslyUseHTMLString: true,
        beforeClose: (action, instance, done) => {
          if (action === "confirm") {
            instance.confirmButtonLoading = true;
            this.copyReferenceLootTemplate({ Entry: this.currentRow.Entry })
              .then(() => {
                Promise.all([
                  this.searchReferenceLootTemplates(this.payload),
                  this.countReferenceLootTemplates(this.payload),
                ]);
              })
              .then(() => {
                this.$notify({
                  title: "复制成功",
                  position: "bottom-left",
                  type: "success",
                });
                instance.confirmButtonLoading = false;
                done();
              });
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
          beforeClose: (action, instance, done) => {
            if (action === "confirm") {
              instance.confirmButtonLoading = true;
              this.destroyReferenceLootTemplate({
                Entry: this.currentRow.Entry,
                Item: this.currentRow.Item,
              })
                .then(() => {
                  Promise.all([
                    this.searchReferenceLootTemplates(this.payload),
                    this.countReferenceLootTemplates(this.payload),
                  ]);
                })
                .then(() => {
                  this.$notify({
                    title: "删除成功",
                    position: "bottom-left",
                    type: "success",
                  });
                  instance.confirmButtonLoading = false;
                  done();
                });
            } else {
              done();
            }
          },
        }
      );
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    async paginate(page) {
      this.loading = true;
      this.paginateReferenceLootTemplates({ page: page });
      await this.searchReferenceLootTemplates(this.payload);
      this.loading = false;
    },
    show(row) {
      this.$router.push(`/reference-loot/${row.Entry}?Item=${row.Item}`);
    },
    async init() {
      this.loading = true;
      await Promise.all([
        this.searchReferenceLootTemplates(this.payload),
        this.countReferenceLootTemplates(this.payload),
      ]);
      this.loading = false;
    },
  },
  mounted() {
    if (this.refresh) {
      this.init();
    }
  },
  components: {
    ItemTemplateName,
  },
};
</script>
