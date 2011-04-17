
jQuery.ajaxSetup({
    'beforeSend': function(xhr) {
        xhr.setRequestHeader("Accept", "text/javascript")
    }
})

jQuery.fn.submitWithAjax = function() {
    this.submit(function() {
        $.post(this.action, $(this).serialize(), null, "script");
        return false;
    })
    return this;
};
$(document).ready(function() { 

    $("div#content form").each(function(){
        var form_class = $(this).attr('class');
        var form_id = $(this).attr('data');
        var form_action = $(this).attr('action');

        $("."+form_class+"").submit(function() {

            var $this = $(this);

            var public_profile_name 	= $(".public_profile_name_" + form_id);
            var message_sender_email 	= $(".message_sender_email_" + form_id);
            var message_body 			= $(".message_body_" + form_id);

            //validating name
            if ( public_profile_name.val() == "" ) {
                clearErrorMessages();
                public_profile_name.after("<span class='fieldWithError'>Digite um nome</span>");
                return false;
            }
		
            //validating email
            if ( ( message_sender_email.val() == "") || (!isValidEmail(message_sender_email.val())) ) {
                clearErrorMessages();
                message_sender_email.after("<span class='fieldWithError'>Digite seu e-mail válido</span>");
                return false;
            }
		
            //validating message
            if ( message_body.val() == "" ) {
                clearErrorMessages();
                message_body.after("<span class='fieldWithError'>Digite sua mensagem</span>");
                return false;
            }
            $("span.fieldWithError").remove();
		
            $.ajax({
                type: 'POST',
                url: form_action,
                data: $this.serialize(),
                beforeSend: function(){
                    $(".result-message-window").empty();
                    $(".result-message-window").append("Enviando...");
                },
                success: function() {
                    $(".result-message-window").empty();
                    $(".result-message-window").append("Mensagem enviada");
                     $this.get(0).reset();
                },
                error: function()  {
                    $(".result-message-window").empty();
                    $(".result-message-window").append("Erro ao enviar");
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

});