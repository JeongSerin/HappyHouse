<template>
  <div class="wrapper">
    <parallax
      class="section page-header header-filter"
      :style="headerStyle"
    >
          <div class="md-layout">
        <div class="md-layout-item">
          <div class="image-wrapper">
            <div class="brand">
              <h2 class="title">My page</h2>

            </div>
          </div>
        </div>
      </div>
    </parallax>
    <div class="main main-raised">
      <div class="section profile-content">
        <div class="container">
          <div class="md-layout">

            <h3  v-if="$store.state.userInfo.id == null"> {{ loginneed() }}</h3>

            <div class="md-layout-item md-size-50 mx-auto">
              <div class="profile">
                <div class="avatar">
                  <img
                    :src="img"
                    alt="Circle Image"
                    class="img-raised rounded-circle img-fluid"
                  />
                </div>
                <div class="name">
                  <h3 class="title" style="font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;">
                    {{ $store.state.userInfo.name }}</h3>
                  <h6 v-if="$store.state.userInfo.isAdmin === '0'">회원</h6>
                  <h6 v-if="$store.state.userInfo.isAdmin === '1'">관리자</h6>
                </div>
              </div>
            </div>
          </div>
          <div class="description text-center" v-if="$store.state.isLogin">
            <div class="section section-white">
              <div class="container">
                <div class="md-layout-item md-size-100">
                  <tabs
                    :tab-name="['회원정보 조회', '회원정보 수정', '회원 탈퇴']"
                    :tab-icon="['notes', 'create', 'sensor_door']"
                    plain
                    flex-column
                    nav-pills-icons
                    color-button="rose"
                  >
                    <!-- here you can add your content for tab-content -->
                    <!-- 조회 -->
                    <template slot="tab-pane-1">
                      <md-table>
                        <md-table-row>
                          <md-table-head md-numeric>ID</md-table-head>
                          <md-table-cell>{{ $store.state.userInfo.id }}</md-table-cell>
                        </md-table-row>

                        <md-table-row>
                          <md-table-head md-numeric>Password</md-table-head>
                          <md-table-cell>{{ $store.state.userInfo.pw }}</md-table-cell>
                        </md-table-row>

                        <md-table-row>
                          <md-table-head md-numeric>Name</md-table-head>
                          <md-table-cell>{{ $store.state.userInfo.name }}</md-table-cell>
                        </md-table-row>

                        <md-table-row>
                          <md-table-head md-numeric>NickName</md-table-head>
                          <md-table-cell>{{ $store.state.userInfo.nickname }}</md-table-cell>
                        </md-table-row>

                        <md-table-row>
                          <md-table-head md-numeric>Email</md-table-head>
                          <md-table-cell>{{ $store.state.userInfo.email }}</md-table-cell>
                        </md-table-row>

                        <md-table-row>
                          <md-table-head md-numeric>Address</md-table-head>
                          <md-table-cell>{{ $store.state.userInfo.address }}</md-table-cell>
                        </md-table-row>

                        <md-table-row>
                          <md-table-head md-numeric>Homepage</md-table-head>
                          <md-table-cell>{{ $store.state.userInfo.homepage }}</md-table-cell>
                        </md-table-row>

                        <md-table-row>
                          <md-table-head md-numeric>Hobby</md-table-head>
                          <md-table-cell>{{ $store.state.userInfo.hobby }}</md-table-cell>
                        </md-table-row>
                      </md-table>
                    </template>

                    <!-- 수정 전 -->
                    <template slot="tab-pane-2" v-if="wantUpdate">
                      <md-table>
                        <md-table-row>
                          <md-table-head md-numeric>ID</md-table-head>
                          <md-table-cell>{{ $store.state.userInfo.id }}</md-table-cell>
                        </md-table-row>

                        <md-table-row>
                          <md-table-head md-numeric>Password</md-table-head>
                          <md-table-cell>{{ $store.state.userInfo.pw }}</md-table-cell>
                        </md-table-row>

                        <md-table-row>
                          <md-table-head md-numeric>Name</md-table-head>
                          <md-table-cell>{{ $store.state.userInfo.name }}</md-table-cell>
                        </md-table-row>

                        <md-table-row>
                          <md-table-head md-numeric>NickName</md-table-head>
                          <md-table-cell>{{ $store.state.userInfo.nickname }}</md-table-cell>
                        </md-table-row>

                        <md-table-row>
                          <md-table-head md-numeric>Email</md-table-head>
                          <md-table-cell>{{ $store.state.userInfo.email }}</md-table-cell>
                        </md-table-row>

                        <md-table-row>
                          <md-table-head md-numeric>Address</md-table-head>
                          <md-table-cell>{{ $store.state.userInfo.address }}</md-table-cell>
                        </md-table-row>

                        <md-table-row>
                          <md-table-head md-numeric>Homepage</md-table-head>
                          <md-table-cell>{{ $store.state.userInfo.homepage }}</md-table-cell>
                        </md-table-row>

                        <md-table-row>
                          <md-table-head md-numeric>Hobby</md-table-head>
                          <md-table-cell>{{ $store.state.userInfo.hobby }}</md-table-cell>
                        </md-table-row>
                      </md-table>
                      <md-button slot="footer" class="md-primary" 
                        @click="changeView($store.state.userInfo.id,
                                           $store.state.userInfo.pw,
                                           $store.state.userInfo.name,
                                           $store.state.userInfo.nickname,
                                           $store.state.userInfo.email,
                                           $store.state.userInfo.address,
                                           $store.state.userInfo.homepage,
                                           $store.state.userInfo.hobby)"
                      >수정하기</md-button>
                    </template>

                    <!-- 수정 시 -->
                    <template slot="tab-pane-2" v-else>
                      <md-field md-clearable>
                        <label>ID</label>
                        <md-input v-model="updateId" ref="updateId"></md-input>
                      </md-field>
                      <md-field md-clearable>
                        <label>Password</label>
                        <md-input v-model="updatePw" ref="updatePw"></md-input>
                      </md-field>
                      <md-field md-clearable>
                        <label>Name</label>
                        <md-input v-model="updateName" ref="updateName"></md-input>
                      </md-field>
                      <md-field md-clearable>
                        <label>Nickname</label>
                        <md-input v-model="updateNickname" ref="updateNickname"></md-input>
                      </md-field>
                      <md-field md-clearable>
                        <label>Email</label>
                        <md-input v-model="updateEmail" ref="updateEmail"></md-input>
                      </md-field>
                      <md-field md-clearable>
                        <label>Address</label>
                        <md-input v-model="updateAddress" ref="updateAddress"></md-input>
                      </md-field>
                      <md-field md-clearable>
                        <label>Homepage</label>
                        <md-input v-model="updateHomepage" ref="updateHomepage"></md-input>
                      </md-field>
                      <md-field md-clearable>
                        <label>Hobby</label>
                        <md-input v-model="updateHobby" ref="updateHobby"></md-input>
                      </md-field>
                      <md-button slot="footer" class="md-rose" 
                        @click="doUpdate($store.state.userInfo.id)"
                      >
                        수정 완료
                      </md-button>
                      <md-button slot="footer" class="md-default" 
                        @click="cancel"
                      >
                        취소
                      </md-button>
                    </template>
                    
                    <!-- 탈퇴 -->
                    <template slot="tab-pane-3">
                      <md-button class="md-danger"
                        @click="deleteUser($store.state.userInfo.id)">
                        탈퇴하기
                      </md-button>
                    </template>
                  </tabs>
                </div>
              </div>
            </div>
          </div>
          <div class="description text-center" v-else>
            <h4>No User Info</h4>
          </div>
          <div class="profile-tabs">
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import store from "@/store/store.js";
import { Tabs } from "@/components";

