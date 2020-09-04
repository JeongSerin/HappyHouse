<template>
  <div class="md-layout-item md-size-100">
    <h3 class="title" style="font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;">
        주택 거래 정보</h3>
    <img
        :src="image"
        alt="Rounded Image"
        class="rounded"
    />
        <!-- :class="{ 'responsive-image': responsive }" -->
    <table style="margin-top: 20px; border-collapse: separate; border-spacing: 5px;" >
      <tr>
        <th>주택명 :</th>
        <td>{{ $store.state.housedealitem.aptName }}</td>
      </tr>
      <tr>
        <th>거래금액 :</th>
        <td>{{ $store.state.housedealitem.dealAmount }}</td>
      </tr>
      <tr>
        <th>건축연도 :</th>
        <td>{{ $store.state.housedealitem.buildYear }}</td>
      </tr>
      <tr>
        <th>전용면적 :</th>
        <td>{{ $store.state.housedealitem.area }}</td>
      </tr>
      <tr>
        <th>거래일 :</th>
        <td>{{ $store.state.housedealitem.dealDate }}</td>
      </tr>
      <tr>
        <th>법정동 :</th>
        <td>{{ $store.state.housedealitem.dong }}</td>
      </tr>
      <tr>
        <th>지번 :</th>
        <td>{{ $store.state.housedealitem.jibun }}</td>
      </tr>
    </table>
  </div>
</template>

<script>
import { mapGetters, mapActions, mapState } from 'vuex';
import http from '@/util/http-common';
import axios from 'axios';

import store from "@/store/store.js";

export default {
  props: {
    image: {
      type: String,
      default: require("@/assets/img/houseimg/그림1.jpg")
    }
  },
  data() {
    return {
      selected: false,
      no: 0,
    }
  }
}
</script>

<style scoped>
th {
  text-align: right;
}
</style>