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
        <el-breadcrumb-item>缩放属性分配管理</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">缩放属性分配列表</h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-form :model="credential" @submit.native.prevent="search">
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input v-model="credential.ID" placeholder="ID"></el-input>
          </el-col>
          <el-col :span="6">
            <el-select v-model="credential.Stat" placeholder="Stat">
              <el-option
                v-for="(localeStatType, index) in localeStatTypes"
                :key="`Stat-${index}`"
                :value="index"
                :label="localeStatType"
              ></el-option>
            </el-select>
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
        :data="scalingStatDistributions"
        highlight-current-row
        class="hide-when-overflow"
        @current-change="select"
        @row-dblclick="show"
      >
        <el-table-column prop="ID" label="编号" width="80px"> </el-table-column>
        <el-table-column label="属性">
          <template slot-scope="scope">
            <span v-if="scope.row.StatID_1 > 0">
              {{ localeStatTypes[scope.row.StatID_1] }}({{ scope.row.Bonus_1 }})
            </span>
          </template>
        </el-table-column>
        <el-table-column label="属性">
          <template slot-scope="scope">
            <span v-if="scope.row.StatID_2 > 0">
              {{ localeStatTypes[scope.row.StatID_2] }}({{ scope.row.Bonus_2 }})
            </span>
          </template>
        </el-table-column>
        <el-table-column label="属性">
          <template slot-scope="scope">
            <span v-if="scope.row.StatID_3 > 0">
              {{ localeStatTypes[scope.row.StatID_3] }}({{ scope.row.Bonus_3 }})
            </span>
          </template>
        </el-table-column>
        <el-table-column label="属性">
          <template slot-scope="scope">
            <span v-if="scope.row.StatID_4 > 0">
              {{ localeStatTypes[scope.row.StatID_4] }}({{ scope.row.Bonus_4 }})
            </span>
          </template>
        </el-table-column>
        <el-table-column label="属性">
          <template slot-scope="scope">
            <span v-if="scope.row.StatID_5 > 0">
              {{ localeStatTypes[scope.row.StatID_5] }}({{ scope.row.Bonus_5 }})
            </span>
          </template>
        </el-table-column>
        <el-table-column label="属性">
          <template slot-scope="scope">
            <span v-if="scope.row.StatID_6 > 0">
              {{ localeStatTypes[scope.row.StatID_6] }}({{ scope.row.Bonus_6 }})
            </span>
          </template>
        </el-table-column>
        <el-table-column label="属性">
          <template slot-scope="scope">
            <span v-if="scope.row.StatID_7 > 0">
              {{ localeStatTypes[scope.row.StatID_7] }}({{ scope.row.Bonus_7 }})
            </span>
          </template>
        </el-table-column>
        <el-table-column label="属性">
          <template slot-scope="scope">
            <span v-if="scope.row.StatID_8 > 0">
              {{ localeStatTypes[scope.row.StatID_8] }}({{ scope.row.Bonus_8 }})
            </span>
          </template>
        </el-table-column>
        <el-table-column label="属性">
          <template slot-scope="scope">
            <span v-if="scope.row.StatID_9 > 0">
              {{ localeStatTypes[scope.row.StatID_9] }}({{ scope.row.Bonus_9 }})
            </span>
          </template>
        </el-table-column>
        <el-table-column label="属性">
          <template slot-scope="scope">
            <span v-if="scope.row.StatID_10 > 0">
              {{ localeStatTypes[scope.row.StatID_10] }}({{
                scope.row.Bonus_10
              }})
            </span>
          </template>
        </el-table-column>
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

import { localeStatTypes } from "@/locales/item";

export default {
  data() {
    return {
      loading: false,
      currentRow: undefined,
      localeStatTypes: localeStatTypes,
    };
  },
  computed: {
    ...mapState("scalingStatDistribution", [
      "refresh",
      "credential",
      "pagination",
      "scalingStatDistributions",
    ]),
    payload() {
      return {
        ID: this.credential.ID,
        Stat: this.credential.Stat,
        page: this.pagination.page,
      };
    },
    disabled() {
      return this.currentRow == undefined ? true : false;
    },
  },
  methods: {
    ...mapActions("scalingStatDistribution", [
      "searchScalingStatDistributions",
      "countScalingStatDistributions",
      "paginateScalingStatDistributions",
      "copyScalingStatDistribution",
      "destroyScalingStatDistribution",
      "resetCredential",
    ]),
    async search() {
      this.loading = true;
      this.paginateScalingStatDistributions({ page: 1 });
      await Promise.all([
        this.searchScalingStatDistributions(this.payload),
        this.countScalingStatDistributions(this.payload),
      ]);
      this.loading = false;
    },
    async reset() {
      await this.resetCredential();
    },
    create() {
      this.$router.push("/scaling-stat-distribution/create");
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
            this.copyScalingStatDistribution({ ID: this.currentRow.ID })
              .then(() => {
                Promise.all([
                  this.searchScalingStatDistributions(this.payload),
                  this.countScalingStatDistributions(this.payload),
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
              this.destroyScalingStatDistribution({ ID: this.currentRow.ID })
                .then(() => {
                  Promise.all([
                    this.searchScalingStatDistributions(this.payload),
                    this.countScalingStatDistributions(this.payload),
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
      this.paginateScalingStatDistributions({ page: page });
      await this.searchScalingStatDistributions(this.payload);
      this.loading = false;
    },
    show(row) {
      this.$router.push(`/scaling-stat-distribution/${row.ID}`);
    },
    async init() {
      this.loading = true;
      await Promise.all([
        this.searchScalingStatDistributions(this.payload),
        this.countScalingStatDistributions(this.payload),
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
