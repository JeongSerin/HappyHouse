<template>
  <div> 
    
    <p style="display:none;">{{ $store.state.housedealitem }}</p>
    <div class="md-layout-item md-large-size md-medium-size-100">
      <div id="map" style="width:90%;height:450px;margin:auto"></div>
    </div>
<div v-if="$store.state.housedealitem.aptName!=null && isSelected"> {{ showMap($store.state.housedealitem.lat, $store.state.housedealitem.lng, $store.state.housedealitem) }}</div>
  </div>
</template>

<script>
import store from "@/store/store.js";

import { mapGetters, mapActions, mapState } from "vuex";
import http from "@/util/http-common";

import axios from "axios";

let infowindow;
let marker

let map;

export default {
  name: "mapview",

  mounted() {
    this.addScript();
    this.initMap();
  },

  data: function() {
    return {
      userid: "ssafy",
      isSelected: false,
    };
  },

  components: {
  },

  computed: {
    ...mapGetters(["housedealitems"])
  },
  created() {
    store.dispatch("getHousedealitems", '/house');
  },
  methods: {
    showMapDefault(lat, lng) {
      lat = lat.substring(1, lat.length-1);
      lng = lng.substring(1, lng.length-1);

      this.setpos(lat, lng);
      this.panTo(lat, lng);

    },

    showMap(lat, lng, item) {
      // 기존 마커 지우기
      if(marker != null){
        marker.setMap(null);  
      }

      if (lat != null && lat.charAt(0) == '"') {
        lat = lat.substring(1, lat.length-1);
        lng = lng.substring(1, lng.length-1);
      }

      this.setpos(lat, lng);
      this.openInfoWindow(lat, lng, item);
      this.panTo(lat, lng);
    },

    initMap() {
      var mapContainer = document.getElementById("map"), // 지도를 표시할 div
        mapOption = {
          center: new kakao.maps.LatLng(37.58, 127.0), // 지도의 중심좌표
          level: 3 // 지도의 확대 레벨
        };

      map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

      this.isSelected = true;
    },

    setpos(lat, lng) {
      var markerPosition = new kakao.maps.LatLng(lat, lng);

      marker = new kakao.maps.Marker({
        position: markerPosition
      });

      marker.setMap(map);
    },

    panTo(lat, lng) {
      var moveLatLon = new kakao.maps.LatLng(lat, lng);

      map.panTo(moveLatLon);
    },
    openInfoWindow(lat, lng, item){
      if (this.isSelected == false) return;
      // 기존 인포 윈도우 닫기
      if (infowindow != null) infowindow.close();
      if(marker != null){
        marker.setMap(null);  
      }
      
      var markerPosition  = new kakao.maps.LatLng(lat, lng); 

      // 마커를 생성합니다
      marker = new kakao.maps.Marker({
          position: markerPosition
      });

      // 마커가 지도 위에 표시되도록 설정합니다
      marker.setMap(map);

// { "no": 2, "dong": "사직동", "aptName": "광화문풍림스페이스본(106동)", "code": 0, "dealAmount": "162,000", "buildYear": 2008, 
// "dealYear": 0, "dealMonth": 0, "dealDay": 0, "dealDate": "2019/1/11", "area": 163.33, "floor": 0, "jibun": "9-1", 
// "lat": "37.57348", "lng": "126.967792", "type": null, "rentMoney": null, "img": null }
      var iwContent = `
        <div style="display:table;margin: auto;padding: 15px;">
          <p style="text-align:center;">
          <h5 style="font-weight:bold; text-align:center;">${item.aptName}
          <a style="float:right;" href="https://map.kakao.com/link/to/${item.aptName},${lat},${lng}" style="color:blue" target="_blank">길찾기</a>
          </h5>
          <!--<img src="@/assets/img/houseimg/그림1.jpg"/><br>-->
          ${item.dong} (${item.jibun})<br>
          건축년도: ${item.buildYear}<br>
          거래금액: ${item.dealAmount}

          
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
    }
  }
};
</script>

<style></style>
