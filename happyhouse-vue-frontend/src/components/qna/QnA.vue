<template>
  <div class="wrapper">
    

    <parallax class="section page-header header-filter" :style="headerStyle">
      <div class="container">
        <div class="md-layout">
          <div
            class="md-layout-item md-size-50 md-small-size-70 md-xsmall-size-100">
            <h1 class="title" style="font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;">QnA</h1>
            <h4>
              질문 게시판
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
                    <md-option value="con">질문내용</md-option>
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
                      <th class="tableRow">질문날짜</th>
                      <th class="tableRow">답변자</th>
                      <th class="tableRow">답변날짜</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-if="qnaitems == null"> {{ searchword }}에 대한 검색 결과가 없습니다</tr>   
                    <tr v-for="(qnaitem, index) in calData" :key="index + '_qnaitems'" @click="classicModalshow(qnaitem.qna_no, qnaitem.reply_userid)">
                      <td>
                        {{qnaitem.qna_no}}</td>
                      <td>
                        {{qnaitem.qna_title}}</td>
                      <td>
                        {{qnaitem.qna_userid}}</td>
                      <td>
                        {{getFormatDate(qnaitem.qna_datetime)}}</td>
                      <td>
                        {{qnaitem.reply_userid}}</td>
                      <td>
                        {{getFormatDate(qnaitem.reply_datetime)}}</td>
                    </tr> 


                  </tbody>
                </table>


                   <!-- <md-table v-model="items" md-sort="no" md-sort-order="asc" md-card md-fixed-header @md-selected="onSelect" class="md-layout-item md-size-100">
                      <md-table-row slot="md-table-row" slot-scope="{ item }" :class="getClass(item)" md-selectable="single" @click="classicModalshow(item.qna_no, item.reply_userid)">
                        <md-table-cell md-label="번호" md-sort-by="qna_no" md-numeric>{{ item.qna_no }}</md-table-cell>
                        <md-table-cell md-label="제목" md-sort-by="title">{{ item.qna_title }}</md-table-cell>
                        <md-table-cell md-label="작성자" md-sort-by="qna_userid">{{ item.qna_userid }}</md-table-cell>
                        <md-table-cell md-label="작성날짜" md-sort-by="qna_datetime">{{ getFormatDate(item.qna_datetime) }}</md-table-cell>
                        <md-table-cell md-label="답변자" md-sort-by="reply_userid">{{ item.reply_userid }}</md-table-cell>
                        <md-table-cell md-label="답변날짜" md-sort-by="reply_datetime">{{ getFormatDate(item.reply_datetime) }}</md-table-cell>
                      </md-table-row>
                    </md-table>  -->


              </div>

              <pagination v-model="curPageNum" :page-count="numOfPages"></pagination>
                <!-- <div>글이 없습니다.</div> -->

                <div style="text-align: right;" v-if="$store.state.userInfo.id != null">
                    <md-button
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
            <h4 class="modal-title" v-if="isDetail" style="font-weight: bold;">{{qnaitem.qna_title}}</h4>
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
              {{qnaitem.qna_content}}
            </p>

            <!-- update -->
            <md-field maxlength="10" v-if="!isDetail">
                  <label>Content</label>
                  <md-textarea v-model="updatecontent" ref="updatecontent"></md-textarea>
            </md-field>

            <p style="text-align: right;font-size: 12px;" v-if="!isInsert">
              작성자: {{qnaitem.qna_userid}} <br>
              질문 작성 날짜: {{qnaitem.qna_datetime}}
            </p>
          </template>


          <br>
          

          <!-- reply -->
          <template slot="body" >
            <!-- detail -->
            <p v-if="isDetail && reply_userid != null" style="color:blue;">
              {{qnaitem.reply_content}}
            </p>

            <!-- update -->
            <md-field maxlength="10" v-if="isReply">
                  <label>Reply</label>
                  <md-textarea v-model="reply_content" ref="reply_content"></md-textarea>
            </md-field>

            <p style="text-align: right;font-size: 12px;color:blue;" v-if="!isInsert && reply_userid!=null">
              답변자: {{qnaitem.reply_userid}} <br>
              답변 작성 날짜: {{qnaitem.reply_datetime}}
            </p>
          </template>




          
          <template slot="footer">
            <md-button class="md-warning md-simple" v-if="isDetail && reply_userid==null && !isReply && $store.state.userInfo.id != null" @click="replyShow(qnaitem.qna_no)">Reply</md-button>
            <md-button class="md-warning md-simple" v-if="isDetail && reply_userid==null && isReply && $store.state.userInfo.id != null" @click="replyUpdate(qnaitem.qna_no, $store.state.userInfo.id)">Reply</md-button>

            <md-button class="md-success md-simple" v-if="isDetail && reply_userid==null&&  !isReply && qnaitem.qna_userid == $store.state.userInfo.id" @click="updateModal(qnaitem.qna_title, qnaitem.qna_content)">Update</md-button>

            <md-button class="md-success md-simple" v-if="!isDetail && !isInsert && qnaitem.qna_userid == $store.state.userInfo.id" @click="updateComplete(qnaitem.qna_no)">Update complete</md-button>

            <md-button class="md-success md-simple" v-if="isInsert" @click="insertQna">Add</md-button>
            <!-- <router-link :to="'/notice/delete?noticeno=' + item.noticeno"> -->
            
            
            <md-button class="md-danger md-simple" v-if="isDetail && qnaitem.qna_userid == $store.state.userInfo.id" @click="deleteNotice(qnaitem.qna_no)">Delete</md-button>
            
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
  name: "qna",

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
          //
          items: this.$store.state.qnaitems,
          itemno: 0,
          id: this.$store.state.userInfo.id,
          // detail
          classicModal: false,
          isDetail: true,
          isReply:false,
          // update q
          updatecontent: "",
          updatesubject: "",
          // search
          searchword: "",
          searchoption: "sub",
          // insert
          isInsert:false,
          // update reply
          reply_userid: null,
          reply_content: "",
          // pagination
          curPageNum: 1,
          dataPerPage: 6,
        };
  },

  computed: {
    ...mapGetters(['qnaitems']),
    ...mapGetters(['qnaitem']),
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
      return Math.ceil(this.qnaitems.length / this.dataPerPage);
    },
    calData(){
      return this.qnaitems.slice(this.startOffSet, this.endOffSet);
    },
  },
  created() {
    // List
    store.dispatch('getQnaitems', '/qna');
  },
  methods: {

    getList(){
      if (this.searchword == '') {
        store.dispatch('getQnaitems', '/qna/');
      }else if (this.searchoption == 'sub'){  // 제목
        store.dispatch('getQnaitems', '/qna/sub/' + this.searchword);
      }else if (this.searchoption == 'con'){  // 내용
        store.dispatch('getQnaitems', '/qna/con/' + this.searchword);
      }else if (this.searchoption == 'no'){ // 번호
        store.dispatch('getQnaitems', '/qna/no/' + this.searchword);
      }
    },
    loginneed(){
      alert("로그인이 필요합니다");
      this.$router.push('/');
    },
    getFormatDate(regtime) {
      if (regtime==null) return null;
      return moment(new Date(regtime)).format('YYYY.MM.DD');
    },
    
    
    // Detail
    classicModalshow(qna_no, reply_userid) {
      store.dispatch('getQnaitem', `/qna/` + qna_no);
      this.itemno = qna_no;
      this.reply_userid = reply_userid;
      this.classicModal = true;
        
    },
    classicModalHide() {
        this.classicModal = false;
        this.isDetail = true;
        this.isInsert = false;
        this.isReply = false;
        this.reply_userid=null;
    },

    // updateModal
    updateModal(subject, content) {
      this.updatesubject = subject;
      this.updatecontent = content;
      this.isDetail = false;
    },

    // update 
    updateComplete(qna_no){
      this.blankCheck();

      http
        .put(`/qna/${qna_no}`, {
          qna_no: qna_no,
          qna_title: this.updatesubject,
          qna_content: this.updatecontent,
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
          store.dispatch('getQnaitems', '/qna');
        });
      
    },

    replyShow(qna_no){
      this.itemno = qna_no;
      this.isReply = true;
    },

    replyUpdate(qna_no, id){
      // this.replyblankCheck();

      http
        .put(`/qna/reply/${qna_no}`, {
          qna_no: qna_no,
          reply_content: this.reply_content,
          // 임시
          reply_userid: id,
        })
        .then(({ data }) => {
          alert('답변을 작성 하였습니다.');
        })
        .catch(() => {
          // alert('삭제 처리시 에러가 발생했습니다.');
        })
        .finally(() => {
          this.classicModalHide();
          this.reply_content = '';
          // 목록 새로고침
          store.dispatch('getQnaitems', '/qna');
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

    replyblankCheck(){
      let err = true;
      let msg = '';
      !this.reply_content &&
        ((msg = '답변 내용을 입력해주세요'),
        (err = false), alert(msg),
        this.$refs.reply_content.focus());
    },

    // delte
    deleteNotice(qna_no) {
      http
      .delete(`/qna/` + qna_no)
      .then(({ data }) => {
        alert('삭제가 완료되었습니다.');
      })
      .catch(() => {
        // alert('삭제 처리시 에러가 발생했습니다.');
      })
      .finally(() => {
        this.classicModalHide();
        // 목록 새로고침
        store.dispatch('getQnaitems', '/qna');
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
    insertQna(){
      // 빈칸 확인
      this.blankCheck();
       http
        .post(`/qna/add/`, {
          qna_title: this.updatesubject,
          qna_content: this.updatecontent,
          qna_userid: this.$store.state.userInfo.id,
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
          store.dispatch('getQnaitems', '/qna');
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
