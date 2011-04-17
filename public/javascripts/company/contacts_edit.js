function arredondaCantos(){
    $('.btn').corner("5px");
    $('.preview').corner("15px");
    $('.publish').corner("15px");
    $('h4').corner("3px");
    $('#inf_numero1').corner("5px");
    $('.gray-box').corner("5px");
    $('.submenu ul li.active a').corner("5px 5px 0 0 top");
}

$(document).ready(function() {
    arredondaCantos();
    (function($){
        $.fn.fieldController = function(settings){

            var form = settings.form;
            var controller = $(this);

            return this.each(function() {
                $(controller).click(function(){
                    controller.hide();
                    $("."+form+"").show("slow", function(){
                        $(this).delegate("a", "click", function(){
                            $(this).parent().parent().parent().hide();
                            controller.show("slow");
                            return false;
                        });
                    });
                    return false;
                });
            });
        };
    })(jQuery);

    (function($){
        $.fn.phoneController = function(){

            return this.each(function() {
                var $this = $(this);
                $this.click(function(){
                    $.ajax({
                        type: 'POST',
                        url: '/company/layout_contact/destroy_phone',
                        data: 'id='+ $this.attr('data'),
                        success:function(){
                            $this.parent().remove();
                        }
                    });
                    return false;
                });
            });
        };
    })(jQuery);

    $("a.address-view").fieldController({
        form:'address-form'
    });
    $('form.edit_layout_address').submitWithAjax();

    $("a.city-view").fieldController({
        form:'city-form'
    });
    $('form.edit_layout_city').submitWithAjax();

    $("a.state-view").fieldController({
        form:'state-form'
    });
    $('form.edit_layout_state').submitWithAjax();

    $("a.zip-view").fieldController({
        form:'zip-form'
    });
    $('form.edit_layout_zip').submitWithAjax();

    $("a.email-view").fieldController({
        form:'email-form'
    });
    $('form.edit_layout_email').submitWithAjax();

    $("a.facebook-view").fieldController({
        form:'facebook-form'
    });
    $('form.edit_layout_facebook').submitWithAjax();

    $("a.orkut-view").fieldController({
        form:'orkut-form'
    });
    $('form.edit_layout_orkut').submitWithAjax();

    $("a.twitter-view").fieldController({
        form:'twitter-form'
    });
    $('form.edit_layout_twitter').submitWithAjax();

    $("a.flickr-view").fieldController({
        form:'flickr-form'
    });
    $('form.edit_layout_flickr').submitWithAjax();

    $("a.delete_phone").phoneController();

    $("form.add_phone").submitWithAjax();
    jQuery("input#show_address_site").click(function(){
        jQuery.ajax({
            async:true,
            url:'/company/layout_contact/update_attribute',
            type:'POST',
            data:{
                _method:'PUT',
                authenticity_token:AUTH_TOKEN,
                field: 'show',
                value:jQuery("input#show_address_site").is(':checked')
            },
            success:function(data){
            },
            error:function(request){
                alert('Ocorreu um erro durante a ação. Entre em contato com seu administrador.');
            }
        });
    });
    jQuery("input#show_address_sidebar").click(function(){
        jQuery.ajax({
            async:true,
            url:'/company/layout_contact/update_attribute',
            type:'POST',
            data:{
                _method:'PUT',
                field: 'show_sidebar',
                authenticity_token:AUTH_TOKEN,
                value:jQuery("input#show_address_sidebar").is(':checked')
            },
            success:function(data){
            },
            error:function(request){
                alert('Ocorreu um erro durante a ação. Entre em contato com seu administrador.');
            }
        });
    });
    $('a.publish').click(function(){
        $('.publish-message').html('Seu site está sendo gerado. Aguarde.');
        $('.publish-message').show();
        jQuery.ajax({
            async:true,
            url:'/company/publish/create.json',
            type:'POST',
            data:{
                authenticity_token:AUTH_TOKEN
            },
            success:function(request){
                $('.publish-message').html('Seu site está disponível em: <a href="'+request+'" target="blank">'+request+"</a>")
            },
            error:function(request){
                $('.publish-message').html("Ocorreu um erro na criação no seu site. Entre em contato com um de nossos administradores.");
                $('body').css('cursor','auto')
            }
        });
    });
});