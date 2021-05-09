<template>
  <div class="changelog">
    <el-card>
      <div slot="header">
        <h2>1.0.5 <small>2021-05-09</small></h2>
      </div>
      <h3>Bug Fixes</h3>
      <ul>
        <li>
          fix preload in vue.config.js
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/dda2d9ee7978cc8c6af06893a44c5e40ee27bfa5"
            text="(dda2d9e)"
          ></clickable-span>
        </li>
        <li>
          remove some components don't need (<clickable-span
            url="https://github.com/CalsRanna/foxy/commit/c8fb0aa7342edc36da6f28f7c518cd974c285610"
            text="(c8fb0aa)"
          ></clickable-span>
        </li>
        <li>
          <strong>creature:</strong> fix missing spell school immune mask
          (<clickable-span
            url="https://github.com/CalsRanna/foxy/commit/4123fbf872918215d10bbfec005961e8b5b866d0"
            text="(4123fbf)"
          ></clickable-span>
        </li>
        <li>
          <strong>creature:</strong> remove some fields to match latest version
          of creature_template (<clickable-span
            url="https://github.com/CalsRanna/foxy/commit/150d7f2980a48d7d2a231b8f73927b26eaba1f20"
            text="(150d7f2)"
          ></clickable-span>
        </li>
        <li>
          <strong>error handler:</strong> fix parse error failure
          (<clickable-span
            url="https://github.com/CalsRanna/foxy/commit/33f5502638d9168968fcabe40beab60cd7e75fb8"
            text="(33f5502)"
          ></clickable-span>
        </li>
      </ul>
      <h3>Features</h3>
      <ul>
        <li>
          <strong>chart:</strong> remove chart component from dashboard
          (<clickable-span
            url="https://github.com/CalsRanna/foxy/commit/29f81ba7238365bf02ffe8cd2c446e2963d92fd9"
            text="(29f81ba)"
          ></clickable-span>
        </li>
        <li>
          <strong>component:</strong> add spell cast time selector
          (<clickable-span
            url="https://github.com/CalsRanna/foxy/commit/ff0df0759d23ea1894fb4f9dd8b5bc552b3a1896"
            text="(ff0df07)"
          ></clickable-span>
        </li>
        <li>
          <strong>component:</strong> add spell range selector (<clickable-span
            url="https://github.com/CalsRanna/foxy/commit/f34bb0fab016fe656118ecb426c4d5e724d4ecb1"
            text="(f34bb0f)"
          ></clickable-span>
        </li>
        <li>
          <strong>creature:</strong> add creature resistance module
          (<clickable-span
            url="https://github.com/CalsRanna/foxy/commit/efcff55a1e1083b408157ee9ac2517af346efaf0"
            text="(efcff55)"
          ></clickable-span>
        </li>
        <li>
          <strong>creature:</strong> add creature spell module (<clickable-span
            url="https://github.com/CalsRanna/foxy/commit/447586060ff9d3cf3aad4fd1e860546eb275b56c"
            text="(4475860)"
          ></clickable-span>
        </li>
        <li>
          <strong>dashboard:</strong> add net disk download url (<clickable-span
            url="https://github.com/CalsRanna/foxy/commit/2975497b7d8d3a1b012706811a24a75ce5c7becf"
            text="(2975497)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell mechanic:</strong> add spell mechanic module
          (<clickable-span
            url="https://github.com/CalsRanna/foxy/commit/fa9064ebde9dec31ec92217e45d04813f5e89b58"
            text="(fa9064e)"
          ></clickable-span>
        </li>
        <li>
          <strong>talent:</strong> add loading talent.dbc (<clickable-span
            url="https://github.com/CalsRanna/foxy/commit/be86accb01222787ac29dc74e42b028f6e3d0687"
            text="(be86acc)"
          ></clickable-span>
        </li>
        <li>
          <strong>talent:</strong> add talent module (<clickable-span
            url="https://github.com/CalsRanna/foxy/commit/f116ded61a2843433cd397d71b04b5beeb07845b"
            text="(f116ded)"
          ></clickable-span>
        </li>
        <li>
          <strong>talent:</strong> add talent tab tab pane to talent
          (<clickable-span
            url="https://github.com/CalsRanna/foxy/commit/a109b15ee9490a3a26d09b4da21fc2e3b7697eb8"
            text="(a109b15)"
          ></clickable-span>
        </li>
        <li>
          <strong>talent tab:</strong> add loading TalentTab.dbc
          (<clickable-span
            url="https://github.com/CalsRanna/foxy/commit/957c4853c0a3ee9cef53be1e69afce5f665ffb9f"
            text="(957c485)"
          ></clickable-span>
        </li>
        <li>
          <strong>talent tab:</strong> add talent tab module (<clickable-span
            url="https://github.com/CalsRanna/foxy/commit/8f2c25bc6244e985a82670f5137d2e5a765cbd47"
            text="(8f2c25b)"
          ></clickable-span>
        </li>
        <li>
          <strong>view:</strong> add item set module (<clickable-span
            url="https://github.com/CalsRanna/foxy/commit/777f9445a26a9aae6cc3d20b0548466f882acb1c"
            text="(777f944)"
          ></clickable-span>
        </li>
      </ul>
    </el-card>
    <el-card style="margin-top: 16px">
      <div slot="header">
        <h2>0.1.4 <small>2021-04-14</small></h2>
      </div>
      <h3>Bug Fixes</h3>
      <ul>
        <li>
          <strong>creature:</strong> fix creature quest ender don't display
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commits/8a2749475e2cb50da4f65a6cbcc87c0ee8d64c76"
            text="(8a27494)"
          ></clickable-span>
        </li>
        <li>
          <strong>dbc:</strong> fix dbc config while first set
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commits/8b77a26c704d815af492f7db0fa861d07c822414"
            text="(8b77a26)"
          ></clickable-span>
        </li>
        <li>
          <strong>quest:</strong> fix used time is too long when search quest
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commits/44f793c5c784d395b10b129bded39eaecadfd096"
            text="(44f793c)"
          ></clickable-span>
        </li>
        <li>
          <strong>quest_template:</strong> fix quest template not display when
          has no znCN locale
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commits/cc409fd60cc38846497fe1bc3ef9c6ccef0b6088"
            text="(cc409fd)"
          ></clickable-span>
        </li>
        <li>
          <strong>reference_loot_template:</strong> fix render error
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commits/9b9349d748b3c58bc6f7374d842641d09cef12ae"
            text="(9b9349d)"
          ></clickable-span>
        </li>
        <li>
          <strong>scaling stat distribution:</strong> add breadcrumb of advance
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commits/96890652bde32d3f9c034c68d6335cd2850fae84"
            text="(9689065)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell selector:</strong> fix description not display well
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commits/63b4f2c873eda5e11738d0ba8f5da7cd520757c7"
            text="(63b4f2c)"
          ></clickable-span>
        </li>
      </ul>
      <h3>Features</h3>
      <ul>
        <li>
          <strong>advance:</strong> add advance module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commits/5db5bc58a3c1ca2f1b70e68c573750b3dfafdb8d"
            text="(5db5bc5)"
          ></clickable-span>
        </li>
        <li>
          <strong>component:</strong> add reference loot template cards
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commits/b37512fb1391e6fe4dbaeb391e5431dee88b0a7a"
            text="(b37512f)"
          ></clickable-span>
        </li>
        <li>
          <strong>component:</strong> add version card to dashboard
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commits/34fc07bd3a202a58622f633caa7992ab18d21d3a"
            text="(34fc07b)"
          ></clickable-span>
        </li>
        <li>
          <strong>scaling stat distribution:</strong> add scaling stat
          distribution module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commits/6b29d69e4cc867418bea7bbe3d9c8c0ce4e90a6d"
            text="(6b29d69)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell group:</strong> add spell group tab pane
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commits/e3e98cb4d116c5d0b5465e946529c06385787759"
            text="(e3e98cb)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell group:</strong> add stack_rule and description when
          display spell groups
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commits/0e5efa99777c3298d73f1b5645c0ed57a231084d"
            text="(0e5efa9)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell linked spell:</strong> add spell linked spell tab pane
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commits/cdffda40096ac97c9d3383fd9388916827eed711"
            text="(cdffda4)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell loot template:</strong> add spell loot template tab pane
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commits/5377bf979bbd7ba0b89d0dcc1337d100cba5b2d6"
            text="(5377bf9)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell_area:</strong> add spell area tab pane
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commits/5150532208085136c33a4a1ee6f74c1cd7a67610"
            text="(5150532)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell_bonus_data:</strong> add spell bonus data tab pane
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commits/f6cb1dfc0a345e064e959d03eb04c475fd68083f"
            text="(f6cb1df)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell_custom_attr:</strong> add spell custom attr tab pane
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commits/ec4c6ee0fd7847594103b76ddbeb54049cac3a51"
            text="(ec4c6ee)"
          ></clickable-span>
        </li>
        <li>
          <strong>views:</strong> add reference loot template cards to loot
          template tab panes
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commits/a72e60c4e78a8955f9dad35b06c45e84c5058be3"
            text="(a72e60c)"
          ></clickable-span>
        </li>
      </ul>
    </el-card>
    <el-card style="margin-top: 16px">
      <div slot="header">
        <h2>0.1.3 <small>2021-03-02</small></h2>
      </div>
      <h3>feat</h3>
      <ul>
        <li>
          add creature model info selector
          <clickable-span
            text="(2e1bb17)"
            url="https://github.com/CalsRanna/foxy/commit/2e1bb17fab8b2f68e4cf87d4ce35a5f5a6b74118"
          ></clickable-span>
        </li>
        <li>
          add creature spell data selector
          <clickable-span
            text="(9d99095)"
            url="https://github.com/CalsRanna/foxy/commit/9d99095278ae53f3cd2f55c40ea9a4b3ef43da96"
          ></clickable-span>
        </li>
        <li>
          add creature template selector
          <clickable-span
            text="(cd29ee0)"
            url="https://github.com/CalsRanna/foxy/commit/cd29ee011cd7bd37a7a31fa488bb7c83bb613731"
          ></clickable-span>
        </li>
        <li>
          add item display info selector
          <clickable-span
            text="(6bbf316)"
            url="https://github.com/CalsRanna/foxy/commit/6bbf316b43876a7d084862b96d99212dc391c9e4"
          ></clickable-span>
        </li>
        <li>
          add item enchantment template selector
          <clickable-span
            text="(b79824b)"
            url="https://github.com/CalsRanna/foxy/commit/b79824bfa9d16c91c171a05d9cadd5a6a981bfe0"
          ></clickable-span>
        </li>
        <li>
          add item random properties selector
          <clickable-span
            text="(23bd93a)"
            url="https://github.com/CalsRanna/foxy/commit/23bd93a76dbd3eac0987615165e78781a4314ab7"
          ></clickable-span>
        </li>
        <li>
          add item random suffix selector
          <clickable-span
            text="(3582e8e)"
            url="https://github.com/CalsRanna/foxy/commit/3582e8e3b2fe348d6ee38813dae885d684d8c8bc"
          ></clickable-span>
        </li>
        <li>
          add item set selector
          <clickable-span
            text="(cc7c48d)"
            url="https://github.com/CalsRanna/foxy/commit/cc7c48d1fcea6f871bd707a73ce437b25d3db641"
          ></clickable-span>
        </li>
        <li>
          add quest template selector
          <clickable-span
            text="(dc9c7f9)"
            url="https://github.com/CalsRanna/foxy/commit/dc9c7f98ec966fd250b7e264c444d817fce0875d"
          ></clickable-span>
        </li>
        <li>
          add scaling stat distribution selector
          <clickable-span
            text="(c80e301)"
            url="https://github.com/CalsRanna/foxy/commit/c80e30160f3b706e399786a7be72f4308aee079d"
          ></clickable-span>
        </li>
        <li>
          add scaling stat values flag editor
          <clickable-span
            text="(25e627b)"
            url="https://github.com/CalsRanna/foxy/commit/25e627b605949ed8b878fcf5b7d72e70b2235347"
          ></clickable-span>
        </li>
        <li>
          add waypoint data selector
          <clickable-span
            text="(8404858)"
            url="https://github.com/CalsRanna/foxy/commit/840485823dd8a2cdc290e28605f5c292b165701d"
          ></clickable-span>
        </li>
        <li>
          load creature spell data
          <clickable-span
            text="(c2a5ee0)"
            url="https://github.com/CalsRanna/foxy/commit/c2a5ee0699966d65f9a70c0f1269c58904867f8f"
          ></clickable-span>
        </li>
        <li>
          load item random properties
          <clickable-span
            text="(269b18b)"
            url="https://github.com/CalsRanna/foxy/commit/269b18b7845f876af66366a23863cefb01fae422"
          ></clickable-span>
        </li>
        <li>
          load item random suffix
          <clickable-span
            text="(fafb195)"
            url="https://github.com/CalsRanna/foxy/commit/fafb1951f8538c7f8f93e21eed5c8a9bed683ee3"
          ></clickable-span>
        </li>
        <li>
          load spell item enchantments
          <clickable-span
            text="(f3ac217)"
            url="https://github.com/CalsRanna/foxy/commit/f3ac217a067a1f68eeaec8b8744826675f3cd226"
          ></clickable-span>
        </li>
      </ul>
      <h3>fix</h3>
      <ul>
        <li>
          adjust label of model name
          <clickable-span
            text="(e58088c)"
            url="https://github.com/CalsRanna/foxy/commit/e58088c936d66d6024638d62092865f058b187ff"
          ></clickable-span>
        </li>
        <li>
          fix locale info in table and detail
          <clickable-span
            text="(3d2e9f9)"
            url="https://github.com/CalsRanna/foxy/commit/3d2e9f90529fedd601e14dd34a851859c724755c"
          ></clickable-span>
        </li>
        <li>
          fix name not work when search spell in selector
          <clickable-span
            text="(4fc2d9c)"
            url="https://github.com/CalsRanna/foxy/commit/4fc2d9cc08ad4620c3029d1f46d4745513e2c69c"
          ></clickable-span>
        </li>
        <li>
          reference right dbc while choose enchantment
          <clickable-span
            text="(f842db9)"
            url="https://github.com/CalsRanna/foxy/commit/f842db9d9259d7d84833d75906ecc2fc4c74f263"
          ></clickable-span>
        </li>
        <li>
          reference right dbc while list enchantment
          <clickable-span
            text="(3c6b0b3)"
            url="https://github.com/CalsRanna/foxy/commit/3c6b0b3135d03202b1c02111fbd0b2e082a003cf"
          ></clickable-span>
        </li>
        <li>
          use correct component while add enchantment
          <clickable-span
            text="(6299e90)"
            url="https://github.com/CalsRanna/foxy/commit/6299e90490c1c4cc87c59fe2f098622cdb7bf403"
          ></clickable-span>
        </li>
      </ul>
      <h3>chore</h3>
      <ul>
        <li>
          add hide when overflow in table
          <clickable-span
            text="(8b6c4fe)"
            url="https://github.com/CalsRanna/foxy/commit/8b6c4fe0d85f93cd033aae44cb3011cdaaeaaf84"
          ></clickable-span>
        </li>
        <li>
          update warcrafty to 1.0.8
          <clickable-span
            text="(f663992)"
            url="https://github.com/CalsRanna/foxy/commit/f663992616b6544093e4ab61568cff269457ac0c"
          ></clickable-span>
        </li>
        <li>
          use item template selector instead
          <clickable-span
            text="(d0fd671)"
            url="https://github.com/CalsRanna/foxy/commit/d0fd67190ffe674ab89f20ef71da1faf72c18bc8"
          ></clickable-span>
        </li>
      </ul>
    </el-card>
    <el-card style="margin-top: 16px">
      <div slot="header">
        <h2>0.1.2-alpha <small>2021-02-18</small></h2>
      </div>
      <h3>feat</h3>
      <ul>
        <li>
          add aura interrupt flags
          <clickable-span
            text="(cf8fa08)"
            url="https://github.com/CalsRanna/foxy/commit/cf8fa08e4bf510619c8d085ea8589b3d3e3a2d4f"
          ></clickable-span>
        </li>
        <li>
          add interrupt flags
          <clickable-span
            text="(40246d6)"
            url="https://github.com/CalsRanna/foxy/commit/40246d69e188cb220f345dd93b065cf92059ebd8"
          ></clickable-span>
        </li>
        <li>
          add some type select
          <clickable-span
            text="(532cb67)"
            url="https://github.com/CalsRanna/foxy/commit/532cb679b3f65dc4f38c7d0d5011043730eb75de"
          ></clickable-span>
        </li>
        <li>
          add spell duration selector component
          <clickable-span
            text="(946cab8)"
            url="https://github.com/CalsRanna/foxy/commit/946cab8488e4098688e23c38b422720713362dcb"
          ></clickable-span>
        </li>
      </ul>
      <h3>fix</h3>
      <ul>
        <li>
          adjust margin of components
          <clickable-span
            text="(90d20ae)"
            url="https://github.com/CalsRanna/foxy/commit/90d20ae9b2ecbcf4c0e6f6dea45fb2f1609218f2"
          ></clickable-span>
        </li>
        <li>
          fix global error handle
          <clickable-span
            text="(a9e5588)"
            url="https://github.com/CalsRanna/foxy/commit/clickable-span9e558826d91cf812c73fb8a48736a6e4264d861"
          ></clickable-span>
        </li>
        <li>
          fix global error handler
          <clickable-span
            text="(b0b5e19)"
            url="https://github.com/CalsRanna/foxy/commit/b0b5e1901878eed7ea75d42d7e1868f9f78d5250"
          ></clickable-span>
        </li>
      </ul>
      <h3>chore</h3>
      <ul>
        <li>
          remove annotations
          <clickable-span
            text="(ca0c118)"
            url="https://github.com/CalsRanna/foxy/commit/ca0c11834028e9fda7b71a4457218407aeaec9b4"
          ></clickable-span>
        </li>
        <li>
          remove annotations
          <clickable-span
            text="(d8fb181)"
            url="https://github.com/CalsRanna/foxy/commit/d8fb1818f520b946df7797ae67afb7779b1fe4d7"
          ></clickable-span>
        </li>
      </ul>
    </el-card>
    <el-card style="margin-top: 16px">
      <div slot="header">
        <h2>0.1.1-alpha <small>2021-02-05</small></h2>
      </div>
      <h3>feat</h3>
      <ul>
        <li>
          add faction template selector
          <clickable-span
            text="(d9fd70e)"
            url="https://github.com/CalsRanna/foxy/commit/d9fd70edb6bfe1fdad6f0a79b9f0337993b7539a"
          ></clickable-span>
        </li>
        <li>
          add gossip menu selector
          <clickable-span
            text="(96dda98)"
            url="https://github.com/CalsRanna/foxy/commit/96dda989a681ca9ea881df9b954c92329c9b326f"
          ></clickable-span>
        </li>
        <li>
          add item template selector
          <clickable-span
            text="(3b3c457)"
            url="https://github.com/CalsRanna/foxy/commit/3b3c457f819e8c4df8b82d3228b3929dec605487"
          ></clickable-span>
        </li>
        <li>
          add some localizer
          <clickable-span
            text="(da2e6f7)"
            url="https://github.com/CalsRanna/foxy/commit/da2e6f74bb1403838dc6dfa07d32f01523c9259d"
          ></clickable-span>
        </li>
        <li>
          add spell selector
          <clickable-span
            text="(2e72187)"
            url="https://github.com/CalsRanna/foxy/commit/2e721878877270843d46e51b9ee866b97ad57094"
          ></clickable-span>
        </li>
      </ul>
    </el-card>
    <el-card style="margin-top: 16px">
      <div slot="header">
        <h2>0.1.0-alpha <small>2021-02-04</small></h2>
      </div>
      <h3>chore</h3>
      <ul>
        <li>
          do some regular optimization
          <clickable-span
            text="(f522c52)"
            url="https://github.com/CalsRanna/foxy/commit/f522c5266d00e3023dd565739804ea8fc227ab8f"
          ></clickable-span>
        </li>
      </ul>
    </el-card>
  </div>
</template>

<script>
import ClickableSpan from "@/components/ClickableSpan";
export default {
  methods: {
    openBrowser(url) {
      const shell = window.shell;
      shell.openExternal(url);
    },
  },
  components: {
    ClickableSpan,
  },
};
</script>

<style scoped>
.changelog h2 {
  color: #409eff;
}
.changelog small {
  color: #909399;
  font-weight: normal;
  font-size: 16px;
}

.changelog li {
  margin-top: 8px;
}
</style>
