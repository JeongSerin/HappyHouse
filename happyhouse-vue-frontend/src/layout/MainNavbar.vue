<template>
  <md-toolbar
    id="toolbar"
    md-elevation="0"
    class="md-transparent md-absolute"
    :class="extraNavClasses"
    :color-on-scroll="colorOnScroll"
  >
    <div class="md-toolbar-row md-collapse-lateral">
      <div class="md-toolbar-section-start">
        <router-link to="/">
          <h3 class="md-title"><i class="material-icons">home</i>Happy House</h3>
        </router-link>
      </div>
      <div class="md-toolbar-section-end">
        <md-button
          class="md-just-icon md-simple md-toolbar-toggle"
          :class="{ toggled: toggledClass }"
          @click="toggleNavbarMobile()"
        >
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </md-button>

        <div class="md-collapse">
          <div class="md-collapse-wrapper">
            <mobile-menu nav-mobile-section-start="false">
              <!-- Here you can add your items from the section-start of your toolbar -->
            </mobile-menu>
            <md-list>
              <!-- <md-list-item href="/" target="_blank" onclick="return false;" v-if="showDownload">
                <router-link to="/origin">
                  <i class="material-icons">content_paste</i><p>Origin</p>
                </router-link>
              </md-list-item> -->
              
              <md-list-item href="/" target="_blank" onclick="return false;" v-if="$store.state.isLogin">
                <router-link to="/notice">
                  <i class="material-icons">content_paste</i><p>공지사항</p>
                </router-link>
              </md-list-item>

              <md-list-item href="/" target="_blank" onclick="return false;" v-if="$store.state.isLogin">
                <router-link to="/fav">
                  <i class="fa fa-star"></i><p>관심지역</p>
                </router-link>
              </md-list-item>

              <md-list-item href="/" target="_blank" onclick="return false;" v-if="$store.state.isLogin">
                <router-link to="/qna">
                  <i class="material-icons">comments</i><p>Q&A</p>
                </router-link>
              </md-list-item>

              <!--
              <li class="md-list-item">
                <a
                  href="javascript:void(0)"
                  class="md-list-item-router md-list-item-container md-button-clean dropdown"
                >
                  <div class="md-list-item-content">
                    <drop-down direction="down">
                      <md-button
                        slot="title"
                        class="md-button md-button-link md-white md-simple dropdown-toggle"
                        data-toggle="dropdown"
                      >
                        <i class="material-icons">view_carousel</i>
                        <p>Examples</p>
                      </md-button>
                      <ul class="dropdown-menu dropdown-with-icons">
                        <li>
                          <a href="/landing">
                            <i class="material-icons">view_day</i>
                            <p>Landing Page</p>
                          </a>
                        </li>
                        <li>
                          <a href="/profile">
                            <i class="material-icons">account_circle</i>
                            <p>Profile Page</p>
                          </a>
                        </li>
                      </ul>
                    </drop-down>
                  </div>
                </a>
              </li>
              -->

              <md-list-item href="/" target="_blank" onclick="return false;" v-if="$store.state.isLogin">
                <router-link to="/profile">
                  <i class="fa fa-user"></i><p>{{ $store.state.userInfo.name }} 님</p>
                </router-link>
                <md-tooltip md-direction="bottom">MyPage</md-tooltip>
              </md-list-item>

              <md-list-item href="/" target="_blank" onclick="return false;"
              @click="goLogout" v-if="$store.state.isLogin">
                  <i class="fa fa-lock-open"></i><p>Logout</p>
              </md-list-item>
              
              <md-list-item href="/" target="_blank" onclick="return false;" v-if="showDownload && !$store.state.isLogin"
              @click="$store.state.loginModal = true">
                <i class="fa fa-lock"></i><p>Login</p>
              </md-list-item>

              <md-list-item href="/" target="_blank" onclick="return false;">
                <router-link to="/signup" v-if="!$store.state.isLogin">
                  <i class="fa fa-address-card"></i><p>회원가입</p>
                </router-link>
              </md-list-item>
            </md-list>
          </div>
        </div>
      </div>
    </div>
  </md-toolbar>
</template>

<script>
let resizeTimeout;
function resizeThrottler(actualResizeHandler) {
  // ignore resize events as long as an actualResizeHandler execution is in the queue
  if (!resizeTimeout) {
    resizeTimeout = setTimeout(() => {
      resizeTimeout = null;
      actualResizeHandler();

      // The actualResizeHandler will execute at a rate of 15fps
    }, 66);
  }
}

import MobileMenu from "@/layout/MobileMenu";
//import { Modal } from "@/components";
//import { LoginCard } from "@/components";

import store from "@/store/store.js";

export default {
  components: {
    //LoginCard,
    //Modal,
    MobileMenu
  },
  props: {
    type: {
      type: String,
      default: "white",
      validator(value) {
        return [
          "white",
          "default",
          "primary",
          "danger",
          "success",
          "warning",
          "info"
        ].includes(value);
      }
    },
    colorOnScroll: {
      type: Number,
      default: 0
    }
  },
  data() {
    return {
      isLogin: false,
      classicModal: false,
      extraNavClasses: "",
      toggledClass: false
    };
  },
  computed: {
    showDownload() {
      const excludedRoutes = ["signup"];
      return excludedRoutes.every(r => r !== this.$route.name);
    }
  },
  methods: {
    bodyClick() {
      let bodyClick = document.getElementById("bodyClick");

      if (bodyClick === null) {
        let body = document.querySelector("body");
        let elem = document.createElement("div");
        elem.setAttribute("id", "bodyClick");
        body.appendChild(elem);

        let bodyClick = document.getElementById("bodyClick");
        bodyClick.addEventListener("click", this.toggleNavbarMobile);
      } else {
        bodyClick.remove();
      }
    },
    toggleNavbarMobile() {
      this.NavbarStore.showNavbar = !this.NavbarStore.showNavbar;
      this.toggledClass = !this.toggledClass;
      this.bodyClick();
    },
    handleScroll() {
      let scrollValue =
        document.body.scrollTop || document.documentElement.scrollTop;
      let navbarColor = document.getElementById("toolbar");
      this.currentScrollValue = scrollValue;
      if (this.colorOnScroll > 0 && scrollValue > this.colorOnScroll) {
        this.extraNavClasses = `md-${this.type}`;
        navbarColor.classList.remove("md-transparent");
      } else {
        if (this.extraNavClasses) {
          this.extraNavClasses = "";
          navbarColor.classList.add("md-transparent");
        }
      }
    },
    scrollListener() {
      resizeThrottler(this.handleScroll);
    },
    scrollToElement() {
      let element_id = document.getElementById("downloadSection");
      if (element_id) {
        element_id.scrollIntoView({ block: "end", behavior: "smooth" });
      }
    },
    goLogout() {
      //alert("로그아웃 되었습니다.");
      store.dispatch('logout', { url: '/' });
    }
  },
  mounted() {
    document.addEventListener("scroll", this.scrollListener);
  },
  beforeDestroy() {
    document.removeEventListener("scroll", this.scrollListener);
  },
  created() {
    this.isLogin = store.state.isLogin
  }
};
</script>
