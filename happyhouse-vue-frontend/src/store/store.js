import Vue from "vue";
import Vuex from "vuex";
import http from '@/util/http-common';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    noticeitems: [],
    noticeitem: {},

    qnaitems: [],
    qnaitem: {},

    favitems:[],
    favitem:{},

    commitems:[],

    // housedeal
    housedealitems:[],
    housedealitem:{},
    housedealNo: 0,

    // login
    isLogin: false,
    userInfo: {},
    // findpwd
    foundUser: {},
    // userinfo
    //userInfo: {},

    // login 모달창
    loginModal: false,
    
    // dongList
    dongitems:[],
    

  },
  getters: {
    // notice
    noticeitems(state) {
      return state.noticeitems;
    },
  
    noticeitem(state) {
      return state.noticeitem;
    },

    // qna
    qnaitems(state) {
      return state.qnaitems;
    },
  
    qnaitem(state) {
      return state.qnaitem;
    },

    // fav
    favitems(state) {
      return state.favitems;
    },
    favitem(state) {
      return state.favitem;
    },
    // comm
    commitems(state) {
      return state.commitems;
    },


    // housedeal
    housedealitems(state) {
      return state.housedealitems;
    },
    housedealitem(state) {
      return state.housedealitem;
    },
    housedealNo(state) {
      return state.housedealNo;
    },

    // login
    isLogin(state) {
      return state.isLogin;
    },
    userInfo(state) {
      return state.userInfo;
    },
    // findpwd
    foundUser(state) {
      return state.foundUser;
    },

    // dong
    dongitems(state) {
      return state.dongitems;
    },


  },
  mutations: {
    // notice
    mutateSetNoticeitems(state, noticeitems){
      state.noticeitems = noticeitems
    },
    mutateSetNoticeitem(state, noticeitem){
      state.noticeitem = noticeitem
    },
    // qna
    mutateSetQnaitems(state, qnaitems){
      state.qnaitems = qnaitems
    },
    mutateSetQnaitem(state, qnaitem){
      state.qnaitem = qnaitem
    },
    
    // fav
    mutateSetFavitems(state, favitems){
      state.favitems = favitems
    },
    mutateSetFavitem(state, favitem){
      state.favitem = favitem
    },
    // comm
    mutateSetCommitems(state, commitems){
      state.commitems = commitems
    },


    // housedeal
    mutateSetHousedealitems(state, housedealitems){
      state.housedealitems = housedealitems
    },
    mutateSetHousedealitem(state, housedealitem){
      state.housedealitem = housedealitem
    },
    mutateSetHousedealNo(state, no) {
      state.housedealNo = no
    },

    // login
    mutateIsLogin(state, isLogin){
      state.isLogin = isLogin
      if(isLogin) {
        alert("로그인 되었습니다.");
      } else {
        alert("로그아웃 되었습니다.");
      }
    },
    mutateUserInfo(state, userInfo){
      state.userInfo = userInfo
    },
    mutateLoginModal(state, loginModal){
      state.loginModal = loginModal
    },
    // findpwd
    mutateSetFindpwditem(state, foundUser){
      if(foundUser) alert("비밀번호 : " + foundUser.pw);
      else alert("회원정보가 존재하지 않습니다. 아이디를 다시 확인해주세요.");
      state.foundUser = foundUser;
    },
    /*mutateSetUserinfo(state, userInfo){
      state.userInfo = userInfo;
    },*/
    // dong
    mutateSetDongitems(state, dongitems){
      state.dongitems = dongitems
    },

  },
  actions: {
    // notice
    getNoticeitems(context, payload) {
      http
        .get(payload)
        .then(({ data }) => {
          context.commit('mutateSetNoticeitems', data);
        })
        .catch(() => {
          alert('에러가 발생했습니다.');
        });
    },
    getNoticeitem(context, payload) {
      http.get(payload).then(({ data }) => {
        context.commit('mutateSetNoticeitem', data);
      });
    },

    // qna
    getQnaitems(context, payload) {
      http
        .get(payload)
        .then(({ data }) => {
          context.commit('mutateSetQnaitems', data);
        })
        .catch(() => {
          alert('에러가 발생했습니다.');
        });
    },
    getQnaitem(context, payload) {
      http.get(payload).then(({ data }) => {
        context.commit('mutateSetQnaitem', data);
      });
    },


    // fav
    getFavitems(context, payload) {
      http
        .get(payload)
        .then(({ data }) => {
          context.commit('mutateSetFavitems', data);
        })
        .catch(() => {
          alert('에러가 발생했습니다.');
        });
    },
    getFavitem(context, payload) {
      http.get(payload).then(({ data }) => {
        context.commit('mutateSetFavitem', data);
      });
    },
    // comm
    getCommitems(context, payload) {
      http
        .get(payload)
        .then(({ data }) => {
          context.commit('mutateSetCommitems', data);
        })
        .catch(() => {
          alert('에러가 발생했습니다.');
        });
    },

    
    // housedeal
    getHousedealitems(context, payload) {
      http
        .get(payload)
        .then(({ data }) => {
          context.commit('mutateSetHousedealitems', data);
        })
        .catch(() => {
          alert('에러가 발생했습니다.');
        });
    },
    getHousedealitem(context, payload) {
      http.get(payload).then(({ data }) => {
        context.commit('mutateSetHousedealitem', data);
      });
    },
    getHousedealNo(context, no) {
      context.commit('mutateSetHousedealNo', no);
    },

    // login
    login(context, {id, pw, url}) {
      http
        .post("/login/login", {
          id: id,
          pw: pw
        })
        .then(({ data }) => {
          console.log(data);
          context.commit('mutateIsLogin', true)
          context.commit('mutateUserInfo', data)
          context.commit('mutateLoginModal', false)
          router.push(url);
          // 오류 코드 this in promise-then()
          // Uncaught (in promise) TypeError
          //this.$router.push('/About')
        })
        .catch((error) => {
          if (error.response.status == '404') {
            alert("아이디 또는 비밀번호가 올바르지 않습니다.");
          } else {
            alert('로그인 처리시 에러가 발생했습니다.');
          }
          console.log(error.config);

        });
    },
    logout(context, {url}){
      http
        .post("/login/logout")
        .then(( data ) => {
          console.log(data);
          context.commit('mutateIsLogin', false)
          context.commit('mutateUserInfo', {})
          router.push(url);

          console.log(url);
        })
        .catch((error) => {
          //alert('로그아웃 처리시 에러가 발생했습니다.');
          console.log(error.config);
        });
    },
    // findpwd
    findpwd(context, payload) {
      http
        .get(payload)
        .then(({ data }) => {
          context.commit('mutateSetFindpwditem', data);
        });
    },
    // 회원 조회
    getUserinfo(context, payload) {
      http
        .get(payload)
        .then(({ data }) => {
          context.commit('mutateUserinfo', data);
        });
    },
    
    // dong
    getDongitems(context) {
      http
        .get('/fav/dong')
        .then(({ data }) => {
          context.commit('mutateSetDongitems', data);
        })
        .catch(() => {
          alert('에러가 발생했습니다.');
        });
    },
  }
});
