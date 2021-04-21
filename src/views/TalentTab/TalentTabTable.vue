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
        <el-breadcrumb-item>天赋页管理</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">天赋页列表</h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-form :model="credential" @submit.native.prevent="search">
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input v-model="credential.ID" placeholder="ID"></el-input>
          </el-col>
          <el-col :span="6">
            <el-input
              v-model="credential.Name_Lang_zhCN"
              placeholder="名称"
            ></el-input>
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
        :data="talentTabs"
        highlight-current-row
        @current-change="select"
        @row-dblclick="show"
      >
        <el-table-column prop="ID" label="编号" sortable width="80px">
        </el-table-column>
        <el-table-column
          prop="Name_Lang_zhCN"
          label="名称"
          sortable
        ></el-table-column>
        <el-table-column
          prop="RaceMask"
          label="种族掩码"
          sortable
        ></el-table-column>
        <el-table-column
          prop="ClassMask"
          label="职业掩码"
          sortable
        ></el-table-column>
        <el-table-column
          prop="PetTalentMask"
          label="宠物天赋掩码"
          sortable
        ></el-table-column>
        <el-table-column
          prop="OrderIndex"
          label="权重"
          sortable
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
    ...mapState("talentTab", [
      "refresh",
      "credential",
      "pagination",
      "talentTabs",
    ]),
    payload() {
      return {
        ID: this.credential.ID,
        Name_Lang_zhCN: this.credential.Name_Lang_zhCN,
        page: this.pagination.page,
      };
    },
    disabled() {
      return this.currentRow == undefined ? true : false;
    },
  },
  methods: {
    ...mapActions("talentTab", [
      "searchTalentTabs",
      "countTalentTabs",
      "paginateTalentTabs",
      "copyTalentTab",
      "destroyTalentTab",
      "resetCredential",
    ]),
    async search() {
      this.loading = true;
      this.paginateTalentTabs({ page: 1 });
      await Promise.all([
        this.searchTalentTabs(this.payload),
        this.countTalentTabs(this.payload),
      ]);
      this.loading = false;
    },
    async reset() {
      await this.resetCredential();
    },
    create() {
      this.$router.push("/talent-tab/create");
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
            this.copyTalentTab({ ID: this.currentRow.ID })
              .then(() => {
                Promise.all([
                  this.searchTalentTabs(this.payload),
                  this.countTalentTabs(this.payload),
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
              this.destroyTalentTab({ ID: this.currentRow.ID })
                .then(() => {
                  Promise.all([
                    this.searchTalentTabs(this.payload),
                    this.countTalentTabs(this.payload),
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
      this.paginateTalentTabs({ page: page });
      await this.searchTalentTabs(this.payload);
      this.loading = false;
    },
    show(row) {
      this.$router.push(`/talent-tab/${row.ID}`);
    },
    async init() {
      this.loading = true;
      await Promise.all([
        this.searchTalentTabs(this.payload),
        this.countTalentTabs(this.payload),
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
