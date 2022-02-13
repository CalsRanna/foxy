<template>
  <div
    class="changelog"
    :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }"
  >
    <el-card>
      <div slot="header">
        <h2>0.2.8 <small>2022-02-13</small></h2>
      </div>
      <h3>Bug Fixes</h3>
      <ul>
        <li>
          <strong>exporter:</strong> fix error when export glyph property
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/2ef727616e6fd49d70fab84337eb44a7ae9d22d8"
            text="(2ef7276)"
          />
        </li>
        <li>
          <strong>glyph property:</strong> fix error when search by id
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/d87d2129a88c85a60f2ddd205e9b3b653a0117c7"
            text="(d87d212)"
          />
        </li>
      </ul>
      <h3>Features</h3>
      <ul>
        <li>
          <strong>glyph property selector:</strong> build glyph property
          selector
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/9fcd9522a01a57a18a6c9e12b6eb83e6a0fea2cf"
            text="(9fcd952)"
          />
        </li>
      </ul>
    </el-card>
    <el-card style="margin-top: 16px">
      <div slot="header">
        <h2>0.2.7 <small>2022-02-12</small></h2>
      </div>
      <h3>Bug Fixes</h3>
      <ul>
        <li>
          <strong>typo:</strong> fix some typo error
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/2748c44019976def0f5062d8f198b72eaa9bae9c"
            text="(2748c44)"
          />
        </li>
        <li>
          <strong>updater:</strong> use sfc instead github api to fetch remote
          version
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/88e23a7d18973598a060bd46ff1329a0f92eb4ab"
            text="(88e23a7)"
          />
        </li>
      </ul>
      <h3>Features</h3>
      <ul>
        <li>
          <strong>glyph property:</strong> add glyph property module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/86569a0ca2a34cb5aa592f33472d17a380f63058"
            text="(86569a0)"
          />
        </li>
        <li>
          <strong>spell rank:</strong> add spell rank module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/01af0e20a2a575b67fa0b37313a09823b455ad67"
            text="(01af0e2)"
          />
        </li>
      </ul>
    </el-card>
    <el-card style="margin-top: 16px">
      <div slot="header">
        <h2>0.2.6 <small>2022-01-12</small></h2>
      </div>
      <h3>Bug Fixes</h3>
      <ul>
        <li>
          <strong>achievement criteria:</strong> fix error while has no bindings
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/82091a0db99fa5cf9059a7e137c33f2a96194185"
            text="(82091a0)"
          />
        </li>
        <li>
          <strong>clickable span:</strong> remove extra space around text
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/b272526ade578ed135ce10c81b3abb31cb45b0e9"
            text="(b272526)"
          />
        </li>
        <li>
          <strong>exporter:</strong> fix export talent tab no such table error
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/be03539c726a053a5fb7c0a8b34d4c6d5e5369d6"
            text="(be03539)"
          />
        </li>
      </ul>
      <h3>Features</h3>
      <ul>
        <li>
          <strong>achievement category:</strong> add achievement category module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/9ebb6870bb743505fc12295b37fc3e15843b2c60"
            text="(9ebb687)"
          />
        </li>
        <li>
          <strong>achievement criteria data:</strong> add achievement criteria
          data module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/86939c77685e4560f3008fa3a7bc1bb201867283"
            text="(86939c7)"
          />
        </li>
        <li>
          <strong>achievement reward:</strong> add achievement reward module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/cf44301f191f859626a58622aa13248fbef4b7db"
            text="(cf44301)"
          />
        </li>
        <li>
          <strong>localizer:</strong> add achievement reward localizer
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/8ca727ca6931c95da46dc4113124219a85b47ff1"
            text="(8ca727c)"
          />
        </li>
        <li>
          <strong>talent tab:</strong> add selector and editor
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/32a0be264d138f22a3d269610c7ba62dfa850ae8"
            text="(32a0be2)"
          />
        </li>
      </ul>
    </el-card>
    <el-card style="margin-top: 16px">
      <div slot="header">
        <h2>0.2.5 <small>2021-09-30</small></h2>
      </div>
      <h3>Features</h3>
      <ul>
        <li>
          <strong>advance:</strong> add tree filter to advance view
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/ad6897906aed7733c84c006bbcd109c17876cdcd"
            text="(ad68979)"
          />
        </li>
        <li>
          <strong>area table:</strong> add area table selector
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/4c128b1cd0aef72080668881202ab8a0c103cf19"
            text="(4c128b1)"
          />
        </li>
        <li>
          <strong>player create info action:</strong> add player create info
          action module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/0f28051e48206174f37cc18c743705abbd2b6ac7"
            text="(0f28051)"
          />
        </li>
        <li>
          <strong>player create info item:</strong> add player create info item
          module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/cfa3a99370b50eaf52e809d69bcff4bdf4877be2"
            text="(cfa3a99)"
          />
        </li>
        <li>
          <strong>player create info spell custom:</strong> add player create
          info spell custom module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/2d5375be9b7be508545855f400d3828aacfbb199"
            text="(2d5375b)"
          />
        </li>
        <li>
          <strong>player create info:</strong> add player create info module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/36ec1831cded56db21ee7494cd66828d1328ecfd"
            text="(36ec183)"
          />
        </li>
        <li>
          <strong>smart script:</strong> make params flexable with its type
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/68746ac729d802552b0b1a706e337e87a98d7160"
            text="(68746ac)"
          />
        </li>
      </ul>
    </el-card>
    <el-card style="margin-top: 16px">
      <div slot="header">
        <h2>0.2.4 <small>2021-09-01</small></h2>
      </div>
      <h3>Bug Fixes</h3>
      <ul>
        <li>
          <strong>changlog:</strong> add max height
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/26ff8e87fc7d96a9cdea9232864dcd170e0ffc92"
            text="(26ff8e8)"
          />
        </li>
        <li>
          <strong>table:</strong> remove second pagination under table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/f77d91c7eb54792c6bd36720a2d0c29bc2777786"
            text="(f77d91c)"
          />
        </li>
      </ul>
      <h3>Features</h3>
      <ul>
        <li>
          <strong>achievement:</strong> add achievement module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/9aa9b9d62e90f2dae2e5d70ea47aa14328033587"
            text="(9aa9b9d)"
          />
        </li>
        <li>
          <strong>currency:</strong> add currency module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/9195ec061bd24a5afa978c4262a0e9349ca3ac46"
            text="(9195ec0)"
          />
        </li>
        <li>
          <strong>exporter:</strong> add missing dbc export function
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/c4b2ede64aa7c8697458564c434f8fd15c8c8caf"
            text="(c4b2ede)"
          />
        </li>
        <li>
          <strong>item extended cost:</strong> add item extended cost module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/fceb14b9ba41240975064426c53798614add5c8e"
            text="(fceb14b)"
          />
        </li>
        <li>
          <strong>page text:</strong> add page text module and related
          components
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/8fc099cfd82b3e37a8ecab8e3b70d8c31c3a2b50"
            text="(8fc099c)"
          />
        </li>
        <li>
          <strong>quest offer reward localizer:</strong> add quest offer reward
          localizer
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/402761cb3e18e68756c23dca17d8ae4bb0d23a36"
            text="(402761c)"
          />
        </li>
        <li>
          <strong>quest request items localizer:</strong> add quest request
          items localizer
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/3529f012da16edf7b6975c7d09e38c591a7828f8"
            text="(3529f01)"
          />
        </li>
      </ul>
    </el-card>
    <el-card style="margin-top: 16px">
      <div slot="header">
        <h2>0.2.3 <small>2021-08-11</small></h2>
      </div>
      <h3>Bug Fixes</h3>
      <ul>
        <li>
          <strong>calculate max height:</strong> fix client height undefined
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/00a52e86339e7e00176f956f964628bcb246f5c5"
            text="(00a52e8)"
          ></clickable-span>
        </li>
        <li>
          <strong>developer:</strong> make button triggable
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/2ee2d4549ee9a344cb222fef1e8838318a7e0c87"
            text="(2ee2d45)"
          ></clickable-span>
        </li>
        <li>
          <strong>loot view:</strong> adjust margin and max height to all loot
          view
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/7ee55d7c643e9a47a73c4064f55ec5fe4ee6f65a"
            text="(7ee55d7)"
          ></clickable-span>
        </li>
        <li>
          <strong>size:</strong> make size effect in mysql selection
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/97dd09057ea17f1f114f75bc3bec65972f8d3177"
            text="(97dd090)"
          ></clickable-span>
        </li>
        <li>
          <strong>size:</strong> rename per page to size
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/8e97bce932fedf99c51260f5007c1407a236f5d7"
            text="(8e97bce)"
          ></clickable-span>
        </li>
      </ul>
      <h3>Features</h3>
      <ul>
        <li>
          <strong>advance config:</strong> add advance config view
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/420220bb58eb38f3cbb1d67613a5a3883ee41b6c"
            text="(420220b)"
          ></clickable-span>
        </li>
        <li>
          <strong>footer:</strong> some view add footer to make card fixed
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/4b35b39e8e5afde277e9e8d58bfcf5025334f44d"
            text="(4b35b39)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell:</strong> adjust some inputs' type
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/1f3086afc9562cab29c6272b57b098aa45aba3c0"
            text="(1f3086a)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell category:</strong> add spell category selector
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/58a93b37899c9c66640c35b02876a9220af708e1"
            text="(58a93b3)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell description variable:</strong> add spell description
          variable selector
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/db7e6d447faebdc7b7ae7647c329f108cff2e32a"
            text="(db7e6d4)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell difficulty:</strong> add spell difficulty selector
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/028222f1c9a69a862f0fbc440c1bf09ee38f0c6e"
            text="(028222f)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell dispel type:</strong> load dispel types from dbc instead
          of constants
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/9d26e6011907fc4f655f169e88bb2cd1857aaac4"
            text="(9d26e60)"
          ></clickable-span>
        </li>
        <li>
          <strong>tab:</strong> add max height to all tab view
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/ec7bc49fa3d8bf03ee8b360e1d1b27cb7dc36955"
            text="(ec7bc49)"
          ></clickable-span>
        </li>
        <li>
          <strong>table:</strong> add max height to all table view
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/8d723a4861dab830d3952b3a367653a2c85bb824"
            text="(8d723a4)"
          ></clickable-span>
        </li>
      </ul>
    </el-card>
    <el-card style="margin-top: 16px">
      <div slot="header">
        <h2>0.2.2 <small>2021-07-30</small></h2>
      </div>
      <h3>Bug Fixes</h3>
      <ul>
        <li>
          <strong>icon:</strong> fix padding between icon and label in table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/4cef4159659f6b98caa159c82d748489a9eec47f"
            text="(4cef415)"
          ></clickable-span>
        </li>
        <li>
          <strong>talent:</strong> fix update talent<clickable-span
            url="https://github.com/CalsRanna/foxy/commit/6f73aa2b23ce4fd2c80d7b98eda0a1da8eb09a96"
            text="(6f73aa2)"
          ></clickable-span>
        </li>
      </ul>
      <h3>Features</h3>
      <ul>
        <li>
          <strong>spell selector:</strong> add name subtext in table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/16e7668f2ecbb1ca68e52a4ca70c6b61de3e2e7a"
            text="(16e7668)"
          ></clickable-span>
        </li>
        <li>
          <strong>updater:</strong> redesign updater to make tips more
          conspicuous
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/e67b827bc3bfaee02d81b8d201f539895211e55b"
            text="(e67b827)"
          ></clickable-span>
        </li>
      </ul>
    </el-card>
    <el-card style="margin-top: 16px">
      <div slot="header">
        <h2>0.2.1 <small>2021-07-14</small></h2>
      </div>
      <h3>Bug Fixes</h3>
      <ul>
        <li>
          remove unused api and view
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/f59d413cad86e7a40831e134628763ff975cc24f"
            text="(f59d413)"
          ></clickable-span>
        </li>
        <li>
          <strong>el-card:</strong> fix padding of el-card body when has form
          item component
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/2b0901f058afc7d7bbadf39273d243e5e833581a"
            text="(2b0901f)"
          ></clickable-span>
        </li>
        <li>
          <strong>el-tabs:</strong> remove el-card which warp el-tabs
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/a6adf376cdc23c89fbb3aca4826387896c694d81"
            text="(a6adf37)"
          ></clickable-span>
        </li>
        <li>
          <strong>exporter:</strong> fix export spell item enchantment
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/e0bc58b23fdd8fabf12e969c6f74d4ad065a72a5"
            text="(e0bc58b)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell:</strong> add option to mechanic select
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/5c8979d9d9d8003639b169bdbb304edd2b7c7a00"
            text="(5c8979d)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell item enchantment:</strong> adjust type of form item
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/e4f4b409d6b097bfd29821c711620d77f030859b"
            text="(e4f4b40)"
          ></clickable-span>
        </li>
        <li>
          <strong>table:</strong> remove sortable of all table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/6455ffe9166655c892db52c087ccf8a009da4e27"
            text="(6455ffe)"
          ></clickable-span>
        </li>
      </ul>
      <h3>Features</h3>
      <ul>
        <li>
          make searching by primary key precisely
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/38db8ca2dac1265c49f92d87588962c70e3e8a1d"
            text="(38db8ca)"
          ></clickable-span>
        </li>
        <li>
          <strong>broadcast text:</strong> add broadcast text selector
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/44339ba5ba746dcc1cfe47be9b6fdb451f6ff0fe"
            text="(44339ba)"
          ></clickable-span>
        </li>
        <li>
          <strong>exporter:</strong> add missing dbc exports
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/5602710c1dcbadd6ad8748099c63083acbe9dae7"
            text="(5602710)"
          ></clickable-span>
        </li>
        <li>
          <strong>item enchantment:</strong> add tag to table and selector
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/b1d5938566ae6ee575807c4b426b961a8dd4a683"
            text="(b1d5938)"
          ></clickable-span>
        </li>
        <li>
          <strong>loot template:</strong> add entry column
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/42b139a0fc9625c6c2cb3f42253832da2a4d6f9b"
            text="(42b139a)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell item enchantment:</strong> add export of spell item
          enchantment
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/0095309253b6efa856306d40c0e1f3df751a6ca2"
            text="(0095309)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell item enchantment:</strong> add spell item enchantment
          module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/67e0164e630cc6fb5c4ee1bf0607308087077c3e"
            text="(67e0164)"
          ></clickable-span>
        </li>
      </ul>
    </el-card>
    <el-card style="margin-top: 16px">
      <div slot="header">
        <h2>0.2.0 <small>2021-06-30</small></h2>
      </div>
      <h3>Features</h3>
      <ul>
        <li>
          <strong>area table:</strong> add area table module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/d9ded1949961738f57d4fa2d8a2be0eca7adfb30"
            text="(d9ded19)"
          ></clickable-span>
        </li>
        <li>
          <strong>area table or quest sort:</strong> add area table or quest
          sort selector
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/fe10d6266c21729b3a9a0e94fe647d6237d867ce"
            text="(fe10d62)"
          ></clickable-span>
        </li>
        <li>
          <strong>char title:</strong> add char title selector
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/fc490283258cef0f0e63efc12f3e1324c3078211"
            text="(fc49028)"
          ></clickable-span>
        </li>
        <li>
          <strong>emote:</strong> add emote selector
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/ea7e20b65da97aa7fb58b225b43393726b93e1e2"
            text="(ea7e20b)"
          ></clickable-span>
        </li>
        <li>
          <strong>emote text:</strong> add emote text module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/63437074c1e4ffe0be38377558d8feb2c443f350"
            text="(6343707)"
          ></clickable-span>
        </li>
        <li>
          <strong>game object:</strong> add game object display info selector
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/73f2ec3ec4df77d1a5341c99957f6ed4af369391"
            text="(73f2ec3)"
          ></clickable-span>
        </li>
        <li>
          <strong>map:</strong> add map selector
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/ab5daa0850244ea6122419bd825fc77cef604f01"
            text="(ab5daa0)"
          ></clickable-span>
        </li>
        <li>
          <strong>quest faction reward:</strong> add quest faction reward module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/1dd600efc036538aafdd50e8dcc93c7337c529aa"
            text="(1dd600e)"
          ></clickable-span>
        </li>
        <li>
          <strong>quest info:</strong> add quest info module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/587b308334038afb0f1387aee351a9c82f8dc1a3"
            text="(587b308)"
          ></clickable-span>
        </li>
        <li>
          <strong>quest info:</strong> add quest info selector
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/c2fb3fbca574a31b4234250f96ec354eba9d7d14"
            text="(c2fb3fb)"
          ></clickable-span>
        </li>
        <li>
          <strong>quest sort:</strong> add quest sort module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/40f151195cd3587d6f3d05b3883ab67f7f45a612"
            text="(40f1511)"
          ></clickable-span>
        </li>
      </ul>
    </el-card>
    <el-card style="margin-top: 16px">
      <div slot="header">
        <h2>0.1.9 <small>2021-06-29</small></h2>
      </div>
      <h3>Bug Fixes</h3>
      <ul>
        <li>
          <strong>flag editor:</strong> fix table display in dialog when has
          long content
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/1df210b61ee6387d8f6074644440a4e13e3e2642"
            text="(1df210b)"
          >
          </clickable-span>
        </li>
        <li>
          <strong>item display info selector:</strong> fix inventory icon input
          type to text instead of number
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/46635310f619b03f98f820a9672928edc7143e1b"
            text="(4663531)"
          >
          </clickable-span>
        </li>
        <li>
          <strong>localizer:</strong> fix overflow and max height of table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/425aa0cd88835f009f284b89b516aed909adc243"
            text="(425aa0c)"
          >
          </clickable-span>
        </li>
        <li>
          <strong>selector:</strong> fix overflow and max height of table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/55cf71d43cb10bf45ca31595eb0df7e38f98d455"
            text="(55cf71d)"
          >
          </clickable-span>
        </li>
      </ul>
      <h3>Features</h3>
      <ul>
        <li>
          <strong>faction selector:</strong> add faction selector
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/8f58c83839160257819e29d06ae5454b2e651583"
            text="(8f58c83)"
          >
          </clickable-span>
        </li>
        <li>
          <strong>localizer:</strong> split fields into single localizer
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/9c91241d805c91ad1aee3bf6f5d1e4ef29d0e144"
            text="(9c91241)"
          >
          </clickable-span>
        </li>
        <li>
          <strong>lock:</strong> build lock selector
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/de5375615b3dd075fc50661e92f36d1c573df104"
            text="(de53756)"
          >
          </clickable-span>
        </li>
      </ul>
    </el-card>
    <el-card style="margin-top: 16px">
      <div slot="header">
        <h2>0.1.8 <small>2021-06-01</small></h2>
      </div>
      <h3>Bug Fixes</h3>
      <ul>
        <li>
          <strong>item template name:</strong> fix name of inventory icon to fit
          icons in disk
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/9d55f4edcd6f3bbfdb7d57aa83a3083064fc04b6"
            text="(9d55f4e)"
          ></clickable-span>
        </li>
        <li>
          <strong>item template name:</strong> fix padding between icon and name
          to keep same when display chinese and original name
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/b08413435dff4f0d1b5b69600b63866a84f561bc"
            text="(b084134)"
          ></clickable-span>
        </li>
        <li>
          <strong>version:</strong> fix new version shown when has no new
          version
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/ba0ea8f3d1d0b7fedcd79cb4f568da2eff3c1379"
            text="(ba0ea8f)"
          ></clickable-span>
        </li>
      </ul>
      <h3>Features</h3>
      <ul>
        <li>
          <strong>chr class:</strong> add chr class editor
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/da917a5a8c75aae1e6b53ce2172ce8b142c6cd0e"
            text="(da917a5)"
          ></clickable-span>
        </li>
        <li>
          <strong>chr race:</strong> add chr race editor
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/502c329ea61cb8f653fdeb5e3eb18421c2b2f5ec"
            text="(502c329)"
          ></clickable-span>
        </li>
        <li>
          <strong>dashboard:</strong> make card clickable
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/39a2a75826232f274f81cbb32cc47fea41cfa1a0"
            text="(39a2a75)"
          ></clickable-span>
        </li>
        <li>
          <strong>reference loot template:</strong> add reference loot tempalte
          module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/f70d6942fd3a018214ca3929c26548aa2bb081da"
            text="(f70d694)"
          ></clickable-span>
        </li>
        <li>
          <strong>scaling stat values:</strong> add scaling stat values module
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/ded73476b60aefb178bd3e0ab0b679c85e83cf6e"
            text="(ded7347)"
          ></clickable-span>
        </li>
        <li>
          <strong>selector:</strong> add loading while searching and use enter
          key to search
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/621b1a2f6eec72264ba17190502ae91d00d58789"
            text="(621b1a2)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell icon selector:</strong> add spell icon selector
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/87b713021fc93830d66ddd85f1d666640f7d7587"
            text="(87b7130)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell name:</strong> add icon to spell name
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/192624828966a0b4b9c209cda6296550597af292"
            text="(1926248)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell selector:</strong> add icon display in table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/0140fa59f6659b734b13b57fc5938a04cd71d756"
            text="(0140fa5)"
          ></clickable-span>
        </li>
      </ul>
    </el-card>
    <el-card style="margin-top: 16px">
      <div slot="header">
        <h2>0.1.7 <small>2021-05-27</small></h2>
      </div>
      <h3>Bug Fixes</h3>
      <ul>
        <li>
          <strong>app:</strong> fix active view while reloading app
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/c8ccc5faa54c51ab1a79441e33d97ff69a58863b"
            text="(c8ccc5f)"
          ></clickable-span>
        </li>
        <li>
          <strong>creature:</strong> use mechanics from dbc instead of constant
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/4d5b0c7439f8ae29d4e34a1d2e847a366da9677d"
            text="(4d5b0c7)"
          ></clickable-span>
        </li>
        <li>
          <strong>error:</strong> set timeout to 1000ms
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/03a1514ea8f145880b43ce1cfec219544f08c8eb"
            text="(03a1514)"
          ></clickable-span>
        </li>
        <li>
          <strong>error:</strong> show error only once when serval same errors
          occurred
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/da4c941edab0336f44a8898ca585d5dc4df00f56"
            text="(da4c941)"
          ></clickable-span>
        </li>
        <li>
          <strong>game object loot template:</strong> fix searching game object
          loot template when game object has loot template
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/0fc06ec483f908f25ec24036ffd7cbf5cb5f2797"
            text="(0fc06ec)"
          ></clickable-span>
        </li>
        <li>
          <strong>item template name:</strong> fix img and span display error
          when has no icon or long name
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/e574252772d8a9b58b12e2c7e43f6a2a44fa304f"
            text="(e574252)"
          ></clickable-span>
        </li>
        <li>
          <strong>localizer:</strong> remove display entry or id from localizer
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/47a124f16db39d6dc65bc396939722faa91aa44e"
            text="(47a124f)"
          ></clickable-span>
        </li>
        <li>
          <strong>setting:</strong> fix setting active tab when init and reload
          view
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/503568bfc5b69d3ea1157726a331b47a8c7f9ace"
            text="(503568b)"
          ></clickable-span>
        </li>
        <li>
          <strong>sql:</strong> fix charset and collate when init loading dbc
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/eca773dbb9c40a797b8035f3b2bd0d2a5826c501"
            text="(eca773d)"
          ></clickable-span>
        </li>
      </ul>
      <h3>Features</h3>
      <ul>
        <li>
          <strong>creature equipment template:</strong> add icon display in
          table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/ee9e9cedfde0779594b9c1f87c78319747af2ff3"
            text="(ee9e9ce)"
          ></clickable-span>
        </li>
        <li>
          <strong>creature loot template:</strong> add icon display in table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/4943cc2acdce5e353028560b5cf61b1726e94030"
            text="(4943cc2)"
          ></clickable-span>
        </li>
        <li>
          <strong>creature quest item:</strong> add icon display in table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/c1ee32c19eb928086a6886e53182aa56dcae8aa8"
            text="(c1ee32c)"
          ></clickable-span>
        </li>
        <li>
          <strong>disenchant loot template:</strong> add icon display in table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/d18d2ab97b8d4f6d8b2ed7bd1e82c138c8a4c11e"
            text="(d18d2ab)"
          ></clickable-span>
        </li>
        <li>
          <strong>game object loot template:</strong> add icon display in table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/80bbae96be3cf5d346d09f62596b3ab62c54ecf8"
            text="(80bbae9)"
          ></clickable-span>
        </li>
        <li>
          <strong>game object quest item:</strong> add icon display in table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/d6b47af00e69bdd9c33958a22b374a6524c5d759"
            text="(d6b47af)"
          ></clickable-span>
        </li>
        <li>
          <strong>item:</strong> add item icon in item template name component
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/6c1654fb6b52f43a0678450a6f2aa4be999df41b"
            text="(6c1654f)"
          ></clickable-span>
        </li>
        <li>
          <strong>item loot template:</strong> add icon display in table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/82f869600fd9e039538e9ca15b0c19a1c57bbf3a"
            text="(82f8696)"
          ></clickable-span>
        </li>
        <li>
          <strong>item template selector:</strong> add icon display in table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/b0ebf5c063e0aba10914989751c86167815e1a1d"
            text="(b0ebf5c)"
          ></clickable-span>
        </li>
        <li>
          <strong>milling loot template:</strong> add icon display in table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/12040233c8a87eb3af5c08b5d98c1b81c2598e73"
            text="(1204023)"
          ></clickable-span>
        </li>
        <li>
          <strong>mysql connection:</strong> add port to mysql connection
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/1ad7b0fcdd38fc81ca737d58dfef17dbc0d2185c"
            text="(1ad7b0f)"
          ></clickable-span>
        </li>
        <li>
          <strong>npc vendor:</strong> add icon display in table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/dd39d8e34634fc70431121efb5104903e2472ff7"
            text="(dd39d8e)"
          ></clickable-span>
        </li>
        <li>
          <strong>pickpocketing loot template:</strong> add icon display in
          table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/5c476b10c8c972869c116ef076c5501f9f69b7af"
            text="(5c476b1)"
          ></clickable-span>
        </li>
        <li>
          <strong>prospecting loot template:</strong> add icon display in table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/45a6de2e360a02f5f668cc0491752b0f5490c861"
            text="(45a6de2)"
          ></clickable-span>
        </li>
        <li>
          <strong>reference loot template:</strong> add icon display in table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/f9d7a2338112912d348078c62cce8e9f1ea62eb3"
            text="(f9d7a23)"
          ></clickable-span>
        </li>
        <li>
          <strong>skinning loot template:</strong> add icon display in table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/583545f7b6cf1193c30c26b324da505c81a23b2d"
            text="(583545f)"
          ></clickable-span>
        </li>
        <li>
          <strong>spell loot template:</strong> add icon display in table
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/fb898838b869b6d8d11752a63cc71da1a233db8a"
            text="(fb89883)"
          ></clickable-span>
        </li>
      </ul>
    </el-card>
    <el-card style="margin-top: 16px">
      <div slot="header">
        <h2>0.1.6 <small>2021-05-10</small></h2>
      </div>
      <h3>Bug Fixes</h3>
      <ul>
        <li>
          <strong>spell:</strong> fix mechanics didn't work properly
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/99d7e28e87f83246ef194c65683c85fcc604958e"
            text="(99d7e28)"
          ></clickable-span>
        </li>
      </ul>
      <h3>Features</h3>
      <ul>
        <li>
          <strong>about:</strong> add about view
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/f18f2adbfd7cdb2f265c2babf07c35e5005c3d2b"
            text="(f18f2ad)"
          ></clickable-span>
        </li>
        <li>
          <strong>initiator:</strong> build a new initiator instead of inline
          dialog
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/59127b9fc9a29d11b8f44fe4db031d5efaf471da"
            text="(59127b9)"
          ></clickable-span>
        </li>
        <li>
          <strong>version:</strong> use state of version instead of data in
          component
          <clickable-span
            url="https://github.com/CalsRanna/foxy/commit/920026d46b3cdfa08fd5807f7b3fb785e758d5e9"
            text="(920026d)"
          ></clickable-span>
        </li>
      </ul>
    </el-card>
    <el-card style="margin-top: 16px">
      <div slot="header">
        <h2>0.1.5 <small>2021-05-09</small></h2>
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
import { mapState } from "vuex";
import ClickableSpan from "@/components/ClickableSpan";
export default {
  computed: {
    ...mapState("app", ["clientHeight"]),
  },
  methods: {
    openBrowser(url) {
      const shell = window.shell;
      shell.openExternal(url);
    },
    calculateMaxHeight() {
      return this.clientHeight - 154;
    },
  },
  components: {
    ClickableSpan,
  },
};
</script>

<style scoped>
.changelog h1,
h2 {
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
