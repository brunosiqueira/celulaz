$(document).ready(function(){
	//navegacao pelo feed
    $.bottomlessPagination({
        objName:'atividades',
        ajaxLoaderPath:"/images/colorbox/loading.gif",
        callback:null,
        results:'.feeds'
    });
	
	//componente - envio de e-mail 
    $('a.sent-to-friend-obs-link').click(function(){
        $('#message_to_friend_observations').show("slow");
        $(this).hide()
    });

    $('form#message-to-friend-form').submit(function(){
        if(!isValidEmail($('form#message-to-friend-form >input#message_to_friend_email_to').val())){
            $('form#message-to-friend-form > span.fieldWithError').html('Digite um e-mail v&aacute;lido.');
        }
		else {
            $.post(this.action,$(this).serialize(),null,"script");
        }
        return false;
    });

	$("form#recommendations").bind('submit', function(){
		$("form#recommendations > span.fieldWithError").empty();
		$("form#recommendations > div#result").remove();
		var $this = $(this);
		var addresses = $("form#recommendations > input#addresses").val();

		if (addresses == '' || !isValidEmail(addresses)){
			$("form#recommendations > span.fieldWithError").append('Digite um e-mail v&aacute;lido.');
			return false;
		}
		
		$.ajax({
            type: 'POST',
            url: $this.attr('action'),
            data: $(this).serialize(),
            beforeSend: function(){
                
            },
            success: function() {
                $("form#recommendations > input.btn-input").after("<div id='result'>Convite enviado</div>");
            },
            error: function()  {
                
            },
            complete: function() {
				$this[0].reset();
            }
        });
		
		return false;
	});
	
	function isValidEmail(email){
        var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        return filter.test(email);
    }

    $("h4").corner("3px");
	$(".sidebar > .box").corner("8px");

	
	$(".feeds .remove-feed").removeFeed();
});