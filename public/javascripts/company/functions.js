var randomico=Math.floor(Math.random()*101);
var jsonLeitura='/company/construction/content.json';
var jsonEscrita='json.php';
var jsonModulo='/company/components/create.json';
var jsonModuloEdit='/company/components/update.json';
var jsonModuloDelete='/company/components/destroy.json';
var jsonModuloPicturesDelete='/company/pictures/destroy.json';
var jsonModuloTab='/company/tabs/create.json';
var jsonModuloTabUpdate='/company/tabs/update.json';
var jsonModuloTabReorder='/company/tabs/reorder.json';
var jsonModuloTabComponent='/company/tab_components/create.json';
var jsonModuloPublish='/company/publish/create.json';
var jsonModuloTabComponentDelete='/company/tab_components/destroy.json';
var jsonModuloTabComponentUpdate='/company/tab_components/update.json';
var jsonModuloTabDelete='/company/tabs/destroy.json';
function fillCreatedContent(result,conteudo){
    var title = (result.title == '' || result.title == null || result.title == undefined) ? 'Sem Título' : result.title;
    $('<div id="m-'+result.id+'" class="conteudo new conteudoInterno"><h5><a href="#">'+title+'</a></h5><p>'+conteudo+'</p><span class="remove"></span><input type="checkbox" /><span class="handle"></span></div>').prependTo('#page-conteudos');
    $('body').css('cursor','auto');
    $('#site-conteudos .remove').removeContent();
    $('.conteudoInterno a').click(function(event){
        editContent($(this).parent().parent().attr('id').substring(2));
        event.stopPropagation();
        return false
    })
}
function fillConteudo(content){
    if(content.tipo=='texto'||content.type=='ComponentText'){
        if (content.conteudo != null){
            return content.conteudo.substring(0,50);
        } else {
            return content.description_small;
        }
    }else if(content.tipo=='galeria'||content.type=='ComponentGallery'){
        return"<img src='/images/company/ico-novo-galeria.png' width='65' height='51' alt='Imagem' />"
    }else if(content.tipo=='imagem'||content.type=='ComponentPicture'){
        return"<img src='/images/company/ico-novo-imagem.png' width='65' height='51' alt='Imagem' />"
    }else if(content.tipo=='video'||content.type=='ComponentVideo'){
        return"<img src='/images/company/ico-novo-video.png' width='65' height='51' alt='Imagem' />"
    }else{
        return"<img src='/images/company/ico-novo-formulario.png' width='65' height='51' alt='Imagem' />"
    }
}
function changeTabComponent(event,ui){
    $('body').css('cursor','wait');
    if($(ui.item).parent().parent().attr('id').match(/line/)=='line'){
        $.ajax({
            type:"POST",
            url:jsonModuloTabComponent,
            data:{
                id:$(ui.item).attr('id').substring(2),
                tab_component:{
                    full_line:!$(ui.item).parent().parent().hasClass('coluna'),
                    column:$(ui.item).parent().hasClass("conteudo0")?1:2,
                    line:$(ui.item).parent().parent().attr('id').substring(5),
                    tab_id:$(ui.item).parent().parent().parent().attr('id').substring(3)
                },
                authenticity_token:AUTH_TOKEN
            },
            dataType:"json",
            success:function(result){
                $('body').css('cursor','auto')
            },
            error:function(request,status,errorThrown){
                alert('Erro na Ação!'+status)
            }
        })
    }else{
        $.ajax({
            type:"POST",
            url:jsonModuloTabComponentDelete,
            data:{
                _method:'DELETE',
                id:$(ui.item).attr('id').substring(2),
                authenticity_token:AUTH_TOKEN
            },
            dataType:"json",
            success:function(result){
                $('body').css('cursor','auto')
            },
            error:function(request,status,errorThrown){
                alert('Erro na Ação!'+status)
            }
        })
    }
}
$.fn.expandirComponent=function(){
    $(this).dblclick(function(){
        var cont=0;
        $(this).parent().children().each(function(){
            cont+=$(this).children().size()
        });
        if(($(this).parent().children().first().children().first().size()==0)&&($(this).parent().children().last().children().first().size()!=0)){
            $('body').css('cursor','wait');
            element=$(this);
            $.ajax({
                type:"POST",
                url:jsonModuloTabComponentUpdate,
                data:{
                    id:element.children().first().attr('id').substring(2),
                    full_line:element.parent().hasClass('coluna'),
                    authenticity_token:AUTH_TOKEN
                },
                dataType:"json",
                success:function(result){
                    element.parent().children().first().toggleClass('conteudo0');
                    element.parent().children().first().toggleClass('conteudo1');
                    element.parent().children().last().toggleClass('conteudo1');
                    element.parent().children().last().toggleClass('conteudo0');
                    element.parent().toggleClass('coluna');
                    $('body').css('cursor','auto')
                },
                error:function(request,status,errorThrown){
                    alert('Erro na Ação!'+status)
                }
            })
        }else if(cont==1){
            $('body').css('cursor','wait');
            element=$(this);
            $.ajax({
                type:"POST",
                url:jsonModuloTabComponentUpdate,
                data:{
                    id:element.children().first().attr('id').substring(2),
                    full_line:element.parent().hasClass('coluna'),
                    authenticity_token:AUTH_TOKEN
                },
                dataType:"json",
                success:function(result){
                    element.parent().toggleClass('coluna');
                    $('body').css('cursor','auto')
                },
                error:function(request,status,errorThrown){
                    alert('Erro na Ação!'+status)
                }
            });
        }
    })
}

