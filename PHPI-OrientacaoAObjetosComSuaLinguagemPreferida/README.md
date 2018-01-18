---------------------------------------------------------------------------------------------------
<h1>Seção 01 - Classes e Objetos</h1>

Bem vindo ao nosso curso de PHP e Orientação a Objetos. No decorrer deste módulo entenderemos alguns dos principais conceitos e recursos de OO e colocaremos isso em prática na aplicação que foi desenvolvida no curso de PHP e MySQL. Não se preocupe se você não fez o outro curso, no primeiro exercício deste capítulo você receberá instruções para baixar o projeto e configurar o banco para continuar a partir deste ponto.

O projeto do curso é bastante simples, criaremos um formulário e nele nós vamos adicionar, remover e listar produtos.

Uma forma melhor de representar um Produto
No código, informações de um Produto estão todas espalhadas pelas assinaturas das nossas funções. Você pode notar isso no método insereProduto, do arquivo banco-produto.php:

function insereProduto($conexao, $nome, $preco, $descricao, $categoria_id, $usado) {

    $query = "insert into produtos (nome, preco, descricao, categoria_id, usado) 
        values ('{$nome}', '{$preco}', '{$descricao}', '{$categoria_id}', {$usado})";

    return mysqli_query($conexao, $query);
}
Um dos problemas de se fazer isso é que a cada nova informação dos produtos, um novo argumento precisa ser passado. Com o passar do tempo a assinatura da função insereProduto vai ficando cada vez maior, com mais argumentos e, portanto, mais difícil de ler e manter.

Uma das primeiras propostas para escrever um código orientado a objetos é que quando um elemento é importante em um contexto, ele deve ser representado por um tipo próprio. Um produto, por exemplo, é extremamente importante para nossa aplicação de loja, portanto, nada mais justo do que criar um tipo Produto para representá-lo, no lugar de trabalhar com informações espalhadas. Dessa forma o código ficará muito mais organizado.

Criando uma classe em PHP
Dentro da loja, vamos criar a pasta class e dentro dela criaremos o arquivo Produto.php, com a definição inicial de um Produto. Isso pode ser feito da seguinte forma:

<?php

class Produto {
    // ...
}

?>
Repare que a estrutura de uma classe é bem simples, ela começa com a palavra reservada class, seguida de seu nome e um par de chaves. Uma classe é um molde, uma receita de como criar determinado objeto de nosso sistema.

Convenção de nomes para classes
O ideal é que você sempre dê nomes significativos para suas classes, refletindo bem o que determinado objeto desse tipo representa em seu sistema. Por esse motivo é bastante recomendado que você não use muitas abreviações ao declarar este nome.

Além disso, por padrão, uma classe deve começar com letra maiúscula e ter seu case alterado a cada nova palavra (o famoso CamelCase ou CamelCaps). Você pode ler mais sobre convenções de código PHP aqui.

Propriedades da classe
A classe Produto, por enquanto, está vazia, mas uma classe deve representar tudo o que um objeto tem e faz. Por enquanto, vamos focar no que Produto tem: id, nome, preco descricao, categoria_id e usado. Ao acrescentar estes elementos, nós acabamos de definir atributos da classe é importante que junto deles adicionemos o símbolo $ e a palavra reservada public que faz com que nós acessemos de diversos lugares esses parâmetros. Teremos o seguinte código:

<?php

class Produto {

    public $id;
    public $nome;
    public $preco;
    public $descricao;
    public $categoria_id;
    public $usado;
}

?>
Não se intimide com a presença desse novo modificador, o public. Ele e outros modificadores de visibilidade serão melhor detalhados mais à frente. Apesar de se parecer muito com uma variável normal, esse tipo especial de variável é conhecido como propriedade (property). Comumente também são chamadas de variáveis de classe, variáveis membro, atributos ou fields.

As propriedades de uma classe, caso necessário, também podem ser inicializadas. Em cada novo produto, podemos explicitamente declarar o valor das propriedades , mas há um detalhe importante, o valor padrão precisa ser uma expressão constante. Não podemos, por exemplo, atribuir a uma variável, uma outra propriedade ou mesmo uma chamada de função. No caso, o seguinte código é inválido:

class Produto {

    // inválido, não pode receber uma variável
    public $id = $algum_atributo;

    // ok, isso é válido
    public $nome = 'Iphone 6 dobrável';

    // inválido, não pode receber outra propriedade
    public $preco = $nome;

    // inválido, tem que ser constante
    public $descricao = 'alguma '.'descricao';

    // inválido, não pode receber uma função
    public $categoria_id = retornaCategoriaPadrao();
}
Classes e objetos são a mesma coisa?
É completamente natural confundir esses dois conceitos no início, mas é fundamental saber distinguir o que é classe e o que é objeto.

Vimos que uma classe é como um protótipo, um molde para criar um objeto de determinado tipo. Mas como isso funciona? A ideia é que a nossa loja possa ter milhares de produtos, mas haverá apenas uma classe Produto. Um único molde. A partir dele, diversos objetos serão criados.

Uma analogia interessante é comparar uma classe com uma receita de bolo. A pergunta é certeira: você come uma receita de bolo? Não. Precisamos instanciá-la, criar um objeto bolo a partir dessa especificação (a classe) para utilizá-la. Podemos criar centenas de bolos a partir dessa classe (a receita, no caso), eles podem ser bem semelhantes, alguns até idênticos, mas são objetos diferentes.

