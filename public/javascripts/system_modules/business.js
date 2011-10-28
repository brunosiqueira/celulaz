$(document).ready(function(){
	$(".report").bind('click', function(){
		var $this = $(this);
		var href = $this.attr("href");
		$("#company-report").load(
					href,
					{
						authenticity_token:AUTH_TOKEN
					},
					function(responseText,textStatus,XMLHttpRequest){
						$("#company-report").dialog({
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
					}
				);
		return false;
	});
});