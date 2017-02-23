function span_class_value(value, klass) {
  c = "test_result_value";
  if (value > 0) {
    c += " ";
    c += klass;
  }
  s = "<td class='" + c + "'>";
  s += value;
  return s + "</td>";
}

function index(colors){
  $.getJSON("/ordnung/index", function (json) {
  });
}