Já vimos como criar uma classe, mas como utilizá-la?

Criando e usando objetos
Acabamos de criar a definição do produto no arquivo Produto.php. Antes de utilizá-lo vamos criar um novo arquivo, o CriaProduto.php, para testar uma nova classe.

Uma classe é como uma receita de bolo, é preciso colocar a mão na massa, produzir o bolo para depois comê-lo. A classe segue essa mesma ideia, não basta que ela exista, é preciso criá-la. Assim, para instanciar a classe produto faz-se necessário adicionar o new:

<?php
    require once("class/Produto.php")

    $livro = new Produto();

?>
Agora um livro passa a ter todas as propriedades e regras que foram definidas no livro, o id, nome, preco, etc.

Note que criamos uma variável $livro para futuramente referenciar esse novo objeto que está sendo criado. Através dessa variável, podemos acessar e atribuir valores a ele, como por exemplo:

<?php
    require once("class/Produto.php")

    $livro = new Produto();

    $livro->nome = "Livro de PHP";

?>
Utilizamos o operador ->, conhecido como Object Operator, para fazer essa atribuição. Da mesma forma podemos popular as propriedades preco, descricao, categoria e usado. Um exemplo seria:

$produto->nome = "Livro da Casa do Código";
$produto->preco = 29.90;
$produto->descricao = "Livro de tecnologia";
$produto->usado = "true";
$produto->categoria_id = 1;
É importante perceber que, mesmo que as propriedades tenham sido declaradas com o prefixo $, nós não usamos esse símbolo ao atribuir valores para elas. Sendo assim, o seguinte código é inválido:

<?php

// Código inválido!!!
$produto->$nome = "Livro da Casa do Código";

?>
Colocando o conhecimento em prática
Agora que já temos uma base, vamos modificar nosso arquivo adiciona-produto.php para utilizar a nova classe. Fizemos um teste instanciando a classe livro, agora, podemos instanciar a Produto, que ficará da seguinte maneira:

<?php

require once("class/Produto.php")

$produto = new Produto();

$produto->nome = "Livro da Casa do Código";

?>
Feito isso podemos utilizá-la no código do arquivo adiciona-produto.php. No lugar de fazer:

$nome = $_POST["nome"];
$preco = $_POST["preco"];
$descricao = $_POST["descricao"];
$categoria_id = $_POST["categoria_id"];
if(array_key_exists('usado', $_POST)) {
    $usado = "true";
} else {
    $usado = "false";
}
Vamos criar um novo objeto do tipo Produto e atribuir esses valores a ele. O código deve ficar assim:

$produto = new Produto();

$produto->nome = $_POST['nome'];
$produto->preco = $_POST['preco'];
$produto->descricao = $_POST['descricao'];
$produto->categoria_id = $_POST['categoria_id'];

if(array_key_exists('usado', $_POST)) {
    $produto->usado = "true";
} else {
    $produto->usado = "false";
}
Lembrando que para usar a classe Produto, precisaremos fazer o import do arquivo Produto.php. Para isso basta adicionar a linha junto com os outros imports no início do arquivo adiciona-produto.php:

require_once("class/Produto.php");
É preciso também adicionar o produto junto a categoria_id:

$produto->categoria_id = $_POST['categoria_id'];
Feito isso, em nosso if, no lugar de fazer:

if (insereProduto($conexao, $nome, $preco, $descricao, $categoria_id, $usado))
Podemos passar apenas o $produto como argumento:

if (insereProduto($conexao, $produto))
Muito mais simples e declarativo, não acha? Vamos agora modificar a função insereProduto, no arquivo banco-produto.php, para que passe a funcionar dessa forma. Atualmente, o código está assim:

function insereProduto($conexao, $nome, $preco, $descricao, $categoria_id, $usado) {

    $query = "insert into produtos (nome, preco, descricao, categoria_id, usado) 

}
A primeira mudança será na assinatura dessa função, que deve ficar:

function insereProduto($conexao, $produto) {

    $query = "insert into produtos (nome, preco, descricao, categoria_id, usado) 
}
E agora, em todo lugar que utilizávamos as variáveis diretamente, passaremos a usar a sintaxe do object operator (->) que acabamos de conhecer. O código deve ficar assim:

