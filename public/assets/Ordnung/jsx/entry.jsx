var Entry = React.createClass({
  entryStyle: {
    borderStyle: 'solid',
    margin: '0 10px 10px 0',
    float: 'left',
    height: 50,
    width: 50,
    fontSize: '50%'
  },
  getInitialState: function() {
    console.log("Entry getInitialState");
    return { data: null };
  },
  componentDidMount: function() {
    console.log("Entry componentDidMount");
    $.get("/ordnung/entry/"+this.props.hash).done(function(data) {
      console.log("Entry /ordnung/entry/"+this.props.hash);
      this.setState({data: data});
    }.bind(this));
  },
  render: function() {
    if (this.state.data) {
      console.log("Entry data:" + this.state.data);
      return <div style={this.entryStyle}>{this.state.data.name}</div>;
    }
    console.log("Entry hash:" + this.props.hash);
    return <div style={this.entryStyle}></div>;
  }
});
