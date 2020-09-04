<template>
  <div>
    <div class="md-layout-item md-large-size md-medium-size-100" style="float:left;width: 50%">
    <!-- <div style="float:left; width: 50%"> -->
      <table class="table table-hover">
        <tr>
          <th class="tableRow">번호</th>
          <th class="tableRow">시</th>
          <th class="tableRow">구군</th>
          <th class="tableRow">동</th>
          <th class="tableRow" style="color:red;"></th>
        </tr>
      
        <tbody>
          <tr v-for="(favitem, index) in calData" :key="index + '_favitems'" @click="showMap(favitem.lat, favitem.lng, favitem)" >
            {{ setpos(favitem.lat, favitem.lng) }}
            {{ panTo(favitem.lat, favitem.lng) }}
            <td>
              {{ favitem.favno }}
            </td>
            <td>
              {{ favitem.city }}
            </td>
            <td>
              {{ favitem.gugun }}
            </td>
            <td>
              {{ favitem.dong }}
            </td>

            

            <td>
              <a
                type="button"
                style="color:red"
                @click="deleteFav(favitem.favno)"
                >삭제</a
              >
            </td>
          </tr>

        </tbody>
      </table>

      <br>
      <pagination v-model="curPageNum" :page-count="numOfPages"></pagination>


    </div>

    <div class="md-layout-item md-large-size md-medium-size-100" style="float:right;width: 50%">
      <div id="map" style="width:100%;height:500px;margin-right:20px"></div>
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

let map;
let infowindow = null;

export default {
  name: "list",

  mounted() {
    this.addScript();
    this.initMap();
  },

  data: function() {
    return {
      userid: "ssafy",
      curPageNum: 1,
      dataPerPage: 6,
    };
  },

  components: {
    Pagination
  },

  computed: {
    ...mapGetters(["favitems"]),
    startOffSet(){
      return ((this.curPageNum-1) * this.dataPerPage);
    },
    endOffSet(){
      return (this.startOffSet + this.dataPerPage);
    },
    numOfPages(){
      return Math.ceil(this.favitems.length / this.dataPerPage);
    },
    calData(){
      return this.favitems.slice(this.startOffSet, this.endOffSet);
    }
   

  },
  created() {
  },
  methods: {
    showMap(lat, lng, favitem) {
      // marker.setMap(null); 
      // this.setpos(lat, lng);
      this.openInfoWindow(lat, lng, favitem);
      this.panTo(lat, lng);

    },
    // delete
    deleteFav(favno) {
      http
        .delete(`/fav/` + favno)
        .then(({ data }) => {
          alert("삭제가 완료되었습니다.");
        })
        .catch(() => {
          // alert('삭제 처리시 에러가 발생했습니다.');
        })
        .finally(() => {
          // 목록 새로고침
          this.initMap();
          store.dispatch("getFavitems", "/fav/" + this.$store.state.userInfo.id);
        });
    },

    initMap() {
      var mapContainer = document.getElementById("map"), // 지도를 표시할 div
        mapOption = {
          center: new kakao.maps.LatLng(37.58, 127.0), // 지도의 중심좌표
          level: 5 // 지도의 확대 레벨
        };

      map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
    },

    setpos(lat, lng) {
      var markerPosition = new kakao.maps.LatLng(lat, lng);
      var marker = new kakao.maps.Marker({
        position: markerPosition
      });
      marker.setMap(map);
    },

    panTo(lat, lng) {
      var moveLatLon = new kakao.maps.LatLng(lat, lng);
      map.panTo(moveLatLon);
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
      marker.setMap(map);

      var iwContent = `
        <div style="display:table;margin: auto;padding: 15px;">
          <p style="text-align:center;">
          <h6 style="font-weight:bold;">${item.city} ${item.gugun}<br>
          ${item.dong}</h6><br>
          <a style="float: right;" href="https://map.kakao.com/link/to/${item.dong},${lat},${lng}" style="color:blue" target="_blank">길찾기</a>
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
      infowindow.open(map, marker); 
     
    },




    addScript() {
      const script = document.createElement("script");
      /* global kakao */

      script.onload = () => kakao.maps.load(this.initMap);
      script.src =
        "http://dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=c88e4cadd71527a28431b19b33fcb71f";
      document.head.appendChild(script);
    },
    
    
    
  }
};
</script>

<style>
ul {
  justify-content: center;
}

</style>
