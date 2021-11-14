const Header = {
  data() {
    return {
      title: 'Chaos',
      image: '/images/Ordnung_Chaos.jpg'
    }
  },
  mounted() {
    console.log("Header is mounted");
  },
  template:
  /*html*/
  `
  <div id="ordnung-header" class="ordnung-header">
    <span>
      <img class="header-image" v-bind:src="image"/>
      {{ title }}
    </span>
  </div>
  `
}
