<?php 
include("cabecalho.php");
include("conecta.php");
include("banco-produto.php");

$id = $_POST['id'];
$nome = $_POST["nome"];
$preco = $_POST["preco"];
$descricao = $_POST["descricao"];
$categoria_id = $_POST["categoria_id"];

//SE TEM O usado NA ARRAY DO POST, ENTÃO É TRUE, SE NÃO É FALSE - ISSO PQ O CHECK BOX NÃO É ENVIADO QUANDO NÃO SELECIONADO
//NECESSÁRIO COLOCAR ENTRE ASPAS, POIS QUANDO FOR CONCATENADO COM A QUERY O FALSE SEM ASPAS SIGNIFICA STRING VAZIA]
//OU SEJA ELE SERÁ CONCATENADO COM VAZIO
if(array_key_exists('usado', $_POST)){
	$usado = "true";
}else{
	$usado = "false";
}


//EXECUTA A QUERY NA CONEXÃO
if(alteraProduto($conexao, $id, $nome, $preco, $descricao, $categoria_id, $usado)){ ?>

<p class="text-success">Produto <?= $nome; ?>, <?= $preco; ?> foi alterado com sucesso!</p>


<?php } else { 
	$msg = mysqli_error($conexao);
?>

<p class="text-danger">Produto <?= $nome; ?>, <?= $preco; ?> não foi alterado: <?=$msg?></p>

<?php 


} 
//FECHA CONEXÃO
//QUANDO TERMINA A REQUISIÇÃO O PHP FECHA A CONEXÃO
//A LINHA DE BAIXO PODE SER OMITIDA
mysqli_close($conexao);

?>
<?php include("rodape.php") ?>