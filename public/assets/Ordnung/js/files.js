const Files = {
  data() {
    return {
      offset: 0,
      limit: 5,
      files: null
    }
  },
  mounted() {
    console.log("Files.mounted");
    axios.get('/api/files?offset=' + this.offset + '&limit=' + this.limit)
    .then(response =>
      this.files = response.data.files
    )
  },
  template: `
    <div v-for="f in files">
      <item :itemKey="f"></item>
    </div>
  `
}
