------------------------------------------------------------------------------------------------------
<h1>Seção 01 - Autoloading de classes</h1>

Bem Vindos ao segundo módulo do curso PHP II: Avançando com Orientação a objetos!

Neste curso vamos explorar o conceito de Orientação a objetos, os DAOs - Data Access Objects, reescrita de método, polimorfismo e herança de classes. Também colocaremos em prática tudo o que aprendemos no módulo I!

O primeiro exercício desta aula contem o projeto do curso! Clique aquipara obtê-lo.

Caso você já tenha feito a parte I, o projeto segue sendo o mesmo.

#
Importante!

Para aqueles que não assistiram ao primeiro curso, é recomendável fazer este exercício antes de seguir com o treinamento. Nele é possível fazer o download do projeto do curso e configurar o banco. Caso você já tenha feito o primeiro módulo, fique à vontade para pular esta atividade e continuar com seus estudos!

Autoloading de classes
Aprendemos que é interessante criar classes para representar objetos importantes do contexto, como foi o caso de Produto e Categoria. Assim, encapsulando as regras do negócio, o código fica muito mais organizado. Outra prática importante é manter cada classe em um arquivo separado, da forma como fizemos ao criar a classe Produto que é armazenada no arquivo Produto.php e Categoria no arquivo Categoria.php, ambos dentro da pasta class. Com isso vem a responsabilidade de carregar os arquivos, isto é, dar include para cada classe utilizada.

Em outras palavras, se em um mesmo arquivo precisamos das classes Produto e Categoria, será necessário incluí-las uma a uma:

<?php require_once("class/Produto.php"); ?>
<?php require_once("class/Categoria.php"); ?>
Quando esquecemos de incluir a classe Produto, por exemplo, recebemos um fatal error como a seguir:

Fatal error: Class 'Produto' not found in /Users/turini
    /Desktop/cursophp/loja/banco-produto.php on line 21
Para simplificar o processo, o PHP 5 possui um recurso conhecido como autoload. Você pode criar uma função simples que será executada automaticamente no caso de tentarmos usar uma classe que ainda não tenha sido definida. Um exemplo seria:

function carregaClasse($nomeDaClasse) {
    require_once("class/".$nomeDaClasse.".php");
}
A função sabe que o nome do arquivo é igual ao nome da classe! Por isso, nós adicionamos o require_once("class/".$nomeDaClasse.".php"). Além de escrever a função, vamos encontrar o lugar ideal para inseri-la. O arquivo cabecalho.php é perfeito, pois todas as páginas carregam este documento e, assim, não é preciso que ele seja carregado diversas vezes. Basta acrescentar a função no início do arquivo!

Note também que essa é uma função normal e para que ela tenha sentido especial de autoload é precisamos registrá-la através de:

spl_autoload_register("carregaClasse");
O spl_autoload_register nos permite passar várias implementações de autoload como parâmetro e que sejam separadas por vírgulas. Dessa forma conseguimos criar estratégias de fallback.

Agora que a função esta devidamente registrada, ela será executada sempre que tentarmos utilizar uma classe não definida. Assim damos ao scripting engine do PHP uma última chance para incluir o recurso antes que seu código falhe.


<h2>Autoloading</h2>

Vimos que o autoloading é útil pois seu uso permite não repetir o require_once para cada classe. No entanto, em nosso caso, temos que respeitar uma regra!

Que é essa regra?

Cada classe deve estar no seu arquivo e o nome do arquivo deve ser o nome da classe.

Como cada classe estará em seu respectivo arquivo, ficará fácil importar a classe correta utilizando o autoload, que tem como argumento, o nome da classe.


<h2>Para saber mais: autoloading sem função explícita</h2>

Já falamos sobre como criar uma função que carrega as classes automaticamente quando a classe é utilizada.

Vimos que é necessário criar uma função, a carregaClasse. Mas, existe também um atalho que não exige a criação de uma função explícita e sim uma função implícita. Veja o código abaixo que usa diretamente o spl_autoload_register:

spl_autoload_register(function($nomeDaClasse) {
    require_once("class/".$nomeDaClasse.".php");
});
Repare que a função foi definida dentro das parênteses do spl_autoload_register. Isso é uma função anônima, uma função sem nome explícito!

As funções anônimas, também são chamadas de closures, possibilitam a criação de funções que não têm o nome explícito e específico. Elas são úteis quando usamos a função em um único lugar - como é o nosso caso - ou quando precisamos passar uma função como parâmetro.

Passar como parâmetro? Função como parâmetro? Como assim?

Até agora aprendemos a declaração tradicional de funções ou métodos. Por exemplo, veja o exemplo abaixo, que define uma função com o nome soma:

function soma(a, b) {
    return a+b;
}
Sabendo que existem funções anônimas, podemos definir a mesma funcionalidade da seguinte maneira:

$calculaSoma = function($a, $b) {
    return $a+$b;
};
Repare que declaramos uma variável $calculaSoma, que recebe uma função como valor! É isso mesmo, o valor da variável calculaSoma é uma função :)

Para chamar essa função a partir da variável, você usa a própria:

<?= $calculaSoma(1,2) ?>
Bem vindo ao mundo de funções anônimas!

Se você precisar, baixe aqui o projeto pronto até este ponto do curso.

----------------------------------------------------------------------------------------------
<h1>Seção 02 - DAO - Data Access Object</h1>

Neste capítulo vamos abordar o acesso ao Banco de Dados!

Quando queremos adicionar, remover, listar ou fazer qualquer operação que envolva acesso a dados, vamos trabalhar direto com o arquivo banco-produto.php. É interessante notar que mesmo antes de aprendermos isso, nós instintivamente já inserimos neste documento todas as funções e operações referentes ao Banco de Dados. A vantagem desta boa prática é que ela facilita a manutenção do código. Além disso, evita a duplicação do código, já que todas as funções podem ser reutilizadas em qualquer lugar do projeto. Tal prática também ajuda caso seja preciso alterar o banco de dados, pois não precisaremos modificar diversos pontos do código, basta mudar o arquivo que centraliza os comportamentos.

O problema é que as funções estão todas soltas em um arquivo. Por isso, nada mais justo do que criar uma classe para encapsular esse trabalho.

Uma instância dessa classe será um objeto responsável por acessar os dados do banco de dados e é uma prática comum chamar esse tipo de classe de DAO (Data Access Object). Esse é um dos mais famosos padrões de projeto (design patterns) utilizados pelas linguagens orientadas a objeto, como PHP, Java e C#.

Para construir esta nova classe, vamos criar o arquivo, ProdutoDao.php, dentro de class.

Dentro deste novo documento vamos criar a class ProdutoDao e dentro dela introduzimos todas as funções do arquivo banco-produto.php. Como conexao é elemento comum de todas as funções, nada mais justo do que transformá-lo em atributo, assim, adicionamos o private $conexao. Ao fazer isso podemos remover todas as chamadas de função que contenham a palavra conexao. Ainda, vamos passar o this-> em todos os lugares que tiverem conexao. Também é preciso passar a conexao para o ProdutoDao e faremos isso utilizando o construtor, isto é, da mesma maneira que fizemos com o Produto. Portanto, adicionamos o function __construct(), atribuímos a isso o $conexao e também o $this->conexao = $conexao. Lembrando que é importante ajustar a indentação do arquivo. Teremos o seguinte:

class ProdutoDao {

    private $conexao;

    function __construct($conexao) {
        $this->conexao = $conexao;
    }

