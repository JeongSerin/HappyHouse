<template>
  <div class="wrapper">
    

    <parallax class="section page-header header-filter" :style="headerStyle">
      <div class="container">
        <div class="md-layout">
          <div
            class="md-layout-item md-size-50 md-small-size-70 md-xsmall-size-100">
            <h1 class="title">Notice</h1>
            <h4 class="title" style="font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;">
              공지사항 게시판
            </h4>
            
            <br />
            
          </div>
        </div>
      </div>
    </parallax>
    <div class="main main-raised">
      <div class="section section-contacts">
        <div class="container">
          <div class="md-layout">

            <h3  v-if="$store.state.userInfo.id == null"> {{ loginneed() }}</h3>

            <div class="md-layout-item md-size-66 md-xsmall-size-100 mx-auto" v-if="$store.state.userInfo.id != null">
              
            
             
              <form id="serchForm">
                <md-field>
                  <md-select v-model="searchoption" class="md-primary md-m" >
                    <md-option value="sub">제목</md-option>
                    <md-option value="con">내용</md-option>
                    <md-option value="no">글번호</md-option>
                  </md-select>
                  <md-input v-model="searchword" placeholder="Search" style="width=20%;"></md-input>
                  <md-button class="md-primary md-small" @click="getList">검색</md-button>
                </md-field>
              </form>

              <div class="container">
                <table class="table table-hover">
                  <thead>
                    <tr>
                      <th class="tableRow">번호</th>
                      <th class="tableRow">제목</th>
                      <th class="tableRow">작성자</th>
                      <th class="tableRow">날짜</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-if="noticeitems == null"> {{ searchword }}에 대한 검색 결과가 없습니다</tr>
                    <tr v-for="(noticeitem, index) in calData" :key="index + '_noticeitems'" @click="classicModalshow(noticeitem.noticeno)">

                      <td>
                        {{noticeitem.noticeno}}</td>
                      <td >
                        {{noticeitem.subject}}
                          </td>
                      <td>
                        {{noticeitem.id}}</td>
                      <td>
                        {{getFormatDate(noticeitem.regtime)}}</td>
                    </tr> 


                  </tbody>
                </table>
              </div>

              <pagination v-model="curPageNum" :page-count="numOfPages"></pagination>

                <!-- <div>글이 없습니다.</div> -->

                <div style="text-align: right;">
                    <md-button v-if="$store.state.userInfo.isAdmin == 1"
                    class="md-primary md-round "
                    target="_blank"
                    @click="insertOpen"
                    style=""> 등록</md-button>
                </div>


            </div>
          </div>
        </div>
      </div>
    </div>

    

    <!-- Detail & update -->
    <div class="md-layout">
      <div class="md-layout-item md-size-33">
        <modal v-if="classicModal" @close="classicModalHide">
          <template slot="header">
             <!-- detail -->
            <h4 class="modal-title" v-if="isDetail" style="font-weight: bold;">{{noticeitem.subject}}</h4>
            <!-- update -->
            <md-field v-if="!isDetail">
              <label>Subject</label>
              <md-input v-model="updatesubject" type="text" ref="updatesubject"></md-input>
            </md-field>

            <md-button
              class="md-simple md-just-icon md-round modal-default-button"
              @click="classicModalHide">
              <md-icon>clear</md-icon>
            </md-button>
          </template>
          <template slot="body">
            <!-- detail -->
            <p v-if="isDetail">
              {{noticeitem.content}}
            </p>

            <!-- update -->
            <md-field maxlength="10" v-if="!isDetail">
                  <label>Content</label>
                  <md-textarea v-model="updatecontent" ref="updatecontent"></md-textarea>
            </md-field>

            <p style="text-align: right;font-size: 12px;" v-if="!isInsert">
              작성자: {{noticeitem.id}} <br>
              작성 날짜: {{noticeitem.regtime}}
            </p>
          </template>
          
          <template slot="footer">
            <md-button class="md-success md-simple" v-if="isDetail && $store.state.userInfo.isAdmin == 1" @click="updateModal(noticeitem.subject, noticeitem.content)">Update</md-button>

            <md-button class="md-success md-simple" v-if="!isDetail && !isInsert && $store.state.userInfo.isAdmin == 1" @click="updateComplete(noticeitem.noticeno)">Update complete</md-button>

            <md-button class="md-success md-simple" v-if="isInsert && $store.state.userInfo.isAdmin == 1" @click="insertNotice">Add</md-button>
            <!-- <router-link :to="'/notice/delete?noticeno=' + item.noticeno"> -->
            
            
            <md-button class="md-danger md-simple" v-if="isDetail && $store.state.userInfo.isAdmin == 1" @click="deleteNotice(noticeitem.noticeno)">Delete</md-button>
            
            <md-button
              class="md-simple"
              @click="classicModalHide"
              >Close</md-button>
          </template>
        </modal>
      </div>
    </div>
    
    

  </div>
</template>

<script>


import store from "@/store/store.js";

