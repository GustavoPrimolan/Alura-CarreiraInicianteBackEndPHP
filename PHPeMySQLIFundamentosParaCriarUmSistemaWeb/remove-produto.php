<?php 
include("cabecalho.php");
include("conecta.php");
include("banco-produto.php");

$id = $_POST['id'];
removeProduto($conexao, $id);

//FAZ O REDIRECIONAMENTO PARA A PÁGINA PARA LISTA PRODUTOS
//SEMPRE DEPOIS QUE FIZER UM LOCATION, FAZER UM DIE
//PASSA O REMOVIDO COMO PARÂMETRO PARA QUE APAREÇA A MENSAGEM DE REMOVIDO COM SUCESSO
header("Location: produto-lista.php?removido=true");
//PHP NÃO IRÁ FAZER MAIS NADA APÓS ISSO
die();

?>
