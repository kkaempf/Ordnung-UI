
var Entries = React.createClass({
  render: function() {
    console.log("Entries.render: " + JSON.stringify(this.props.data));
    this.props.data.map((entry) =>
      console.log("Entries.entry " + entry)
    )
    return <div>{this.props.data.map((entry) =>
      <Entry data={entry} key={entry}/>
    )}</div>;
  }
});

var Index = React.createClass({
  getInitialState: function() {
    console.log("getInitialState");
    return { data: null };
  },
  componentDidMount: function() {
    console.log("componentDidMount");
    $.get("/ordnung/index").done(function(entries) {
      console.log("/ordnung/index");
      this.setState({data: entries});
    }.bind(this));
  },
  render: function() {
    console.log("render");
    if (this.state.data) {
      console.log("calling Entries: " + this.state.data);
      return <Entries data={this.state.data} />;
    }
    return <div>Loading ...</div>;
  }
});

ReactDOM.render(
  <Index entries='World'/>,
  document.getElementById('index')
);



