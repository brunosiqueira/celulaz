$(document).ready(function(){
    $(".btn-relac").corner("5px");
    $(".btn-stop-relac").corner("5px");
    $(".btn-msg").corner("5px");
    $(".ok").corner("5px");
    $(".cancel").corner("5px");
    $("a.btn-relac").colorbox();
    $('.false-input').editable('/company/messages/create',{
        type:'textarea',
        rows:8,
        cssclass:'edit',
        cancel:'Cancelar ',
        submit:' Enviar ',
        indicator:"<img src='/images/colorbox/loading.gif'/>",
        placeholder:'Escreva uma mensagem...',
        data:function(value,settings){
            var retval=value.replace(/<br[\s\/]?>/gi,'\n');
            return retval
        },
        submitdata:{
            authenticity_token:AUTH_TOKEN,
            message:{
                subject:'Enviado do perfil público',
                to:[$(".hidden_id").attr('value')]
            },
            public_profile:true
        },
        callback: function(){
            $('.false-input').html('Escreva uma mensagem...')
            }
    })
});