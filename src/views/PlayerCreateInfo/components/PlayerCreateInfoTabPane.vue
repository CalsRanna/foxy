<template>
  <el-form :model="playerCreateInfo" label-position="right" label-width="120px">
    <div :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }">
      <el-card
        :body-style="{ padding: '22px 20px 0 20px' }"
        style="margin-top: 1px"
      >
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="种族">
              <el-select v-model="playerCreateInfo.race" placeholder="race">
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
              <el-select v-model="playerCreateInfo.class" placeholder="class">
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
        :body-style="{ padding: '22px 20px 0 20px' }"
        style="margin-top: 16px"
      >
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="地图">
              <map-selector
                v-model="playerCreateInfo.map"
                placeholder="map"
              ></map-selector>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="区域">
              <area-table-selector
                v-model="playerCreateInfo.zone"
                placeholder="zone"
              ></area-table-selector>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="X坐标">
              <el-input-number
                v-model="playerCreateInfo.position_x"
                controls-position="right"
                placeholder="position_x"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="X坐标">
              <el-input-number
                v-model="playerCreateInfo.position_y"
                controls-position="right"
                placeholder="position_y"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="X坐标">
              <el-input-number
                v-model="playerCreateInfo.position_z"
                controls-position="right"
                placeholder="position_z"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="朝向">
              <el-input-number
                v-model="playerCreateInfo.orientation"
                controls-position="right"
                placeholder="orientation"
              ></el-input-number>
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
</template>

<script>
import { mapActions, mapState } from "vuex";
import AreaTableSelector from "@/components/AreaTableSelector";
import MapSelector from "@/components/MapSelector";

export default {
  data() {
    return {
      initing: false,
      loading: false,
      creating: false,
    };
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("initiator", ["chrClasses", "chrRaces"]),
    ...mapState("playerCreateInfo", ["playerCreateInfo"]),
    credential() {
      return {
        race: this.$route.params.id,
        class: this.$route.query.class,
      };
    },
  },
  methods: {
    ...mapActions("playerCreateInfo", [
      "storePlayerCreateInfo",
      "findPlayerCreateInfo",
      "updatePlayerCreateInfo",
      "createPlayerCreateInfo",
    ]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      if (this.creating) {
        this.storePlayerCreateInfo(this.playerCreateInfo);
        this.$notify({
          title: "保存成功",
          position: "top-right",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updatePlayerCreateInfo({
          credential: this.credential,
          playerCreateInfo: this.playerCreateInfo,
        });
        this.$notify({
          title: "修改成功",
          position: "top-right",
          type: "success",
        });
      }
      this.loading = false;
    },
    cancel() {
      this.$router.go(-1);
    },
    async init() {
      this.initing = true;
      if (this.$route.path == "/player-create-info/create") {
        this.creating = true;
        await Promise.all([this.createPlayerCreateInfo()]);
      } else {
        await this.findPlayerCreateInfo(this.credential);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: {
    AreaTableSelector,
    MapSelector,
  },
};
</script>
