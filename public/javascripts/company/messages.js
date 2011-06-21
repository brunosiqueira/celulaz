$(document).ready(function() { 
	$("#new").click(function(){
		
		$("#close").click(function(){
			$("#message-form").slideUp(800).fadeOut(400);
			$(".fieldWithError").remove();
			$("#message-result").empty();
			$("#new").removeClass("active");
			$("#message-form")[0].reset();
			return false;
		});
		
		$("#message-form").slideDown(800).fadeIn(1000);
			$(this).addClass("active");
			return false;
		});
		
		$("#message-form").submit(function(){
			var $this = $(this);
			if( $(".as-values").val() == "" || $(".as-values").attr("value") == "" ){
				$(".fieldWithError").remove();
				$('.as-selections').after("<span class='fieldWithError'>Digite um contato</span>");
				return false
			}
			if($("textarea#message_content").val()==""){
				$(".fieldWithError").remove();
				$('textarea#message_content').after("<span class='fieldWithError'>Digite uma mensagem</span>");
			return false
			}
			$("input#recipients").attr("value",$(".as-values").val());
			$.ajax({
				type:'POST',
				url:"/system_modules/mailbox/messages",
				data:$(this).serialize(),
				beforeSend:function(){
					$("#message-result").empty();
					$("#message-result").append("Enviando...")
					},
				success:function(){
						$("#message-result").empty();
						$("#message-result").append("Sua mensagem foi enviada corretamente")
				},
				error:function(){
							$("#message-result").empty();
							$("#message-result").append("Erro ao enviar. Contacte o administrador do sistema.")
				}
			});
			return false
		});
		
		$("#delete").click(function(){
			var message_id="";
			if($(":checkbox:checked").size()>0){
				$(":checkbox:checked").each(function(){
					message_id+=$(this).attr('value')+","});
					$.ajax({
						type:'POST',
						url:'/system_modules/mailbox/messages/'+message_id,
						data:{_method:'DELETE',authenticity_token:AUTH_TOKEN},
						beforeSend:function(){
							if(!confirm("Tem certeza que deseja excluir ?")){
								return false
							}
							return true
						},
						success:function(data){
								$("#message_"+message_id).remove();
								location.reload()
						},
						error:function(){
							alert("Houve um erro ao excluir. Contacte o administrador.")
						}
					})
			}
			else{
				alert("Selecione uma mensagem para excluí-la.")
			}
			return false
		});
		
		$("#answer-form").submit(function(){
			
			if($("textarea#answer_message_content").val()==""){
				$(".fieldWithError").remove();
				$('textarea#answer_message_content').after("<span class='fieldWithError'>Digite uma mensagem</span>");
				return false
			}
			
			$.ajax({
					type:'POST',
					url:"/system_modules/mailbox/messages/reply",
					data:$(this).serialize(),
					beforeSend:function(){
						$("#answer-message-result").empty();
						$("#answer-message-result").append("Enviando...")
					},
					success:function(){
								$("#answer-message-result").empty();
								$("#answer-message-result").append("Mensagem enviada").delay(10000);
								location.reload()
					},
					error:function(){
									$("#answer-message-result").empty();
									$("#answer-message-result").append("Erro ao enviar. Contacte o Administrador do sistema.")}
					});
					return false
					});
			$("#new").corner("5px");$("#delete").corner("5px");$("li.active a").corner("5px top");
		});

function isValidEmail(email){var filter=/^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;return filter.test(email)}function is_ie7(){if(jQuery.browser.version=="7.0"&&jQuery.browser.msie===true){return true}return false}