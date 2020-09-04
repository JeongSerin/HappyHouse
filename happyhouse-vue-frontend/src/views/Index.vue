<template>
  <div class="wrapper">
    <parallax class="page-header header-filter" :style="headerStyle">
      <div class="md-layout">
        <div class="md-layout-item">
          <div class="image-wrapper">
            <div class="brand">
              <h1>Happy House:)</h1>
              <h3>Find Your Dream House</h3>
            </div>
          </div>
        </div>
      </div>
    </parallax>
    
    <div class="main main-raised">

      <!-- 로그인 모달 창 -->
      <modal v-if="$store.state.loginModal" @close="$store.state.loginModal = false">
        <template slot="header">
          <br />
          <md-button
            class="md-simple md-just-icon md-round modal-default-button"
            @click="$store.state.loginModal = false"
          >
            <md-icon>clear</md-icon>
          </md-button>
        </template>

        <template slot="body">
          <login-card header-color="green" v-if="!findpwd">
            <h4 slot="title" class="card-title">Login</h4>
            <p slot="description" class="description">Or Be Classical</p>
            
              <md-field class="md-form-group" slot="inputs">
                <md-icon>face</md-icon>
                <label>ID...</label>
                <md-input v-model="id"></md-input>
              </md-field>
              <md-field class="md-form-group" slot="inputs">
                <md-icon>lock_outline</md-icon>
                <label>Password...</label>
                <md-input v-model="pw" type="password"></md-input>
              </md-field>
            
            <md-button @click="goLogin" slot="footer" class="md-simple md-success md-lg">
              로그인
            </md-button>
          </login-card>

          <!-- 비밀번호 찾기 -->
          <login-card header-color="yellow" v-else>
            <h4 slot="title" class="card-title">Forgot Password?</h4>
            <p slot="description" class="description">Or Be Classical</p>
            
              <md-field class="md-form-group" slot="inputs">
                <md-icon>face</md-icon>
                <label>ID...</label>
                <md-input v-model="id"></md-input>
              </md-field>
            
            <md-button @click="findPwd" slot="footer" class="md-simple md-info md-lg">
              비밀번호 찾기
            </md-button>
          </login-card>
        </template>

        <template slot="footer" v-if="!findpwd">
          <md-button class="md-simple" @click="showFindpwd">비밀번호 찾기</md-button>
          <md-button
            class="md-danger md-simple"
            @click="$store.state.loginModal = false"
            >Close</md-button
          >
        </template>

        <template slot="footer" v-else>
          <md-button class="md-simple md-success" @click="hideFindpwd">로그인하러 가기</md-button>
          <md-button
            class="md-danger md-simple"
            @click="$store.state.loginModal = false"
            >Close</md-button
          >
        </template>
      </modal>
      
      <!-- 주택 정보 -->
      <div class="section">

        <!-- 지도 -->
        <map-view />

        <div class="container-fluid">
          <div class="md-layout">
            <div class="md-layout-item md-size-5"></div>

            <!-- 왼쪽 표, 주택 거래 내역 목록 -->
            <div class="md-layout-item md-size-60 md-small-size-100">
              <house></house>
            </div>

            <!-- 오른쪽 표, 주택 거래 정보 -->
            <div class="md-layout-item md-size-30 md-small-size-100">
              <div class="md-layout-item md-size-100">
                <house-detail></house-detail>
              </div>
            </div>
            <div class="md-layout-item md-size-5"></div>
          </div>
        </div>  
      </div>
    </div>
  </div>
</template>

<script>
import { Modal } from "@/components";
import { LoginCard } from "@/components";
import House from "@/components/house/House.vue";
import HouseDetail from "@/components/house/HouseDetail.vue";
import MapView from "@/components/house/Map.vue";

import store from "@/store/store.js";
import { mapGetters, mapActions, mapState } from 'vuex';

export default {
  components: {
    LoginCard,
    Modal,
    House,
    HouseDetail,
    MapView
  },
  name: "index",
  bodyClass: "index-page",
  props: {
    image: {
      type: String,
      default: require("@/assets/img/vue-mk-header.jpg")
    }
  },
  data() {
    return {
      classicModal: false,
      findpwd: false,
      aptdeal: true,
      aptrent: true,
      housedeal: true,
      houserent: true,
      id: "",
      pw: "",
      foundpw: "",
    };
  },
  methods: {
    leafActive() {
      if (window.innerWidth < 768) {
        this.leafShow = false;
      } else {
        this.leafShow = true;
      }
    },
    goLogin(){
      store.dispatch('login', { id: this.id, pw: this.pw, url: '/' });
      // 오류 코드
      // store 의 commit 발생 전에 router.push 먼저 수행됨 (router 이동 후 store 변경됨)
      // store.dispatch('login', { userId: this.userId, pwd: this.pwd })
      // console.log(10)
      // router.push('/About')
      // console.log(11)
    },
    showFindpwd() {
      this.findpwd = true;
    },
    hideFindpwd() {
      this.findpwd = false;
    },
    findPwd() {
      store.dispatch('findpwd', `/user/` + this.id);
    },
  },
  created() {
    store.dispatch('getHousedealitems', '/house');
  },
  computed: {
    ...mapGetters(['foundUser']),
    headerStyle() {
      return {
        backgroundImage: `url(${this.image})`
      };
    },
    signupImage() {
      return {
        backgroundImage: `url(${this.signup})`
      };
    }
  },
  mounted() {
    this.leafActive();
    window.addEventListener("resize", this.leafActive);
  },
  beforeDestroy() {
    window.removeEventListener("resize", this.leafActive);
  }
};
</script>

<style lang="scss">
.section-download {
  .md-button + .md-button {
    margin-left: 5px;
  }
}

@media all and (min-width: 991px) {
  .btn-container {
    display: flex;
  }
}
</style>
