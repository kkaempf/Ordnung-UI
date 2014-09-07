// defaults.js

var zoom = 0;

var set_thumbnail_size = function() {
  $('.thumbnail').css('width', zoom+"px");
  $('.thumbnail').css('height', zoom+"px");
};

// feed window size change back to application
var log_size = function(with_redraw) {
  var ordnung_middle_w = $( '#ordnung_middle' ).width();
  var ordnung_middle_h = $(window).height() - $('#navbar').height();
//  console.log((with_redraw?"redraw!":"") + " W "+ ordnung_middle_w + " H " + ordnung_middle_h );
  uri = "/resize/" + ordnung_middle_w + "/" + ordnung_middle_h + "/" + zoom;
  if (with_redraw) {
    $.ajax(uri, {
      success: redraw_dashboard
    });
  }
  else {
    $.ajax(uri);
  };
};

// fill dashboard content
var fill_dashboard = function(data) {
  $('#dashboard_content').html(data);
  set_thumbnail_size();
}

// redraw dashboard content
var redraw_dashboard = function(data) {
  zoom = data.zoom;
  $.ajax('/dashboard/redraw', {
    success: fill_dashboard
  });
}

// handle resize events (throttled)
var doit;
$( window ).resize(function() {
  // throttle resize events
  clearTimeout(doit);
  doit = setTimeout(function() {
    log_size(true);
  }, 250);
});

// start app
$( window ).ready(function() {
  // change mouse cursor over zoom elements
  $('.glyphicon').hover(
    function() { // enter
      $('html,body').css('cursor', 'pointer');
    },
    function() { // leave
      $('html,body').css('cursor', 'default');
    }
  );
  // make page elements clickable
  $('#page_previous').click(function() {
  });
  $('#page_next').click(function() {
  });
  // make zoom elements clickable
  $('#zoom_in').click(function() {
    if (zoom < 300) {
      zoom += 10;
      log_size(true);
    }
  });
  $('#zoom_out').click(function() {
    if (zoom > 0) {
      zoom -= 10;
      log_size(true);
    }
  });
  // feed window size back to app
  log_size(true);
});