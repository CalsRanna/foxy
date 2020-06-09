<template>
  <div>
    <el-card style="margin-bottom: 16px;">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-input-number
            v-model="entry"
            controls-position="right"
            placeholder="Entry"
            style="width: 100%"
          ></el-input-number>
        </el-col>
        <el-col :span="6">
          <el-input v-model="name" placeholder="姓名"></el-input>
        </el-col>
        <el-col :span="6">
          <el-input v-model="subname" placeholder="称号"></el-input>
        </el-col>
        <el-col :span="6" style="text-align: right;">
          <el-button type="primary" @click="search">查询</el-button>
          <el-button>重置</el-button>
        </el-col>
      </el-row>
    </el-card>
    <el-card>
      <el-table :data="creatureTemplates">
        <el-table-column prop="entry" label="ID"></el-table-column>
        <el-table-column prop="name" label="姓名"></el-table-column>
        <el-table-column prop="subname" label="称号"></el-table-column>
        <el-table-column prop="minlevel" label="最小等级"></el-table-column>
        <el-table-column prop="maxlevel" label="最大等级"></el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
import {CreatureTemplate} from "../models/creature_template";
export default {
  data() {
    return {
      entry: 0,
      name: "",
      subname: "",
      creatureTemplates: [],
    };
  },
  methods: {
    search: () => {
      console.log(this.name);
    },
  },
  created: () => {
    CreatureTemplate.findAll().then((creatureTemplates) => {
      console.log(creatureTemplates.length);
    });
  },
};
</script>

<style></style>
