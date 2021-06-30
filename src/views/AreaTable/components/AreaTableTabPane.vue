<template>
  <el-form :model="areaTable" label-position="right" label-width="120px">
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="编号">
            <el-input-number
              v-model="areaTable.ID"
              controls-position="right"
              placeholder="ID"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="名称">
            <el-input
              v-model="areaTable.AreaName_Lang_zhCN"
              placeholder="AreaName_Lang_zhCN"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="名称掩码">
            <el-input-number
              v-model="areaTable.AreaName_Lang_Mask"
              controls-position="right"
              placeholder="AreaName_Lang_Mask"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="大陆编号">
            <el-input v-model="areaTable.ContinentID" placeholder="ContinentID">
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="父级区域">
            <el-input
              v-model="areaTable.ParentAreaID"
              placeholder="ParentAreaID"
            >
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="AreaBit">
            <el-input v-model="areaTable.AreaBit" placeholder="AreaBit">
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="标识">
            <el-input v-model="areaTable.Flags" placeholder="Flags"> </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="SoundProviderPref">
            <el-input
              v-model="areaTable.SoundProviderPref"
              placeholder="SoundProviderPref"
            >
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="SoundProviderPrefUnderwater">
            <el-input
              v-model="areaTable.SoundProviderPrefUnderwater"
              placeholder="SoundProviderPrefUnderwater"
            >
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="AmbienceID">
            <el-input v-model="areaTable.AmbienceID" placeholder="AmbienceID">
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="区域音乐">
            <el-input v-model="areaTable.ZoneMusic" placeholder="ZoneMusic">
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="IntroSound">
            <el-input v-model="areaTable.IntroSound" placeholder="IntroSound">
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="探索等级">
            <el-input
              v-model="areaTable.ExplorationLevel"
              placeholder="ExplorationLevel"
            >
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="声望组掩码">
            <el-input
              v-model="areaTable.FactionGroupMask"
              placeholder="FactionGroupMask"
            >
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="液体类型">
            <el-input
              v-model="areaTable.LiquidTypeID_1"
              placeholder="LiquidTypeID_1"
            >
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="液体类型">
            <el-input
              v-model="areaTable.LiquidTypeID_2"
              placeholder="LiquidTypeID_2"
            >
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="液体类型">
            <el-input
              v-model="areaTable.LiquidTypeID_3"
              placeholder="LiquidTypeID_3"
            >
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="液体类型">
            <el-input
              v-model="areaTable.LiquidTypeID_4"
              placeholder="LiquidTypeID_4"
            >
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="MinElevation">
            <el-input
              v-model="areaTable.MinElevation"
              placeholder="MinElevation"
            >
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Ambient_Multiplier">
            <el-input
              v-model="areaTable.Ambient_Multiplier"
              placeholder="Ambient_Multiplier"
            >
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Lightid">
            <el-input v-model="areaTable.Lightid" placeholder="Lightid">
            </el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
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

export default {
  data() {
    return {
      initing: false,
      loading: false,
      creating: false,
    };
  },
  computed: {
    ...mapState("areaTable", ["areaTable"]),
    credential() {
      return {
        ID: this.$route.params.id,
      };
    },
  },
  methods: {
    ...mapActions("areaTable", [
      "storeAreaTable",
      "findAreaTable",
      "updateAreaTable",
      "createAreaTable",
    ]),
    async store() {
      this.loading = true;
      if (this.creating) {
        this.storeAreaTable(this.areaTable);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateAreaTable({
          credential: this.credential,
          areaTable: this.areaTable,
        });
        this.$notify({
          title: "修改成功",
          position: "bottom-left",
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
      if (this.$route.path == "/area-table/create") {
        this.creating = true;
        await Promise.all([this.createAreaTable()]);
      } else {
        await this.findAreaTable(this.credential);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
