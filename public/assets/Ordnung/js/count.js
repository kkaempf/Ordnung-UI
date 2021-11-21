const Count = {
  data() {
    return {
      count: 0
    }
  },
  mounted() {
    axios.get('/api/files/count')
    .then(response =>
      this.count = response.data.count
    )
  },
  template: `
    <div>
      {{ count }} entries
    </div>
  `
}
