app.component('ordnung-header',  {
  data() {
    return {
      title: 'Chaos',
      image: './public/assets/images/Ordnung_Chaos.jpg'
    }
  },
  template:
  /*html*/
  `
  <div id="ordnung-header" class="ordnung-header">
    <img v-bind:src="image"/>
    <h1>{{ title }}</h1>
  </div>
  `
})
