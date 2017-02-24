var Index = React.createClass({
  render: function() {
    console.log("Entries: " + this.props.entries);
    return(<h1>Hello {this.props.entries}!</h1>);
  },
  componentDidMount: function() {
    console.log("componentDidMount");
    var _this = this;
    fetch("/ordnung/index").then(function(response) {
      console.log("fetch");
      _this.setState({entries: "Foo"});
    });
  }
});

ReactDOM.render(
  <Index entries='World'/>,
  document.getElementById('index')
);