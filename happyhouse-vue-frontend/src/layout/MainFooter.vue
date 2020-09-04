<template>
  <footer
    class="footer"
    :class="{ [`footer-${type}`]: type }"
    :data-background-color="backgroundColor"
  >
    <div class="container">
      <nav>
        <ul>
          <li>
            <router-link to="/landing">
              About Us
            </router-link>
          </li>
        </ul>
      </nav>
      <div class="copyright">
        &copy; {{ year }}, made by 김소희 & 정세린 using <a href="https://kr.vuejs.org/">Vue.js</a>
      </div>
    </div>
  </footer>
</template>
<script>
export default {
  props: {
    backgroundColor: String,
    type: String
  },
  data() {
    return {
      year: new Date().getFullYear()
    };
  }
};
</script>
<style></style>
