## [0.1.8](https://github.com/CalsRanna/foxy/compare/0.1.7...0.1.8) (2021-06-01)


### Bug Fixes

* **item template name:** fix name of inventory icon to fit icons in disk ([9d55f4e](https://github.com/CalsRanna/foxy/commit/9d55f4edcd6f3bbfdb7d57aa83a3083064fc04b6))
* **item template name:** fix padding between icon and name to keep same when display chinese and original name ([b084134](https://github.com/CalsRanna/foxy/commit/b08413435dff4f0d1b5b69600b63866a84f561bc))
* **version:** fix new version shown when has no new version ([ba0ea8f](https://github.com/CalsRanna/foxy/commit/ba0ea8f3d1d0b7fedcd79cb4f568da2eff3c1379))


### Features

* **chr class:** add chr class editor ([da917a5](https://github.com/CalsRanna/foxy/commit/da917a5a8c75aae1e6b53ce2172ce8b142c6cd0e))
* **chr race:** add chr race editor ([502c329](https://github.com/CalsRanna/foxy/commit/502c329ea61cb8f653fdeb5e3eb18421c2b2f5ec))
* **dashboard:** make card clickable ([39a2a75](https://github.com/CalsRanna/foxy/commit/39a2a75826232f274f81cbb32cc47fea41cfa1a0))
* **reference loot template:** add reference loot tempalte module ([f70d694](https://github.com/CalsRanna/foxy/commit/f70d6942fd3a018214ca3929c26548aa2bb081da))
* **scaling stat values:** add scaling stat values module ([ded7347](https://github.com/CalsRanna/foxy/commit/ded73476b60aefb178bd3e0ab0b679c85e83cf6e))
* **selector:** add loading while searching and use enter key to search ([621b1a2](https://github.com/CalsRanna/foxy/commit/621b1a2f6eec72264ba17190502ae91d00d58789))
* **spell icon selector:** add spell icon selector ([87b7130](https://github.com/CalsRanna/foxy/commit/87b713021fc93830d66ddd85f1d666640f7d7587))
* **spell name:** add icon to spell name ([1926248](https://github.com/CalsRanna/foxy/commit/192624828966a0b4b9c209cda6296550597af292))
* **spell selector:** add icon display in table ([0140fa5](https://github.com/CalsRanna/foxy/commit/0140fa59f6659b734b13b57fc5938a04cd71d756))



## [0.1.7](https://github.com/CalsRanna/foxy/compare/0.1.6...0.1.7) (2021-05-27)

### Bug Fixes

- **app:** fix active view while reloading app ([c8ccc5f](https://github.com/CalsRanna/foxy/commit/c8ccc5faa54c51ab1a79441e33d97ff69a58863b))
- **creature:** use mechanics from dbc instead of constant ([4d5b0c7](https://github.com/CalsRanna/foxy/commit/4d5b0c7439f8ae29d4e34a1d2e847a366da9677d))
- **error:** set timeout to 1000ms ([03a1514](https://github.com/CalsRanna/foxy/commit/03a1514ea8f145880b43ce1cfec219544f08c8eb))
- **error:** show error only once when serval same errors occurred ([da4c941](https://github.com/CalsRanna/foxy/commit/da4c941edab0336f44a8898ca585d5dc4df00f56))
- **game object loot template:** fix searching game object loot template when game object has loot template ([0fc06ec](https://github.com/CalsRanna/foxy/commit/0fc06ec483f908f25ec24036ffd7cbf5cb5f2797))
- **item template name:** fix img and span display error when has no icon or long name ([e574252](https://github.com/CalsRanna/foxy/commit/e574252772d8a9b58b12e2c7e43f6a2a44fa304f))
- **localizer:** remove display entry or id from localizer ([47a124f](https://github.com/CalsRanna/foxy/commit/47a124f16db39d6dc65bc396939722faa91aa44e))
- **setting:** fix setting active tab when init and reload view ([503568b](https://github.com/CalsRanna/foxy/commit/503568bfc5b69d3ea1157726a331b47a8c7f9ace))
- **sql:** fix charset and collate when init loading dbc ([eca773d](https://github.com/CalsRanna/foxy/commit/eca773dbb9c40a797b8035f3b2bd0d2a5826c501))

### Features

- **creature equipment template:** add icon display in table ([ee9e9ce](https://github.com/CalsRanna/foxy/commit/ee9e9cedfde0779594b9c1f87c78319747af2ff3))
- **creature loot template:** add icon display in table ([4943cc2](https://github.com/CalsRanna/foxy/commit/4943cc2acdce5e353028560b5cf61b1726e94030))
- **creature quest item:** add icon display in table ([c1ee32c](https://github.com/CalsRanna/foxy/commit/c1ee32c19eb928086a6886e53182aa56dcae8aa8))
- **disenchant loot template:** add icon display in table ([d18d2ab](https://github.com/CalsRanna/foxy/commit/d18d2ab97b8d4f6d8b2ed7bd1e82c138c8a4c11e))
- **game object loot template:** add icon display in table ([80bbae9](https://github.com/CalsRanna/foxy/commit/80bbae96be3cf5d346d09f62596b3ab62c54ecf8))
- **game object quest item:** add icon display in table ([d6b47af](https://github.com/CalsRanna/foxy/commit/d6b47af00e69bdd9c33958a22b374a6524c5d759))
- **item:** add item icon in item template name component ([6c1654f](https://github.com/CalsRanna/foxy/commit/6c1654fb6b52f43a0678450a6f2aa4be999df41b))
- **item loot template:** add icon display in table ([82f8696](https://github.com/CalsRanna/foxy/commit/82f869600fd9e039538e9ca15b0c19a1c57bbf3a))
- **item template selector:** add icon display in table ([b0ebf5c](https://github.com/CalsRanna/foxy/commit/b0ebf5c063e0aba10914989751c86167815e1a1d))
- **milling loot template:** add icon display in table ([1204023](https://github.com/CalsRanna/foxy/commit/12040233c8a87eb3af5c08b5d98c1b81c2598e73))
- **mysql connection:** add port to mysql connection ([1ad7b0f](https://github.com/CalsRanna/foxy/commit/1ad7b0fcdd38fc81ca737d58dfef17dbc0d2185c))
- **npc vendor:** add icon display in table ([dd39d8e](https://github.com/CalsRanna/foxy/commit/dd39d8e34634fc70431121efb5104903e2472ff7))
- **pickpocketing loot template:** add icon display in table ([5c476b1](https://github.com/CalsRanna/foxy/commit/5c476b10c8c972869c116ef076c5501f9f69b7af))
- **prospecting loot template:** add icon display in table ([45a6de2](https://github.com/CalsRanna/foxy/commit/45a6de2e360a02f5f668cc0491752b0f5490c861))
- **reference loot template:** add icon display in table ([f9d7a23](https://github.com/CalsRanna/foxy/commit/f9d7a2338112912d348078c62cce8e9f1ea62eb3))
- **skinning loot template:** add icon display in table ([583545f](https://github.com/CalsRanna/foxy/commit/583545f7b6cf1193c30c26b324da505c81a23b2d))
- **spell loot template:** add icon display in table ([fb89883](https://github.com/CalsRanna/foxy/commit/fb898838b869b6d8d11752a63cc71da1a233db8a))

## [0.1.6](https://github.com/CalsRanna/foxy/compare/0.1.5...0.1.6) (2021-05-10)

### Bug Fixes

- **spell:** fix mechanics didn't work properly ([99d7e28](https://github.com/CalsRanna/foxy/commit/99d7e28e87f83246ef194c65683c85fcc604958e))

### Features

- **about:** add about view ([f18f2ad](https://github.com/CalsRanna/foxy/commit/f18f2adbfd7cdb2f265c2babf07c35e5005c3d2b))
- **initiator:** build a new initiator instead of inline dialog ([59127b9](https://github.com/CalsRanna/foxy/commit/59127b9fc9a29d11b8f44fe4db031d5efaf471da))
- **version:** use state of version instead of data in component ([920026d](https://github.com/CalsRanna/foxy/commit/920026d46b3cdfa08fd5807f7b3fb785e758d5e9))

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
