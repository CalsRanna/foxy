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
        <el-breadcrumb-item>玩家出生信息管理</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">玩家出生信息列表</h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-form :model="credential" @submit.native.prevent="search">
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input v-model="credential.ID" placeholder="ID"></el-input>
          </el-col>
          <el-col :span="6">
            <el-input v-model="credential.Title" placeholder="Title"></el-input>
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
        :data="playerCreateInfos"
        highlight-current-row
        :max-height="calculateMaxHeight()"
        class="hide-when-overflow"
        @current-change="select"
        @row-dblclick="show"
      >
        <el-table-column prop="race" label="种族">
          <span slot-scope="scope">{{ getRaceName(scope.row.race) }}</span>
        </el-table-column>
        <el-table-column prop="class" label="职业">
          <span slot-scope="scope">{{ getClassName(scope.row.class) }}</span>
        </el-table-column>
        <el-table-column prop="map" label="地图" />
        <el-table-column prop="zone" label="区域" />
        <el-table-column prop="position_x" label="X坐标" />
        <el-table-column prop="position_y" label="Y坐标" />
        <el-table-column prop="position_z" label="Z坐标" />
        <el-table-column prop="orientation" label="朝向" />
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
    ...mapState("initiator", ["advanceConfig", "chrRaces", "chrClasses"]),
    ...mapState("playerCreateInfo", [
      "refresh",
      "credential",
      "pagination",
      "playerCreateInfos",
    ]),
    payload() {
      return {
        ID: this.credential.ID,
        Title: this.credential.Title,
        page: this.pagination.page,
        size: this.advanceConfig.size,
      };
    },
    disabled() {
      return this.currentRow == undefined ? true : false;
    },
  },
  methods: {
    ...mapActions("playerCreateInfo", [
      "searchPlayerCreateInfos",
      "countPlayerCreateInfos",
      "paginatePlayerCreateInfos",
      "copyPlayerCreateInfo",
      "destroyPlayerCreateInfo",
      "resetCredential",
    ]),
    getRaceName(race) {
      let name = race;
      for (let chrRace of this.chrRaces) {
        if (chrRace.ID === race) {
          name = chrRace.Name_Lang_zhCN;
        }
      }
      return name;
    },
    getClassName(c) {
      let name = c;
      for (let chrClass of this.chrClasses) {
        if (chrClass.ID === c) {
          name = chrClass.Name_Lang_zhCN;
        }
      }
      return name;
    },
    calculateMaxHeight() {
      return this.pagination.total > this.advanceConfig.size
        ? this.clientHeight - 440
        : this.clientHeight - 392;
    },
    async search() {
      this.loading = true;
      this.paginatePlayerCreateInfos({ page: 1 });
      await Promise.all([
        this.searchPlayerCreateInfos(this.payload),
        this.countPlayerCreateInfos(this.payload),
      ]);
      this.loading = false;
    },
    async reset() {
      await this.resetCredential();
    },
    create() {
      this.$router.push("/player-create-info/create");
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
            this.copyPlayerCreateInfo({
              race: this.currentRow.race,
              class: this.currentRow.class,
            })
              .then(() => {
                Promise.all([
                  this.searchPlayerCreateInfos(this.payload),
                  this.countPlayerCreateInfos(this.payload),
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
              this.destroyPlayerCreateInfo({
                race: this.currentRow.race,
                class: this.currentRow.class,
              })
                .then(() => {
                  Promise.all([
                    this.searchPlayerCreateInfos(this.payload),
                    this.countPlayerCreateInfos(this.payload),
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
      this.paginatePlayerCreateInfos({ page: page });
      await this.searchPlayerCreateInfos(this.payload);
      this.loading = false;
    },
    show(row) {
      this.$router.push(`/player-create-info/${row.race}?class=${row.class}`);
    },
    async init() {
      this.loading = true;
      await Promise.all([
        this.searchPlayerCreateInfos(this.payload),
        this.countPlayerCreateInfos(this.payload),
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