    function listaProdutos() {

        $produtos = array();
        $resultado = mysqli_query($this->conexao, "select p.*,c.nome as categoria_nome 
            from produtos as p join categorias as c on c.id=p.categoria_id");

        while($produto_array = mysqli_fetch_assoc($resultado)) {

            $categoria = new Categoria();
            $categoria->setNome($produto_array['categoria_nome']);

            $nome = $produto_array['nome'];
            $descricao = $produto_array['descricao'];
            $preco = $produto_array['preco'];
            $usado = $produto_array['usado'];

            $produto = new Produto($nome, $preco, $descricao, $categoria, $usado);
            $produto->setId($produto_array['id']);

            array_push($produtos, $produto);
        }

        return $produtos;
    }

    function insereProduto(Produto $produto) {

        $query = "insert into produtos (nome, preco, descricao, categoria_id, usado) 
            values ('{$produto->getNome()}', {$produto->getPreco()}, 
                '{$produto->getDescricao()}', {$produto->getCategoria()->getId()}, 
                    {$produto->isUsado()})";

        return mysqli_query($this->conexao, $query);
    }

    function alteraProduto(Produto $produto) {

        $query = "update produtos set nome = '{$produto->getNome()}', 
            preco = {$produto->getPreco()}, descricao = '{$produto->getDescricao()}', 
                categoria_id= {$produto->getCategoria()->getId()}, 
                    usado = {$produto->isUsado()} where id = '{$produto->getId()}'";

        return mysqli_query($this->conexao, $query);
    }

    function buscaProduto($id) {

        $query = "select * from produtos where id = {$id}";
        $resultado = mysqli_query($this->conexao, $query);
        $produto_buscado = mysqli_fetch_assoc($resultado);

        $categoria = new Categoria();
        $categoria->setId($produto_buscado['categoria_id']);

        $nome = $produto_buscado['nome'];
        $descricao = $produto_buscado['descricao'];
        $preco = $produto_buscado['preco'];
        $usado = $produto_buscado['usado'];

        $produto = new Produto($nome, $preco, $descricao, $categoria, $usado);
        $produto->setId($produto_buscado['id']);

        return $produto;
    }

    function removeProduto($id) {

        $query = "delete from produtos where id = {$id}";

        return mysqli_query($this->conexao, $query);
    }
}
A partir da criação de uma nova instância, a ProdutoDAO, é preciso passar para ela a conexão. Assim, em todos os locais da aplicação que fazem acesso ao banco de dados deve ser utilizada a classe ProdutoDao. O primeiro arquivo que vamos verificar é o adiciona-produto.php. Neste documento existe um insereProduto, portanto, para ter acesso a este elemento é preciso adicionar o produtoDao = new ProdutoDao() e passamos para ele o conexao:

$produtoDao = new ProdutoDao($conexao)
A instância deve ser adicionada entre o $produto e ìf(insereProduto($conexao, $produto)). Este último deve ser modificado para: ìf($produtoDao->insereProduto($produto)). Lembrando que neste caso não é preciso mais passar a conexao, pois a função utilizada já importa o produtoDao. Ainda falta estabelecer a conexao de alguma maneira, então, é necessário importar o conector.php. O arquivo cabecalho.php é importado em todas as circunstâncias do projeto, por este motivo, ao em vez de importar a conexão individualmente em cada arquivo, vamos adicioná-lo ao cabecalho.php:

<?php

function carregaClasse($nomeDaClasse) {
    require_once("class/".$nomeDaClasse.".php");
}

spl_autolad_register("carregaClasse");

error_reporting(E_ALL * E_NOTICE);
require_once("mostra-alerta.php")
require_once("conecta.php") ?>
Falta alterar o produto-lista.php, portanto, neste arquivo vamos chamar o $produtoDao = new ProdutoDao($conexao). Também chamaremos através do produtoDao a listaProdutos, $produtoDao->listaProdutos($conexao). Teremos:

<?php 
$produtoDao = new ProdutoDao($conexao);
$produtos = $produtoDao->listaProdutos($conexao);
foreach($produtos as $produto) :
?>
Lembrando que é preciso retirar dos arquivos produto-lista.php, adiciona-produto.php e altera-produto.php o seguinte:

require_once("banco-produto.php");
No arquivo altera-produto.php também vamos instanciar o $produtoDao. Ele deve ser inserido acima do if(alteraProduto($conexao, $produto)). Este último deve ser modificado para if($produtoDao->alteraProduto($produto)). Teremos o seguinte:

$produtoDao = new ProdutoDao($conexao);
Falta ainda verificar os locais nos quais utilizamos o buscaProduto. Portanto, vamos acessar o arquivo produto-altera-formulario.php. Neste documento nós também inserimos o $produtoDao = new ProdutoDao($conexao). É preciso alterar, ainda, o buscaProduto que deixa de receber a conexao e passa a ficar assim: $produtoDao->buscaProduto($id);. Por último, é preciso remover do arquivo o require_once("banco-produto.php"). Teremos o seguinte:

require_once("cabecalho.php");
require_once("banco-categoria.php");

$id = $ GET['id'];
$produtoDao = new ProdutoDao(conexao)
$produto = $produtoDao->buscaProduto($id);
$categorias = listaCategorias($conexao);
Agora parece que todos os recursos da aplicação correm bem!

------------------------------------------------------------------------------------------------------
<h1>Seção 03 - Herança</h1>

<h2>Evoluindo os produtos</h2>
Livros são os produtos que mais aparecem em nosso estoque. Todo livro precisa de um número ISBN (International Standard Book Number), que equivale a seu identificador único, por isso, é fundamental manter e exibir esta informação. Precisamos modificar a tabela produtos a fim de adicionar esta nova coluna. Podemos fazer isso acessando o phpMyAdmin e, na aba SQL, executamos a seguinte instrução:

ALTER TABLE produtos ADD COLUMN isbn VARCHAR(255);
Vamos adicionar a propriedade isbn também na classe Produto. Ao fazer isso é preciso acrescentar no arquivo produto.php o private $isbn:

private $id;
private $nome;
private $preco;
private $descricao;
private $categoria;
private $usado;
private $isbn;
No mesmo arquivo vamos incluir os métodos get e set. O código ficará assim:

    public function getIsbn() {
        return $this->isbn;
    }

    public function setIsbn($isbn) {
        $this->isbn = $isbn;
    }
Com estas informações fomos capazes de criar um novo campo na tabela. Mas, como saber se o produto é um livro ou não? Só faz sentido manter e exibir o isbn se o produto em questão for um livro. Uma forma simples de verificar é adicionar mais uma coluna na tabela que indique o "tipo do produto". Portanto, vamos adicionar o seguinte:

ALTER TABLE produtos ADD COLUMN tipoProduto VARCHAR(255);
Agora, na classe Produto vamos adicionar a propriedade tipoProduto e os métodos get e set:

private $id;
private $nome;
private $preco;
private $descricao;
private $categoria;
private $usado;
private $isbn;
private $tipoProduto
E:

    public function getIsbn() {
        return $this->isbn;
    }

    public function setIsbn($isbn) {
        $this->isbn = $isbn;
    }

    public function getTipoProduto() {
        return $this->tipoProduto;
    }   

