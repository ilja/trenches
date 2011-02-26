$(function() {
  $('.expand').click(function(){
    var storybody = $(this).parents("li.story").children('.storybody');

    if (storybody.css('display') == 'none'){
      $(this).find("img").attr({src:"/images/close.png"});
    } else {
      $(this).find("img").attr({src:"/images/open.png"});
    }

    storybody.toggle('fast');
  });
});
