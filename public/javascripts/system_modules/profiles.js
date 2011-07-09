$(document).ready(function(){
    $(".btn-relac").corner("5px");
    $(".btn-stop-relac").corner("5px");
    $(".btn-msg").corner("5px");
    $(".ok").corner("5px");
    $(".cancel").corner("5px");
	$("#send-message").corner("5px");
    
	$("a.btn-relac").colorbox();
    
	/* to control the opened window */
    var messageActive = new Array();
    messageActive['company'] = false;
	
    /* urls */
    var messageUrl = new Array();
    messageUrl['company'] = '/messages';

	/* bind message to company */
    $('#company-message').bind('click', function() {
		$( "#company-message-window" ).dialog({ 
												modal:true,
												minHeight: 300,
												minWidth: 350
											});
		return false;
    });

	$("form#company-message-form").bind('submit', function() {
        clearErrorMessages();
        
		if ( $('input#message-subject').val() == "" ) {
            $('input#message-subject').after("<span class='fieldWithError'>Digite um assunto</span>");
            return false;
        }

        if ( $("textarea#message-content").val() == "" ) {
            $('textarea#message-content').after("<span class='fieldWithError'>Digite uma mensagem</span>");
            return false;
        }

        $.ajax({
            type: 'POST',
            url: messageUrl['company'],
            data: $(this).serialize(),
            beforeSend: function(){
                $("#result-company-message-window").empty();
                $("#result-company-message-window").append("Enviando...");
            },
            success: function() {
                $("#result-company-message-window").empty();
                $("#result-company-message-window").append("Mensagem enviada");
            },
            error: function()  {
                $("#result-company-message-window").empty();
                $("#result-company-message-window").append("Erro ao enviar");
            },
            complete: function() {
				
            }
        });
        return false;
    });

	function clearErrorMessages(){
        $(".fieldWithError").remove();
    }


	$("#tabs").tabs({
				ajaxOptions: {
								error: function( xhr, status, index, anchor ) {
									$( anchor.hash ).html(
										"Estamos com indisponibilidade no momento. Volte em instantes. " );
								}
							}
			});

	$('#partners').click(function() { // bind click event to link
	    $tabs.tabs('select', 3); // switch to third tab
	    return false;
	});

});