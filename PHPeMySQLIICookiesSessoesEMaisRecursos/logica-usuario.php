<?php
//COMEÇA A SESSÃO / USA SE JÁ EXISTE OU CRIA
session_start();
function usuarioEstaLogado(){
	//return isset($_COOKIE['usuario_logado']);
	return isset($_SESSION['usuario_logado']);
}

function verificaUsuario(){
	if(!usuarioEstaLogado()){
		$_SESSION["danger"] = "Você não tem acesso a esta funcionalidade.";
		header("Location: index.php");
		die();
	}	
}

function usuarioLogado(){
	//return $_COOKIE["usuario_logado"];
	return $_SESSION['usuario_logado'];
}

function logaUsuario($email){
	//NOME DO COOKIE, CONTEÚDO DELE E O TEMPO QUE IRÁ PERMANECER
	//setcookie("usuario_logado", $email, time() + 60);

	//FAZENDO COM SESSÃO
	$_SESSION['usuario_logado'] = $email;

}

function logout(){
	//O PRIMEIRO TIRA O VALOR DA SESSÃO
	//unset($_SESSION['usuario_logado']);
	//ESSE DESTROI A SESSÃO
	session_destroy();
	//COMEÇA OUTRA SESSÃO PARA A MENSAGEM DE DESLOGADO COM SUCESSO
	session_start();
}