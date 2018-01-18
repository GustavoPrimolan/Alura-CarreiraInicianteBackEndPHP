<?php 
class Produto{

	private $id;
	private $nome;
	private $preco;
	private $descricao;
	private $categoria;
	private $usado;


	public function __construct($nome, $preco, $descricao, Categoria $categoria, $usado){
		$this->nome = $nome;
		$this->preco = $preco;
		$this->descricao = $descricao;
		$this->categoria = $categoria;
		$this->usado = $usado;
	}

	//CALCULA O PREÇO COM 10% DE DESCONTO
	//POSSÍVEL PASSAR UM VALOR DEFAULT (PADRÃO) PARA O PARÂMETRO
	public function precoComDesconto($valor = 0.1){

		if($valor > 0 && $valor <= 0.5){
			//PARA NÃO MODIFICAR O PREÇO DO OBJETO
			$this->preco -= $this->preco * $valor;	
		}

		return $this->preco;
		
	}


	public function getId(){
		return $this->id;
	}

	public function getNome(){
		return $this->nome;	
	}

	public function getPreco(){
		return $this->preco;
	}

	public function getDescricao(){
		return $this->descricao;
	}

	public function getCategoria(){
		return $this->categoria;
	}

	public function getUsado(){
		return $this->usado;
	}

	public function setId($id){
		$this->id = $id;
	}

	public function setUsado($usado){
		$this->usado = $usado;
	}

	public function __toString(){
		return $this->nome . ": R$ " .$this->preco;
	}
	

}