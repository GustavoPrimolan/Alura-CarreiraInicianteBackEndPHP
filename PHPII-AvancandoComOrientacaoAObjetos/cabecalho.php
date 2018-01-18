<?php
//PARA FAZER O AUTOLOAD PODE SER UTILIZADO A FUNÇÃO EXPLICITA, ENTRETANDO TAMBÉM FUNCIONA COM UMA FUNÇÃO IMPLÍCITA
//function carregaClasse($nomeDaClasse){
//	require_once("class/".$nomeDaClasse.".php");
//}
//REGISTRA A FUNÇÃO COMO AUTOLOAD
//spl_autoload_register("carregaClasse");

//FUNÇÃO ANÔNIMA E FUNÇÃO IMPLÍCITA
spl_autoload_register(function($nomeDaClasse){
	require_once("class/".$nomeDaClasse.".php");
});



error_reporting(E_ALL ^ E_NOTICE);
require_once("mostra-alerta.php"); 
require_once("conecta.php");
?>

<html>
<head>
	<meta charset="utf-8">
	<title>Minha Loja</title>
	<link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/loja.css" rel="stylesheet">
</head>
<body>

	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="index.php">Minha Loja</a>
			</div>
			<div>
				<ul class="nav navbar-nav">
					<li><a href="produto-formulario.php">Adiciona Produto</a></li>
					<li><a href="produto-lista.php">Produtos</a></li>
					<li><a href="contato.php">Contato</a></li>
				</ul>
			</div>
		</div>
	</div>

	<div class="container">
		<div class="principal">
			<?php  mostraAlerta("success"); ?>
			<?php mostraAlerta("danger"); ?>