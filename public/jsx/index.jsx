var Index = React.createClass({

  render: function() {
    return(<h1>Hello {this.props.name}!</h1>)
  }

});

ReactDOM.render(
  <Index name='World'/>,
  document.getElementById('index')
);
