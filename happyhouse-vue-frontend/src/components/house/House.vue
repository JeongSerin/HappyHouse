<template>
  <div>
    <!-- v-model="$store.state.housedealitems" -->
    <md-table v-model="$store.state.housedealitems" md-sort="no" md-sort-order="asc" md-card md-fixed-header @md-selected="onSelect" class="md-layout-item md-size-100"
      v-if="!dataExist">
      <md-table-toolbar>
        <div class="md-toolbar-section-start">
          <h3 class="title" style="font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;">
            주택 거래 내역 목록</h3>
        </div>

        <!-- 검색 필터링 -->
        <div class="md-toolbar-section-start md-layout-item md-size-100">
          <md-checkbox v-model="aptdeal">아파트 매매</md-checkbox>
          <md-checkbox v-model="aptrent">아파트 전월세</md-checkbox>
          <md-checkbox v-model="housedeal">다세대/주택 매매</md-checkbox>
          <md-checkbox v-model="houserent">다세대/주택 전월세</md-checkbox>
        </div>
        <div class="md-toolbar-section-start md-layout-item md-size-100">
          <md-field>
            <label for="searchby">SearchBy</label>
            <md-select v-model="searchby" name="searchby" id="searchby" md-dense>
              <md-option value="byDong">법정동</md-option>
              <md-option value="byAptName">주택명</md-option>
            </md-select>
          </md-field>
          <md-field md-clearable>
            <md-input placeholder="Search" v-model="search" @input="searchOnTable" />
          </md-field>
        </div>
      </md-table-toolbar>
      
      <!-- 검색 결과 없을 경우 -->
      <md-table-empty-state
        md-label="No Result"
        :md-description="`검색어 '${search}'에 대한 주택 거래 정보가 없습니다.`">
      </md-table-empty-state>

      <!-- 표 -->
      <md-table-row slot="md-table-row" slot-scope="{ item }" :class="getClass(item)" md-selectable="single">
        <md-table-cell md-label="번호" md-sort-by="no" md-numeric>{{ item.no }}</md-table-cell>
        <md-table-cell md-label="법정동" md-sort-by="dong">{{ item.dong }}</md-table-cell>
        <md-table-cell md-label="주택명" md-sort-by="aptName">{{ item.aptName }}</md-table-cell>
        <md-table-cell md-label="거래금액" md-sort-by="dealAmount" md-numeric>{{ item.dealAmount }}</md-table-cell>
        <md-table-cell md-label="거래종류" md-sort-by="type">{{ item.type }}</md-table-cell>
      </md-table-row>
      
    </md-table>


    <!-- v-model="searched" -->
    <md-table v-model="searched" md-sort="no" md-sort-order="asc" md-card md-fixed-header @md-selected="onSelect" class="md-layout-item md-size-100"
      v-else>
      <md-table-toolbar>
        <div class="md-toolbar-section-start">
          <h3 class="title" style="font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;">
            주택 거래 내역 목록</h3>
        </div>

        <!-- 검색 필터링 -->
        <div class="md-toolbar-section-start md-layout-item md-size-100">
          <md-checkbox v-model="aptdeal">아파트 매매</md-checkbox>
          <md-checkbox v-model="aptrent">아파트 전월세</md-checkbox>
          <md-checkbox v-model="housedeal">다세대/주택 매매</md-checkbox>
          <md-checkbox v-model="houserent">다세대/주택 전월세</md-checkbox>
        </div>
        <div class="md-toolbar-section-start md-layout-item md-size-100">
          <md-field>
            <label for="searchby">SearchBy</label>
            <md-select v-model="searchby" name="searchby" id="searchby" md-dense>
              <md-option value="byDong">법정동</md-option>
              <md-option value="byAptName">주택명</md-option>
            </md-select>
          </md-field>
          <md-field md-clearable>
            <md-input placeholder="Search" v-model="search" @input="searchOnTable" />
          </md-field>
        </div>
      </md-table-toolbar>
      
      <!-- 검색 결과 없을 경우 -->
      <md-table-empty-state
        md-label="No Result"
        :md-description="`검색어 '${search}'에 대한 주택 거래 정보가 없습니다.`">
      </md-table-empty-state>

      <!-- 표 -->
      <md-table-row slot="md-table-row" slot-scope="{ item }" :class="getClass(item)" md-selectable="single">
        <md-table-cell md-label="번호" md-sort-by="no" md-numeric>{{ item.no }}</md-table-cell>
        <md-table-cell md-label="법정동" md-sort-by="dong">{{ item.dong }}</md-table-cell>
        <md-table-cell md-label="주택명" md-sort-by="aptName">{{ item.aptName }}</md-table-cell>
        <md-table-cell md-label="거래금액" md-sort-by="dealAmount" md-numeric>{{ item.dealAmount }}</md-table-cell>
        <md-table-cell md-label="거래종류" md-sort-by="type">{{ item.type }}</md-table-cell>
      </md-table-row>
      
    </md-table>

  </div>
</template>

<script>
  import { mapGetters, mapActions, mapState } from 'vuex';
  import http from '@/util/http-common';
  import axios from 'axios';

  import store from "@/store/store.js";

  const toLower = text => {
    return text.toString().toLowerCase()
  }

  const searchByDong = (items, term) => {
    if (term) {
      return items.filter(item => toLower(item.dong).includes(toLower(term)))
    }
    return items
  }

  const searchByAptName = (items, term) => {
    if (term) {
      return items.filter(item => toLower(item.aptName).includes(toLower(term)))
    }
    return items
  }

  const searchByAll = (items, term) => {
    if (term) {
      return items.filter(item => toLower(item.aptName).includes(toLower(term)) || toLower(item.dong).includes(toLower(term)))
    }
    return items
  }

  export default {
    name: 'house',
    data: () => ({
      country: null,
      dataExist: false,
      aptdeal: true,
      aptrent: true,
      housedeal: true,
      houserent: true,
      selectedNo: 0,
      search: null,
      searched: [],
      searchby: null,
    }),
    computed: {
      ...mapGetters(['housedealitems']),
      ...mapGetters(['housedealitem']),
    },
    methods: {
      searchOnTable () {
        this.dataExist = true;
        if(this.searchby == 'byDong') {
          this.searched = searchByDong(this.$store.state.housedealitems, this.search)
          console(this.searched.length)
        }
        else if(this.searchby == 'byAptName') {
          this.searched = searchByAptName(this.$store.state.housedealitems, this.search)
        }
        else {
          this.searched = searchByAll(this.$store.state.housedealitems, this.search)
        }
      },
      getClass: ({ no }) => ({
        'md-accent': no
      }),
      onSelect (item) {
        this.selectedNo = item.no,
        store.dispatch('getHousedealNo', item.no);
        store.dispatch('getHousedealitem', `/house/` + item.no);
      }
    },
    created () {
      store.dispatch('getHousedealitems', '/house');
    }
  }
</script>

<style lang="scss" scoped>
  .md-field {
    max-width: 300px;
  }
  .md-checkbox {
    display: flex;
  }
</style>