    public function setTipoProduto($tipoProduto) {
        $this->tipoProduto = $tipoProduto;
    }
Para que tudo siga funcionando ainda precisamos alterar os métodos adicionar, alterar e listar os produtos. Vamos começar com o arquivo produto-formulario-base.php. Nele podemos adicionar mais dois inputs, um para o isbn e outro para o tipoProduto.

No tipoProduto vamos fazer algo bem parecido com o que foi feito com as categorias, só que com um array para tipos do produto. Esse array será percorrido, verificando se o o tipo é igual à classe do produto. Se for igual, o valor será selecionado. O código fica da seguinte maneira:

<tr>
    <td>Tipo do produto</td>
    <td>
        <select name="tipoProduto" class="form-control">
            <?php
            $tipos = array("Produto", "Livro");
            foreach($tipos as $tipo) : 
                $esseEhOTipo = $produto->getTipoProduto() == $tipo;
                $selecao = $esseEhOTipo ? "selected='selected'" : "";
            ?>
                <option value="<?=$tipo?>" <?=$selecao?>>
                    <?=$tipo?>
                </option>
            <?php
            endforeach 
            ?>
        </select>
    </td>
</tr>
    <td>ISBN (caso seja um Livro)</td>
    <td>
        <input type="text" name="isbn" class="form-control" 
                    value="<?=$produto->getIsbn()?>" >
    </td>
</tr>
Precisamos modificar o arquivo adiciona-produto.php, chamando o setter desses dois campos novos. Portanto, adicionamos o $isbn = $_POST['isbn']) e $tipoProduto = $_POST['tipoProduto']. E vamos setar o $produto->setIsbn($isbn); e $produto->setTipoProduto($tipoProduto);. A parte que deve mudar ficará assim:

$nome = $_POST['nome'];
$preco = $_POST['preco'];
$descricao = $_POST['descricao'];
$isbn = $_POST['isbn'];
$tipoProduto = $_POST['tipoProduto'];

if(array_key_exists('usado', $_POST)) {
    $usado = "true";
} else {
    $usado = "false";
}

$produto = new Produto($nome, $preco, $descricao, $categoria, $usado);
$produto->setIsbn($isbn);
$produto->setTipoProduto($tipoProduto);

$produtoDao = new ProdutoDAO($conexao);
Como as informações estão sendo enviadas para o produtoDao.php é preciso modificar o arquivo e inserir nele os dados na query. Assim, vamos acrescentar $produto->getIsbn()} e {$produto->getTipoProduto()}. Sem esquecer de passar para o insert into produtos as colunas isbn e tipoProduto :

$query = "insert into produtos (nome, preco, descricao, categoria_id, 
        usado, isbn, tipoProduto) values ('{$produto->getNome()}', 
            {$produto->getPreco()}, '{$produto->getDescricao()}', 
                {$produto->getCategoria()->getId()}, {$produto->isUsado()}, 
                    '{$produto->getIsbn()}', '{$produto->getTipoProduto()}')";

    return mysqli_query($this->conexao, $query);
}
No arquivo produto-lista.php nós também vamos inserir ISBN: <?= $produto->getIsbn() ?>:

<tr>
    <td><?= $produto->getNome() ?></td>
    <td><?= $produto->getPreco() ?></td>
    <td><?= $produto->precoComDesconto() ?></td>
    <td><?= substr($produto->getDescricao(), 0, 40) ?></td>
    <td><?= $produto->getCategoria()->getNome() ?></td>
    <td> ISBN: <?= $produto->getIsbn() ?></td>

    //...

</tr>
Após fazer isso vamos voltar ao arquivo ProdutoDao.php e acrescentar o $isbn = $produto_array['isbn'] e $tipoProduto = $produto array['tipoProduto']. Também é preciso acrescentar o $produto->setIsbn($isbn) e $produto->setTipoProduto($tipoProduto). Teremos:

$nome = $produto_array['nome'];
$preco = $produto array['preco'];
$descricao = $produto array['descricao'];
$usado = $produto_array['usado'];
$isbn = $produto_array['isbn'];
$tipoProduto = $produto array['tipoProduto'];
Por fim, é necessário inserir o $produto->setIsbn($isbn) e $produto->setTipoProduto($tipoProduto) abaixo do $produto->setId($produto array['id']).

Ao fazer isso veremos que o formulário estará funcionando!

Acoplamento
Essa é uma discussão um pouco mais avançada, mas desde já perceba que o uso de herança aumenta o acoplamento entre as classes, isto é, o quanto uma classe depende de outra. Como há uma relação muito forte entre classe mãe e filha, acaba sendo necessário conhecermos os detalhes de implementação da classe mãe para que tudo funcione como esperado. O problema vai além, imagine que um certo dia a classe mãe adiciona um método com nome igual a um que já existe na classe filha. Quando alguém chamar esse método, esperando o comportamento definido na classe mãe, poderá estar chamando sem querer a classe filha. Isso pode bagunçar toda a lógica. Em outras palavras, a classe mãe também precisa conhecer detalhes de implementação de suas filhas - que podem ainda nem existir.

Veremos mais à frente alguns outros recursos que nos ajudam a resolver esse problema.

<h2>Herdando de Produto</h2>

Alguns detalhes precisam ser ajustados, pois ao adicionarmos um produto que não é um livro, ele ainda pode ser classificado na lista como dotado de isbn. Para especificar que um produto é do tipo "Livro" vamos criar um método. Assim, incluímos no arquivo Produto.php, abaixo da função precoComDesconto, o seguinte:

public function isLivro() {
    return $this->tipoProduto == 'Livro';
}
No arquivo produto-lista.php nós vamos introduzir um if, abaixo do $produto->getIsbn(), ele indica que se o elemento em questão for um livro ele vai possuir um isbn:

<?php 
    if($produto->isLivro()) {
        echo "ISBN: ".$produto->getIsbn();
    }
?>
Ao fazer isso nós conseguimos reclassificar os produtos de maneira a que somente aqueles que são livros apareçam com o ISBN.

A grande parte dos produtos registrados em nosso sistema são livros. Portanto, nada mais adequado do que criar uma classe para Livro. Na verdade, um livro não deixa de ser um produto, a única diferença é que ele possui algumas características a mais, isto é, um livro é a extensão de um produto. Assim, vamos criar um novo arquivo, o Livro.php e neste novo documento adicionamos a class Livro e extends Produto, por fim, acrescentamos o atributo que realmente distingue o Livro de outros elementos, no caso, o isbn. Além do atributo isbn é preciso adicionar o get e set. Ao fazer isso teremos:

<?php

class Livro extends Produto{
    private $isbn;

    public function getIsbn() {
        return $this->isbn;
    }

    public function setIsbn($isbn) {
        $this->isbn = $isbn;
    }
}

?>
Ao fazer isso, deixa de fazer sentido possuir o set e get no arquivo Produto.php, então, podemos apagar estes elementos. Assim como podemos remover a seguinte linha:

private $isbn
Falta verificar o tipo do produto. Portanto, vamos adicionar no arquivo o adiciona-produto.php e if($tipoProduto == "Livro") . Dentro do if vamos inserir o $produto = new Produto($nome, $preco, $descricao, $categoria, $usado, $tipoProduto) e o $produto->setIsbn($isbn) e ainda precisamos adicionar o else. Por fim, vamos remover o $produto->setIsbn($isbn) e o $produto = new Livro($nome, $preco, $descricao, $categoria, $usado, $tipoProduto) que já estão agregados no if e else:

if($tipoProduto == "Livro") {
    $produto = new Livro($nome, $preco, $descricao, $categoria, $usado, $tipoProduto);
    $produto->setIsbn($isbn);    
} else {
    $produto = new Livro($nome, $preco, $descricao, $categoria, $usado, $tipoProduto);
}

$produto->setId($produto array['id']);
$produto->setTipoProduto($tipoProduto);

array push($produtos, $produto);
Após fazer estas alterações podemos acessar o arquivo Produto.php e alterar o método existente de isLivro para temIsbn. Além disso, é preciso adicionar o instanceof:

public function tem Isbn() 
    return $this instanceof == "Livro";
Como alteramos o método é preciso modificar também a listagem, no arquivo produto-lista.php, nós vamos mudar de isLivro para temIsbn:

<?php
    if($produto->temIsbn()) {
        echo "ISBN: ".$produto->getIsbn();
    }
