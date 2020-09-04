<template>
  <div>
    <div class="md-layout-item md-large-size md-medium-size-100" style="float:left;width: 50%">
      <div style="width: 35%;margin: auto; ">
        <md-field>
          <md-select v-model="dong" class="md-primary md-m" style="text-align: center;" placeholder="== 관심지역 선택 ==">
            <md-option v-for="(favitem, index) in favitems" :value="favitem.dong" :key="index + '_favitems'">
              {{ favitem.city }} {{ favitem.gugun }} {{ favitem.dong }}</md-option>
          </md-select>
          <md-button class="md-primary md-small" @click="getList">검색</md-button>
        </md-field>
      </div>

      <table class="table table-hover" v-if="isSelected" >
        <tr>
          <!-- <th class="tableRow">번호</th> -->
          <th class="tableRow">위치</th>
          <th class="tableRow">가게이름</th>
          <th class="tableRow">업종</th>
        </tr>

        <tbody>
          <tr v-for="(commitem, index) in calData" :key="index + '_commitems'" @click="showMap(commitem.lat, commitem.lng, commitem)">
            {{ showMapDefault(commitem.lat, commitem.lng) }}
            <!-- <td v-if="commitem.dong==dong"> 
                      {{commitem.no}}</td> -->

            <td >
              {{ commitem.city }} {{ commitem.gu }} {{ commitem.dong }}
            </td>
            <td>
              {{ commitem.shopname }}
            </td>
            <td >
              {{ commitem.codename2 }}
            </td>


          </tr>
        </tbody>
      </table>

      <br>
      <pagination v-if="isSelected" v-model="curPageNum" :page-count="numOfPages"></pagination>

    </div>
    <div class="md-layout-item md-large-size md-medium-size-100" style="float:right;width: 50%">
      <div id="map2" style="width:100%;height:500px;margin-right:20px"></div>
    </div>
  </div>
</template>

<script>
import store from "@/store/store.js";

import { mapGetters, mapActions, mapState } from "vuex";
import http from "@/util/http-common";

import axios from "axios";

// pagenation
import { Pagination } from "@/components";

let map2;
let infowindow = null;

export default {
  name: "comlist",

  components: {
    Pagination,
  },

    mounted() {
    this.addScript();
    this.initMap();
  },

  data: function() {
    return {
      dong: "",
      curPageNum: 1,
      dataPerPage: 7,
      isSelected: false,
      inPageNum: 0,
      commlist:[],
      start:0,
    };
  },

  computed: {
    ...mapGetters(["favitems"]),
    ...mapGetters(["commitems"]),


    startOffSet(start){
      return ((this.curPageNum-1) * this.dataPerPage);
    },
    endOffSet(){
      return (this.startOffSet + this.dataPerPage);
    },
    numOfPages(){
      return Math.ceil(this.commitems.length / this.dataPerPage);
    },
    calData(){
      this.initMap();
      return this.commitems.slice(this.startOffSet, this.endOffSet);
    },
    
  },
  created() {
    
  },
  methods: {
    getList(){
      store.dispatch('getCommitems', `/comm/` + this.dong);
      this.isSelected = true;
    },

    showMapDefault(lat, lng) {
      if (lat.charAt(0) == '"') {
        lat = lat.substring(1, lat.length-1);
        lng = lng.substring(1, lng.length-1);
      }

      this.setpos(lat, lng);
      this.panTo(lat, lng);

    },
    showMap(lat, lng, commitem) {
      if (lat.charAt(0) == '"') {
        lat = lat.substring(1, lat.length-1);
        lng = lng.substring(1, lng.length-1);
      }

      this.setpos(lat, lng);
      this.openInfoWindow(lat, lng, commitem);
      this.panTo(lat, lng);

    },

    initMap() {
      var mapContainer = document.getElementById("map2"), // 지도를 표시할 div
        mapOption = {
          center: new kakao.maps.LatLng(37.58, 127.0), // 지도의 중심좌표
          level: 4 // 지도의 확대 레벨
        };

      map2 = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
    },

    setpos(lat, lng) {
      var markerPosition = new kakao.maps.LatLng(lat, lng);

      var marker = new kakao.maps.Marker({
        position: markerPosition
      });

      marker.setMap(map2);
    },

    panTo(lat, lng) {
      var moveLatLon = new kakao.maps.LatLng(lat, lng);

      map2.panTo(moveLatLon);
    },

    openInfoWindow(lat, lng, item){

      // 기존 인포 윈도우 닫기
      if (infowindow != null) infowindow.close();
      
      var markerPosition  = new kakao.maps.LatLng(lat, lng); 

      // 마커를 생성합니다
      var marker = new kakao.maps.Marker({
          position: markerPosition
      });

      // 마커가 지도 위에 표시되도록 설정합니다
      marker.setMap(map2);

      var iwContent = `
        <div style="display:table;margin: auto;padding: 15px; text-align:left;">
          <p text-align:left;>
          <h5 style="font-weight:bold;text-align:center;">${item.shopname} ${item.localname}<br>
          </h5>
          주소: ${item.address}<br>
          업종: ${item.codename4}
          <a style="float: right;" href="https://map.kakao.com/link/to/${item.shopname},${lat},${lng}" style="color:blue" target="_blank">길찾기</a><br>
          <br>
          </p>
          
        </div>`, 
          iwPosition = new kakao.maps.LatLng(lat, lng); //인포윈도우 표시 위치입니다

      // 인포윈도우를 생성합니다
      infowindow = new kakao.maps.InfoWindow({
          position : iwPosition, 
          content : iwContent 
      });
      // 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
      infowindow.open(map2, marker); 
     
    },


    addScript() {
      const script = document.createElement("script");
      /* global kakao */

      script.onload = () => kakao.maps.load(this.initMap);
      script.src =
        "http://dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=c88e4cadd71527a28431b19b33fcb71f";
      document.head.appendChild(script);
    }
  }
};
</script>

<style>
ul {
  justify-content: center;
}
</style>
