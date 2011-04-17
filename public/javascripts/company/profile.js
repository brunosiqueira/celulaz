$(document).ready(function(){
    $.bottomlessPagination({
        objName:'atividades',
        ajaxLoaderPath:"/images/colorbox/loading.gif",
        callback:null,
        results:'.feeds'
    });
    $('a.sent-to-friend-obs-link').click(function(){
        $('.sent-to-friend-obs').show("slow");
        $(this).hide()
    });
    $('form#message-to-friend-form').submit(function(){
        if(!isValidEmail($('input#message_to_friend_email_to').val())){
            $('span.message_error_email_to').html('email deve ser preenchido corretamente')
        }else{
            $.post(this.action,$(this).serialize(),null,"script")
        }
        return false
    });
    $("h4").corner("3px");
    $("#send-to-friend").corner("5px");
    $(".analytcs").corner("5px");
    $(".feeds .remove-feed").removeFeed();
});