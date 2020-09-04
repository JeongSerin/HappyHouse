<template>
  <div class="wrapper">
    <div class="section page-header header-filter" :style="headerStyle">
      <div class="container">
        <div class="md-layout">
          <div
            class="md-layout-item md-size-33 md-small-size-66 md-xsmall-size-100 md-medium-size-40 mx-auto"
          >
            <login-card header-color="green">
              <h4 slot="title" class="card-title">Sign up</h4>
              <p slot="description" class="description">Or Be Classical</p>
              <md-field class="md-form-group" slot="inputs">
                <md-icon>mood</md-icon>
                <label>ID...</label>
                <md-input v-model="id"></md-input>
              </md-field>
              <md-field class="md-form-group" slot="inputs">
                <md-icon>lock_outline</md-icon>
                <label>Password...</label>
                <md-input v-model="pw"></md-input>
              </md-field>
              <md-field class="md-form-group" slot="inputs">
                <md-icon>face</md-icon>
                <label>Name...</label>
                <md-input v-model="name"></md-input>
              </md-field>
              <md-field class="md-form-group" slot="inputs">
                <md-icon>how_to_reg</md-icon>
                <label>Nick Name...</label>
                <md-input v-model="nickname"></md-input>
              </md-field>
              <md-field class="md-form-group" slot="inputs">
                <md-icon>email</md-icon>
                <label>Email...</label>
                <md-input v-model="email" type="email"></md-input>
              </md-field>
              <md-field class="md-form-group" slot="inputs">
                <md-icon>location_city</md-icon>
                <label>Address...</label>
                <md-input v-model="address"></md-input>
              </md-field>
              <md-field class="md-form-group" slot="inputs">
                <md-icon>alternate_email</md-icon>
                <label>Homepage URL...</label>
                <md-input v-model="homepage"></md-input>
              </md-field>
              <md-field class="md-form-group" slot="inputs">
                <md-icon>directions_bike</md-icon>
                <label>hobby...</label>
                <md-input v-model="hobby"></md-input>
              </md-field>
              <md-button slot="footer" class="md-simple md-success md-lg" 
                @click="checkHandler"
              >
                가입하기
              </md-button>
            </login-card>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { LoginCard } from "@/components";

import http from '@/util/http-common';

export default {
  components: {
    LoginCard
  },
  bodyClass: "login-page",
  data() {
    return {
      id: null,
      pw: null,
      name: null,
      nickname: null,
      email: null,
      homepage: null,
      address: null,
      hobby: null
    };
  },
  props: {
    header: {
      type: String,
      default: require("@/assets/img/city.jpg")
    }
  },
  computed: {
    headerStyle() {
      return {
        backgroundImage: `url(${this.header})`
      };
    }
  },
  methods: {
    checkHandler() {
      let err = true;
      let msg = '';
        !this.id &&
        ((msg = '아이디를 입력해주세요'),
        (err = false), this.$refs.id.focus());
      err &&
        !this.pw &&
        ((msg = '비밀번호를 입력해주세요'),
        (err = false), this.$refs.pw.focus());
      err &&
        !this.name &&
        ((msg = '이름을 입력해주세요'),
        (err = false), this.$refs.name.focus());
      err &&
        !this.nickname &&
        ((msg = '닉네임을 입력해주세요'),
        (err = false), this.$refs.nickname.focus());
      err &&
        !this.email &&
        ((msg = '이메일을 입력해주세요'),
        (err = false), this.$refs.email.focus());
      err &&
        !this.address &&
        ((msg = '주소를 입력해주세요'),
        (err = false), this.$refs.address.focus());
      err &&
        !this.homepage &&
        ((msg = '홈페이지 URL을 입력해주세요'),
        (err = false), this.$refs.homepage.focus());
      err &&
        !this.hobby &&
        ((msg = '취미를 입력해주세요'),
        (err = false), this.$refs.hobby.focus());

      if (!err) alert(msg);
      else this.createHandler();
    },
    createHandler() {
      http
        .post('/user', {
          id: this.id,
          pw: this.pw,
          name: this.name,
          nickname: this.nickname,
          email: this.email,
          address: this.address,
          homepage: this.homepage,
          hobby: this.hobby
        })
        .then(({ data }) => {
          let msg = '가입 처리시 문제가 발생했습니다.';
          if (data === 'success') {
            msg = '회원가입이 완료되었습니다.';
          }
          alert(msg);
          this.moveList();
        })
        .catch(() => {
          alert('가입 처리시 에러가 발생했습니다.');
        });
    },
    moveList() {
      this.$router.push('/');
    },
  }
};
</script>

<style lang="css"></style>
