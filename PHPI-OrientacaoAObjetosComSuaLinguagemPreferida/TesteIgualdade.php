<?php
	require("class/Produto.php");

	$produto = new Produto();
	$produto->setPreco(59.9);
	$produto->setNome("Livro da Casa do Codigo");

	$outroProduto = new Produto();
	$outroProduto->setPreco(59.9);
	$outroProduto->setNome("Livro da Casa do Codigo");

	$outroProduto = $produto;

	//RETORNA IGUAIS QUANDO OS ATRIBUTOS SÃO IGUAIS
	if($produto == $outroProduto){
		echo "São iguais<br/>";
	}else{
		echo "São diferentes<br/>";
	}


	//COMPARA A INSTANCIA DOS OBJETOS
	if($produto === $outroProduto){
		echo "São iguais";
	}else{
		echo "São diferentes";
	}

?>