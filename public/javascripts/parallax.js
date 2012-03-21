function verticalPosition(tile_height, speed_ratio, scroll_position) {
  return tile_height - (Math.floor(scroll_position / speed_ratio) % (tile_height+1));
}

$(document).ready(function () {
  $(window).scroll(function () {
    var posY = (document.documentElement.scrollTop) ? document.documentElement.scrollTop : window.pageYOffset;
    
    $('#ground').css('backgroundPosition', "0 " + verticalPosition(230, 8, posY) + "px");
  });
});