O mesmo procedimento nós devemos incorrer no produto-formulario-base.php. Dessa forma, vamos adicionar o if($produto->temIsbn). Teremos:

<input type="text" name="isbn" class="form-control"
    value="<?php if($produto->temIsbn()) { echo $produto-getIsbn(); }?>" >
Ao fazer estas alterações estamos apontado que o TipoProduto é representado por classes. Então, podemos remover do arquivo Produto.php o seguinte:

public function getTipoProduto() {
    return $this->tipoProduto;
}

public function setTipoProduto($tipoProduto) {
    $this->tipoProduto = $tipoProduto;
}
Nesse mesmo arquivo podemos excluir também a seguinte linha:

private $tipoProduto;
Também vamos alterar o arquivo produto-formulario-base.php. Nele eliminaremos o getTipoProduto(), pois este elemento já não existe mais. Ainda, vamos instanciar a classe, então, adicionamos o get_class e teremos:

<?php
$tipos = array("Produto", "Livro");
foreach($tipos as $tipo) :
    $essaEhOTipo = get_class($produto) == $tipo;
    $selecao = $essaEh
Resta ajustar o ProdutoDao.php. Acima da query nós vamos adicionar o $tipoProduto = get_class($produto). Ademais, é preciso remover o $produto->get e $produto->getIsbn() e deixar apenas o $isbn. Por fim, adicionaremos o $isbn = "". Teremos o seguinte:

function insereProduto(Produto $produto) {
    $isbn = "";
    if($produto->temIsbn())
        $isbn = $produto->getIsbn();
    $tipoProduto = get_class($produto);

    $query = "insert into produtos (nome, preco, descricao, categoria_id, 
            usado, isbn, tipoProduto) values ('{$produto->getNome()}', 
                {$produto->getPreco()}, '{$produto->getDescricao()}', 
                    {$produto->getCategoria()->getId()}, 
                        {$produto->isUsado()}, '{$isbn}', 
                            '{$tipoProduto}')";

    return mysqli_query($this->conexao, $query);
}
Assim como fizemos isso na função insereProduto() podemos repetir o processo na function alteraProduto($produto), então, vamos adicionar o seguinte:

