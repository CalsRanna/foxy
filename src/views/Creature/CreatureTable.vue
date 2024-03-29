<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item>生物管理</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">生物列表</h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-form :model="credential" @submit.native.prevent="search">
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input-number
              v-model="credential.entry"
              controls-position="right"
              placeholder="entry"
            ></el-input-number>
          </el-col>
          <el-col :span="6">
            <el-input v-model="credential.name" placeholder="name"></el-input>
          </el-col>
          <el-col :span="6">
            <el-input
              v-model="credential.subname"
              placeholder="subname"
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
        :page-size="advanceConfig.size"
        hide-on-single-page
        @current-change="paginate"
        style="margin-bottom: 16px"
      ></el-pagination>
      <el-table
        ref="creatureTable"
        :data="creatureTemplates"
        highlight-current-row
        :max-height="calculateMaxHeight()"
        class="hide-when-overflow"
        @current-change="select"
        @row-dblclick="show"
      >
        <el-table-column
          prop="entry"
          label="编号"
          width="80px"
        ></el-table-column>
        <el-table-column label="姓名">
          <template slot-scope="scope">
            <span v-if="scope.row.localeName">
              {{ scope.row.localeName }}
            </span>
            <span v-else>{{ scope.row.name }}</span>
          </template>
        </el-table-column>
        <el-table-column label="称号">
          <template slot-scope="scope">
            <span v-if="scope.row.localeTitle">
              {{ scope.row.localeTitle }}
            </span>
            <span v-else>{{ scope.row.subname }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="minlevel" label="最小等级"></el-table-column>
        <el-table-column prop="maxlevel" label="最大等级"></el-table-column>
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
    ...mapState("creatureTemplate", [
      "refresh",
      "credential",
      "pagination",
      "creatureTemplates",
    ]),
    payload() {
      return {
        entry: this.credential.entry,
        name: this.credential.name,
        subname: this.credential.subname,
        page: this.pagination.page,
        size: this.advanceConfig.size,
      };
    },
    disabled() {
      return this.currentRow == undefined ? true : false;
    },
  },
  methods: {
    ...mapActions("creatureTemplate", [
      "searchCreatureTemplates",
      "countCreatureTemplates",
      "paginateCreatureTemplates",
      "destroyCreatureTemplate",
      "copyCreatureTemplate",
      "resetCredential",
    ]),
    calculateMaxHeight() {
      return this.pagination.total > this.advanceConfig.size
        ? this.clientHeight - 440
        : this.clientHeight - 392;
    },
    async search() {
      this.loading = true;
      try {
        await this.paginateCreatureTemplates({ page: 1 });
        await Promise.all([
          this.searchCreatureTemplates(this.payload),
          this.countCreatureTemplates(this.payload),
        ]);
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
    reset() {
      this.resetCredential();
    },
    create() {
      this.$router.push("/creature/create");
    },
    copy() {
      this.$confirm("此操作不会复制关联表数据，确认继续？", "确认复制", {
        confirmButtonText: "确认",
        cancelButtonText: "取消",
        type: "info",
        dangerouslyUseHTMLString: true,
        beforeClose: async (action, instance, done) => {
          if (action === "confirm") {
            try {
              instance.confirmButtonLoading = true;
              await this.copyCreatureTemplate({ entry: this.currentRow.entry });
              await Promise.all([
                this.searchCreatureTemplates(this.payload),
                this.countCreatureTemplates(this.payload),
              ]);
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
                instance.confirmButtonLoading = true;
                await this.destroyCreatureTemplate({
                  entry: this.currentRow.entry,
                });
                await Promise.all([
                  this.searchCreatureTemplates(this.payload),
                  this.countCreatureTemplates(this.payload),
                ]);
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
    select(currentRow) {
      this.currentRow = currentRow;
    },
    async paginate(page) {
      this.loading = true;
      try {
        await this.paginateCreatureTemplates({ page: page });
        await this.searchCreatureTemplates(this.payload);
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
    show(row) {
      this.$router.push(`/creature/${row.entry}`);
    },
    async init() {
      this.loading = true;
      try {
        await Promise.all([
          this.searchCreatureTemplates(this.payload),
          this.countCreatureTemplates(this.payload),
        ]);
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
  },
  mounted() {
    if (this.refresh) {
      this.init();
    }
  },
};
</script>
