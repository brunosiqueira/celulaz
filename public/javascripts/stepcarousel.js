
var stepcarousel={ajaxloadingmsg:'<div style="margin: 1em; font-weight: bold"><img src="ajaxloadr.gif" style="vertical-align: middle" /> Fetching Content. Please wait...</div>',defaultbuttonsfade:0.4,configholder:{},getCSSValue:function(val){return(val=="auto")?0:parseInt(val)},getremotepanels:function($,config){config.$belt.html(this.ajaxloadingmsg)
$.ajax({url:config.contenttype[1],async:true,error:function(ajaxrequest){config.$belt.html('Error fetching content.<br />Server Response: '+ajaxrequest.responseText)},success:function(content){config.$belt.html(content)
config.$panels=config.$gallery.find('.'+config.panelclass)
stepcarousel.alignpanels($,config)}})},getoffset:function(what,offsettype){return(what.offsetParent)?what[offsettype]+this.getoffset(what.offsetParent,offsettype):what[offsettype]},getCookie:function(Name){var re=new RegExp(Name+"=[^;]+","i");if(document.cookie.match(re))
return document.cookie.match(re)[0].split("=")[1]
return null},setCookie:function(name,value){document.cookie=name+"="+value},fadebuttons:function(config,currentpanel){config.$leftnavbutton.fadeTo('fast',currentpanel==0?this.defaultbuttonsfade:1)
config.$rightnavbutton.fadeTo('fast',currentpanel==config.lastvisiblepanel?this.defaultbuttonsfade:1)},addnavbuttons:function(config,currentpanel){config.$leftnavbutton=$('<img src="'+config.defaultbuttons.leftnav[0]+'">').css({zIndex:50,position:'absolute',left:config.offsets.left+config.defaultbuttons.leftnav[1]+'px',top:config.offsets.top+config.defaultbuttons.leftnav[2]+'px',cursor:'hand',cursor:'pointer'}).attr({title:'Back '+config.defaultbuttons.moveby+' panels'}).appendTo('body')
config.$rightnavbutton=$('<img src="'+config.defaultbuttons.rightnav[0]+'">').css({zIndex:50,position:'absolute',left:config.offsets.left+config.$gallery.get(0).offsetWidth+config.defaultbuttons.rightnav[1]+'px',top:config.offsets.top+config.defaultbuttons.rightnav[2]+'px',cursor:'hand',cursor:'pointer'}).attr({title:'Forward '+config.defaultbuttons.moveby+' panels'}).appendTo('body')
config.$leftnavbutton.bind('click',function(){stepcarousel.stepBy(config.galleryid,-config.defaultbuttons.moveby)})
config.$rightnavbutton.bind('click',function(){stepcarousel.stepBy(config.galleryid,config.defaultbuttons.moveby)})
if(config.panelbehavior.wraparound==false){this.fadebuttons(config,currentpanel)}
return config.$leftnavbutton.add(config.$rightnavbutton)},stopautostep:function(config){clearTimeout(config.steptimer)
clearTimeout(config.resumeautostep)},alignpanels:function($,config){var paneloffset=0
config.paneloffsets=[paneloffset]
config.panelwidths=[]
config.$panels.each(function(index){var $currentpanel=$(this)
$currentpanel.css({float:'none',position:'absolute',left:paneloffset+'px'})
$currentpanel.bind('click',function(e){return config.onpanelclick(e.target)})
paneloffset+=stepcarousel.getCSSValue($currentpanel.css('marginRight'))+parseInt($currentpanel.get(0).offsetWidth||$currentpanel.css('width'))
config.paneloffsets.push(paneloffset)
config.panelwidths.push(paneloffset-config.paneloffsets[config.paneloffsets.length-2])})
config.paneloffsets.pop()
var addpanelwidths=0
var lastpanelindex=config.$panels.length-1
config.lastvisiblepanel=lastpanelindex
for(var i=config.$panels.length-1;i>=0;i--){addpanelwidths+=(i==lastpanelindex?config.panelwidths[lastpanelindex]:config.paneloffsets[i+1]-config.paneloffsets[i])
if(config.gallerywidth>addpanelwidths){config.lastvisiblepanel=i}}
config.$belt.css({width:paneloffset+'px'})
config.currentpanel=(config.panelbehavior.persist)?parseInt(this.getCookie(window[config.galleryid+"persist"])):0
config.currentpanel=(typeof config.currentpanel=="number"&&config.currentpanel<config.$panels.length)?config.currentpanel:0
if(config.currentpanel!=0){var endpoint=config.paneloffsets[config.currentpanel]+(config.currentpanel==0?0:config.beltoffset)
config.$belt.css({left:-endpoint+'px'})}
if(config.defaultbuttons.enable==true){var $navbuttons=this.addnavbuttons(config,config.currentpanel)
$(window).bind("load resize",function(){config.offsets={left:stepcarousel.getoffset(config.$gallery.get(0),"offsetLeft"),top:stepcarousel.getoffset(config.$gallery.get(0),"offsetTop")}
config.$leftnavbutton.css({left:config.offsets.left+config.defaultbuttons.leftnav[1]+'px',top:config.offsets.top+config.defaultbuttons.leftnav[2]+'px'})
config.$rightnavbutton.css({left:config.offsets.left+config.$gallery.get(0).offsetWidth+config.defaultbuttons.rightnav[1]+'px',top:config.offsets.top+config.defaultbuttons.rightnav[2]+'px'})})}
if(config.autostep&&config.autostep.enable){var $carouselparts=config.$gallery.add(typeof $navbuttons!="undefined"?$navbuttons:null)
$carouselparts.bind('click',function(){stepcarousel.stopautostep(config)
config.autostep.status="stopped"})
$carouselparts.hover(function(){stepcarousel.stopautostep(config)
config.autostep.hoverstate="over"},function(){if(config.steptimer&&config.autostep.hoverstate=="over"&&config.autostep.status!="stopped"){config.resumeautostep=setTimeout(function(){stepcarousel.autorotate(config.galleryid)
config.autostep.hoverstate="out"},500)}})
config.steptimer=setTimeout(function(){stepcarousel.autorotate(config.galleryid)},config.autostep.pause)}
this.statusreport(config.galleryid)
config.oninit()
config.onslideaction(this)},stepTo:function(galleryid,pindex){var config=stepcarousel.configholder[galleryid]
if(typeof config=="undefined"){alert("There's an error with your set up of Carousel Viewer \""+galleryid+"\"!")
return}
stepcarousel.stopautostep(config)
var pindex=Math.min(pindex-1,config.paneloffsets.length-1)
var endpoint=config.paneloffsets[pindex]+(pindex==0?0:config.beltoffset)
if(config.panelbehavior.wraparound==false&&config.defaultbuttons.enable==true){this.fadebuttons(config,pindex)}
config.$belt.animate({left:-endpoint+'px'},config.panelbehavior.speed,function(){config.onslideaction(this)})
config.currentpanel=pindex
this.statusreport(galleryid)},stepBy:function(galleryid,steps){var config=stepcarousel.configholder[galleryid]
if(typeof config=="undefined"){alert("There's an error with your set up of Carousel Viewer \""+galleryid+"\"!")
return}
stepcarousel.stopautostep(config)
var direction=(steps>0)?'forward':'back'
var pindex=config.currentpanel+steps
if(config.panelbehavior.wraparound==false){pindex=(direction=="back"&&pindex<=0)?0:(direction=="forward")?Math.min(pindex,config.lastvisiblepanel):pindex
if(config.defaultbuttons.enable==true){stepcarousel.fadebuttons(config,pindex)}}
else{if(pindex>config.lastvisiblepanel&&direction=="forward"){pindex=(config.currentpanel<config.lastvisiblepanel)?config.lastvisiblepanel:0}
else if(pindex<0&&direction=="back"){pindex=(config.currentpanel>0)?0:config.lastvisiblepanel}}
var endpoint=config.paneloffsets[pindex]+(pindex==0?0:config.beltoffset)
if(pindex==0&&direction=='forward'||config.currentpanel==0&&direction=='back'&&config.panelbehavior.wraparound==true){config.$belt.animate({left:-config.paneloffsets[config.currentpanel]-(direction=='forward'?100:-30)+'px'},'normal',function(){config.$belt.animate({left:-endpoint+'px'},config.panelbehavior.speed,function(){config.onslideaction(this)})})}
else
config.$belt.animate({left:-endpoint+'px'},config.panelbehavior.speed,function(){config.onslideaction(this)})
config.currentpanel=pindex
this.statusreport(galleryid)},autorotate:function(galleryid){var config=stepcarousel.configholder[galleryid]
if(config.$gallery.attr('_ismouseover')!="yes"){this.stepBy(galleryid,config.autostep.moveby)}
config.steptimer=setTimeout(function(){stepcarousel.autorotate(galleryid)},config.autostep.pause)},statusreport:function(galleryid){var config=stepcarousel.configholder[galleryid]
var startpoint=config.currentpanel
var visiblewidth=0
for(var endpoint=startpoint;endpoint<config.paneloffsets.length;endpoint++){visiblewidth+=config.panelwidths[endpoint]
if(visiblewidth>config.gallerywidth){break}}
startpoint+=1
endpoint=(endpoint+1==startpoint)?startpoint:endpoint
var valuearray=[startpoint,endpoint,config.panelwidths.length]
for(var i=0;i<config.statusvars.length;i++){window[config.statusvars[i]]=valuearray[i]
config.$statusobjs[i].text(valuearray[i]+" ")}},setup:function(config){document.write('<style type="text/css">\n#'+config.galleryid+'{overflow: hidden;}\n</style>')
jQuery(document).ready(function($){config.$gallery=$('#'+config.galleryid)
config.gallerywidth=config.$gallery.width()
config.offsets={left:stepcarousel.getoffset(config.$gallery.get(0),"offsetLeft"),top:stepcarousel.getoffset(config.$gallery.get(0),"offsetTop")}
config.$belt=config.$gallery.find('.'+config.beltclass)
config.$panels=config.$gallery.find('.'+config.panelclass)
config.panelbehavior.wraparound=(config.autostep&&config.autostep.enable)?true:config.panelbehavior.wraparound
config.onpanelclick=(typeof config.onpanelclick=="undefined")?function(target){}:config.onpanelclick
config.onslideaction=(typeof config.onslide=="undefined")?function(){}:function(beltobj){$(beltobj).stop();config.onslide()}
config.oninit=(typeof config.oninit=="undefined")?function(){}:config.oninit
config.beltoffset=stepcarousel.getCSSValue(config.$belt.css('marginLeft'))
config.statusvars=config.statusvars||[]
config.$statusobjs=[$('#'+config.statusvars[0]),$('#'+config.statusvars[1]),$('#'+config.statusvars[2])]
config.currentpanel=0
stepcarousel.configholder[config.galleryid]=config
if(config.contenttype[0]=="ajax"&&typeof config.contenttype[1]!="undefined")
stepcarousel.getremotepanels($,config)
else
stepcarousel.alignpanels($,config)})
jQuery(window).bind('unload',function(){if(config.panelbehavior.persist){stepcarousel.setCookie(window[config.galleryid+"persist"],config.currentpanel)}
jQuery.each(config,function(ai,oi){oi=null})
config=null})}}