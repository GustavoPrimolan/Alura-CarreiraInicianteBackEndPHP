<?php

//SE A CLASSE TIVER TIVER UM MÉTODO ABSTRATO, SERÁ NECESSÁRIO ELA TAMBÉM SER ABSTRATA
abstract class Produto {

	private $id;
	private $nome;
	//LIBERA O ACESSO À PRÓPRIA CLASSE A SUAS FILHAS
	//protected $preco;
	//IDEAL PARA CONTINUAR UTILIZANDO O MÉTODO GET
	private $preco;
	private $descricao;
	private $categoria;
	private $usado;


	function __construct($nome, $preco, $descricao, Categoria $categoria, $usado) {
		$this->nome = $nome;
		$this->preco = $preco;
		$this->descricao = $descricao;
		$this->categoria = $categoria;
		$this->usado = $usado;
	}

	public function getId() {
		return $this->id;
	}

	public function setId($id) {
		$this->id = $id;
	}

	public function getNome() {
		return $this->nome;
	}

	public function getPreco() {
		return $this->preco;
	}

	public function getDescricao() {
		return $this->descricao;
	}

	public function getCategoria() {
		return $this->categoria;
	}

	public function isUsado() {
		return $this->usado;
	}

	public function setUsado($usado) {
		$this->usado = $usado;
	}

	public function temIsbn(){
		//INSTANCIA DE LIVRO
		//SE FOR OBJETO LIVRO ELE IRÁ RETORNAR TRUE
		return $this instanceof Livro;
	}

	public function temTaxaImpressao(){
		//INSTANCIA DE LIVRO
		//SE FOR OBJETO LIVRO ELE IRÁ RETORNAR TRUE
		return $this instanceof LivroFisico;
	}

	public function temWaterMark(){
		//INSTANCIA DE LIVRO
		//SE FOR OBJETO LIVRO ELE IRÁ RETORNAR TRUE
		return $this instanceof Ebook;
	}

	public function precoComDesconto($valor = 0.1) {

		if ($valor > 0 && $valor <= 0.5) {
			$this->preco -= $this->preco * $valor;
		}

		return $this->preco;
	}

	public function calculaImposto(){

		return $this->preco * 0.195;
	}


	//OBRIGATÓRIAMENTE AS CLASSES QUE EXTENDEM A CLASSE
	//É NECESSÁRIO IMPLEMENTAR O MÉTODO
	abstract function atualizaBaseadoEm($params);

	function __toString() {
		return $this->nome.": R$ ".$this->preco;
	}
}