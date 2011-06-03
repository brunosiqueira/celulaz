jQuery.ajaxSetup({'beforeSend':function(xhr){xhr.setRequestHeader("Accept","text/javascript")}});jQuery.fn.submitWithAjax=function(){this.submit(function(){$.post(this.action,$(this).serialize(),null,"script");return false;})
return this;};function isValidEmail(email){var filter=/^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;return filter.test(email)}
$.fn.removeFeed=function(){$(this).click(function(){$('body').css('cursor','wait');var id=$(this).parent().attr("id");var element=$(this);$("#dialog-confirm").dialog({resizable:false,height:140,modal:true,buttons:{"Ok":function(){$('body').css('cursor','wait');$.ajax({type:"POST",url:"/company/profile/destroy",data:{id:id,authenticity_token:AUTH_TOKEN},success:function(result){element.parent().remove();$('body').css('cursor','auto');},error:function(request,status,errorThrown){alert('Erro na Ação!'+status);$('body').css('cursor','auto');}});$(this).dialog("close");},"Cancelar":function(){$(this).dialog("close");$('body').css('cursor','auto');}}});});}

$.fn.likeFeed=function(){
	var id = $(this).attr("id");
	$(this).click(function(){
		$('body').css('cursor','wait');
		$.ajax({
			type:"POST",
			dataType:"json",
			url:"/company/feed_likes/create.json",
			data:{
				id:id,
				authenticity_token:AUTH_TOKEN
			},
			success:function(result){
				$('#'+id+" .like-count-feed").html(result.feed_likes_count);
				$('#'+id+" .like-feed").remove();
				$('#'+id+' .like-count-feed').after('<a id="'+id+'" class="undo-like-feed"> Creditar(desfazer)</a>');
				$("#"+id+" .undo-like-feed").undoLikeFeed();
				$('body').css('cursor','auto');
			},
			error:function(request,status,errorThrown){
				alert('Erro na Ação!'+status);
				$('body').css('cursor','auto');
			}
		});
	});
}

$.fn.undoLikeFeed=function(){
	var id= $(this).attr("id");
	$(this).click(function(){
		$.ajax({
			type:"POST",
			dataType:"json",
			url:"/company/feed_likes/destroy.json",
			data:{
				id:id,
				authenticity_token:AUTH_TOKEN
				},
				success:function(result){
					if(result.feed_likes_count>0){
						$('#'+id+" .like-count-feed").html(result.feed_likes_count);
					}else{
						$('#'+id+" .like-count-feed").html('');
					}
					$('#'+id+" .undo-like-feed").remove();
					$('#'+id+' .like-count-feed').after("<a id=\""+id+"\" class=\"like-feed\">creditar</a>");
					$('#'+id+" .like-feed").likeFeed();
					$('body').css('cursor','auto');
				},
				error:function(request,status,errorThrown){
					alert('Erro na Ação!'+status);
					$('body').css('cursor','auto');
				}
		});
	});
}

$.fn.showWhoLikeFeed = function() {
	$(this).click(function(){
		$('body').css('cursor','wait');
		var id = $(this).attr("id");
	$("#companies-like").load(
		'/company/feed_likes/index.html',
		{
			id:id,
			authenticity_token:AUTH_TOKEN
		},
		function(responseText,textStatus,XMLHttpRequest){
			$("#companies-like").dialog({
				resizable:false,
				height:500,
				width:500,
				modal:true,
				open:function(event,ui){
					$('body').css('cursor','auto');
					},
				buttons:{
					"Fechar":function(){
						$(this).dialog("close");
					}
				}
			});
		});
	});
}