import { mapGetters, mapActions, mapState } from 'vuex';
import http from '@/util/http-common';

import axios from 'axios';
import moment from 'moment';

// Modal
import { Modal } from "@/components";
// pagination
import { Pagination } from "@/components";

export default {
  bodyClass: "profile-page",
  name: "notice",

  props: {
    header: {
      type: String,
      default: require("@/assets/img/vue-mk-menu.jpg")
    },
    
  },
  

  components: {
    Modal,
    Pagination,
  },
  

  data: function () {
        return {
          itemno: 0,
          id: "admin",
          // detail
          classicModal: false,
          isDetail: true,
          // update
          updatecontent: "",
          updatesubject: "",
          // search
          searchword: "",
          searchoption: "sub",
          // insert
          isInsert:false,
          // pagination
          curPageNum: 1,
          dataPerPage: 6,
        };
  },

  computed: {
    ...mapGetters(['noticeitems']),
    ...mapGetters(['noticeitem']),
    headerStyle() {
      return {
        backgroundImage: `url(${this.header})`
      };
    },
    // pagination
    startOffSet(start){
      return ((this.curPageNum-1) * this.dataPerPage);
    },
    endOffSet(){
      return (this.startOffSet + this.dataPerPage);
    },
    numOfPages(){
      return Math.ceil(this.noticeitems.length / this.dataPerPage);
    },
    calData(){
      return this.noticeitems.slice(this.startOffSet, this.endOffSet);
    },
  },
  created() {
    // List
    store.dispatch('getNoticeitems', '/notice');
  },
  methods: {
    getList(){
      if (this.searchword == '') {
        store.dispatch('getNoticeitems', '/notice/');
      }else if (this.searchoption == 'sub'){  // 제목
        store.dispatch('getNoticeitems', '/notice/sub/' + this.searchword);
      }else if (this.searchoption == 'con'){  // 내용
        store.dispatch('getNoticeitems', '/notice/con/' + this.searchword);
      }else if (this.searchoption == 'no'){ // 번호
        store.dispatch('getNoticeitems', '/notice/no/' + this.searchword);
      }
    },
    loginneed(){
      alert("로그인이 필요합니다");
      this.$router.push('/');
    },
    getFormatDate(regtime) {
        return moment(new Date(regtime)).format('YYYY.MM.DD');
    },
    movePage() {
      this.$router.push('/');
    },
    
    // Detail
    classicModalshow(no) {
      this.itemno = no;
      store.dispatch('getNoticeitem', `/notice/` + no);
      this.classicModal = true;
        
    },
    classicModalHide() {
        this.classicModal = false;
        this.isDetail = true;
        this.isInsert = false;
    },

    // updateModal
    updateModal(subject, content) {
      this.updatesubject = subject;
      this.updatecontent = content;
      this.isDetail = false;
    },

    // update 
    updateComplete(noticeno){
      this.blankCheck();

      http
        .put(`/notice/${noticeno}`, {
          noticeno: noticeno,
          subject: this.updatesubject,
          content: this.updatecontent,
        })
        .then(({ data }) => {
          alert('수정이 완료되었습니다.');
        })
        .catch(() => {
          // alert('삭제 처리시 에러가 발생했습니다.');
        })
        .finally(() => {
          this.classicModalHide();
          // 목록 새로고침
          store.dispatch('getNoticeitems', '/notice');
        });
      
    },

    blankCheck(){
      let err = true;
      let msg = '';
      !this.updatesubject &&
        ((msg = '제목을 입력해주세요'),
        (err = false), alert(msg),
        this.$refs.updatesubject.focus());
      err &&
        !this.updatecontent &&
        ((msg = '내용을 입력해주세요'),  alert(msg), (err = false), this.$refs.updatecontent.focus());
      
    },

    // delte
    deleteNotice(no) {
      http
      .delete(`/notice/` + no)
      .then(({ data }) => {
        alert('삭제가 완료되었습니다.');
      })
      .catch(() => {
        // alert('삭제 처리시 에러가 발생했습니다.');
      })
      .finally(() => {
        this.classicModalHide();
        // 목록 새로고침
        store.dispatch('getNoticeitems', '/notice');
      });
    },
    // insert
    insertOpen(){
      this.updatesubject="";
      this.updatecontent="";
      this.isInsert=true;
      this.isDetail=false;
      this.classicModal = true;
    },
    insertNotice(){
      // 빈칸 확인
      this.blankCheck();

       http
        .post(`/notice/add`, {
          subject: this.updatesubject,
          content: this.updatecontent,
          id: this.id,
        })
        .then(({ data }) => {
          alert('등록이 완료되었습니다.');
        })
        .catch(() => {
          alert('등록 처리시 에러가 발생했습니다.');
        })
        .finally(() => {
          // closeModal
          this.classicModalHide();
          // 목록 새로고침
          store.dispatch('getNoticeitems', '/notice');
        });
    },

    
  },
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
td {
  width: auto;
}
ul {
  justify-content: center;
}

</style>