import http from '@/util/http-common';

export default {
  components: {
    Tabs
  },
  bodyClass: "profile-page",
  data() {
    return {
      wantUpdate: true,
      updateId: "",
      updatePw: "",
      updateName: "",
      updateNickname: "",
      updateEmail: "",
      updateAddress: "",
      updateHomepage: "",
      updateHobby: ""
    };
  },
  props: {
    header: {
      type: String,
      default: require("@/assets/img/city-profile.jpg")
    },
    img: {
      type: String,
      default: require("@/assets/img/faces/character.jpg")
    }
  },
  computed: {
    headerStyle() {
      return {
        backgroundImage: `url(${this.header})`
      };
    }
  },
  created() {
  },
  methods: {
    loginneed(){
      alert("로그인이 필요합니다");
      this.$router.push('/');
    },
    changeView(id, pw, name, nickname, email, address, homepage, hobby) {
      this.wantUpdate = false;

      this.updateId = id,
      this.updatePw = pw,
      this.updateName = name,
      this.updateNickname = nickname,
      this.updateEmail = email,
      this.updateAddress = address,
      this.updateHomepage = homepage,
      this.updateHobby = hobby
    },
    cancel() {
      this.wantUpdate = true;
    },
    // 회원 정보 수정
    doUpdate(id) {
      this.blankCheck();

      http
        .put(`/user/${id}`, {
          id: this.updateId,
          pw: this.updatePw,
          name: this.updateName,
          nickname: this.updateNickname,
          email: this.updateEmail,
          address: this.updateAddress,
          homepage: this.updateHomepage,
          hobby: this.updateHobby
        })
        .then(({ data }) => {
          alert('수정이 완료되었습니다.');
          store.dispatch('userinfo', `/user/` + this.updateId);
          this.wantUpdate = true;
        })
        .catch(() => {
          alert('수정 처리시 에러가 발생했습니다.');
        });
    },
    // 회원 탈퇴
    deleteUser(id) {
      http
      .delete(`/user/` + id)
      .then(({ data }) => {
        alert('탈퇴가 완료되었습니다.');
        store.dispatch('logout', { url: '/' });
      })
      .catch(() => {
        alert('탈퇴 처리시 에러가 발생했습니다.');
      })
    },  
    // 빈칸 체크
    blankCheck(){
      let err = true;
      let msg = '';
        !this.updateId &&
        ((msg = '아이디를 입력해주세요'),
        (err = false), this.$refs.updateId.focus());
      err &&
        !this.updatePw &&
        ((msg = '비밀번호를 입력해주세요'),
        (err = false), this.$refs.updatePw.focus());
      err &&
        !this.updateName &&
        ((msg = '이름을 입력해주세요'),
        (err = false), this.$refs.updateName.focus());
      err &&
        !this.updateNickname &&
        ((msg = '닉네임을 입력해주세요'),
        (err = false), this.$refs.updateNickname.focus());
      err &&
        !this.updateEmail &&
        ((msg = '이메일을 입력해주세요'),
        (err = false), this.$refs.updateEmail.focus());
      err &&
        !this.updateAddress &&
        ((msg = '주소를 입력해주세요'),
        (err = false), this.$refs.updateAddress.focus());
      err &&
        !this.updateHomepage &&
        ((msg = '홈페이지 URL을 입력해주세요'),
        (err = false), this.$refs.updateHomepage.focus());
      err &&
        !this.updateHobby &&
        ((msg = '취미를 입력해주세요'),
        (err = false), this.$refs.updateHobby.focus());
    },
  }
};
</script>

<style lang="scss" scoped>
.section {
  padding: 0;
}

.profile-tabs::v-deep {
  .md-card-tabs .md-list {
    justify-content: center;
  }

  [class*="tab-pane-"] {
    margin-top: 3.213rem;
    padding-bottom: 50px;

    img {
      margin-bottom: 2.142rem;
    }
  }
}

.viewport {
  width: 320px;
  max-width: 100%;
  display: inline-block;
  vertical-align: top;
  overflow: auto;
  border: 1px solid rgba(#000, .12);
}
</style>
