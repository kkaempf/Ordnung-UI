var Entry = React.createClass({
  entryStyle: {
    borderStyle: 'solid',
    margin: '0 10px 10px 0',
    float: 'left',
    height: 42,
    width: 42
  },
  render: function() {
    console.log("XEntry:" + this.props.data);
    return <div style={this.entryStyle}></div>;
  }
});
