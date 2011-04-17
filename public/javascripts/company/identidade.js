$(document).ready(function(){
    arredondaCantos();
    $('.bg-example-box ul.img-gallery').bxSlider({
        displaySlideQty: 9,
        moveSlideQty: 3,
        infiniteLoop: false,
        prevImage: "/images/company/layout/ico-right.gif",
        nextImage: "/images/company/layout/ico-left.gif"
    });
    $('.top-example-box ul.img-gallery').bxSlider({
        displaySlideQty: 9,
        moveSlideQty: 3,
        infiniteLoop: false,
        prevImage: "/images/company/layout/ico-right.gif",
        nextImage: "/images/company/layout/ico-left.gif"
    });
    var a=$("div.item-identidade a");
    for(var i=0;i<a.length;i++){
        a[i].href=a[i].href.substring(a[i].href.indexOf('#'));
    }
    $('div.item-identidade').tabs();
    jQuery('.img-site').tabs();
    jQuery("input#repeat_x").click(function(){
        jQuery.ajax({
            async:true,
            url:'/company/layout/update_background_property',
            type:'POST',
            data:{
                _method:'PUT',
                authenticity_token:AUTH_TOKEN,
                id:'repeat_background_x',
                value:jQuery("input#repeat_x").is(':checked')
            },
            success:function(data){
                updateFields(data);
            },
            error:function(request){
                alert('Ocorreu um erro durante a ação. Entre em contato com seu administrador.');
            }
        });
    });
    jQuery("input#show_name").click(function(){
        jQuery.ajax({
            async:true,
            url:'/company/layout/update_attribute',
            type:'POST',
            data:{
                _method:'PUT',
                authenticity_token:AUTH_TOKEN,
                id:'show_name',
                value:jQuery("input#show_name").is(':checked')
            },
            success:function(data){
                if (data == "true"){
                    $('span#name').show();
                } else {
                    $('span#name').hide();
                }
            },
            error:function(request){
                alert('Ocorreu um erro durante a ação. Entre em contato com seu administrador.');
            }
        });
    });
    jQuery("input#show_slogan").click(function(){
        jQuery.ajax({
            async:true,
            url:'/company/layout/update_attribute',
            type:'POST',
            data:{
                _method:'PUT',
                authenticity_token:AUTH_TOKEN,
                id:'show_slogan',
                value:jQuery("input#show_slogan").is(':checked')
            },
            success:function(data){
                if (data == "true"){
                    $('span#slogan').show();
                } else {
                    $('span#slogan').hide();
                }
            },
            error:function(request){
                alert('Ocorreu um erro durante a ação. Entre em contato com seu administrador.');
            }
        });
    });
    jQuery("input#repeat_y").click(function(){
        jQuery.ajax({
            async:true,
            url:'/company/layout/update_background_property',
            type:'POST',
            data:{
                _method:'PUT',
                authenticity_token:AUTH_TOKEN,
                id:'repeat_background_y',
                value:jQuery("input#repeat_y").is(':checked')
            },
            success:function(data){
                updateFields(data);
            },
            error:function(request){
                alert('Ocorreu um erro durante a ação. Entre em contato com seu administrador.');
            }
        })
    });
    jQuery("input#centralize").click(function(){
        jQuery.ajax({
            async:true,
            url:'/company/layout/update_background_property',
            type:'POST',
            data:{
                _method:'PUT',
                authenticity_token:AUTH_TOKEN,
                id:'centralize_background',
                value:jQuery("input#centralize").is(':checked')
            },
            success:function(data){
                updateFields(data);
            },
            error:function(request){
                alert('Ocorreu um erro durante a ação. Entre em contato com seu administrador.');
            }
        })
    });
    jQuery("ul.background img.img-gallery-item").click(function(){
        if(confirm('Deseja alterar sua imagem de fundo?')){
            var src=jQuery(this).attr('src');
            jQuery.ajax({
                async:true,
                url:'/company/layout/update_background',
                type:'POST',
                data:{
                    _method:'PUT',
                    authenticity_token:AUTH_TOKEN,
                    id:src
                },
                success:function(data){
                    $('div.show-bck-choices').css('background-image','url('+data+')');
                },
                error:function(request){
                    alert('Ocorreu um erro durante a ação. Entre em contato com seu administrador.');
                }
            })
        }
    });
    jQuery("ul.top img.img-gallery-item").click(function(){
        if(confirm('Deseja alterar sua imagem de fundo?')){
            var src=jQuery(this).attr('src');
            jQuery.ajax({
                async:true,
                url:'/company/layout/update_background_top',
                type:'POST',
                data:{
                    _method:'PUT',
                    authenticity_token:AUTH_TOKEN,
                    id:src
                },
                success:function(data){
                    $('#top-selected').css('background-image','url('+data+')');
                },
                error:function(request){
                    alert('Ocorreu um erro durante a ação. Entre em contato com seu administrador.');
                }
            })
        }
    });
    $('span#name').editable('/company/layout/update_attribute',{
        cancel:'Cancelar',
        submit:'Ok',
        cssclass:'text_field',
        indicator:"<img src='/images/colorbox/loading.gif'/>",
        placeholder:'Clique para editar...',
        submitdata:{
            authenticity_token:AUTH_TOKEN
        },
        onsubmit:function(settings,original){
            if(original==null||original==''){
                alert('O campo \'Nome da Empresa\' deve ser preenchido');
                return false
            }
            return true
        }
    });
    $('span#slogan').editable('/company/layout/update_attribute',{
        cancel:'Cancelar',
        submit:'Ok',
        cssclass:'text_field',
        indicator:"<img src='/images/colorbox/loading.gif'/>",
        placeholder:'Clique para editar...',
        submitdata:{
            authenticity_token:AUTH_TOKEN
        }
    });
    $('a.alt-modelo').click(function(){
        if($('div#conteudo_miolo').css('display')=="none"){
            $('div#conteudo_miolo').show('slow')
        }else{
            $('div#conteudo_miolo').hide('slow')
        }
    });
    var uploader=new qq.FileUploader({
        element:$('#file-uploader')[0],
        allowedExtensions:["jpg","png","gif","bmp","tif"],
        multiple:false,
        label:'ADICIONAR IMAGEM',
        onSubmit:function(id,fileName){
            uploader.setParams({
                authenticity_token:AUTH_TOKEN,
                tipo:'galeria',
                component:{
                    title:$('input#titulo1').val()
                }
            })
        },
        onComplete:function(id,fileName,responseJSON){
            $('.qq-upload-list').html('');
            $('#top-selected').css('background-image','url('+responseJSON.url+')');
            return true
        },
        action:'/company/layout/upload_background_top'
    });
    var uploader2=new qq.FileUploader({
        element:$('#file-uploader-background')[0],
        allowedExtensions:["jpg","png","gif","bmp","tif"],
        multiple:false,
        label:'ADICIONAR IMAGEM',
        onSubmit:function(id,fileName){
            uploader.setParams({
                authenticity_token:AUTH_TOKEN,
                tipo:'galeria',
                component:{
                    title:$('input#titulo1').val()
                }
            })
        },
        onComplete:function(id,fileName,responseJSON){
            $('.qq-upload-list').html('');
            $('.show-bck-choices').css('background-image','url('+responseJSON.url+')');
            return true
        },
        action:'/company/layout/upload_background'
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
    $('body').css('cursor', 'auto');
});
function arredondaCantos(){
    $('.qq-upload-button').corner("5px");
    $('.btn').corner("5px");
    $('.preview').corner("15px");
    $('.publish').corner("15px");
    $('.submenu ul li.active a').corner("5px 5px 0 0 top");
    $('#salvar').corner("5px");
    $('#cancelar').corner("5px");
    $('#quadro_cores').corner("5px");
    $('.submenu-small a').corner("5px top");
    $('h4').corner("3px");
}
function updateFields(data){
    var json=jQuery.parseJSON(data);
    if(json.repeat_x=="true"&&json.repeat_y=="true"){
        $('div.show-bck-choices').css('background-repeat','repeat');
    }else if(json.repeat_x=="false"&&json.repeat_y=="false"){
        $('div.show-bck-choices').css('background-repeat','no-repeat');
    }else{
        if(json.repeat_x=="true"){
            $('div.show-bck-choices').css('background-repeat','repeat-x');
        }else{
            $('div.show-bck-choices').css('background-repeat','repeat-y');
        }
    }
    if(data.centralize=="true"){
        $('div.show-bck-choices').css('background-position','top center');
    }else{
        $('div.show-bck-choices').css('background-position','top left');
    }
}

$(document).ready(function(){
	$(".exclude_background_top").bind('click', function(){
		var $this = $(this);
		if (confirm("Deseja mesmo excluir a imagem ?")) {
			jQuery.ajax({
	            async:true,
				url: $this.attr('href'),
				type:'POST',
	            data:{
	                authenticity_token:AUTH_TOKEN
	            },
				success:function(request){
	                $this.parent().parent().remove();
	            },
	            error:function(request){
	                alert('Nao foi possivel apagar a imagem');
	            }
			
			});
		}
		return false;
	});
	$(".delete_my_backgrounds").bind('click', function(){
		var $this = $(this);
		if (confirm("Deseja mesmo excluir a imagem de fundo ?")) {
			jQuery.ajax({
	            async:true,
				url: $this.attr('href'),
				type:'POST',
	            data:{
	                authenticity_token:AUTH_TOKEN
	            },
				success:function(request){
	                $this.parent().parent().remove();
	            },
	            error:function(request){
	                alert('Nao foi possivel apagar a imagem');
	            }
			
			});
		}
		return false;
	});
});