/* Formatters */
function timestampReduce(timestamp) {
  arr = timestamp.split("T");
  return arr[0];
}

function routeUrl(url) {
  return '<a href="' + url + '" target="_blank">' + url + '</a>';
}
