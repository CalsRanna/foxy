## [0.1.5](https://github.com/CalsRanna/foxy/compare/0.1.4...0.1.5) (2021-05-09)

### Bug Fixes

- fix preload in vue.config.js ([dda2d9e](https://github.com/CalsRanna/foxy/commit/dda2d9ee7978cc8c6af06893a44c5e40ee27bfa5))
- remove some components don't need ([c8fb0aa](https://github.com/CalsRanna/foxy/commit/c8fb0aa7342edc36da6f28f7c518cd974c285610))
- **creature:** fix missing spell school immune mask ([4123fbf](https://github.com/CalsRanna/foxy/commit/4123fbf872918215d10bbfec005961e8b5b866d0))
- **creature:** remove some fields to match latest version of creature_template ([150d7f2](https://github.com/CalsRanna/foxy/commit/150d7f2980a48d7d2a231b8f73927b26eaba1f20))
- **error handler:** fix parse error failure ([33f5502](https://github.com/CalsRanna/foxy/commit/33f5502638d9168968fcabe40beab60cd7e75fb8))

### Features

- **chart:** remove chart component from dashboard ([29f81ba](https://github.com/CalsRanna/foxy/commit/29f81ba7238365bf02ffe8cd2c446e2963d92fd9))
- **component:** add spell cast time selector ([ff0df07](https://github.com/CalsRanna/foxy/commit/ff0df0759d23ea1894fb4f9dd8b5bc552b3a1896))
- **component:** add spell range selector ([f34bb0f](https://github.com/CalsRanna/foxy/commit/f34bb0fab016fe656118ecb426c4d5e724d4ecb1))
- **creature:** add creature resistance module ([efcff55](https://github.com/CalsRanna/foxy/commit/efcff55a1e1083b408157ee9ac2517af346efaf0))
- **creature:** add creature spell module ([4475860](https://github.com/CalsRanna/foxy/commit/447586060ff9d3cf3aad4fd1e860546eb275b56c))
- **dashboard:** add net disk download url ([2975497](https://github.com/CalsRanna/foxy/commit/2975497b7d8d3a1b012706811a24a75ce5c7becf))
- **spell mechanic:** add spell mechanic module ([fa9064e](https://github.com/CalsRanna/foxy/commit/fa9064ebde9dec31ec92217e45d04813f5e89b58))
- **talent:** add loading talent.dbc ([be86acc](https://github.com/CalsRanna/foxy/commit/be86accb01222787ac29dc74e42b028f6e3d0687))
- **talent:** add talent module ([f116ded](https://github.com/CalsRanna/foxy/commit/f116ded61a2843433cd397d71b04b5beeb07845b))
- **talent:** add talent tab tab pane to talent ([a109b15](https://github.com/CalsRanna/foxy/commit/a109b15ee9490a3a26d09b4da21fc2e3b7697eb8))
- **talent tab:** add loading TalentTab.dbc ([957c485](https://github.com/CalsRanna/foxy/commit/957c4853c0a3ee9cef53be1e69afce5f665ffb9f))
- **talent tab:** add talent tab module ([8f2c25b](https://github.com/CalsRanna/foxy/commit/8f2c25bc6244e985a82670f5137d2e5a765cbd47))
- **view:** add item set module ([777f944](https://github.com/CalsRanna/foxy/commit/777f9445a26a9aae6cc3d20b0548466f882acb1c))

## [0.1.4](https://e.coding.net/foxcore/foxcorefoxcore/foxy/compare/0.1.3...0.1.4) (2021-04-14)

### Bug Fixes

- **creature:** fix creature quest ender don't display ([8a27494](https://e.coding.net/foxcore/foxcorefoxcore/foxy/commits/8a2749475e2cb50da4f65a6cbcc87c0ee8d64c76))
- **dbc:** fix dbc config while first set ([8b77a26](https://e.coding.net/foxcore/foxcorefoxcore/foxy/commits/8b77a26c704d815af492f7db0fa861d07c822414))
- **quest:** fix used time is too long when search quest ([44f793c](https://e.coding.net/foxcore/foxcorefoxcore/foxy/commits/44f793c5c784d395b10b129bded39eaecadfd096))
- **quest_template:** fix quest template not display when has no znCN locale ([cc409fd](https://e.coding.net/foxcore/foxcorefoxcore/foxy/commits/cc409fd60cc38846497fe1bc3ef9c6ccef0b6088))
- **reference_loot_template:** fix render error ([9b9349d](https://e.coding.net/foxcore/foxcorefoxcore/foxy/commits/9b9349d748b3c58bc6f7374d842641d09cef12ae))
- **scaling stat distribution:** add breadcrumb of advance ([9689065](https://e.coding.net/foxcore/foxcorefoxcore/foxy/commits/96890652bde32d3f9c034c68d6335cd2850fae84))
- **spell selector:** fix description not display well ([63b4f2c](https://e.coding.net/foxcore/foxcorefoxcore/foxy/commits/63b4f2c873eda5e11738d0ba8f5da7cd520757c7))

### Features

- **advance:** add advance module ([5db5bc5](https://e.coding.net/foxcore/foxcorefoxcore/foxy/commits/5db5bc58a3c1ca2f1b70e68c573750b3dfafdb8d))
- **component:** add reference loot template cards ([b37512f](https://e.coding.net/foxcore/foxcorefoxcore/foxy/commits/b37512fb1391e6fe4dbaeb391e5431dee88b0a7a))
- **component:** add version card to dashboard ([34fc07b](https://e.coding.net/foxcore/foxcorefoxcore/foxy/commits/34fc07bd3a202a58622f633caa7992ab18d21d3a))
- **scaling stat distribution:** add scaling stat distribution module ([6b29d69](https://e.coding.net/foxcore/foxcorefoxcore/foxy/commits/6b29d69e4cc867418bea7bbe3d9c8c0ce4e90a6d))
- **spell group:** add spell group tab pane ([e3e98cb](https://e.coding.net/foxcore/foxcorefoxcore/foxy/commits/e3e98cb4d116c5d0b5465e946529c06385787759))
- **spell group:** add stack_rule and description when display spell groups ([0e5efa9](https://e.coding.net/foxcore/foxcorefoxcore/foxy/commits/0e5efa99777c3298d73f1b5645c0ed57a231084d))
- **spell linked spell:** add spell linked spell tab pane ([cdffda4](https://e.coding.net/foxcore/foxcorefoxcore/foxy/commits/cdffda40096ac97c9d3383fd9388916827eed711))
- **spell loot template:** add spell loot template tab pane ([5377bf9](https://e.coding.net/foxcore/foxcorefoxcore/foxy/commits/5377bf979bbd7ba0b89d0dcc1337d100cba5b2d6))
- **spell_area:** add spell area tab pane ([5150532](https://e.coding.net/foxcore/foxcorefoxcore/foxy/commits/5150532208085136c33a4a1ee6f74c1cd7a67610))
- **spell_bonus_data:** add spell bonus data tab pane ([f6cb1df](https://e.coding.net/foxcore/foxcorefoxcore/foxy/commits/f6cb1dfc0a345e064e959d03eb04c475fd68083f))
- **spell_custom_attr:** add spell custom attr tab pane ([ec4c6ee](https://e.coding.net/foxcore/foxcorefoxcore/foxy/commits/ec4c6ee0fd7847594103b76ddbeb54049cac3a51))
- **views:** add reference loot template cards to loot template tab panes ([a72e60c](https://e.coding.net/foxcore/foxcorefoxcore/foxy/commits/a72e60c4e78a8955f9dad35b06c45e84c5058be3))

## [0.1.3](https://github.com/CalsRanna/foxy/compare/0.1.2-alpha...0.1.3) (2021-03-02)

### feat

- add creature model info selector. ([2e1bb17](https://github.com/CalsRanna/foxy/commit/2e1bb17fab8b2f68e4cf87d4ce35a5f5a6b74118))
- add creature spell data selector. ([9d99095](https://github.com/CalsRanna/foxy/commit/9d99095278ae53f3cd2f55c40ea9a4b3ef43da96))
- add creature template selector. ([cd29ee0](https://github.com/CalsRanna/foxy/commit/cd29ee011cd7bd37a7a31fa488bb7c83bb613731))
- add item display info selector. ([6bbf316](https://github.com/CalsRanna/foxy/commit/6bbf316b43876a7d084862b96d99212dc391c9e4))
- add item enchantment template selector. ([b79824b](https://github.com/CalsRanna/foxy/commit/b79824bfa9d16c91c171a05d9cadd5a6a981bfe0))
- add item random properties selector. ([23bd93a](https://github.com/CalsRanna/foxy/commit/23bd93a76dbd3eac0987615165e78781a4314ab7))
- add item random suffix selector. ([3582e8e](https://github.com/CalsRanna/foxy/commit/3582e8e3b2fe348d6ee38813dae885d684d8c8bc))
- add item set selector. ([cc7c48d](https://github.com/CalsRanna/foxy/commit/cc7c48d1fcea6f871bd707a73ce437b25d3db641))
- add quest template selector. ([dc9c7f9](https://github.com/CalsRanna/foxy/commit/dc9c7f98ec966fd250b7e264c444d817fce0875d))
- add scaling stat distribution selector. ([c80e301](https://github.com/CalsRanna/foxy/commit/c80e30160f3b706e399786a7be72f4308aee079d))
- add scaling stat values flag editor. ([25e627b](https://github.com/CalsRanna/foxy/commit/25e627b605949ed8b878fcf5b7d72e70b2235347))
- add waypoint data selector. ([8404858](https://github.com/CalsRanna/foxy/commit/840485823dd8a2cdc290e28605f5c292b165701d))
- load CreatureSpellData.dbc. ([c2a5ee0](https://github.com/CalsRanna/foxy/commit/c2a5ee0699966d65f9a70c0f1269c58904867f8f))
- load item random properties. ([269b18b](https://github.com/CalsRanna/foxy/commit/269b18b7845f876af66366a23863cefb01fae422))
- load item random suffix. ([fafb195](https://github.com/CalsRanna/foxy/commit/fafb1951f8538c7f8f93e21eed5c8a9bed683ee3))
- load spell item enchantments. ([f3ac217](https://github.com/CalsRanna/foxy/commit/f3ac217a067a1f68eeaec8b8744826675f3cd226))

### fix

- adjust label of ModelName_2. ([e58088c](https://github.com/CalsRanna/foxy/commit/e58088c936d66d6024638d62092865f058b187ff))
- fix locale info in table and detail. ([3d2e9f9](https://github.com/CalsRanna/foxy/commit/3d2e9f90529fedd601e14dd34a851859c724755c))
- fix name not work when search spell in selector. ([4fc2d9c](https://github.com/CalsRanna/foxy/commit/4fc2d9cc08ad4620c3029d1f46d4745513e2c69c))
- reference right dbc while choose enchantment. ([f842db9](https://github.com/CalsRanna/foxy/commit/f842db9d9259d7d84833d75906ecc2fc4c74f263))
- reference right dbc while list enchantment. ([3c6b0b3](https://github.com/CalsRanna/foxy/commit/3c6b0b3135d03202b1c02111fbd0b2e082a003cf))
- use correct component while add enchantment. ([6299e90](https://github.com/CalsRanna/foxy/commit/6299e90490c1c4cc87c59fe2f098622cdb7bf403))

### chore

- add hide when overflow in table. ([8b6c4fe](https://github.com/CalsRanna/foxy/commit/8b6c4fe0d85f93cd033aae44cb3011cdaaeaaf84))
- update warcrafty to 1.0.8. ([f663992](https://github.com/CalsRanna/foxy/commit/f663992616b6544093e4ab61568cff269457ac0c))
- use item template selector instead. ([d0fd671](https://github.com/CalsRanna/foxy/commit/d0fd67190ffe674ab89f20ef71da1faf72c18bc8))

## [0.1.2-alpha](https://github.com/CalsRanna/foxy/compare/0.1.1-alpha...0.1.2-alpha) (2021-02-18)

### feat

- add aura interrupt flags. ([cf8fa08](https://github.com/CalsRanna/foxy/commit/cf8fa08e4bf510619c8d085ea8589b3d3e3a2d4f))
- add interrupt flags. ([40246d6](https://github.com/CalsRanna/foxy/commit/40246d69e188cb220f345dd93b065cf92059ebd8))
- add some type select. ([532cb67](https://github.com/CalsRanna/foxy/commit/532cb679b3f65dc4f38c7d0d5011043730eb75de))
- add spell duration selector component. ([946cab8](https://github.com/CalsRanna/foxy/commit/946cab8488e4098688e23c38b422720713362dcb))

### fix

- adjust margin of components. ([90d20ae](https://github.com/CalsRanna/foxy/commit/90d20ae9b2ecbcf4c0e6f6dea45fb2f1609218f2))
- fix global error handle. ([a9e5588](https://github.com/CalsRanna/foxy/commit/a9e558826d91cf812c73fb8a48736a6e4264d861))
- fix global error handler. ([b0b5e19](https://github.com/CalsRanna/foxy/commit/b0b5e1901878eed7ea75d42d7e1868f9f78d5250))

### chore

- remove annotations. ([ca0c118](https://github.com/CalsRanna/foxy/commit/ca0c11834028e9fda7b71a4457218407aeaec9b4))
- remove annotations. ([d8fb181](https://github.com/CalsRanna/foxy/commit/d8fb1818f520b946df7797ae67afb7779b1fe4d7))

## [0.1.1-alpha](https://github.com/CalsRanna/foxy/compare/0.1.0-alpha...0.1.1-alpha) (2021-02-05)

### feat

- add faction template selector. ([d9fd70e](https://github.com/CalsRanna/foxy/commit/d9fd70edb6bfe1fdad6f0a79b9f0337993b7539a))
- add gossip menu selector. ([96dda98](https://github.com/CalsRanna/foxy/commit/96dda989a681ca9ea881df9b954c92329c9b326f))
- add item template selector. ([3b3c457](https://github.com/CalsRanna/foxy/commit/3b3c457f819e8c4df8b82d3228b3929dec605487))
- add some localizer. ([da2e6f7](https://github.com/CalsRanna/foxy/commit/da2e6f74bb1403838dc6dfa07d32f01523c9259d))
- add spell selector. ([2e72187](https://github.com/CalsRanna/foxy/commit/2e721878877270843d46e51b9ee866b97ad57094))

# [0.1.0-alpha](https://github.com/CalsRanna/foxy/compare/f522c5266d00e3023dd565739804ea8fc227ab8f...0.1.0-alpha) (2021-02-04)

### chore

- do some regular optimization. ([f522c52](https://github.com/CalsRanna/foxy/commit/f522c5266d00e3023dd565739804ea8fc227ab8f))
