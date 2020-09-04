<template>
  <div class="wrapper">
    <parallax class="section page-header header-filter" :style="headerStyle" >
      <div class="container" >
        <div class="md-layout">
          
          <div 
            class="md-layout-item md-size-50 md-small-size-70 md-xsmall-size-100"
          >
            <h1
              class="title"
              style="font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;"
            >
              관심 지역
            </h1>

            <h4>
              {{ $store.state.userInfo.id }}님의 관심지역
            </h4>
            <br />
          </div>
        </div>
      </div>
    </parallax>
    <div class="main main-raised" >
      <nav-tabs-card no-label tabs-plain >
        <template slot="content">
          <md-tabs class="md-primary" md-alignment="left">
            <md-tab id="tab-home" md-label="내 관심지역">
              <div class="section">
                <div class="features text-center">

                  <div class="md-layout">
                    <h3  v-if="$store.state.userInfo.id == null"> {{ loginneed() }}</h3>
                    <div
                      class="md-layout-item md-large-size md-medium-size-100"
                     v-if="$store.state.userInfo.id != null">
                      <list />


                      <br /><br />
                    <div class="md-layout-item md-large-size md-medium-size-100" style="float:left;width: 50%">
                      <div id="insertform" v-show="isInsert" >
                        <md-field>
                          <md-select
                            v-model="city"
                            class="md-primary md-m"
                            placeholder="== 시 선택 =="
                            ref="city"
                          >
                            <md-option value="서울">서울</md-option>
                          </md-select>
                          <md-select
                            v-model="gu"
                            class="md-primary md-m"
                            placeholder="== 구군 선택 =="
                            ref="gu"
                          >
                            <md-option value="종로구">종로구</md-option>
                          </md-select>
                          <md-select
                            v-model="dong"
                            class="md-primary md-m"
                            placeholder="== 동 선택 =="
                            ref="dong"
                          >
                            <md-option v-for="(dongitem, index) in dongitems" :value="dongitem" :key="index + '_dongitems'">
                              {{ dongitem }}
                            </md-option>

                          </md-select>
                        </md-field>
                      </div>

                      <div style="text-align: center;">
                        <md-button
                          class="md-primary md-round "
                          target="_blank"
                          @click="insertOpen"
                          style=""
                        >
                          등록</md-button
                        >
                      </div>

                        &nbsp;&nbsp;&nbsp;

                        <md-button
                          v-if="isInsert == true"
                          class="md md-round "
                          target="_blank"
                          @click="insertHide"
                        >
                          취소</md-button
                        >
                      </div>
                    </div>
                    <!-- <div
                      class="md-layout-item md-large-size md-medium-size-100"
                    >
                      <fav-map />
                    </div> -->
                  </div>
                </div>
              </div>
            </md-tab>

            <md-tab id="tab-pages" md-label="관심지역 상권">
              <br />
              <div class="section">
                <div class="features text-center">
                  <div class="md-layout">
                    <div class="md-layout-item md-small-size md-small-size-100">
                      <comm-list />
                    </div>
                    <!-- <div
                      class="md-layout-item md-large-size md-medium-size-100"
                    >
                      <comm-map />
                    </div> -->
                  </div>
                </div>
              </div>
            </md-tab>

            <!-- <md-tab id="tab-posts" md-label="History">
                  <p>
                    I think that’s a responsibility that I have, to push
                    possibilities, to show people, this is the level that things
                    could be at. I will be the leader of a company that ends up
                    being worth billions of dollars, because I got the answers.
                    I understand culture. I am the nucleus. I think that’s a
                    responsibility that I have, to push possibilities, to show
                    people, this is the level that things could be at.
                  </p>
                </md-tab> -->
          </md-tabs>
        </template>
      </nav-tabs-card>
    </div>
  </div>
</template>

<script>
import { NavTabsCard } from "@/components";
import store from "@/store/store.js";

import { mapGetters, mapActions, mapState } from "vuex";
import List from "@/components/fav/List.vue";
import CommList from "@/components/fav/CommList.vue";

import http from "@/util/http-common";

export default {
  bodyClass: "profile-page",
  components: {
    NavTabsCard,
    List,
    CommList,
  },
  props: {
    header: {
      type: String,
      default: require("@/assets/img/vue-mk-menu.jpg")
    }
  },
  created() {
    store.dispatch("getFavitems", "/fav/" + this.$store.state.userInfo.id);
    store.dispatch("getCommitems", "/comm");
    store.dispatch("getDongitems");
  },
  data() {
    return {
      isInsert: false,
      userid: null,
      dong: "",
      city: "",
      gu: ""
    };
  },
  computed: {
    ...mapGetters(["dongitems"]),
    headerStyle() {
      return {
        backgroundImage: `url(${this.header})`
      };
    }
  },
  methods: {
    loginneed(){
      alert("로그인이 필요합니다");
      this.$router.push('/');
    },
    insertOpen() {
      if (this.isInsert == false) {
        this.isInsert = true;
      } else {
        // 등록
        // 빈칸 체크
        this.blankCheck();

        http
          .post(`/fav/add`, {
            userid: this.$store.state.userInfo.id,
            dong: this.dong,
            gu: this.gu,
            city: this.city
          })

          .then(({ data }) => {
            alert("등록이 완료되었습니다.");
          })
          .catch(() => {
            alert("등록 처리시 에러가 발생했습니다.");
          })
          .finally(() => {
            // 목록 새로고침
            store.dispatch("getFavitems", '/fav/' + this.$store.state.userInfo.id);
          });
        this.isInsert = false;
        this.city = "";
        this.gu = "";
        this.dong = "";
      }
    },
    insertHide(){
      this.isInsert = false;
      this.city = "";
      this.gu = "";
      this.dong = "";
    },
    blankCheck() {
      let err = true;
      let msg = "";
      !this.city &&
        ((msg = "시를 선택해 주세요"),
        (err = false),
        alert(msg),
        this.$refs.city.focus());
      err &&
        !this.gu &&
        ((msg = "구군을 선택해 주세요"),
        alert(msg),
        (err = false),
        this.$refs.gu.focus());
      err &&
        !this.dong &&
        ((msg = "동을 선택해 주세요"),
        alert(msg),
        (err = false),
        this.$refs.dong.focus());
    }
  }
};
</script>

<style lang="scss" scoped>
.md-card-actions.text-center {
  display: flex;
  justify-content: center !important;
}
.contact-form {
  margin-top: 30px;
}

.md-has-textarea + .md-layout {
  margin-top: 15px;
}
</style>