function insereProduto($conexao, Produto $produto) {

    $query = "insert into produtos (nome, preco, descricao, categoria_id, usado) 
        values ('{$produto->nome}', {$produto->preco}, '{$produto->descricao}', 
            {$produto->categoria_id}, {$produto->usado})";

    return mysqli_query($conexao, $query);
}
Lembrando que no arquivo adiciona-produto.php na linha do if(insereProduto($conexao, $produto) o $nome não pode mais estar solto. Então, devemos ter a seguinte modificação:

if(insereProduto($conexao, $produto)) { ?>
    <p class="text-success">0 produto <?=$produto->nome ?>, <?= $produto->preco
E também na linha do <p class="text-danger"> no qual o nome deve ser acompanhado de $produto: $produto->nome.

Tudo pronto, rode o código para ver o resultado! Tudo continua funcionando, inclusive podemos adicionar um novo produto sem problemas!

É interessante desde já perceber que essa simples mudança proporciona uma manutenibilidade e legibilidade melhor em nosso código. Se precisarmos adicionar um novo campo no Produto, a assinatura da função não vai mudar e nenhum lugar que chama a função insereProduto precisará ser tocado.

PHP Orientado a Objetos
Apesar do PHP não ser uma linguagem puramente orientada a objetos, ela possui suporte à programação orientada a objetos e cada vez mais a comunidade e bibliotecas tem utilizado essa abordagem. A orientação a objetos é um paradigma que busca tornar seu código mais organizado e reutilizável, dividindo responsabilidades de forma clara dentro do sistema.

Muitos imaginam que as linguagens orientadas a objetos são coisas novas e que só apareceram da década de 90 pra cá. Na verdade, a orientação a objetos é um paradigma antigo e que foi implementado inicialmente na linguagem Simula e depois na Smalltalk. Esta última surgiu na década de 70, apenas para estudos. Teve uma versão real da linguagem nos anos 80 e com os estudos e evolução da linguagem, outras foram seguindo o mesmo paradigma. C++, Java, C# e Ruby são algumas delas.

Mesmo com o grande incentivo da comunidade PHP para que ela se torne uma linguagem puramente orientada a objetos, muito legado ainda existe, o que dificulta a mudança de toda a linguagem e ferramentas. Neste capítulo, vimos algumas das muitas vantagens desse paradigma. Colocaremos tudo isso em prática em nossa aplicação.

-----------------------------------------------------------------------------------------------------------------
<h1>Seção 02 - Evoluindo a listagem de produtos</h1>

Agora que estamos trabalhando com objetos, podemos modificar um pouco nossas listagens de produto e categoria. Podemos começar pela função listaProdutos, do arquivo banco-produto.php. Note que estamos utilizando o mysqli_fetch_assoc para criar um array com os dados de cada produto:

function listaProdutos($conexao) {

    $produtos = array();
    $resultado = mysqli_query($conexao, "select p.*, c.nome as categoria_nome 
        from produtos as p join categorias as c on c.id=p.categoria_id");

    while($produto = mysqli_fetch_assoc($resultado)) {
        array_push($produtos, $produto);
    }

    return $produtos;
}
No lugar de trabalhar com as arrays diretamente na página, podemos a cada iteração criar um objeto Produto com todas as informações necessárias. Para fazer isso, basta modificar o método listaProdutos. Primeiro, alteramos o nome da variável $produto para $produto_array. Depois, vamos instanciar todos os atributos do $produto, ex: $produto-> nome = $produto_array['nome']. Nosso código ficará como a seguir:

function listaProdutos($conexao) {

    $produtos = array();
    $resultado = mysqli_query($conexao, "select p.*, c.nome as categoria_nome 
        from produtos as p join categorias as c on c.id=p.categoria_id");

    while($produto_array = mysqli_fetch_assoc($resultado)) {

            $produto = new Produto();

        $produto->nome = $produto_array['nome'];
                $produto->preco = $produto_array['preco'];
        $produto->descricao = $produto_array['descricao'];
        $produto->categoria id = $produto array ['categoria nome'];
        $produto->usado = $produto_array['usado'];

        array_push($produtos, $produto);
    }

    return $produtos;
}
Feito isso, precisaremos mudar a forma que estamos lidando com esses valores no arquivo produto-lista.php. No lugar de fazer:

<table class="table table-striped table-bordered">

    <?php
    $produtos = listaProdutos($conexao);
    foreach ($produtos as $produto) :
    ?>
        <tr>
            <td><?= $produto['nome'] ?></td>
            <td><?= $produto['preco'] ?></td>

            <!-- continuação do código omitido -->
        </tr>
    <?php
    endforeach
    ?>    
</table>
Passaremos a utilizar a sintaxe de objetos, com o ->. Repare:

<table class="table table-striped table-bordered">

    <?php
    $produtos = listaProdutos($conexao);
    foreach ($produtos as $produto) :
    ?>
        <tr>
            <td><?= $produto->nome ?></td>
            <td><?= $produto->preco ?></td>
            <td><?= substr($produto->descricao, 0, 40) ?></td>
            <td><?=$produto->categoria_id?></td>
            <td><a class="btn btn-primary" href="produto-altera-formulario.php?id=<?=$produto->id?>">a>
            <td>
                <form action="remove-produto.php" method='post"'>
                <input type="hidden" name="id" value="<?=$produto->id?>">
                <button class="btn btn-danger">remover</button>
                </form>
            </td>
        </tr>
    <?php
    endforeach
    ?>    
</table>
Observação: Devemos modificar todo o arquivo para utilizar a sintaxe de objetos (->).

Ao rodar o código encontramos um problema! O que acontece é que criamos no arquivo banco-produto.php o Produto, assim é preciso importar com require_once('class/Produto.php'); bem no início do arquivo:

require_once('conecta.php');
require_once('class/Produto.php');
Após essas alterações podemos executar o código e tudo continuará funcionando conforme esperado!

Relacionamento de objetos
Até agora a categoria era controlada por um id, referenciado no produto. Porém, queremos manter nosso sistema orientado a objetos. Dessa forma, criamos além da classe Produto, também a classe Categoria. Esta classe vai representar uma Categoria em nosso sistema e estará armazenada no novo arquivo Categoria.php:

<?php

class Categoria {

    public $id;
    public $nome;

}

?>
A classe Produto deixa de ter uma $categoria_id para possuir apenas o $categoria:

<?php

class Produto {

    public $id;
    public $nome;
    public $preco;
    public $descricao;
    public $categoria;
    public $usado;
}

?>
No arquivo produto-lista.php nós vamos chamar o objeto categoria que deve exibir o nome:

<tr>
            <td><?= $produto->nome ?></td>
            <td><?= $produto->preco ?></td>
            <td><?= substr($produto->descricao, 0, 40) ?></td>
            <td><?=$produto->categoria->nome ?></td>
            <td><a class="btn btn-primary" href="produto-altera-formulario.php?id=<?=$produto->id?>">a>
            <td>
                <form action="remove-produto.php" method='post"'>
                <input type="hidden" name="id" value="<?=$produto->id?>">
                <button class="btn btn-danger">remover</button>
                </form>
            </td>
        </tr>
Feito isso é preciso também modificar o arquivo banco-produto.php e, em vez de acessarmos o categoria_id, vamos criar uma categoria. Também atribuímos junto da $categoria um nome:

$produto = new Produto();
$categoria = new Categoria();
$categoria->nome = $produto_array['categoria_nome'];

$produto->id = $produto_array['id'];
$produto->nome = $produto_array['nome'];
$produto->preco = $produto_array['preco'];
$produto->descricao = $produto_array['descricao'];
$produto->categoria = $categoria;
$produto->usado = $produto_array['usado'];
Nesse mesmo arquivo é preciso importar a classe recém criada:

require_once('conecta.php');
require_once('class/Produto.php');
require_once('class/Categoria.php');
Agora, ao listar os produtos teremos um funcionamento perfeito e mais semântico! Temos um objeto categoria que carrega suas próprias informações e uma listagem bem mais elaborada!

Agora, a classe Produto possui um atributo que na verdade é um objeto. Isto é, temos um objeto dentro de outro objeto. Já o atributo Categoria faz referência a classe Categoria. Assim, deixamos de ter o categoria_id para termos apenas o categoria. No arquivo adiciona-produto.php vamos pegar o $_POST['categoria_id'] e acrescentá-lo junto de $categoria->id e também adicionamos o $categoria = new Categoria();. Por fim, modificamos o $produto para $produto->categoria = $categoria. Fazemos tudo isso sem esquecer de importar a classe, require_once("class/Categoria.php"):

require_once("cabecalho.php");
require_once("banco-produto.php");
require_once("logica-usuario.php");
require_once("class/Produto.php");
require_once("class/Categoria.php");

verificaUsuario();

$produto = new Produto();
$categoria = new Categoria();
$categoria->id = $_POST['categoria_id'];

//...

$produto->categoria = $categoria;
Repetimos os mesmos procedimentos no arquivo altera-produto.php, importamos a classe categoria e instanciamos nela o seu id. Alteramos também o categoria do $produto para que faça referência ao objeto $categoria:

require_once("cabecalho.php");
require_once("banco-produto.php");
require_once("class/Produto.php");
require_once("class/Categoria.php");

$produto = new Produto();
$categoria = new Categoria();
$categoria->id = $_POST['categoria_id'];

//...

$produto->categoria = $categoria;
É preciso também alterar as funções, tanto para a função de inserir quanto para a alterar. Faz-se necessário também modificar a forma como elas se referenciam a categoria. Assim, no arquivo banco-produto.php teremos nas querys o categoria->id:

$query = "insert into produtos (nome, praço, descricao, categoria_id, usado) 
    values ('{$produto->nome}',(produto->preco), '($produto->descricao)`, 
            {$produto->categoria->id}, {$produto->usado})";
E também:

$query = "update produtos set nome = '{$produto->nome}',
    preco = {$produto->preco},
        descricao = '{$produto->descricao}',
            categoria id = {$produto->categoria->id},
                usado = {$produto->usado}
                    where id = '{$produto->id}'";
Faltam outras modificações no código, mas as próximas mudanças estão melhor explicadas nos exercícios!

-----------------------------------------------------------------------------------------------------------------------------------------------------
<h1>Seção 03 - Métodos</h1>

Vimos que o uso de classes já torna algumas coisas mais interessantes em nosso sistema. Mas até agora, nossas classes Produto e Categoria só tem propriedades, ou seja, só guardam estado. Uma classe também pode (e deve) ter comportamentos. Por exemplo, como faríamos para aplicar um desconto de 10% no valor real do produto? Uma forma simples de fazer isso seria adicionar ao arquivo produto-lista.php o seguinte:

<td><?= $produto->preco - $produto->preco * 0.1? ?></td>
Estamos subtraindo da propriedade $preco, o seu próprio valor multiplicando por 0.1. O código funciona, se observarmos o site encontraremos uma coluna na qual estarão os preços calculados já com os descontos.

Vamos criar uma função que receba um Produto como parâmetro, para que seja possível reutilizar esse comportamento em outros locais do código. Dessa forma, ao final do arquivo produto-lista.php teremos:

<?php

function precoComDesconto(Produto $produto) {
    $produto->preco -= $produto->preco * 0.1;
    return $produto->preco;
}

?>
Em seguida, precisaremos trocar na listagem a linha que multiplicava o valor do desconto por:

<td><?= $precoComDesconto($produto)</td>
Estamos no caminho certo, mas ainda há um problema. Onde essa função deverá ser definida? No arquivo que ela será usada? E se forem vários arquivos? Criamos um arquivo novo só pra ela? Adicionamos no banco-produto.php? Como ela não é uma função de banco, nenhuma das soluções parecem muito satisfatória.

O problema de fazer a função junto da listagem é que isso fica um tanto esquisito, dessa forma, vamos remover a função e colocá-la junto da classe Produto no arquivo Produto.php. Dessa forma, todos que tem acesso ao Produto, terão acesso a esse comportamento em comum. Além disso, a função já terá acesso fácil à propriedade $preco, também definida nessa classe. Essa é uma solução muito mais interessante do que deixar a função em um local desatrelado das informações do Produto. Assim mantemos o estado e comportamento juntos.

Chamamos de método as funções que definimos dentro de uma classe, já que elas definem a forma (método) de fazer operações em determinado objeto. Ainda, podemos adicionar junto a função do precoComDesconto o public que indica que ela pode ser acessada de diferentes locais.

Fazendo as alterações a classe Produto deve ficar assim:

<?php

class Produto {

    public $id;
    public $nome;
    public $preco;
    public $descricao;
    public $categoria;
    public $usado;

    public function precoComDesconto() {
        $this->preco -= $this->preco * 0.1;
        return $this->preco;
    }
}
?>
Repare que no lugar de recebermos um $produto como argumento, não recebemos mais nada, e agora estamos usando a pseudo variável $this, para nos referenciar ao objeto que está chamando essa função. Para executar o método precoComDesconto utilizaremos no arquivo produto-lista.php o operador ->, e também apagamos o parâmetro $produto. O termo usado para isso é invocação de método, a coluna do desconto ficará da seguinte maneira:

<td><?= $produto->precoComDesconto() ?></td>
Ao rodar o código teremos tudo funcionando corretamente, mas de uma maneira mais ordenada.

Podemos deixar esse método ainda mais mais flexível, recebendo o valor do desconto como um argumento (parâmetro) no lugar de sempre aplicar o valor fixo de 0.1 para descontos. Assim, adicionamos o parâmetro $valor e escrevemos preco * $valor:

function precoComDesconto($valor) {
    $this->preco -= $this->preco * $valor;
    return $this->preco;
}
Podemos passar quantos argumentos, ou parâmetros (como são chamados), forem necessários para nossos métodos. Um parâmetro nada mais é do que uma variável comum, chamada também de temporária ou local, pois, ao final da execução desse método, ela deixa de existir.

Agora, ao invocar o método precoComDesconto o produto-lista.php deve ser alterado para, por exemplo, 10% de desconto:

<td><?= $produto->precoComDesconto(0.1)</td>;
Se buscamos um valor padrão de desconto que deve ser extendido para todos os produtos da loja podemos modificar a função e utilizar, por exemplo, $valor = 0.1. Assim, os 10% de desconto serão padrão:

function precoComDesconto($valor = 0.1) {
    $this->preco -= $this->preco * $valor;
    return $this->preco;
}
Lembrando que devemos modificar concomitantemente o arquivo produto-lista.php, que ficará:

<td><?= $produto->precoComDesconto() ?></td>
Para Saber Mais: Sobrecarga com parâmetros opcionais
Um recursos interessante e que pode ser bastante útil são os parâmetros opcionais. Quando necessário, podemos atribuir um valor padrão para o parâmetro como a seguir:

function precoComDesconto($valor = 0.1) {
    if ($valor > 0 && $valor <= 0.5) {
        $this->preco -= $this->preco * $valor;
    }
    return $this->preco;
}
Neste exemplo, caso o valor do desconto não tenha sido fornecido, ele será de 10%. Esse recurso é bastante utilizado quando precisamos fazer uma sobrecarga de método, já que em PHP não podemos ter métodos com o mesmo nome.

Uma regra importante é que quando temos os dois tipos de parâmetros (opcionais e não opcionais) declarados, os opcionais tem que ser os últimos na lista de parâmetros. Por exemplo:

function precoComDesconto($paramObrigatorio, $valor = 0.1) {
    // ...
}
Declarar o $paramObrigatorio por último resultaria em um erro.


----------------------------------------------------------------------------------------------------------------------------------------------------
<h1>Seção 04 - Encapsulamento</h1>

Há um problema em nosso código: O que acontecerá se algum desenvolvedor fornecer um valor negativo de desconto? Vamos adicionar juros ao produto! E se fosse um valor maior que 50%? Provavelmente teremos um prejuízo na venda dos produtos! Por exemplo:

$produto = new Produto();
$produto->preco = 50.00;
$produto->precoComDesconto(0.7); // 15.00
$produto->precoComDesconto(-1); // 100.00
Não podemos permitir que essas situações aconteçam. Portanto, vamos alterar a função precoComDesconto para aplicar nela um novo comportamento que deve validar descontos maiores que 0 e menores ou iguais a 0.5 (50%):

function precoComDesconto($valor) {
    if ($valor > 0 && $valor <= 0.5) {
        $this->preco -= $this->preco * $valor;
    }
    return $this->preco;
}
Ao criar o método precoComDesconto, resolvemos apenas parte do problema. Ele torna nosso comportamento mais centralizado na classe Produto, evitando repetições, já que isola a regra. Mas, ainda é possível realizar procedimentos que não são desejados, como fazer:

$produto->preco -= $produto->preco * 99999;
ou

$produto->nome = 'nome que eu quiser'
Em outras palavras, ninguém garante que o usuário dessa classe vai sempre usar o método precoComDesconto, já que ele pode acessar o $preco do produto diretamente. Esse problema é bem grave! Como evitar que nossa regra de negócio seja violada? A melhor forma seria proibindo o acesso direto ao atributo $preco, assim o usuário da classe Produto só conseguirá aplicar um desconto utilizando o método precoComDesconto, que faz todas as validações necessárias.

Para fazer isso, basta modificar a visibilidade do atributo para private:

class Produto {

    public $id;
    public $nome;
    private $preco;
    public $descricao;
    public $categoria;
    public $usado



    function precoComDesconto($valor = 0.1) {
        if ($valor > 0 && $valor <= 0.5) {
            // eu posso acessar, estou na mesma classe
            $this->preco -= $this->preco * $valor;
        }
        return $this->preco;
    }
}
O private que utilizamos agora é, assim como o public, um modificador de visibilidade (acesso). Ao manter um atributo ou método como private, estamos fechando completamente sua visibilidade para todas as demais classes do sistema, exceto para a própria classe que o declarou.

O problema é que ao rodar o código ocorre um erro! Apenas a própria classe pode ler o atributo private. Assim, é preciso criar um método que acesse o preço e retorne o valor, permitindo que outras classes tenham o valor de $preco. Vamos acrescentar o seguinte no arquivo Produto.php:

public function getPreco() {
    return $this->preco;

}
Modificadores de visibilidade
Agora, ninguém mais consegue aplicar um desconto em um produto sem ser passando pelo método precoComDesconto. Mas ainda não terminamos de solucionar a questão, pois o seguinte código da listagem passa a dar erro:

<table class="table table-striped table-bordered">

    <?php
    $produtos = listaProdutos($conexao);
    foreach ($produtos as $produto) :
    ?>
        <tr>
            <td><?= $produto->nome ?></td>
            <td><?= $produto->preco ?></td>
            <td><?= $produto->precoComDesconto(0.1) ?></td>

            //...

</table>
O problema está na linha que imprime o preço do produto:

<td><?= $produto->preco ?></td>
Esse código agora é inválido, já que não podemos mais acessar o preço do produto fora da sua classe.

É muito comum, e faz todo sentido, que suas propriedades sejam private e quase todos seus métodos sejam public (não é uma regra!). Desta forma, toda conversa de um objeto com outro é feita por troca de mensagens, isto é, acessando seus métodos. Algo muito mais educado que mexer diretamente em um atributo que não é seu!

Assim, o dia em que precisarmos mudar o desconto do Produto vamos modificar apenas o método precoComDesconto. Como exemplo, imagine que o desconto em algum momento precise ser de no máximo 30%. Basta alterar a classe Produto. Além disso, as classes que usam esse método nem precisam ficar sabendo de tal modificação! Ganhamos muito em esconder o funcionamento do nosso método na hora de dar manutenção e fazer modificações.

Portanto, para solucionar o problema vamos alterar a linha <td><?= $produto->preco ?></td>, do arquivo produto-lista.php para:

<td><?= $produto->getPreco() ?></td>
A ideia de esconder os membros de uma classe (como fizemos com o preço do produto) é conhecida como encapsulamento. Encapsular é fundamental para que seu sistema seja suscetível a mudanças, assim: não precisamos mudar uma regra de negócio em vários lugares, mas sim em apenas um único ponto.

Getters e Setters
Note que agora estamos permitindo acesso a esse atributo de forma controlada. Não chamamos o método de getPreco por acaso, essa é uma convenção muito conhecida. Sempre que queremos retornar (pegar) um valor, chamamos o método de get seguido do nome do atributo, no caso, getPreco. De forma similar, quando queremos mudar (inserir) um valor, chamamos o método de set. Assim, vamos incluir no arquivo Produto.php o setPreco:

public function setPreco($preco) {
    $this->preco = $preco;
}
Vamos definir uma "regra" para o preço, o valor passado para o método setPreco não pode ser negativo:

public function setPreco($preco) {
    if ($preco > 0) {
        $this->preco = $preco;
    }
}
Note que o setter sempre recebe um argumento que é o valor que deve ser atribuído.

Para adicionar o preço do produto devemos modificar no arquivo banco-produto.php o $produto->preco = $produto_array['preco']; para $produto->setPreco ($produto_array['preco']):

$produto->id = $produto_array['id'];
$produto->nome = $produto_array['nome']
$produto->setPreco($produto_array['preco']);
$produto->descricao = $produto_array['descricao'];
$produto->categoria = $categoria;
$produto->usado = $produto_array['usado']
Nesta aula modificamos apenas o atributo $preco. Arrumar os demais será uma tarefa para os exercícios! A ideia é deixar todos os atributos como privados e criar getters e setters para cada atributo privado da classe Produtos. A partir disso refatoraremos o código para usar os novos métodos! E repetiremos o processo tanto para o produto quanto para a Categoria.

Em PHP, quando não especificamos o modificador de acesso, por padrão, tanto métodos como atributos são considerados public.

O modificador private serve para restringir o acesso a atributos e métodos da classe, permitindo apenas a própria classe acessar e modificar os seus atributos.

Então, as alternativas corretas eram apenas a 1 e 2.

Também existe o modificador de acesso protected, que não foi usado neste vídeo, mas que será explicado mais à frente no treinamento.

-----------------------------------------------------------------------------------------------------------------------
<h1>Seção 05 - Comparando objetos</h1>

Para conhecer um pouco mais sobre objetos, vamos escrever e executar o seguinte código onde comparamos dois produtos com mesmo preço e nome:

<?php
    require "class/Produto.php";

    $produto = new Produto();
    $produto->setPreco(59.9);
    $produto->setNome("Livro da Casa do Codigo");

    $outroProduto = new Produto();
    $outroProduto->setPreco(59.9);
    $outroProduto->setNome("Livro da Casa do Codigo");

    if ($produto == $outroProduto) {
        echo "sao iguais";
    } else {
        echo "sao diferentes";
    }
?>
O resultado impresso será: sao iguais. Isso acontece pois quando utilizamos o == para comparar objetos em PHP, as instâncias são consideradas iguais se são da mesma classe e se possuem as mesmas propriedades e valores. Como $produto e $outroProduto são instâncias da classe Produto e tem os mesmos atributos, a comparação será verdadeira.

Podemos fazer a comparação utilizando o operador de identidade === (3 iguais). Neste caso a comparação só será verdadeira se os objetos se referem à mesma instância da mesma classe. Em outras palavras, só será igual se for o mesmo objeto. Por exemplo, vamos mudar a comparação para === e executar o código novamente.

<?php
    require "class/Produto.php";

    $produto = new Produto();
    $produto->setPreco(59.9);
    $produto->setNome("Livro da Casa do Codigo");

    $outroProduto = new Produto();
    $outroProduto->setPreco(59.9);
    $outroProduto->setNome("Livro da Casa do Codigo");

    if ($produto === $outroProduto) {
        echo "sao iguais";
    } else {
        echo "sao diferentes";
    }
?>
Dessa vez a saída será "sao diferentes", afinal, apesar de terem o mesmo valor, são produtos diferentes na memória.

Objetos são acessados por referência
É fundamental sempre lembrarmos que uma variável de instância guarda apenas a referência (um número/endereço), apontando para o local da memória onde as informações sobre um objeto estão guardadas. Sendo assim, a cada classe que criamos a referência será diferente.

Para que a comparação anterior seja verdadeira, (a utilizando ===) podemos fazer algo como:

$produto = new Produto();
$produto->setPreco(59.9);
$produto->setNome("Livro da Casa do Codigo");

$outroProduto = new Produto();
$outroProduto->setPreco(59.9);
$outroProduto->setNome("Livro da Casa do Codigo");

$outroProduto = $produto;
Note que dessa forma o $outroProduto recebe o endereço de $produto, passando a referenciar o mesmo objeto que a variável $produto referencia. Sendo assim, ao comparar os dois com o operador de identidade === eles serão consideradas iguais. O código fica assim:

<?php

    require "class/Produto.php";

    $produto = new Produto();
    $produto->setPreco(59.9);
    $produto->setNome("Livro da Casa do Codigo");

    $outroProduto = new Produto();
    $outroProduto->setPreco(59.9);
    $outroProduto->setNome("Livro da Casa do Codigo");

    $outroProduto = $produto;

    if ($produto === $outroProduto) {
        echo "sao iguais";
    } else {
        echo "sao diferentes";
    }

?>
Ao executar o código o resultado é: são iguais.

Resumindo: A diferença entre == e ===
Se o que importa para nós é verificar a igualdade de atributos, utilizamos a igualdade dupla (==), entretanto, se o que nos interessa é se as instancias referenciam o mesmo objeto, utilizamos a igualdade tripla (===).

----------------------------------------------------------------------------------------------------------------------------------------------------
<h1>Seção 06 - Magic methods</h1>

Nesta aula vamos analisar a classe produto.

A pergunta é: faz algum sentido possuir um produto que não tenha nome, preço ou qualquer outro atributo? Atualmente, quando instanciamos a classe Produto, todos os atributos aparecem como nulos. O $nome e $preco são atributos obrigatórios para a construção de um produto, sem isso ele simplesmente não existe! O melhor momento para adicionar os atributos que consideramos necessários é no momento da criação dos objetos!

Todo objeto PHP instanciado através da palavra reservada new já possui um método especial chamado __construct. Vamos realizar um teste adicionando o __construct no arquivo Produto.php:

class Produto {

    private $id;
    private $nome;
    private $preco;
    private $descricao;
    private $categoria;
    private $usado


    function __construct() {
        echo "Construindo um Produto";
    }

//...

}
Esse método funcionará toda vez que instanciarmos um objeto, no caso, um Produto. Quando executarmos a listagem, a mensagem será exibida para cada produto, justamente porque instanciamos com new Produto()

Outro ponto interessante é que o método __construct pode receber diversos parâmetros, dessa forma, podemos inicializar as propriedades que desejamos no momento da construção do objeto. Por exemplo, vamos criar um construtor que já receba o nome e preço do Produto:

    function __construct($nome, $preco) {
        $this->nome = $nome;
        $this->preco = $preco;
    }
Quando definimos o __construct, passamos como parâmetro algumas propriedades que tornam-se obrigatórias. Portanto, a partir de agora sempre que instanciarmos um Produto faz-se necessário passar um preco e nome. Antes de seguir adiante, vamos passar os demais atributos ao construtor: $descricao, $categoria e $usado. Lembrando que id não está incluso e que categoria por ser uma classe, é necessário passar o tipo.

    function __construct($nome, $preco, $descricao, Categoria $categoria, $usado) {
        $this->nome = $nome;
        $this->preco = $preco;
        $this->descricao = $descricao;
        $this->categoria = $categoria;
        $this->usado = $usado;

    }
No arquivo adiciona-produto.php, vamos mover o $produto = new Produto() para baixo do $produto->setCategoria($categoria) e passamos para ele todos os atributos que definimos:

$produto->setCategoria($categoria);

$produto = new Produto($nome, $preco, $descricao, $categoria, $usado);
Feito isso é preciso alterar o setNome, o setPreco e $setDescricao e também modificar o setUsado que está dentro do if e do else. Também não é mais necessário o a linha $produto->setCategoria($categoria);, podemos removê-la. A classe ficará da seguinte maneira:

$nome = $_POST['nome'];
$preco = $_POST['preco'];
$descricao = $_POST['descricao'];

if(array_key_exists('usado', $_POST)) {
    $usado = "true";
} else {
    $usado = "false";
}

$produto = new Produto($nome, $preco, $descricao, $categoria, $usado);
Ao fazer isso adquirimos um código mais limpo e legível! Perceba que não utilizamos nenhum set a não ser o setId. Então, no arquivo Produto.php podemos apagar todas as demais funções: setNome,setPreco, setDescricao e setCategoria. Permanecerão apenas o setUsado e setId. Caso, no futuro, seja necessário o uso de outro set, basta criá-lo.

No arquivo produto-formulario.php temos um produto vazio. Ele de fato deve ser vazio, mas é preciso passar para ele os parâmetros, portanto o construtor ficará da seguinte forma: new Produto("", "", "", $categoria, ""). É preciso também apagar o $produto->setCategoria e mover a linha que instancia o Produto para baixo do $categoria->setId(1);.

$categoria = new Categoria();
$categoria->setId(1);
$produto = new Produto("", "", "", $categoria, "");
Ao rodar o código nos deparamos com um formulário funcionando perfeitamente! O problema é que ocorre um erro ao mostrar a lista de produtos, então, para solucionar a falha no arquivo banco-produto.php é preciso passar os atributos e parâmetros para o construtor. Antes, precisamos colocar a instância do new Produto() e $produto->setId($produto_array['id']) abaixo das variáveis. A classe ficará da seguinte maneira:

$categoria = new Categoria();
$categoria->setNome($produto array['categoria nome']);

$nome = $produto_array['nome'];
$preco = $produto_array['preco'];
$descricao = $produto_array['descricao'];
$produto->setCategoria($categoria);
$usado = $produto_array['usado'];

$produto = new Produto($nome, $preco, $ descricao, $categoria, $usado);

$produto->setId($produto_array['id']);

array_push($produtos, $produto);
Representando o objeto como um texto
Outra necessidade comum do dia-a-dia é representar nossos objetos com um texto, isto é, imprimi-los. Sabemos que para mostrar o nome do Produto podemos adicionar o seguinte:

echo $produto;
Bem, nesse caso a saída não será muito agradável. Recebemos como resposta um erro!

Isso ocorre, pois o PHP não consegue converter um Produto em uma string. Podemos utilizar um método bastante comum para nos ajudar nesta tarefa, o __toString. Ele ensina ao PHP a como se comportar caso algum objeto seja convertido para uma string. Neste caso, na classe Produto, no arquivo Produto.php, faremos:

function __toString() {
    return $this->nome.": R$ ".$this->preco;
}
Tudo pronto! Conseguimos imprimir um produto acompanhado de suas propriedades. Lembrando que é preciso remover o echo $produto para não poluir a aplicação.

__destruct
Outro recurso interessante do PHP são os métodos destrutores. Você pode criar um método chamado __destruct que será chamado assim que todas as referências de um objeto específico forem removidas, ou, caso ele tenha sido destruído explicitamente.

Um exemplo seria:

    function__toString() {
        return $this->nome.": R$ ".this->preco;
    }


    function __destruct() {
        echo "Produto destruído";
    }
Após utilizar o produto que criamos, a seguinte mensagem será exibida:

> Produto destruído
É um método interessante para casos como conexões com o banco de dados, podendo colocar operações que precisam ser executadas antes do objeto ser destruído, por exemplo, fechar a conexão. É importante lembrar de retirar esse trecho do código, pois caso você esqueça, as informações serão eternamente impressas.

Para saber mais: Magic methods
Como vimos, os métodos __construct, __destruct e __toString tem um significado especial no PHP. Eles são conhecidos como Magic Methods. Se quiser, você pode ler mais a respeito e conhecer outros métodos mágicos pela documentação da linguagem, aqui.
http://php.net/manual/pt_BR/language.oop5.magic.php

Chegamos ao final do primeiro capítulo do curso de PHP com Orientação a Objetos. Neste módulo, aprendemos o conceito de classes, objetos e a encapsular o código dentro de métodos. Aprendemos também os construtores, e como instanciar objetos com valores pré-determinados.

Na segunda parte do curso, aprenderemos mais conceitos como herança de classes, DAO's que são os Data Access Object, reescrita, polimorfismo, métodos e classes abstratas. E claro, colocaremos tudo que já aprendemos em prática.

Te encontro na parte dois!