$.fn.removeContent=function(){
    $(this).click(function(event){
        var confirmaRemove=window.confirm("Você tem certeza que gostaria excluir este item?");
        if(confirmaRemove){
            $('body').css('cursor','wait');
            element=$(this);
            id=element.parent().attr('id').substring(2);
            jQuery.ajax({
                async:true,
                url:jsonModuloDelete,
                type:'POST',
                data:{
                    _method:'DELETE',
                    authenticity_token:AUTH_TOKEN,
                    component_id:id
                },
                success:function(){
                    $('body').css('cursor','auto');
                    element.parent().remove();
                    $('body').css('cursor','auto')
                },
                error:function(request){
                    alert('Sorry, there was an error!!!');
                    $('body').css('cursor','auto')
                }
            })
        }
        event.stopPropagation()
    })
}

$.fn.editAba=function(){
    $(this).click(function(event){
        var title =  $('#menu'+$(this).parent().attr("id").substr(4)+' .aba-titulo').html().trim();
        var id =  $(this).parent().attr("id").substr(4);
        $( "#dialog-tab-form" ).dialog({
            autoOpen: true,
            modal: true,
            open: function(event, ui) {
                $(".ui-dialog-content input").val(title);
            },
            buttons: {
                "Salvar": function() {
                    var newTitle = $(".ui-dialog-content input").val();
                    if ( newTitle != null && newTitle.trim().length >0 ) {
                        $.ajax({
                            type:"POST",
                            url:jsonModuloTabUpdate,
                            data:{
                                id:id,
                                tab:{title: newTitle},
                                authenticity_token:AUTH_TOKEN,
                                _method:'DELETE'
                            },
                            dataType:"json",
                            success:function(result){
                                alert('#menu'+id+' .aba-titulo');
                                 $('#menu'+id+' .aba-titulo').html(newTitle);
                                event.stopPropagation()
                            },
                            error:function(request,status,errorThrown){
                                event.stopPropagation();
                            }});
                            $( this ).dialog( "close" );
                        } else {
                            $('.ui-dialog-content .error').html('Preenchimento obrigatório');
                        }
                    },
                    "Cancelar": function() {
                        $( this ).dialog( "close" );
                    }
                },
                close: function() {
                    $('.ui-dialog-content .error').html('');
                    $(".ui-dialog-content input").val('');
                }
            });
        });
    }
    $.fn.removeAba=function(){
        $(this).click(function(event){
            $('body').css('cursor','wait');
            var confirmaRemove=window.confirm("Você tem certeza de que deseja excluir esta sub-página?");
            if(confirmaRemove){
                var element=$(this);
                $.ajax({
                    type:"POST",
                    url:jsonModuloTabDelete,
                    data:{
                        id:element.parent().attr('id').substring(4),
                        authenticity_token:AUTH_TOKEN,
                        _method:'DELETE'
                    },
                    dataType:"json",
                    success:function(result){
                        $('#aba'+element.parent().attr("id").substr(4)+' .widget-conteudo').children().each(function(){
                            $(this).appendTo('#page-conteudos')
                        });
                        $('#aba'+element.parent().attr("id").substr(4)).remove();
                        element.parent().remove();
                        $('body').css('cursor','auto');
                        event.stopPropagation()
                    },
                    error:function(request,status,errorThrown){
                        alert('Erro na exclusão!'+status);
                        $('body').css('cursor','auto');
                        event.stopPropagation()
                    }
                })
            } else {
                $('body').css('cursor','auto');
            }
        })
    }
    $(document).ready(function(){
        $('body').css('cursor','wait');
        arredondaCantos();
        $('#openMenu').click(function(){
            if($('#box-incluir-conteudo').is(":hidden")){
                $('#openMenu').addClass('active');
                $('#box-incluir-conteudo').slideDown('fast');
                $('#menu-novo-conteudo a').click(function(){
                    $('body').css('cursor','wait');
                    var ancora=$(this).attr('rel');
                    $('#box-incluir-conteudo').load('/company/components/new.html',{
                        tipo:ancora
                    });
                    $('body').css('cursor','auto');
                    return false
                })
            }
            $(this).blur();
            return false
        });
        $('.box-novo-conteudo span.remove').click(function(){
            $('#box-incluir-conteudo').slideUp('fast');
            $('#openMenu').removeClass('active');
            $('#box-incluir-conteudo').load('/company/conteudo-menu.html')
        });
        $('.site-menu ul').sortable({
            placeholder:'highlight',
            update:function(event,ui){
                var listIds=new Array();
                var count=0;
                $('ul#menu-abas').children().each(function(){
                    listIds[count]=$(this).attr('id').substring(4);
                    count++
                });
                $.ajax({
                    type:"POST",
                    url:jsonModuloTabReorder,
                    data:{
                        tab_ids:listIds,
                        authenticity_token:AUTH_TOKEN
                    },
                    dataType:"json",
                    error:function(request,status,errorThrown){
                        alert('Erro na Publicação!'+status)
                    }
                })
            }
        }).disableSelection();
        $('#adicionar-linha').click(function(){
            var cont=$('.site-content:visible').children().size();
            if(cont>0){
                cont=parseInt($('.site-content:visible ul:last').attr('id').substring(5))+1
            }
            $('.site-content:visible').append('<ul id="line-'+cont+'" class="conteudoAtivo'+cont+' widget-conteudo coluna"></ul>');
            $('.site-content:visible .conteudoAtivo'+cont).append('<li class="conteudo0 connected"></li>');
            $('.site-content:visible .conteudoAtivo'+cont).append('<li class="conteudo1 connected"></li>');
            $(".connected").sortable({
                items:'div',
                connectWith:'.connected',
                placeholder:'highlight',
                handle:'.handle'
            }).disableSelection();
            $('.site-content:visible ul.widget-conteudo').last().children('.connected').expandirComponent();
            bloqueiaSortable();
            return false
        });
        $('#remover-linha').click(function(){
            var confirmaRemove=window.confirm("Você tem certeza que gostaria excluir a última linha?");
            if(confirmaRemove){
                $(".site-content:visible").children().last().children().each(function(){
                    $(this).children().appendTo('#page-conteudos')
                });
                $(".site-content:visible").children().last().remove()
            }
            return false
        });
        $('#next-carrocel').click(function(){
            var alturaConteudo=$('#page-conteudos').height();
            var posicaoConteudo=$('#page-conteudos').css('margin-top');
            posicaoConteudo=posicaoConteudo.replace('px','');
            posicaoConteudo=parseInt(posicaoConteudo);
            if(Math.abs(posicaoConteudo)<alturaConteudo-420){
                posicaoConteudo=posicaoConteudo-420;
                posicaoConteudo=posicaoConteudo+'px';
                $('#page-conteudos').animate({
                    'margin-top':posicaoConteudo
                },'slow')
            }
        });
        $('#prev-carrocel').click(function(){
            var alturaConteudo=$('#page-conteudos').height();
            var posicaoConteudo=$('#page-conteudos').css('margin-top');
            posicaoConteudo=posicaoConteudo.replace('px','');
            posicaoConteudo=parseInt(posicaoConteudo);
            if(Math.abs(posicaoConteudo)>=420){
                posicaoConteudo=posicaoConteudo+420;
                posicaoConteudo=posicaoConteudo+'px';
                $('#page-conteudos').animate({
                    'margin-top':posicaoConteudo
                },'slow')
            }
        });
        $('#box-nova-aba').hide();
        $('#btn-adicionar-aba').click(function(){
            $('#box-nova-aba').show();
            $('#btn-adicionar-aba').hide();
            return false
        });
        $('#submit-nova-aba').click(function(){
            var titleNovaAba=$('#box-nova-aba .input').val();
            $.ajax({
                type:"POST",
                url:jsonModuloTab,
                data:{
                    tab:{
                        title:titleNovaAba
                    },
                    authenticity_token:AUTH_TOKEN,
                    _method:'PUT'
                },
                dataType:"json",
                success:function(result){
                    var maior=0;
                    $('.site-menu ul li').each(function(){
                        if(maior<$(this).attr('id').substr(4)){
                            maior=$(this).attr('id').substr(4)
                        }
                    });
                    if(titleNovaAba!=''){
                        $('#menu-abas').append('<li id="menu'+result.id+'"><span class="aba-titulo">'+titleNovaAba+'</span><span class="edit-tab"/><span class="remove"></span></li>')
                    }
                    $('#box-nova-aba').hide();
                    $('#btn-adicionar-aba').show();
                    $('#box-nova-aba .input').val('');
                    arredondaCantos();
                    if($('#wrap-show-hide ul').length==0){
                        $('#wrap-show-hide').append('<div id="aba0" class="site-content"></div>');
                        $('#aba0').append('<ul id="line-0" class="conteudoAtivo0 widget-conteudo coluna"></ul>');
                        $('#aba0 .conteudoAtivo0').append('<li class="conteudo0 connected"></li>');
                        $('#aba0 .conteudoAtivo0').append('<li class="conteudo1 connected"></li>')
                    }else{
                        $('#wrap-show-hide').append('<div id="aba'+result.id+'" class="site-content"></div>');
                        $('#aba'+result.id).append('<ul id="line-0" class="conteudoAtivo0 widget-conteudo coluna"></ul>');
                        $('#aba'+result.id+' .conteudoAtivo0').append('<li class="conteudo0 connected"></li>');
                        $('#aba'+result.id+' .conteudoAtivo0').append('<li class="conteudo1 connected"></li>')
                    }
                    $(".connected").sortable({
                        items:'div',
                        connectWith:'.connected',
                        placeholder:'highlight',
                        handle:'.handle'
                    }).disableSelection();
                    $('#aba'+($('#menu-abas li').size()-1)).hide();
                    $('#menu-abas li:last-child').click(function(){
                        $('#wrap-show-hide .site-content').hide();
                        $('#wrap-show-hide #aba'+$(this).attr('id').substring(4)).show();
                        $('#menu-abas li').removeClass('active');
                        $(this).addClass('active')
                    });
                    $('.site-menu .remove').removeAba();
                    $('.site-menu .edit-tab').editAba();
                    $('.site-content ul.widget-conteudo').last().children('.connected').expandirComponent();
                    bloqueiaSortable()
                },
                error:function(request,status,errorThrown){
                    alert('Erro na exclusão!'+status);
                    event.stopPropagation()
                }
            })
        });
        $.ajax({
            url:jsonLeitura,
            data:{
                authenticity_token:AUTH_TOKEN
            },
            success:function(result){
                var json=$.parseJSON(result);
                getMenu(json);
                getInactiveContent(json);
                getActiveContent(json);
                $('body').css('cursor','auto')
            },
            error:function(request,status,errorThrown){
                alert('Erro na Publicação Y!'+errorThrown)
            }
        });
        $('.botoes-contrutor a.btn.remove').click(function(){
            var confirmaRemove=window.confirm("Você tem certeza que gostaria excluir os itens selecionados?");
            if(confirmaRemove){
                var listIds=new Array();
                var listIdsPictures=new Array();
                var count=0;
                $('.box-construtor input:checkbox:checked').each(function(){
                    listIds[count]=$(this).parent().attr('id').substring(2);
                    count++
                });
                if (listIds.length > 0){
                    jQuery.ajax({
                        async:true,
                        url:jsonModuloDelete,
                        type:'POST',
                        data:{
                            _method:'DELETE',
                            authenticity_token:AUTH_TOKEN,
                            component_ids:listIds
                        },
                        success:function(){
                            $('.box-construtor input:checkbox:checked').parent().remove();
                            $('body').css('cursor','auto');
                        },
                        error:function(request){
                            alert('Sorry, there was an error!!!');
                            $('body').css('cursor','auto');
                        }
                    });
                }
                count=0;
                $('.img-gallery input:checkbox:checked').each(function(){
                    listIdsPictures[count]=$(this).attr('name').substring(10);
                    count++
                });
                if (listIdsPictures.length >0){
                    jQuery.ajax({
                        async:true,
                        url:jsonModuloPicturesDelete,
                        type:'POST',
                        data:{
                            _method:'DELETE',
                            authenticity_token:AUTH_TOKEN,
                            picture_ids:listIdsPictures,
                            component_id: $('ul.img-gallery').attr('id')
                        },
                        success:function(){
                            $('.img-gallery input:checkbox:checked').parent().remove();
                            $('body').css('cursor','auto');
                        },
                        error:function(request){
                            alert('Sorry, there was an error!!!');
                            $('body').css('cursor','auto');
                        }
                    });
                }
            }
            return false
        });
        $('a.publish').click(function(){
            $('.publish-message').html('Seu site está sendo gerado. Aguarde.');
            $('.publish-message').show();
            jQuery.ajax({
                async:true,
                url:jsonModuloPublish,
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
            })
        });
    
    });
    function resizeSquare(event,ui){
        event.ta
    }
    function arredondaCantos(){
        $('.btn').corner("5px");
        $('.preview').corner("15px");
        $('.publish').corner("15px");
        $('.submenu ul li.active a').corner("top 3px");
        $('.box-construtor h4').corner("3px");
        $('.site-menu ul li').corner("3px");
        $('.linha').corner("3px");
        $('.widget-conteudo').corner("3px")
    }
    function editContent(id){
        if($('#box-incluir-conteudo').is(":hidden")){
            $('body').css('cursor','wait');
            $('#box-incluir-conteudo').load('/company/components/edit.html',{
                id:id,
                authenticity_token:AUTH_TOKEN
            },function(){
                $('#openMenu').addClass('active');
                $('#box-incluir-conteudo').slideDown('fast');
                $('body').css('cursor','auto')
            })
        }
    }
    function createContent(tipo,titulo,descricao,conteudo,url,viewNome,viewEmail,viewtelefone,viewEndereco,viewRecado,showAll){
        $('body').css('cursor','wait');
        $.ajax({
            type:"POST",
            url:jsonModulo,
            data:{
                tipo:tipo,
                component:{
                    title:titulo,
                    description:descricao,
                    url:url,
                    show_name:viewNome,
                    show_email:viewEmail,
                    show_phone:viewtelefone,
                    show_address:viewEndereco,
                    show_message:viewRecado,
                    show_all_content: showAll
                },
                authenticity_token:AUTH_TOKEN
            },
            dataType:"json",
            success:function(result){
                fillCreatedContent(result,conteudo)
            },
            error:function(request,status,errorThrown){
                alert('Erro na Publicação!'+status)
            }
        })
    }
    function createContentEditado(id,titulo,conteudo,url,viewNome,viewEmail,viewtelefone,viewEndereco,viewRecado,viewAll){
        $('body').css('cursor','wait');
        $.ajax({
            type:"POST",
            url:jsonModuloEdit,
            data:{
                id:id,
                component:{
                    title:titulo,
                    description:conteudo,
                    url:url,
                    show_name:viewNome,
                    show_email:viewEmail,
                    show_phone:viewtelefone,
                    show_address:viewEndereco,
                    show_message:viewRecado,
                    show_all_content: viewAll
                }
            },
            dataType:"json",
            success:function(result){
                var title = (result.title == null || result.title == '' || result.title == undefined) ? 'Sem Título' : result.title;
                $('#m-'+result.id+' h5').children('a').html(title);
                $('#m-'+result.id).children('p').html(fillConteudo(result));
                $('#m-'+result.id).effect('highlight',1500);
                $('body').css('cursor','auto');
//                $('#site-conteudos .remove').removeContent();
//                $('.conteudoInterno a').click(function(event){
//                    editContent($(this).parent().parent().attr('id').substring(2));
//                    event.stopPropagation();
//                    return false
//                })
            },
            error:function(request,status,errorThrown){
                alert('Erro na Publicação!'+status)
            }
        })
    }
    function trataCampos(classe){
        var value="";
        $(classe).focus(function(){
            if($(classe).val()=='Titulo da imagem'||$(classe).val()=='Titulo da nova galeria de imagens'){
                value=$(this).val();
                $(this).val('')
            }
        });
        $(classe).blur(function(){
            if($(this).val()==""){
                $(this).val(value)
            }
        })
    }
    function getActiveContent(json){
        for(var b=0;b<json.ativos.menu.length;b++){
            for(var a=0;a<json.ativos.menu[b].conteudoAtivo.length;a++){
                var index=json.ativos.menu[b].id;
                if(json.ativos.menu[b].conteudoAtivo[a].conteudo.length>1){
                    $('#wrap-show-hide #aba'+index).append('<ul id="line-'+json.ativos.menu[b].conteudoAtivo[a].id+'" class="conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' widget-conteudo coluna"></ul>');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id).append('<li class="conteudo0 connected"></li>');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' .conteudo0').append('<div id="m-'+json.ativos.menu[b].conteudoAtivo[a].conteudo[0].id+'" class="conteudo conteudoInterno"></div>');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' .conteudo0 .conteudoInterno').append('<h5><a href="#">'+json.ativos.menu[b].conteudoAtivo[a].conteudo[0].titulo+'</a></h5>');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' .conteudo0 .conteudoInterno').append('<p>'+fillConteudo(json.ativos.menu[b].conteudoAtivo[a].conteudo[0])+'</p>');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' .conteudo0 .conteudoInterno').append('<span class="remove"></span>');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' .conteudo0 .conteudoInterno').append('<input type="checkbox" />');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' .conteudo0 .conteudoInterno').append('<span class="handle"></span>');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id).append('<li class="conteudo1 connected"></li>');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' .conteudo1').append('<div id="m-'+json.ativos.menu[b].conteudoAtivo[a].conteudo[1].id+'" class="conteudo conteudoInterno"></div>');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' .conteudo1 .conteudoInterno').append('<h5><a href="#">'+json.ativos.menu[b].conteudoAtivo[a].conteudo[1].titulo+'</a></h5>');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' .conteudo1 .conteudoInterno').append('<p>'+fillConteudo(json.ativos.menu[b].conteudoAtivo[a].conteudo[1])+'</p>');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' .conteudo1 .conteudoInterno').append('<span class="remove"></span>');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' .conteudo1 .conteudoInterno').append('<input type="checkbox" />');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' .conteudo1 .conteudoInterno').append('<span class="handle"></span>')
                }else if(json.ativos.menu[b].conteudoAtivo[a].conteudo.length==1){
                    var column = parseInt(json.ativos.menu[b].conteudoAtivo[a].conteudo[0].column)-1;
                    $('#wrap-show-hide #aba'+index).append('<ul id="line-'+json.ativos.menu[b].conteudoAtivo[a].id+'" class="conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' widget-conteudo"></ul>');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id).append('<li class="conteudo0 connected"></li>');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id).append('<li class="conteudo1 connected"></li>')
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' .conteudo'+column).append('<div id="m-'+json.ativos.menu[b].conteudoAtivo[a].conteudo[0].id+'" class="conteudo conteudoInterno"></div>');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' .conteudo'+column+' .conteudoInterno').append('<h5><a href="#">'+json.ativos.menu[b].conteudoAtivo[a].conteudo[0].titulo+'</a></h5>');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' .conteudo'+column+' .conteudoInterno').append('<p>'+fillConteudo(json.ativos.menu[b].conteudoAtivo[a].conteudo[0])+'</p>');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' .conteudo'+column+' .conteudoInterno').append('<span class="remove"></span>');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' .conteudo'+column+' .conteudoInterno').append('<input type="checkbox" />');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' .conteudo'+column+' .conteudoInterno').append('<span class="handle"></span>');
                    if (column == 1){
                        var first = $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' .conteudo0');
                        var last = $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' .conteudo1');
                        first.toggleClass('conteudo0');
                        first.toggleClass('conteudo1');
                        last.toggleClass('conteudo1');
                        last.toggleClass('conteudo0');
                    }

                }else{
                    $('#wrap-show-hide #aba'+index).append('<ul id="line-'+json.ativos.menu[b].conteudoAtivo[a].id+'" class="conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id+' widget-conteudo"></ul>');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id).append('<li class="conteudo0 connected"></li>');
                    $('#wrap-show-hide #aba'+index+' .conteudoAtivo'+json.ativos.menu[b].conteudoAtivo[a].id).append('<li class="conteudo1 connected"></li>')
                }
            }
        }
        $('.connected').expandirComponent();
        $('.site-content .remove').removeContent();
        $(".connected").sortable({
            items:'div',
            connectWith:'.connected',
            placeholder:'highlight',
            handle:'.handle'
        }).disableSelection();
        bloqueiaSortable();
        $('#wrap-show-hide #aba'+$('#menu-abas li.active').attr('id').substring(4)).show();
        $('.conteudoInterno a').click(function(){
            editContent($(this).parent().parent().attr('id').substring(2));
            return false
        })
    }
    function getInactiveContent(json){
        $('#page-conteudos').html('');
        for(var a=0;a<json.ociosos.length;a++){
            $('#page-conteudos').append('<div id="m-'+json.ociosos[a].id+'" class="conteudo conteudoInterno"></div>');
            $('#m-'+json.ociosos[a].id).append('<h5><a href="#">'+json.ociosos[a].titulo+'</a></h5>');
            $('#m-'+json.ociosos[a].id).append('<p>'+fillConteudo(json.ociosos[a])+'</p>');
            $('#m-'+json.ociosos[a].id).append('<span class="remove"></span>');
            $('#m-'+json.ociosos[a].id).append('<input type="checkbox" />');
            $('#m-'+json.ociosos[a].id).append('<span class="handle"></span>')
        }
        $('#site-conteudos .remove').removeContent()
    }
    function getMenu(json){
        $('#menu-abas').html('');
        for(var a=0;a<json.ativos.menu.length;a++){
            $('#menu-abas').append('<li id="menu'+json.ativos.menu[a].id+'"><span class="aba-titulo">'+json.ativos.menu[a].titulo+'</span><span class="edit-tab"/><span class="remove"></span></li>');
            $('#wrap-show-hide').append('<div id="aba'+json.ativos.menu[a].id+'" class="site-content"></div>')
        }
        $('#wrap-show-hide .site-content').hide();
        $('#menu-abas li:first-child').addClass('active');
        $('#menu-abas li').click(function(){
            $('#wrap-show-hide .site-content').hide();
            $('#wrap-show-hide #aba'+$(this).attr('id').substring(4)).show();
            $('#menu-abas li').removeClass('active');
            $(this).addClass('active')
        });
        $('.site-menu .remove').removeAba();
        $('.site-menu .edit-tab').editAba();
        $(".connected").sortable({
            items:'div',
            connectWith:'.connected',
            placeholder:'highlight',
            handle:'.handle'
        }).disableSelection()
    }
    function bloqueiaSortable(){
        $(".connected").bind("sortreceive",function(event,ui){
            var allowed=true;
            if($(this).attr("id")!="page-conteudos"){
                if($(this).children().size()>1){
                    alert("Você não pode inserir mais conteúdos nesta linha!");
                    $(ui.sender).sortable('cancel');
                    event.stopPropagation();
                    allowed=false
                }
            }
            if(allowed){
                changeTabComponent(event,ui)
            }
        })
    }
    function publishContent(){
        $('body').css('cursor','wait');
        var jsonData=new Object();
        jsonData.ativos=new Object();
        jsonData.ociosos=new Array();
        jsonData.ativos.menu=new Array();
        $('#menu-abas li').each(function(){
            jsonData.ativos.menu.push({
                id:$(this).attr('id').substring(4),
                titulo:$(this).children('.aba-titulo').html(),
                conteudoAtivo:new Array()
            })
        });
        for(a=0;a<$('.site-content').size();a++){
            for(b=0;b<$('#aba'+a).children('.widget-conteudo').size();b++){
                if($('#aba'+a+' .conteudoAtivo'+b+' li').children('.conteudo').size()!=0){
                    jsonData.ativos.menu[a].conteudoAtivo.push({
                        id:b,
                        conteudo:new Array()
                    });
                    $('#aba'+a+' .conteudoAtivo'+b).children('li').each(function(){
                        if($(this).children().attr('id')){
                            jsonData.ativos.menu[a].conteudoAtivo[b].conteudo.push({
                                id:$(this).children().attr('id').substring(2),
                                titulo:$(this).children().children('h5').children().html(),
                                conteudo:$(this).children().children('p').html()
                            })
                        }
                    })
                }else{
                    jsonData.ativos.menu[a].conteudoAtivo.push({
                        id:b,
                        conteudo:''
                    })
                }
            }
        }
        $('#page-conteudos .conteudo').each(function(){
            jsonData.ociosos.push({
                'id':$(this).attr('id').substring(2),
                'titulo':$(this).children('h5').children().html(),
                'conteudo':$(this).children('p').html()
            })
        });
        $.ajax({
            type:"POST",
            url:jsonEscrita,
            data:{
                json:JSON.stringify(jsonData)
            },
            dataType:"json",
            success:function(result){
                $('body').css('cursor','auto')
            },
            error:function(request,status,errorThrown){
                alert('Erro na Publicação!'+status)
            }
        })
    }