(function($){$.fn.thumbPopup=function(options)
{settings=jQuery.extend({popupId:"thumbPopup",popupCSS:{'border':'1px solid #000000','background':'#FFFFFF'},imgSmallFlag:"_t",imgLargeFlag:"_l",cursorTopOffset:15,cursorLeftOffset:15,loadingHtml:"<span style='padding: 5px;'>Loading</span>"},options);popup=$("<div />").css(settings.popupCSS).attr("id",settings.popupId).css("position","absolute").appendTo("body").hide();$(this).hover(setPopup).mousemove(updatePopupPosition).mouseout(hidePopup);function setPopup(event)
{var fullImgURL=$(this).attr("src").replace(settings.imgSmallFlag,settings.imgLargeFlag);$(this).data("hovered",true);$("<img />").bind("load",{thumbImage:this},function(event)
{if($(event.data.thumbImage).data("hovered")==true){$(popup).empty().append(this);updatePopupPosition(event);$(popup).show();}
$(event.data.thumbImage).data("cached",true);}).attr("src",fullImgURL);if($(this).data("cached")!=true){$(popup).append($(settings.loadingHtml));$(popup).show();}
updatePopupPosition(event);}
function updatePopupPosition(event)
{var windowSize=getWindowSize();var popupSize=getPopupSize();if(windowSize.width+windowSize.scrollLeft<event.pageX+popupSize.width+settings.cursorLeftOffset){$(popup).css("left",event.pageX-popupSize.width-settings.cursorLeftOffset);}else{$(popup).css("left",event.pageX+settings.cursorLeftOffset);}
if(windowSize.height+windowSize.scrollTop<event.pageY+popupSize.height+settings.cursorTopOffset){$(popup).css("top",event.pageY-popupSize.height-settings.cursorTopOffset);}else{$(popup).css("top",event.pageY+settings.cursorTopOffset);}}
function hidePopup(event)
{$(this).data("hovered",false);$(popup).empty().hide();}
function getWindowSize(){return{scrollLeft:$(window).scrollLeft(),scrollTop:$(window).scrollTop(),width:$(window).width(),height:$(window).height()};}
function getPopupSize(){return{width:$(popup).width(),height:$(popup).height()};}
return this;};})(jQuery);