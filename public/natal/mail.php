<?php
#vamos pegar as variaveis vindas
#atraves do objMail
$nome = $_POST["nome"];
$email = $_POST["email"];
$assunto = $_POST["assunto"];
$mensagem = $_POST["mensagem"];
$telefone = $_POST["telefone"];

#para quem o email sera enviado
$para = "cadastre-se@suaempreza.com.br";
#formato do email
$de = "Content-Type: text/plain;";
#nome de quem esta enviando
$de = "From: $nome <$email>";
#enviando o email e ao mesmo tempo atribuindo a variavel
#$ver o valor 0 se tudo ocorrer certo e 1 se der errado
$ver = mail($para, "$assunto (Telefone: $telefone)", $mensagem, $de);
#enviando a variavel ver e seu conteudo ao flash
echo "ver=$ver";
?>