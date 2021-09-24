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
        <el-breadcrumb-item>条件管理</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">条件列表</h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-form :model="credential" @submit.native.prevent="search">
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input v-model="credential.ID" placeholder="ID"></el-input>
          </el-col>
          <el-col :span="6">
            <el-input v-model="credential.Text" placeholder="Text"></el-input>
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
        :data="conditions"
        highlight-current-row
        :max-height="calculateMaxHeight()"
        class="hide-when-overflow"
        @current-change="select"
        @row-dblclick="show"
      >
        <el-table-column
          prop="SourceTypeOrReferenceId"
          label="SourceTypeOrReferenceId"
        />
        <el-table-column prop="SourceGroup" label="SourceGroup" />
        <el-table-column prop="SourceEntry" label="SourceEntry" />
        <el-table-column prop="SourceId" label="SourceId" />
        <el-table-column prop="ElseGroup" label="ElseGroup" />
        <el-table-column
          prop="ConditionTypeOrReference"
          label="ConditionTypeOrReference"
        />
        <el-table-column prop="ConditionTarget" label="ConditionTarget" />
        <el-table-column prop="ConditionValue1" label="ConditionValue1" />
        <el-table-column prop="ConditionValue2" label="ConditionValue2" />
        <el-table-column prop="ConditionValue3" label="ConditionValue3" />
      </el-table>
    </el-card>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";

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
    ...mapState("condition", [
      "refresh",
      "credential",
      "pagination",
      "conditions",
    ]),
    payload() {
      return {
        ID: this.credential.ID,
        Text: this.credential.Text,
        page: this.pagination.page,
        size: this.advanceConfig.size,
      };
    },
    disabled() {
      return this.currentRow == undefined ? true : false;
    },
  },
  methods: {
    ...mapActions("condition", [
      "searchConditions",
      "countConditions",
      "paginateConditions",
      "copyCondition",
      "destroyCondition",
      "resetCredential",
    ]),
    calculateMaxHeight() {
      return this.pagination.total > this.advanceConfig.size
        ? this.clientHeight - 440
        : this.clientHeight - 392;
    },
    async search() {
      this.loading = true;
      this.paginateConditions({ page: 1 });
      await Promise.all([
        this.searchConditions(this.payload),
        this.countConditions(this.payload),
      ]);
      this.loading = false;
    },
    async reset() {
      await this.resetCredential();
    },
    create() {
      this.$router.push("/condition/create");
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
            this.copyCondition({ ...this.currentRow })
              .then(() => {
                Promise.all([
                  this.searchConditions(this.payload),
                  this.countConditions(this.payload),
                ]);
              })
              .then(() => {
                this.$notify({
                  title: "复制成功",
                  position: "top-right",
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
              this.destroyCondition({ ...this.currentRow })
                .then(() => {
                  Promise.all([
                    this.searchConditions(this.payload),
                    this.countConditions(this.payload),
                  ]);
                })
                .then(() => {
                  this.$notify({
                    title: "删除成功",
                    position: "top-right",
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
      this.paginateConditions({ page: page });
      await this.searchConditions(this.payload);
      this.loading = false;
    },
    show(row) {
      this.$router.push(
        `/condition/${row.SourceTypeOrReferenceId}?SourceGroup=${row.SourceGroup}&SourceEntry=${row.SourceEntry}&SourceId=${row.SourceId}&ElseGroup=${row.ElseGroup}&ConditionTypeOrReference=${row.ConditionTypeOrReference}&ConditionTarget=${row.ConditionTarget}&ConditionValue1=${row.ConditionValue1}&ConditionValue2=${row.ConditionValue2}&ConditionValue3=${row.ConditionValue3}`
      );
    },
    async init() {
      this.loading = true;
      await Promise.all([
        this.searchConditions(this.payload),
        this.countConditions(this.payload),
      ]);
      this.loading = false;
    },
  },
  mounted() {
    if (this.refresh) {
      this.init();
    }
  },
};
</script>
