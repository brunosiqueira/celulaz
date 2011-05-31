$(document).ready(function() { 
    /* to control the opened window */
    var messageActive = new Array();
    messageActive['company'] = false;
    messageActive['friend'] = false;
	
    /* urls */
    var messageUrl = new Array();
    messageUrl['company'] = '/messages';
    messageUrl['friend'] = '/company_to_friend';

    /* bind message to company */
    $('#company-message').bind('click', function() {
        verifyOpenedWindow();
        openWindowMessage('company');
		
		
        /* validateWindow */
        $("form#company-message-form").submit( function() {
            clearErrorMessages();
            if ( ($('input#company_email').val() == "") || (!isValidEmail($('input#company_email').val())) ) {
                $('input#company_email').after("<span class='fieldWithError'>Digite um e-mail válido</span>");
                return false;
            }
			
            if ( $("textarea#message").val() == "" ) {
                $('textarea#message').after("<span class='fieldWithError'>Digite uma mensagem</span>");
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
		
    });
	
    /* bind message to friend */
    $('#friend-message').bind('click', function(){
        verifyOpenedWindow();
        openWindowMessage('friend');
		
        /* validateWindow */
        $("form#friend-message-form").submit( function() {
            clearErrorMessages();
            if ( ($('input#friend_email').val() == "") || (!isValidEmail($('input#friend_email').val())) ) {
                $('input#friend_email').after("<span class='fieldWithError'>Digite um e-mail válido</span>");
                return false;
            }
			
            $.ajax({
                type: 'POST',
                url: messageUrl['friend'],
                data: $(this).serialize(),
                beforeSend: function(){
                    $("#result-friend-message-window").empty();
                    $("#result-friend-message-window").append("Enviando...");
                },
                success: function() {
                    $("#result-friend-message-window").empty();
                    $("#result-friend-message-window").append("Mensagem enviada");
                },
                error: function()  {
                    $("#result-friend-message-window").empty();
                    $("#result-friend-message-window").append("Erro ao enviar");
                },
                complete: function() {
					
                }
            });
            return false;
        });
		
    });
	
	
    function clearErrorMessages(){
        $(".fieldWithError").remove();
    }
	
    function isValidEmail(email){
        var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        return filter.test(email);
    }
	
    function verifyOpenedWindow(){
        for (var i in messageActive) {
            if ( messageActive[i] === true ) {
                closeWindowMessage(i);
            }
        }
    }
	
    function openWindowMessage(windowType){
        $('#' + windowType + '-message-window').show('slow', function() {
            messageActive[windowType] = true;
            $('#close-' + windowType + '-message-window').bind('click', function(){
                closeWindowMessage(windowType);
            });
        });
    }
	
    function closeWindowMessage(windowType){
        messageActive[windowType] = false;
        $('#' + windowType + '-message-window').hide('slow');
    }
    //print button
    $("#print").bind("click", function(){
        window.print();
        return false;
    });
    
    $("#cv-img-master-box img").thumbPopup({
        imgSmallFlag: "/small/",
        imgLargeFlag: "/preview/",
        loadingHtml: '<img src="/images/colorbox/loading.gif"/>',
        cursorTopOffset: 0
    });
	
});

