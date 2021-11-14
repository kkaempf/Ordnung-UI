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
  },
  template: `
    {{ entries }} entries
  `
}
