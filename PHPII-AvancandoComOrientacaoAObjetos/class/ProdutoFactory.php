<?php

class ProdutoFactory{

	private $classes = array("LivroFisico", "Ebook");
	
	public function criaPor($tipoProduto, $params){

		$nome = $params['nome'];
		$preco = $params['preco'];
		$descricao = $params['descricao'];
		$categoria = new Categoria();
		$usado = $params['usado'];

		//in_array pega o que tiver dentro do array
		if(in_array($tipoProduto, $this->classes)){
			return new $tipoProduto($nome, $preco, $descricao, $categoria, $usado);
		}

		return new LivroFisico($nome, $preco, $descricao, $categoria, $usado);
		
	}

}