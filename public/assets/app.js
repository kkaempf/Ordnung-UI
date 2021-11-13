const Entries = {
  data() {
    return {
      entries: 0
    }
  },
  mounted() {
    axios.get('/api/file/count.json')
    .then(response =>
      this.entries = response.data.count
    )
  }
}
console.log("In app.js");
const app = Vue.createApp(Entries);
console.log("app ", app);
