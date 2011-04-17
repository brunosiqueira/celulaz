$(document).ready(function(){
    $("li.active a").corner("5px top");
    $("a.change-password").click(function(){
        if($('div#change-password').css('display')=="none"){
            $('div#change-password').show('slow')
            }else{
            $('div#change-password').hide('slow')
            }
        });
$('form.change-password').submitWithAjax();
    $("div.alt-thumb").click(function(){
    $("form.image_profile_logo").show("slow")
    })
});