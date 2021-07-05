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
        <el-breadcrumb-item>任务声望管理</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">任务声望列表</h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-form :model="credential" @submit.native.prevent="search">
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input v-model="credential.ID" placeholder="ID"></el-input>
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
        :data="questFactionRewards"
        highlight-current-row
        class="hide-when-overflow"
        @current-change="select"
        @row-dblclick="show"
      >
        <el-table-column prop="ID" label="编号" width="80px"> </el-table-column>
        <el-table-column prop="Difficulty_1" label="难度1"> </el-table-column>
        <el-table-column prop="Difficulty_2" label="难度2"> </el-table-column>
        <el-table-column prop="Difficulty_3" label="难度3"> </el-table-column>
        <el-table-column prop="Difficulty_4" label="难度4"> </el-table-column>
        <el-table-column prop="Difficulty_5" label="难度5"> </el-table-column>
        <el-table-column prop="Difficulty_6" label="难度6"> </el-table-column>
        <el-table-column prop="Difficulty_7" label="难度7"> </el-table-column>
        <el-table-column prop="Difficulty_8" label="难度8"> </el-table-column>
        <el-table-column prop="Difficulty_9" label="难度9"> </el-table-column>
        <el-table-column prop="Difficulty_10" label="难度10"> </el-table-column>
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
    ...mapState("questFactionReward", [
      "refresh",
      "credential",
      "pagination",
      "questFactionRewards",
    ]),
    payload() {
      return {
        ID: this.credential.ID,
        page: this.pagination.page,
      };
    },
    disabled() {
      return this.currentRow == undefined ? true : false;
    },
  },
  methods: {
    ...mapActions("questFactionReward", [
      "searchQuestFactionRewards",
      "countQuestFactionRewards",
      "paginateQuestFactionRewards",
      "copyQuestFactionReward",
      "destroyQuestFactionReward",
      "resetCredential",
    ]),
    async search() {
      this.loading = true;
      this.paginateQuestFactionRewards({ page: 1 });
      await Promise.all([
        this.searchQuestFactionRewards(this.payload),
        this.countQuestFactionRewards(this.payload),
      ]);
      this.loading = false;
    },
    async reset() {
      await this.resetCredential();
    },
    create() {
      this.$router.push("/quest-faction-reward/create");
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
            this.copyQuestFactionReward({ ID: this.currentRow.ID })
              .then(() => {
                Promise.all([
                  this.searchQuestFactionRewards(this.payload),
                  this.countQuestFactionRewards(this.payload),
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
              this.destroyQuestFactionReward({ ID: this.currentRow.ID })
                .then(() => {
                  Promise.all([
                    this.searchQuestFactionRewards(this.payload),
                    this.countQuestFactionRewards(this.payload),
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
      this.paginateQuestFactionRewards({ page: page });
      await this.searchQuestFactionRewards(this.payload);
      this.loading = false;
    },
    show(row) {
      this.$router.push(`/quest-faction-reward/${row.ID}`);
    },
    async init() {
      this.loading = true;
      await Promise.all([
        this.searchQuestFactionRewards(this.payload),
        this.countQuestFactionRewards(this.payload),
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
