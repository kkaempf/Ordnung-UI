const Item = {
  props: {
    itemKey: String
  },
  data() {
    return {
      item: {}
    }
  },
  mounted() {
/*    console.log('Key ' + this.itemKey); */
    axios.get('/api/item/' + this.itemKey)
    .then(response =>
      this.item = response.data.item
    )
  },
  template:
  /*html*/
  `
  <div class="panel-item">{{ this.itemKey }} {{ this.item.name }}</div>
  `
}
