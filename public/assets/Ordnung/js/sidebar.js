app.component('ordnung-sidebar',  {
  data() {
    return {
      options: [ "New", "Load", "Save", "Save as", "Close" ]
    }
  },
  template:
  /*html*/
  `
  <div id="ordnung-sidebar" class="ordnung-sidebar">
    <div v-for="option in options">{{ option }}</div>
  </div>
  `
})