function alteraProduto($produto) {
    $isbn = "";
    if($produto->temIsbn())
        $isbn = $produto->getIsbn();

    $tipoProduto = get_class($produto);
E junto do usado = {$produto->isUsado()} vamos acrescentar o isbn ='{isbn}' e teremos usado = {$produto->isUsado(), isbn ='{isbn}'} e também isbn = '{$isbn}', tipoProduto = '{$TipoProduto}'. Lembrando de atentar para a dentação!

Por último, é preciso remover do ProdutoDao.php o $produto->setTipoProduto($tipoProduto) e modificar o $produto->setId($produto_array['id']) para $produto->setId($produto_id). Nesse mesmo arquivo nós vamos adicionar o $produto_id = $produto_array['id']:

$produto_id = $produto_array['id'];
$nome = $produto_array['nome'];
$preco = $produto_array['preco'];
$descricao = $produto_array['descricao'];
$usado = $produto_array['usado']
$isbn = $produto array['isbn'];
$tipoProduto = $produto_array['tipoProduto'];
Após todas estas alterações podemos fazer um teste e veremos que tudo estará funcionando adequadamente! Note que mesmo cadastrando um produto que não é um livro ao inserirmos o ISBN ele aceita essa informação, ainda que não mostre ela na tabela.

Só a própria classe enxerga atributos/métodos private, enquanto protected é visto pela própria classe mais as classes filhas.

 
Está correto, atributos e métodos protected podem ser visto pelas próprias classes e suas filhas... porém, com private apenas a própria classe

------------------------------------------------------------------------------------------------------
<h1>Seção 04 - Reescrita e Polimorfismo</h1>

Nesta aula vamos substituir a coluna desconto por outra que mostre o valor do imposto que incide sobre cada produto.

A regra é simples, 19,5% de imposto sobre o valor total de qualquer produto. Vamos calcular isso utilizando a listagem, no arquivo produto-lista.php e no lugar onde era calculado o desconto vamos inserir o <td><?= $produto->getPreco() * 0.195 ?></td>. O 0.195 equivale ao 19,5 de imposto e o getPreco() serve para acessar a propriedade. Teremos:

    <td><?= $produto->getNome() ?></td>
    <td><?= $produto->getPreco() ?></td>
    <td><?= $produto->getPreco() * 0.195 ?></td>
    <td><?= substr($produto->getDescricao(), 0, 40) ?></td>
    <td><?= $produto->getCategoria()->getNome() ?></td>
É mais adequado extrair um comportamento de um método do que fazer cálculos na listagem. Este é um meio de evitar duplicação de código e facilitar a manutenção e evolução do comportamento.

Assim, vamos criar o método calculaImposto na classe Produto. Portanto, substituímos o <td><?= $produto->getPreco() * 0.195 ?></td> por <td><?= $produto->calculaImposto()?></td> :

    <td><?= $produto->getNome() ?></td>
    <td><?= $produto->getPreco() ?></td>
    <td><?= $produto->calculaImposto()?></td>
    <td><?= substr($produto->getDescricao(), 0, 40) ?></td>
    <td><?= $produto->getCategoria()->getNome() ?></td>
E no arquivo Produto.php vamos escrever, logo abaixo da função temIsbn(), o seguinte:

public function calculaImposto() {
    return $this->preco * 0.195;
}
Porém, quando o produto for um livro, seu desconto não será 19,5%, mas sim 6.5%. Como corrigir isso?

Vamos adicionar um if na função calculaImposto(), dessa forma, caso o produto possua isbn seu preço será de 0.065 e caso não seu valor normal será retornado. O código ficará da seguinte maneira:

public function calculaImposto() {
    if($this->temIsbn()) {
        return $this->preco *0.065;
    } else {
        return $this->preco * 0.195;    
    }
}
Ao fazer isso, estamos realizando a conta direto na classe produto, assim, caso ocorra mais alguma exceção a regra, será preciso criar um novo if e isso prejudica nosso código. O ideal é fazer a conta dentro do arquivo Livro.php, mas este elemento já possui contato com o método calculaImposto, pois ele herda da classe mãe este comportamento. Dessa forma, para alterar o comportamento da classe mãe vamos sobrescrever o método, basta escrever o método mais uma vez acompanhado das mudanças desejadas. Teremos o seguinte:

class Livro extends Produto {

    private $isbn;

    function getIsbn() {
        return $this->isbn;
    }

    function setIsbn($isbn) {
        $this->isbn = $isbn;
    }

    public function calculaImposto() {
        return $this->getPreco() * 0.065;
    }
}
Ao fazer isso podemos remover o if e else que acrescentamos no método calculaImposto() do arquivo Produto.php que ficará apenas:

public function calculaImposto() {
    return $this->getPreco() * 0.195;
}
Caso seja nossa intenção ter acesso ao preço propriamente dito, faz-se necessário modificar, no arquivo Produto.php, o modificador de acesso. Assim, podemos alterar de private para protected que indica um meio termo entre private e public. O public libera o acesso para todos e o private, ao contrário, fecha-se de todos. O interessante é que o protected libera acesso também para as classes filhas, por exemplo Livro é filho de Produto, então também terá acesso.

Importante: Sempre prefira usar a interface pública da classe ao em vez de afrouxar a regra do encapsulamento com a visibilidade protected. Idealmente, apenas a própria classe deveria acessar e modificar seu estado diretamente.

Vamos testar a alteração? Basta abrir a listagem, repare que os valores estão sendo calculados conforme esperado, 6.5% para livros e 19.5% para os demais produtos.

Polimorfismo
Perceba que apesar de chamarmos o mesmo método - o calculaImposto - possui um comportamento diferente de acordo com o tipo da classe que foi instanciada, isto é, muda sua resposta dependendo do objeto em questão, se for um Produto a reação é uma e se for Livro ela é diferente.

Como ele sabe qual imposto deve ser chamado? O PHP chama o método da classe mais específica, naquela que é feito um new. Se o método não estiver presente na classe mais específica, ele busca a classe mãe e a ordem é sempre essa. Esse recurso é conhecido como polimorfismo, isto é, a capacidade de um objeto ser referenciado de várias formas.

Lembrando que sem este recurso, seria necessário encadear uma série de ifs. O código ficaria parecido com:

<tr>
    <td><?= $produto->getNome() ?></td>
    <td><?= $produto->getPreco() ?></td>
    <td><?= substr($produto->getDescricao(), 0, 40) ?></td>
    <td>
        <?php 
            if ($produto->temIsbn()) {
                // calcula 6.5% de imposto
            }
            if ($produto->algumaOutraCoisa()) {
                // calcula 12% de imposto
            } else {
                // calcula 19.5% de imposto
            }
        ?>
    </td>

    //...

</tr>
A pior parte é que a cada novo tipo de produto seria necessário alterar o código, adicionando mais um if. Isso seria um pesadelo, desde a verbosidade dessas várias linhas de código a alta complexidade, ilegibilidade, etc. Tudo isso reflete diretamente na manutenção do código.

O que fizemos para resolver a situação foi aproveitar a estrutura do objeto, que com certeza é um Produto, mas mudar apenas o que o necessário nas implementações:

<td><?= $produto->calculaImposto() ?></td>
Nos exercícios testaremos o que vimos nesta aula!

------------------------------------------------------------------------------------------------------
<h1>Seção 05 - Classe Abstrata e o padrão Factory</h1>

<h2>Abstraindo Livro</h2>

Quando estamos trabalhando com Livros, temos que pensar nas possíveis variações desse produto. Um Livro pode ser físico, virtual, mini-livro, entre outros. Todo livro virtual (ebook), por exemplo, carrega uma marca d'agua (ou water mark) que identifica quem é seu proprietário. Além disso, quando um livro for físico, ele precisa ter uma taxa de impressão. Isso tudo precisa ser considerado em nosso código. Mas como?

Uma forma é adicionar estas novas propriedades na classe Livro, no arquivo Livro.php, assim como as seus respectivos getters e setters. O código que ficará assim:

class Livro extends Produto {

    private $isbn;

    private $taxaImpressao;
        private $waterMark;

    public function getIsbn() {
        return $this->isbn;
    }

    public function setIsbn($isbn) {
        $this->isbn = $isbn;
    }

    public functin getTaxaImpressao() {
        $this->taxaImpressao;
    }

    public function setTaxaImpressao($taxaImpressao){
        return $this->taxaImpressao = $taxaImpressao;
    }

    public functin getWaterMark() {
        $this->waterMark;
    }

    public function setWaterMark($waterMark){
        return $this->waterMark = $waterMark;
    }
    //...
}
Resolveria o problema, mas já vimos que essa não é a condição ideal. Com essa alteração, todo Livro teria waterMark e taxaImpressao, fazendo ou não sentido. Não é justo um ebook ter taxa de impressão, assim como um livro físico possuir uma water mark. Portanto, como resolver esta situação?

A mesma motivação que nos levou a criar a classe Livro vale aqui também! O Livro, lembre-se, diferente de Produto possui um isbn que o distingue.

Portanto, como solução vamos criar a classe Ebook dentro de um novo arquivo, o Ebook.php. É importante reparar que um ebook não deixa de ser um Livro, portanto, podemos utilizar a prática de estender a classe Ebook para Livro:

class Ebook extends
Nesta classe nós vamos inserir apenas a propriedade que é específica de Ebook, no caso, a waterMark, pois o Ebook é um livro e automaticamente herda o isbn:

<?php 

class Ebook {

    public function getWaterMark() {
        return $this->waterMark;
    }

    public function setWaterMark($waterMark) {
        $this->waterMark = $waterMark;
    }

}
O mesmo vale para a classe LivroFisico que terá apenas a taxaImpressao, pois já herda o isbn e tudo o que é comum a classe Livro. Portanto, vamos criar o arquivo LivroFisico.php e nele teremos o seguinte código:

class LivroFisico extends Livro {

    private $taxaImpressao;

    public function getTaxaImpressao() {
        return $this->taxaImpressao;
    }

    public function setTaxaImpressao($taxaImpressao) {
        $this->taxaImpressao = $taxaImpressao;
    }
}
Agora que representamos Livro, sendo ele Ebook ou LivroFisico, podemos nos expressar adicionando um novo Produto de algum destes tipos.

Mas o que acontece quando alguém cria um Livro?

O código funcionará perfeitamente, afinal não se trata de um problema de sintaxe. A falha está na semântica. O que é um Livro agora? Quando alguém cria um novo Livro, qual é seu tipo? Ebook? Físico?

Da mesma forma que não podemos ir à uma livraria e comprar um livro sem saber se é físico ou virtual, não podemos deixar que isso aconteça em nosso sistema!

A partir de agora, um livro é apenas uma abstração dos diferentes tipos de livros e o que eles possuem em comum, por exemplo, o isbn. Todo livro, independente de seu tipo, precisa de um isbn único e que não pode se repetir no código.

Por nossa sorte, a orientação a objetos nos oferece uma forma bem simples de resolver isso. Se a classe Livro é apenas uma abstração, podemos representar isso explicitamente adicionando o modificador abstract na assinatura. Assim, o arquivo Livro.php terá apenas as propriedades comuns a todos os Livros, como: calcular imposto e o isbn. O código fica com a seguinte aparência:

<?php

abstract class Livro extends Produto {

    private $isbn;

    public function getIsbn() {
        return $this->isbn;
    }

    public function setIsbn($isbn) {
        $this->isbn = $isbn;
    }
    public function calculaImposto()
    {
        return $this->getPreco() * 0.065; 
}

?>
Legal, não é? Na prática isso significa que ninguém poderá instanciar um objeto desse tipo, mas sim suas subclasses. Essa classe existe para encapsular as regras de negócio comuns entre os tipos de livros e deve ser utilizada estritamente para isso.

<h2>Adaptando lógica</h2>

Na última aula vimos que não é mais possível instanciar um Livro, portanto, precisamos modificar o código para solucionar a questão.

Podemos começar pelo nosso produto-formulario-base.php, que atualmente tem um select com as opções Produto e Livro. Assim, não é mais preciso disponibilizar a opção Livro

No lugar de Livro, vamos mudar as opções para Livro Físico e Ebook. Repare que Livro Físico possui um espaço, assim, é preciso remover ele da string e podemos fazer isso utilizando str_replace. O HTML ficará assim:

<tr>
    <td>Tipo do produto</td>
    <td>
        <select name="tipoProduto" class="form-control">
            <?php 
            $tipos = array("Produto", "Livro Fisico", "Ebook");
            foreach($tipos as $tipo) : 
                $tipoSemEspaco = str_replace(' ', '', $tipo);
                $esseEhOTipo = get_class($produto) == $tipoSemEspaco;
                $selecaoTipo = $esseEhOTipo ? "selected='selected'" : "";
            ?>
                <option value="<?=$tipoSemEspaco?>" <?=$selecaoTipo?>>
                    <?=$tipo?>
                </option>
            <?php endforeach ?>
        </select>
    </td>
</tr>
Então, usamos a função str_replace para substituir os espaços em branco dos elementos do array, especialmente para o caso do Livro Fisico, que é mostrado para o usuário com o espaço, mas a sua classe não tem espaço, logo Livro Fisico == LivroFisico nunca iria retornar true.

Podemos seguir melhorando o código, basta agrupar Ebook e Livro Fisico para ficar perceptível que são elementos do mesmo tipo. Podemos fazer isso utilizando a tag optgroup do HTML.

Porém, como não queremos que Produto também fique dentro do optgroup, faremos dois ifs. Um para abrir a tag optgroup, que só será aberta se for Livro Fisico. Porquê? Por que ele será o primeiro elemento a ser verificado no array após o Produto, logo iremos abrir a tag nele e fechá-la no Ebook, pois é o último elemento do array que deve ficar dentro do optgroup, por isso, fazemos outro if. Teremos:

<tr>
    <td>Tipo do produto</td>
    <td>
        <select name="tipoProduto" class="form-control">
            <?php 
            $tipos = array("Produto", "Livro Fisico", "Ebook");
            foreach($tipos as $tipo) : 
                $tipoSemEspaco = str_replace(' ', '', $tipo);
                $esseEhOTipo = get_class($produto) == $tipoSemEspaco;
                $selecaoTipo = $esseEhOTipo ? "selected='selected'" : "";
            ?>
                <?php if ($tipo == "Livro Fisico") : ?>
                    <optgroup label="Livros">
                <?php endif ?>
                        <option value="<?=$tipoSemEspaco?>" <?=$selecaoTipo?>>
                            <?=$tipo?>
                        </option>
                <?php if ($tipo == "Ebook") : ?>
                    </optgroup>
                <?php endif ?>
            <?php endforeach ?>
        </select>
    </td>
</tr>
Visualmente a mudança resulta em uma diferença no formulário:



Ainda, precisamos mudar a lógica de adicionar. Portanto, no arquivo adiciona-produto.php, um caminho simples é mudar o if para verificar se o tipo é um LivroFisico e setar o isbn e a taxaImpressao. Também é necessário adicionar outro if para verificar se trata-se de um Ebook e nele setamos a WaterMark:

if ($tipoProduto == "LivroFisico") {
    $produto = new LivroFisico($nome, $preco, $descricao, $categoria, $usado);
    $produto->setIsbn($isbn);
    $produto->setTaxaImpressao($taxaImpressao);
} else if ($tipoProduto == "Ebook") {
    $produto = new Ebook($nome, $preco, $descricao, $categoria, $usado);
    $produto->setIsbn($isbn);
    $produto->setWaterMark($waterMark);
} else {
    $produto = new Produto($nome, $preco, $descricao, $categoria, $usado);
}
Após fazer isso é preciso incluir no mesmo arquivo o $taxaImpressao = $_POST['taxaImpressao'] e $waterMark = $_POST['waterMark']. Teremos o seguinte:

$nome = $_POST['nome'];
$preco = $_POST['preco'];
$descricao = $_POST['descricao'];
$isbn = $_POST['isbn'];
$tipoProduto = $_POST['tipoProduto'];
$taxaImpressao = $_POST['taxaImpressao'];
$waterMark = $_POST['waterMark'];
E, assim como fizemos com o isbn, podemos repetir o procedimento com a Taxa de Impressao e WaterMark. No arquivo produto-formulario-base.php teremos:

<td>Taxa de Impressão (caso seja um Livro Físico)</td>
    <td>
        <input type="text" class="form-control" name="taxaImpressao" 
            value="<?php if ($produto->temTaxaImpressao()) { echo $produto->getTaxaImpressao(); } ?>" />
    </td>
</tr>
<tr>
    <td>WaterMark (caso seja um Ebook)</td>
    <td>
        <input type="text" class="form-control" name="waterMark" 
            value="<?php if ($produto->temWaterMark()) { echo $produto->getWaterMark(); } ?>" />
    </td>
</tr>
<tr>
Feito isso é preciso implementar esses dois métodos na classe Produto, no arquivo Produto.php. Teremos:

    public function temIsbn() {
        return $this instanceof Livro;
    }

    public function temTaxaImpressao() {
        return $this instanceof LivroFisico;
    }

    public function temWaterMark() {
        return $this instanceof Ebook;
    }
Ao fazer isso também faz-se necessário alterar o ProdutoDao.php no insereProduto. Portanto, adicionamos a WaterMark e a TaxaImpressao:

        $isbn = "";
        if($produto->temIsbn()) {
            $isbn = $produto->getIsbn();
        }

        $taxaImpressao = "";
        if($produto->temTaxaImpressao()) {
            $taxaImpressao = $produto->getTaxaImpressao();
        }

        $waterMark = "";
        if($produto->temWaterMark()) {
            $waterMark = $produto->getWaterMark();
        }
Ao fazer isso faz-se necessário acrescentar a TaxaImpressao e o WaterMark na query. E também é preciso adicionar as colunas, portanto, acrescentamos dentro de insert into produtos os dois elementos:

$query = "insert into produtos (nome, preco, descricao, categoria_id, 
                usado, isbn, tipoProduto, waterMark, taxaImpressao) 
                    values ('{$produto->getNome()}', {$produto->getPreco()}, 
                        '{$produto->getDescricao()}', 
                            {$produto->getCategoria()->getId()}, 
                                {$produto->isUsado()}, '{$isbn}', '{$tipoProduto}', 
                                    '{$waterMark}', '{$taxaImpressao}')";
Por fim, no phpMyAdmin vamos entrar em loja e vamos adicionar:

alter table produtos add column TaxaImpressao varchar(255)
alter table produtos add column waterMark varchar(255)
Ao acrescentar estas informações basta clicar no "Executar" e as duas colunas serão adicionadas!


<h2>O padrão Factory</h2>
Vamos observar o código do arquivo adiciona-produto.php:

if ($tipoProduto == "LivroFisico") {
    $produto = new LivroFisico($nome, $preco, $descricao, $categoria, $usado);
    $produto->setIsbn($isbn);
    $produto->setTaxaImpressao($taxaImpressao);
} elseif ($tipoProduto == "Ebook") {
    $produto = new Ebook($nome, $preco, $descricao, $categoria, $usado);
    $produto->setIsbn($isbn);
    $produto->setWaterMark($waterMark);
} else {
    $produto = new Produto($nome, $preco, $descricao, $categoria, $usado);
}
A cada novo produto adicionado, da maneira como o código está construído, faz-se necessário adicionar um novo if. Diante desta situação alguns problemas podem surgir: qual é a chance de esquecermos de alterar detalhes? E se tivermos que fazer alterações em diferentes pontos? Como saber que já fizemos as modificações necessárias em todos? A tendência é que o código fique cada vez maior e mais complexo. Nesta aula abordaremos maneiras de torná-lo mais simples e fácil de manter.

Uma das maneiras de solucionar o problema é usar um valor para instanciar o $_POST["tipoProduto"] de maneira dinâmica. Assim, vamos adicionar o seguinte:

$produto = new $tipoProduto($nome, $preco, $descricao, $categoria, $usado);
Parece simples, não é? Mas, precisamos ter dois cuidados:

Garantir que o parâmetro tipoProduto tenha exatamente o mesmo nome da classe, que por enquanto pode ser um Produto, Ebook ou LivroFisico. Se o parâmetro contem um nome inválido, por exemplo, uma classe que não existe, isso acarretará em um erro fatal ao instanciarmos o tipo.

Qualquer usuário pode editar o HTML da página, mudando o name do select. Afinal, qualquer um pode clicar com o botão direito no item do HTML e fazer um inspect element. Isto é, o HTML pode ser editado no próprio navegador, sem nenhuma dificuldade:



Neste exemplo, quando alguém seleciona um Ebook é a classe ProdutoDAO que deve ser instanciada. Neste caso, um caos ocorrerá não só pelo erro fatal que ocorre, mas também pela falha de segurança. Como resolver? É simples! Basta adicionar o $classes, um if e um else:

$classes = array("Produto", "Ebook", "LivroFisico");

if(in_array($tipoProduto, $classes)) {
    $produto = new Produto();
}
Agora, apenas as classes permitidas podem ser instanciadas. O único problema dessa solução é que o código possivelmente vai se repetir e como não queremos deixar a regra de negócio espalhada, vamos criar uma classe com responsabilidade única para criar os produtos permitidos. Assim, abrimos um novo arquivo, o CriadorDeProdutos.php, e nele adicionamos a class CriadorDeProdutos. Dentro da CriadorDeProduto acrescentamos $classes e if que estava no adiciona-produto.php. Teremos o seguinte:

$classes = array("Produto", "Ebook", "LivroFisico");

if(in_array($tipoProduto, $classes)) {
    $produto = new Produto();
}
O $classes deve possuir um atributo, portanto, adicionamos o private. Abaixo disso inserimos o public function criaPor(). É preciso que o if retorne o uma resposta, portanto, acrescentamos um return e apagamos o $produto, teremos: return new $tipoProduto($nome, $preco, $descricao, $categoria, $usado);.

No else repetimos o procedimento inserindo um return e para o Produto() passamos os seguintes parâmetros: $nome, $preco, $descricao, $categoria, $usado . Por fim, vamos passar para o criaPor() o $tipoProduto. Como os atributos são acessados dentro de um array, vamos receber também uma array, portanto, teremos: criaPor($tipoProduto, $params)

O código ficará da seguinte maneira:

<?php 
class CriadorDeProdutos {

    private $classes = array("Produto", "Ebook", "LivroFisico");

    public function criaPor($tipoProduto, $params) {

        if (in_array($tipoProduto, $this->classes)) {
            return new $tipoProduto($nome, $preco, $descricao, $categoria, $usado);
        } else {

            return new Produto($nome, $preco, $descricao, $categoria, $usado);
    }
}
?>
Ainda, dentro da criaPor() vamos adicionar o seguinte:

$nome = $params['nome'];
$preco = $params['preco'];
$descricao = $params['descricao'];
$categoria = new Categoria();
$usado = $params['usado'];
$CriadorDeProdutos
Agora, no arquivo adiciona-produto.php, vamos adicionar o $criadorDeProdutos = new criadorDeProdutos() e produto = $criadorDeProdutos->criaPor($tipoProduto, $_POST).

Vamos eliminar todos os ifs e elses que havíamos construído e reescrever isso. No caso, vamos apagar o seguinte:

if ($tipoProduto == "LivroFisico") {
    $produto = new LivroFisico($nome, $preco, $descricao, $categoria, $usado);
    $produto->setIsbn($isbn);
    $produto->setTaxaImpressao($taxaImpressao);
} elseif ($tipoProduto == "Ebook") {
    $produto = new Ebook($nome, $preco, $descricao, $categoria, $usado);
    $produto->setIsbn($isbn);
    $produto->setWaterMark($waterMark);
} else {
    $produto = new Produto($nome, $preco, $descricao, $categoria, $usado);
}
Assim, inserimos mais um if a fim de verificar se o produto possui ìsbn, WaterMark e TaxaDeImpressao. Teremos:

$criadorDeProdutos = new criadorDeProdutos();
$produto = $criadorDeProdutos->criaPor($tipoProduto, $_POST);

if ($produto->temIsbn()) {
    $produto->setIsbn($isbn);
}
if ($produto->temTaxaImpressao()) {
    $produto->setTaxaImpressao($taxaImpressao);
}
if ($produto->temMarkWater()) {
    $produto->setMarkWater($waterMark);
}
No arquivo produto-formulario-base.php vamos alterar o <td>WaterMark (caso seja um livro)</td> para <td>WaterMark (caso seja um Ebook)</td>.

<td>WaterMark (caso seja um Ebook)</td>
    <td>
        <input type="text" class="form-control" name="waterMark" 
            value="<?php if ($produto->temWaterMark()) { echo $produto->getWaterMark(); } ?>" />
</td>
No arquivo Produto.php, abaixo do método WaterMark, vamos inserir o atualizaBaseadoEm($params). Dentro disso colocamos os ifs apagados. Teremos:

public function atualizaBaseadoEm($params) {
        if ($this->temIsbn()) {
            $this->setIsbn($params["isbn"]);
        }
        if ($this->temWaterMark()) {
            $this->setWaterMark($params["waterMark"]);
        }
        if ($this->temTaxaImpressao()) {
            $this->setTaxaImpressao($params["taxaImpressao"]);
        }
    }
Ainda, no adiciona-produto.php vamos adicionar o $produto->atualizaBaseadoEm($_POST). Teremos:

$factory = new ProdutoFactory();
$produto = $factory->criaPor($tipoProduto, $_POST);
$produto->atualizaBaseadoEm($_POST);
Ao fazer isso podemos eliminar o que foi adicionado no adiciona-produto.php:

$nome = $_POST['nome'];
$preco = $_POST['preco'];
$descricao = $_POST['descricao'];
$isbn = $_POST['isbn'];
O padrão de projeto factory method
Vamos observar o arquivo adiciona-produto.php. No lugar do if, o código de adição ficará assim:

$tipoProduto = $_POST["tipoProduto"];

$factory = new ProdutoFactory();
$produto = $factory->criaPor($tipoProduto, $_POST);
Vamos apagar o seguinte:

$taxaImpressao = $_POST['taxaImpressao'];
$waterMark = $_POST['waterMark'];
E também:

$categoria = new Categoria();
Ficaremos com:

verificaUsuario();

$tipoProduto = $_POST['tipoProduto'];

$criadorDeProdutos = new CriadorDeProdutos();
$produto = $criadorDeProdutos->criaPor($tipoProduto, $_POST);
$produto->atualizaBaseadoEm($_POST);

$categoria_id->setId($_POST['categoria_id'));
Ainda, é preciso modificar o if e o else, portanto, teremos:

if(array_key_exists('usado', $_POST)) {
    $produto->setUsado("true");
} else {
    $produto->setUsado = ("false");
}
Aparentemente, o arquivo adiciona-produtos.php, está totalmente funcional.

Mas, temos que nos atentar para mais um detalhe, vamos observar o arquivo CriadorDeProdutos.php. Repare que o uso da classe CriadorDeProdutos é bem simples, porém extremamente importante, pois é responsável por encapsular o processo de criação dos produtos. Como trata-se de uma fábrica de produtos, é comum chamar esse tipo de classe de factory. Portanto, vamos renomear a classe de class CriadorDeProdutos para class ProdutoFactory. Ainda, vamos renomear o arquivo para ProdutoFactory.php.

Não foi a toa que a classe foi chamada de ProdutoFactory, esse é um padrão comum e conhecido no mundo orientado a objetos. É um dos famosos design patterns. Quer saber mais sobre este e outros padrões de projeto? Acesse o curso de Design Patterns PHP I: Boas práticas de programação e Design Patterns PHP II: Boas práticas de programação.

Assim, onde estiver escrito $criadorDeProduto é preciso modificar para factory. Também modificamos o $categoria->setId($_POST('categoria id')) para $produto->getCategoria()->setId($categoria_id). Teremos:

tipoProduto-> $_POST('tipoProduto');
$categoria_id = $_POST('categoria_id');

$factory = new ProdutoFactory();
$produto = $factory->criaFor($tipoProduto, $_POST);
$produto->atualizaBaseado($_POST);

$produto->getCategoria()->setId($categoria_id);
Após realizarmos tais modificações e fazermos uma simulação de adição de um Ebook, nos deparamos com um erro de sintaxe. O que acontece é que falta uma vírgula no arquivo ProfutoDao.php, na query, depois do {$produto->isUsado}. Também é preciso modificar a $classe no ProdutoFactory.php, para $this->classes:

if(in_array($tipoProduto, $this->classes))
Ao fazer estas alterações a adição do produto ocorre sem problemas. A falha agora está na listagem, portanto, no arquivo ProdutoDAO.php vamos repetir os mesmos procedimentos. Apagamos os parâmetros nome, preco, isbn, usado e descricao. Deixaremos apenas o $tipoPorduto, o $produto e o $produtocategoria. Este último deve ser modificado para: $produto->getCategoria()->setNome($produto_array['categoria_nome']). Por enquanto temos:

while($produto_array = mysqli_fetch_assoc($resultado)) {

    $tipoProduto = $produto_array['tipoProduto'];

    $produto->setId($produto_array['id']);
    $produto->getCategoria()->setNome($produto_array['categoria_nome']);

    array_push($produtos, $produto);
    }

    return $produtos;
Por fim, instanciamos uma factory, igual fizemos no arquivo adiciona-produto.php. Então, teremos:

$produto = $factory->criaPor($tipoProduto, $_POST);
$produto->atualizaBaseadoEm($_POST);
Mas, ao em vez de passar o $_POST vamos escrever $produto_array (em todos os lugares que o elemento aparecer). Nosso código ficará da seguinte maneira:

while($produto_array = mysqli_fetch_assoc($resultado)) {

            $tipoProduto = $produto_array['tipoProduto'];
            $factory = new ProdutoFactory();
            $produto = $factory->criaPor($tipoProduto, $_POST);
            $produto->atualizaBaseadoEm($_POST);

            $produto->setId($produto_array['id']);
            $produto->getVategoria()->setNome($produto_array['categoria_nome'])

            array_push($produtos, $produto);
        }

        return $produtos;
Ao fazer um teste teremos a listagem funcionando de maneira adequada!

Neste capítulo aprendemos a isolar o código de criação de produtos dentro de uma fábrica de produtos, isto é, uma factory que é um Designe Pattern bastante famoso do mundo de orientação a objetos. Além disso, aprendemos a manusear a factory

------------------------------------------------------------------------------------------------------
<h1>Seção 06 - Método Abstrato</h1>

Na última aula, aprendemos a agrupar if's dentro de um método único a fim de não repetir o código. O problema desta solução é que a cada classe filha, é preciso adicionar novos ifs. A solução é responsabilizar as classes filhas pela atualização das propriedades. Para fazer isso, podemos sobrescrever o método. Portanto, vamos copiar o atualizaBaseadoEm e colocar em Ebook. Seguindo essa ideia, a classe Ebook ficará assim:

<?php

class Ebook extends Livro {

    private $waterMark;

    public function getWaterMark() {
        return $this->waterMark;
    }

    public function setWaterMark($waterMark) {
        $this->waterMark = $waterMark;

    public function atualizaBaseadoEm($params) {
        $this->setIsbn($params['isbn']);
        $this->setWaterMark($params['waterMark']);
    }
}
?>
E repetimos o mesmo procedimento no arquivo LivroFisico.php, mas ao em vez de setar a WaterMark vamos escrever setTaxaImpressao. O LivroFisico, que também tem suas particularidades, fica assim:

<?php 
class LivroFisico extends Livro {

    private $taxaImpressao;

    public function getTaxaImpressao() {
        return $this->taxaImpressao;
    }

    public function setTaxaImpressao($taxaImpressao) {
        $this->taxaImpressao = $taxaImpressao;
    }
    public function atualizaBaseadoEm($params) {
        $this->setIsbn($params['isbn']);
        $this->setTaxaImpressao($params['taxaimpressao']);

    }

}
Note que todo filho de produto deve ter, obrigatoriamente, o atualizaBaseadoEm(). Portanto, podemos obrigar a implementação do método tornando-o abstrato.

Neste caso, os ifs no arquivo Produto.php já não são mais úteis:

public function atualizaBaseadoEm($params) {
    if ($this->temIsbn()) {
        $this->setIsbn($params["isbn"]);
    }
    if ($this->temWaterMark()) {
        $this->setWaterMark($params["waterMark"]);
    }
    if ($this->temTaxaImpressao()) {
        $this->setTaxaImpressao($params["taxaImpressao"]);
    }
}
Vamos remover isto do método e deixá-lo sem corpo. Antes, vamos transformá-lo em um abstract e ele ficará da seguinte maneira:

abstract function atualizaBaseadoEm($params);
Quando um método é abstrato, obrigatoriamente suas filhas, isto é, todas as classes que estendem a classe que possui o método abstract, devem implementar o método. Por isso, no arquivo Ebook.php e LivroFisico.php o atualizaBaseadoEm deve ser implementado.

O problema é que quando uma classe possui um método abstrato, isso obrigatoriamente a torna abstrata. Portanto, é preciso tornar a class Produto, do arquivo Produto.php, uma abstract class Produto,. Teremos o seguinte:

abstract class Produto {

    private $id;
    private $nome;
    private $preco;
    private $descricao;
    private $categoria;
    private $usado;

//...

}
Como transformamos o Produto em uma classe abstrata, é preciso removê-lo do private $classes do arquivo ProdutoFactory.php, que ficará:

private $classes = array("Ebook", "LivroFisico");
Também é preciso modificar o return padrão para ao em vez de ser Produto passar a ser LivroFisico.

No produto-formulario-base.php vamos apagar o seguinte, dentro do Tipo Produto:

<?php if($tipo == "Livro Fisico") : ?>
O endif também deve ser removido:

<?php endif ?>
O $tipos deve ser modificado e ficará da seguinte maneira:

$tipos = array("Livro Fisico", "Ebook");
E movemos o optgroup para baixo do select name e ainda deletamos o seguinte:

<?php if($tipo == "Ebook") : ?>
Sempre devemos lembrar de ajustar a dentação e teremos o seguinte código:

<td>Tipo do produto</td>
    <td>
        <select name="tipoProduto"
            <optgroup label="Livros">
                <?php 
                $tipos = array("Livro Fisico", "Ebook");
                foreach($tipos as $tipo) : 
                    $tipoSemEspaco = str_replace(' ', '', $tipo);
                    $esseEhOTipo = get_class($produto) == $tipoSemEspaco;
                    $selecaoTipo = $esseEhOTipo ? "selected='selected'" : "";
                ?>

                    <option value="<?=$tipoSemEspaco?>" <?=$selecaoTipo?>>
                                <?=$tipo?>
                    </option>

            <?php 
            endforeach 
            ?>
            </optgroup>
        </select>
    </td>
Falta, ainda, ajustar o arquivo produto-formulario.php. Nele nós estamos dando um new no produto:

$produto = new Produto("", "", "", $categoria, "");
O que devemos escrever é o seguinte:

$produto = new Produto("", "", "", $categoria, "");
Devemos alterar o código acima para que passe a ser:

$produto = new LivroFisico("", "", "", $categoria, "");
Agora, ao adicionar um produto teremos tudo funcionando de maneira adequada!

Relembrando:

Se uma clase é abstrata isso significa que não podemos instanciá-la, isto é, dar um new nela

Se a classe mãe possui um método abstrato obrigatoriamente suas filhas precisam implementar esse método. No caso, a classe Livro não precisa implementar o método AtualizaBaseadoEm, pois a classe Livro é igualmente abstrata.

Uma classe abstrata pode ter propriedades e métodos que não são abstratos, mas a partir do momento que ela possui um método abstrato, a classe também precisa ser abstrata
