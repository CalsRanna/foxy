<template>
  <el-form :model="emoteText" label-position="right" label-width="120px">
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="编号">
            <el-input-number
              v-model="emoteText.ID"
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
              v-model="emoteText.Name"
              placeholder="Name_Lang_zhCN"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="表情编号">
            <el-input-number
              v-model="emoteText.EmoteID"
              controls-position="right"
              placeholder="Name_Lang_Mask"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="文本">
            <el-input v-model="emoteText.EmoteText_1" placeholder="EmoteText_1">
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="文本">
            <el-input v-model="emoteText.EmoteText_2" placeholder="EmoteText_2">
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="文本">
            <el-input v-model="emoteText.EmoteText_3" placeholder="EmoteText_3">
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="文本">
            <el-input v-model="emoteText.EmoteText_4" placeholder="EmoteText_4">
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="文本">
            <el-input v-model="emoteText.EmoteText_5" placeholder="EmoteText_5">
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="文本">
            <el-input v-model="emoteText.EmoteText_6" placeholder="EmoteText_6">
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="文本">
            <el-input v-model="emoteText.EmoteText_7" placeholder="EmoteText_7">
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="文本">
            <el-input v-model="emoteText.EmoteText_8" placeholder="EmoteText_8">
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="文本">
            <el-input v-model="emoteText.EmoteText_9" placeholder="EmoteText_9">
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="文本">
            <el-input
              v-model="emoteText.EmoteText_10"
              placeholder="EmoteText_10"
            >
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="文本">
            <el-input
              v-model="emoteText.EmoteText_11"
              placeholder="EmoteText_11"
            >
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="文本">
            <el-input
              v-model="emoteText.EmoteText_12"
              placeholder="EmoteText_12"
            >
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="文本">
            <el-input
              v-model="emoteText.EmoteText_13"
              placeholder="EmoteText_13"
            >
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="文本">
            <el-input
              v-model="emoteText.EmoteText_14"
              placeholder="EmoteText_14"
            >
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="文本">
            <el-input
              v-model="emoteText.EmoteText_15"
              placeholder="EmoteText_15"
            >
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="文本">
            <el-input
              v-model="emoteText.EmoteText_16"
              placeholder="EmoteText_16"
            >
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
import { localeStatTypes } from "@/locales/item";
import { mapActions, mapState } from "vuex";

export default {
  data() {
    return {
      localeStatTypes: localeStatTypes,
      initing: false,
      loading: false,
      creating: false,
    };
  },
  computed: {
    ...mapState("emoteText", ["emoteText"]),
    credential() {
      return {
        ID: this.$route.params.id,
      };
    },
  },
  methods: {
    ...mapActions("emoteText", [
      "storeEmoteText",
      "findEmoteText",
      "updateEmoteText",
      "createEmoteText",
    ]),
    async store() {
      this.loading = true;
      if (this.creating) {
        this.storeEmoteText(this.emoteText);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateEmoteText({
          credential: this.credential,
          emoteText: this.emoteText,
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
      if (this.$route.path == "/emote-set/create") {
        this.creating = true;
        await Promise.all([this.createEmoteText()]);
      } else {
        await this.findEmoteText(this.credential);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
