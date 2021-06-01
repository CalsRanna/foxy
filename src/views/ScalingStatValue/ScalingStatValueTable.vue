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
        <el-breadcrumb-item>缩放属性值管理</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">缩放属性值列表</h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-form :model="credential" @submit.native.prevent="search">
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input v-model="credential.ID" placeholder="ID"></el-input>
          </el-col>
          <el-col :span="6">
            <el-input-number
              v-model="credential.Charlevel"
              controls-position="right"
              placeholder="等级"
            ></el-input-number>
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
        :page-size="pagination.size"
        hide-on-single-page
        @current-change="paginate"
        style="margin-top: 16px"
      ></el-pagination>
      <el-table
        :data="scalingStatValues"
        highlight-current-row
        @current-change="select"
        @row-dblclick="show"
      >
        <el-table-column prop="ID" label="编号" width="80px"> </el-table-column>
        <el-table-column prop="Charlevel" label="等级"></el-table-column>
        <el-table-column
          prop="PrimaryBudget"
          label="主要预算"
        ></el-table-column>
        <el-table-column
          prop="TertiaryBudget"
          label="次要预算"
        ></el-table-column>
        <el-table-column
          prop="ShoulderBudget"
          label="肩膀预算"
        ></el-table-column>
        <el-table-column
          prop="TrinketBudget"
          label="饰品预算"
        ></el-table-column>
        <el-table-column
          prop="WeaponBudget1H"
          label="单手武器预算"
        ></el-table-column>
        <el-table-column
          prop="RangedBudget"
          label="远程武器预算"
        ></el-table-column>
      </el-table>
      <el-pagination
        layout="prev, pager, next"
        :current-page="pagination.page"
        :total="pagination.total"
        :page-size="pagination.size"
        hide-on-single-page
        @current-change="paginate"
        style="margin-top: 16px"
      ></el-pagination>
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
    ...mapState("scalingStatValue", [
      "refresh",
      "credential",
      "pagination",
      "scalingStatValues",
    ]),
    payload() {
      return {
        ID: this.credential.ID,
        Charlevel: this.credential.Charlevel,
        page: this.pagination.page,
      };
    },
    disabled() {
      return this.currentRow == undefined ? true : false;
    },
  },
  methods: {
    ...mapActions("scalingStatValue", [
      "searchScalingStatValues",
      "countScalingStatValues",
      "paginateScalingStatValues",
      "copyScalingStatValue",
      "destroyScalingStatValue",
      "resetCredential",
    ]),
    async search() {
      this.loading = true;
      this.paginateScalingStatValues({ page: 1 });
      await Promise.all([
        this.searchScalingStatValues(this.payload),
        this.countScalingStatValues(this.payload),
      ]);
      this.loading = false;
    },
    async reset() {
      await this.resetCredential();
    },
    create() {
      this.$router.push("/scaling-stat-value/create");
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
            this.copyScalingStatValue({ ID: this.currentRow.ID })
              .then(() => {
                Promise.all([
                  this.searchScalingStatValues(this.payload),
                  this.countScalingStatValues(this.payload),
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
              this.destroyScalingStatValue({ ID: this.currentRow.ID })
                .then(() => {
                  Promise.all([
                    this.searchScalingStatValues(this.payload),
                    this.countScalingStatValues(this.payload),
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
      this.paginateScalingStatValues({ page: page });
      await this.searchScalingStatValues(this.payload);
      this.loading = false;
    },
    show(row) {
      this.$router.push(`/scaling-stat-value/${row.ID}`);
    },
    async init() {
      this.loading = true;
      await Promise.all([
        this.searchScalingStatValues(this.payload),
        this.countScalingStatValues(this.payload),
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
