<h1>Algumas imagens do Projeto</h1>
<img src="https://github.com/GustavoPrimolan/Alura-PHPeMySQLIFundamentosParaCriarUmSistemaWeb/blob/master/TelaInicial.PNG"/>
---------------------------------------------------------------------------------------------------------------------------
<img src="https://github.com/GustavoPrimolan/Alura-PHPeMySQLIFundamentosParaCriarUmSistemaWeb/blob/master/AdicionaProduto.PNG"/>
---------------------------------------------------------------------------------------------------------------------------
<img src="https://github.com/GustavoPrimolan/Alura-PHPeMySQLIFundamentosParaCriarUmSistemaWeb/blob/master/TelaProdutos.PNG"/>
---------------------------------------------------------------------------
<h1>Seção 01 - Primeiros passos com PHP</h1>


<h2>Primeiros passos com PHP</h2>

Bem vindo ao nosso curso de PHP e MySql. Nesse curso, veremos como fazer com que páginas estáticas fiquem dinâmicas, ou seja, sites que reagem de acordo com a ação do usuário. E para isso, utilizaremos o PHP, que é uma tecnologia que nos ajuda nessa tarefa.
Um bom exemplo são os sites das lojas virtuais, como Amazon e etc. Neles, você consegue adicionar e remover produtos do carrinho, alterar produtos, etc. E a grande graça é que todas as informações ficam salvas em servidores na Internet. Assim, qualquer pessoa pode acessar a lista de produtos sempre atualizada.

Neste curso, faremos uma loja de produtos, e o disponibilizaremos na internet. A aplicação será grande: adicionaremos produtos, categorias, os listaremos, e etc. No meio do caminho, precisaremos aprender diversos fundamentos da web. Como funciona o processo de termos um servidor e um cliente, distantes um do outro? Como vários clientes conseguem acessar o mesmo servidor?

Para começar o curso, você já deve ter instalado na sua máquina o XAMPP. O XAMPP nada mais é do que um utilitário que já instala o PHP, o Apache e o MySql, que são todas as ferramentas que precisamos para trabalhar no curso. Se você ainda não instalou, você o instalará no primeiro exercício.

Vamos conferir se a instalação está correta. No diretório que criamos as nossas páginas (que é o diretório de instalação do XAMPP, por exemplo, /Applications/XAMPP/xamppfiles/htdocs), vamos criar um diretório /loja. Em seguida, vamos abrir esse diretório em algum editor de texto, para que possamos lidar com os diversos arquivos que criaremos ao longo do tempo no nosso curso.

Nosso primeiro arquivo se chamará index.php, e terá uma mensagem simples:

<html>
    <h1>Bem vindo!</h1>
</html>
Se quisermos testar, basta abrirmos o browser e acessarmos: http://localhost/loja/. Localhost quer dizer a própria máquina, e /loja é justamente o sub-diretório que criamos. Poderíamos acessar o endereço de outra forma também: http://localhost/loja/index.php.



Vamos entender o que aconteceu. Quando você digitou um endereço no navegador, o navegador foi até o servidor, e o servidor devolveu uma resposta para o browser, que a mostrou. É possível ver o HTML que chegou no browser, por meio da opção View -> Developer -> View Source do Chrome.

No caso acima, ambas as URLs devolvem o mesmo conteúdo, pois o servidor é inteligente: se você faz uma requisição para uma pasta, e não especifica um arquivo exato (como um .php ou .html), ele então procura por um arquivo chamado "index.php", e devolve o conteúdo dele.

Uma outra maneira também de ver a requisição e a resposta acontecendo é usando a aba de Desenvolvedor do Chrome. View -> Developer -> Developer Tools. Outros navegadores também tem opções semelhantes. Se dermos um refresh na página, podemos vê-la na aba Network. Se olharmos ali, vemos que a requisição funcionou (voltou status 200, que significa sucesso, e entenderemos melhor mais pra frente).

Vamos agora criar a pagina que adiciona um produto: adiciona-produto.php. Vamos começar colocando a mensagem de cadastro com sucesso:

<html>
Produto NOME adicionado com sucesso!
</html>
Vamos abrir o browser e testar: http://localhost/loja/adiciona-produto.php. Ele exibe a mensagem. Vamos agora passar parâmetros pra essa página, pela própria URL. Vamos acessar o seguinte endereço: http://localhost/loja/adiciona-produto.php?nome=carro&preco=5000. Veja que usamos o ? e passamos uma lista de chaves e valores: nome=carro, preco=5000, e assim por diante; separamos cada ítem com &.

Mas ao acessarmos essa página, parece que ele "descartou" o nome que passamos, pois a mensagem ainda tem o texto "NOME". É agora que começaremos a programar em PHP. Precisamos dizer na nossa página que temos uma variável nome, que vem do usuário. Para isso, precisamos programar em PHP. Código PHP não é código HTML, e precisamos separar bem ambos para que o servidor entenda e processe corretamente. Repare o <?php:

 <html>
<?php
$nome = $_GET["nome"];
?>
Produto NOME adicionado com sucesso!
</html>
Veja que dentro do código PHP, declaramos uma variável "nome", usando $, e usamos o $_GET[], que é um array, e pega os valores que foram passados pelo usuário na URL. No nosso caso, fizemos $_GET['nome'], porque o parâmetro enviado pela URL se chama "nome". Podemos fazer a mesma coisa para o "preco". Vamos já também imprimir a variável "nome" também no lugar da palavra "NOME":

 <html>
<?php
$nome = $_GET["nome"];
$preco = $_GET["preco"];
?>
Produto <?php echo $nome; ?> adicionado com sucesso!
</html>
Quando o comando php é escrito em uma única linha, o ponto-e-vírgula é opcional. Aqui, vamos usar para manter um padrão. Vamos dar um refresh na página e ver o resultado. O nome agora apareceu no lugar certo!

Vamos exibir o preço também:

 <html>
<?php
$nome = $_GET["nome"];
$preco = $_GET["preco"];
?>
Produto <?php echo $nome; ?>, <?php echo $preco; ?> adicionado com sucesso!
</html>
Também funciona! Como exibiremos informação o tempo todo no PHP, existe um atalho que facilita: <?= $nome; ?>:

 <html>
<?php
$nome = $_GET["nome"];
$preco = $_GET["preco"];
?>
Produto <?= $nome; ?>, <?= $preco; ?> adicionado com sucesso!
</html>
Agora vamos criar o formulário que vai mandar essas informações, afinal não queremos que o usuário digite direto na URL. No arquivo produto-formulario.php, colocaremos:

<html>
    <form>
        Nome: <input type="text" name="nome" /><br/>
        Preço: <input type="number" name="preco" /><br/>

        <input type="submit" value="Cadastrar" />
    </form>
</html>
Veja que demos nomes aos campos de texto, pois é através desse nome, que conseguiremos recuperar a informação lá no PHP. Se acessarmos o formulário pelo browser, temos a seguinte tela:



Se preenchermos o formulário, e clicarmos no botão, ele vai enviar as informações! Mas repare que ele enviou para a página errada. Ele enviou para a própria página. Precisamos mudar isso, pois precisamos mandar para a página adiciona-produto.php. Fazemos essa mudança no form:

<form action="adiciona-produto.php">

</form>
Vamos testar de novo. Abrimos o formulário e cadastramos. Agora funcionou! Os dados que foram digitados no formulário, foram submetidos para a adiciona-produto.php, que por sua vez pegou os valores informados pelo usuário e os exibiu. Veja que aqui tivemos 2 requisições: uma para pedir o formulário, e a resposta foi o formulário; a outra foi o envio das informações, e a resposta foi a mensagem elegante confirmando a adição.

Mas por enquanto nosso sistema está feio. Vamos fazer uso de uma biblioteca famosa, chamada Bootstrap, que vem com um conjunto de CSS que já nos ajudam. Você pode baixá-lo em getbootstrap.com, clicando em Download Bootstrap.

Ao descompactar a biblioteca, vemos que ela é composta por 3 diretórios: css, fonts, js. Vamos copiar as 3 pastas para nosso projeto. Para usá-lo, basta importar o CSS. Vamos na nossa página principal, criar a tag HEAD, e importar o CSS do bootstrap. Além disso, vamos fazer uso das classes do bootstrap, que deixarão nosso site bonito:

<html>
<head>
    <title>Minha loja</title>
    <meta charset="utf-8">
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/loja.css" rel="stylesheet" />
</head>

<body>
    <div class="container">

        <div class="principal">
            <h1>Bem vindo!</h1>
        </div>

    </div>

</body>
</html>
Veja também que colocamos o loja.css dentro da pasta CSS do projeto, que será o css da nossa loja. Vamos criá-lo, pois precisamos escrever a classe "principal":

body {
    padding-top: 50px;
}

.principal {
    padding: 40px 15px;
    text-align: center;
}
Se abrirmos o index.php no browser, vemos que a fonte já está mais elegante, o texto centralizado, e etc. Aos poucos vamos usando mais coisas do Bootstrap.

Vamos levar o mesmo layout pra outra página:

<html>
<head>
    <title>Minha loja</title>
    <meta charset="utf-8">
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/loja.css" rel="stylesheet" />
</head>

<body>
    <div class="container">

        <div class="principal">

        <?php
        $nome = $_GET["nome"];
        $preco = $_GET["preco"];
        ?>
        Produto <?= $nome; ?>, <?= $preco; ?> adicionado com sucesso!

        </div>

    </div>

</body>
</html>
Mas dá pra melhorar ainda mais, já que o Bootstrap tem bastante coisa legal. Vamos pegar a mensagem de sucesso e colocar num parágrafo com a classe "alert-success":

    <p class="alert-success">
        Produto <?= $nome; ?>, <?= $preco; ?> adicionado com sucesso!
    </p>
Vamos fazer a mesma coisa agora na página de formulário, e colocar um H1 para indicar que é um formulário:

<html>
<head>
    <title>Minha loja</title>
    <meta charset="utf-8">
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/loja.css" rel="stylesheet" />
</head>

<body>
    <div class="container">

        <div class="principal">

        <h1>Formulário de cadastro</h1>
        <form action="adiciona-produto.php">
            Nome: <input type="text" name="nome" /><br/>
            Preço: <input type="number" name="preco" /><br/>

            <input type="submit" value="Cadastrar" />
        </form>

        </div>

    </div>

</body>
</html>
O formulário também já está melhor. Mas o problema é que nesses arquivos temos um monte de copy-and-paste. Todo copiar e colar é ruim, pois se precisarmos mudar algo, precisaremos mudar em todos, e o trabalho será muito grande!

Vamos então separar esse código repetido e colocar em um único arquivo, começando pela parte de cima, no cabecalho.php:

<html>
<head>
    <title>Minha loja</title>
    <meta charset="utf-8">
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/loja.css" rel="stylesheet" />
</head>

<body>
    <div class="container">

        <div class="principal">
A mesma coisa para a parte de baixo, no rodape.php :

        </div>

    </div>

</body>
</html>
Vamos agora fazer uso desses arquivos que criamos. Nos arquivos anteriores, vamos jogar fora o "código repetido" e incluir ambos os PHPs que criamos:

<?php include("cabecalho.php"); ?>

        <h1>Formulário de cadastro</h1>
        <form action="adiciona-produto.php">
            Nome: <input type="text" name="nome" /><br/>
            Preço: <input type="number" name="preco" /><br/>

            <input type="submit" value="Cadastrar" />
        </form>

<?php include("rodape.php"); ?>
Veja só como agora está melhor. Se mudarmos o cabeçalho ou rodapé, mudaremos em um único lugar!

Nesse capítulo então aprendemos que o mundo web funciona através de requisições e respostas. O servidor processa a requisição e envia uma resposta de volta ao browser. Aprendemos também que para programar PHP no meio do HTML, basta abrir a tag PHP. Aprendemos também a reaproveitar código, usando a tag include.




<h2>PHP, a sintaxe básica I</h2>
Conhecendo mais a sintaxe
Onde fica?
Nosso código PHP dentro da página HTML sempre ficará dentro da tag:

<?php 

//isso eh um comentario

?>
Variáveis
Em PHP, as variáveis são representadas pelo cifrão($), juntamente com o nome dela. Repare que nós não precisamos definir o tipo da variável:

<?php 
    $curso = "Curso PHP e Mysql I: Fundamentos para criar um sistema na Web";
?>
Imprimindo Dados
Para imprimir dados, como por exemplo, a variável declarada anteriormente, utilizamos o comando "echo":

<?php 
    $curso = "Curso PHP e Mysql I: Fundamentos para criar um sistema na Web";
    echo $curso;
?>
Condicionais
Como em toda linguagem de programação, o PHP também possui o seu if/else:

<?php 
    $numero = 10;
    if($numero > 5){
        echo "Maior que 5!";
    }
    else{
        echo "Menor que 5";
    }
?>
Repetições
Repare que o código PHP difere pouco das outras linguagens. A maior diferença talvez seja o cifrão($) na frente das variáveis. Repare no código do for:

<?php
  for ($i=0; $i < 5 ; $i++) {
    echo "Laço de número: " . $i;
  }
 ?>

?>
Nosso código acima irá imprimir os números: Laço de número: 0 Laço de número: 1 Laço de número: 2 .... Muito parecido com outras linguagens como C e Java!

Veja que juntamos também uma mensagem "Laço de número: ". Em PHP, para concatenarmos tanto strings quanto variáveis, utilizamos o .*(ponto)*. Repare agora no while:

<?php

    $condicao = 5;
    $i = 0;
    while ($i < $condicao) { 
        echo "Laço de número: " . $i;
        $i++;
    }

?>
Temos exatamente a mesma resposta: Laço de número: 0 Laço de número: 1 Laço de número: 2 ...

Arrays
Como aprendemos em Lógica de programação, arrays são muito úteis pois conseguem guardar diversos valores dentro uma mesma variável. Novamente, em PHP não temos nada de muito diferente na declaração de um array:

<?php

    $numeros = array(1,3,9,4,5,8,2,6,7,0);

?>
Passamos para a função array() do PHP os valores na qual queremos colocar dentro da variável $numeros. Para termos o acesso a cada um desses valores individualmente, fazemos:

<?php

    $numeros = array(1,3,9,4,5,8,2,6,7,0);
    for ($i=0; $i < 10; $i++) { 
        echo "Chave: " . $i . "Valor: " . $numeros[$i];
    }

?>
Nosso código acima irá verificar cada posição do array de 0 a 9, e irá imprimir a mensagem dizendo qual chave/valor estamos no array.

Lembra que nós não dizemos qual tipo a variável será? Isso significa também que nosso array não tem tipo, e por isso podemos colocar quaisquer valores dentro do array, inclusive misturando-os:

<?php

    $arrayMaluco = array(0,1,"banana","alura",4,5,"curso php",7,8,9);

?>

<h2>Praticando a sintaxe I</h2>

Vamos praticar um pouco a sintaxe do PHP!
Verifique se as opções abaixo estão corretas:

Para imprimirmos uma variável, substituimos o $ por $echo_nomeVariavel;
 
Alternativa correta
Imprimimos dados concatenados através do .*(ponto)*;
Alternativa correta
Em situações de comparação, não precisamos do $. Ex:
$numero = 1;
if(numero > 0){//código}
 
Alternativa correta
Para declararmos variáveis, não precisamos do tipo, apenas de $;
Alternativa correta
Acessamos uma posição do array através de $->. Ex: numeros$->5. Estamos acessando a posição 5 do array de números.


<h2>PHP, a sintaxe básica</h2>

Funções
Podemos declarar funções em PHP através da palavra function, seguida do nome da função e os parâmetros na qual ela recebe:

<?php
    function mostraConteudoDoArray($array){
        for ($i=0; $i < sizeof($array); $i++) { 
            echo "Chave: " . $i . "Valor: " . $array[$i];
        }
    }
?>
Repare que utilizamos de uma função dentro da nossa, chamada sizeof(). Ela nos retorna o tamanho do nosso array, para assim nosso valor não ficar fixo, e sim variar de acordo com o que passarmos como parâmetro. Agora podemos utilizar a nossa função para mostrar o conteúdo de qualquer array que tivermos:

<?php

    $arrayMaluco = array(0,1,"banana","alura",4,5,"curso php",7,8,9);
    $numeros = array(1,3,9,4,5,8,2,6,7,0);

    mostraConteudoDoArray($arrayMaluco);
    mostraConteudoDoArray($numeros);

?>
E assim teremos na nossa tela o conteúdo dos 2 arrays que declaramos.

Podemos também retornar valores para quem nos chamou no programa. Fazemos isso através da palavra return. Repare que não precisamos especificar o tipo do retorno, já que qualquer variavel poderá assumir o valor retornado!

<?php

    function somaDoisNumeros($n1, $n2){
        $soma = $n1+$n2;
        return $soma;
    }

    //numeros que serão somados
    $a = 60;
    $b = 40;
    //chamando a função
    $resultado = somaDoisNumeros($a, $b);
    echo $resultado;
?>
Teremos na nossa tela o valor 100.

<h2>Praticando a sintaxe II</h2>
Exercício
Agora que sabemos a sintaxe básica de PHP, vamos praticar!

Tente criar uma função que recebe um array de números. O retorno da função será a soma de todos os números de dentro do array.

Talvez você não tenha ainda o ambiente PHP configurado, mas não tem problema. Use seu editor de texto preferido!
Sua função deve ficar parecida com essa:
<?php

    function somaArray($array){
        $soma = 0;
        for ($i=0; $i < sizeof($array); $i++) { 
            $soma = $soma + $array[$i];
        }
        return $soma;
    }

?>
Primeiro criamos a variável que será retornada. Depois percorremos tudo com o for, e vamos somando os valores. Depois é só retornar! Caso não haja valores no array, retornaremos a soma como 0(valor inicial que colocamos).

<h2>Código devolvido ao cliente</h2>
A web é baseada no protocolo HTTP, que envolve requisições e respostas. Quando acessamos nossa página em nosso servidor local, o servidor rodou um programa (chamado php) e gerou um texto, esse texto foi devolvido para o cliente de uma vez só (contendo o cabeçalho, corpo e rodapé).
Para verificarmos o que o servidor devolveu após todo o processamento, basta clicar com o botão da direita do mouse em nossa página e escolher Visualizar código fonte.

O resultado é o conteúdo de nossa página html. Repare então que mesmo que a página html não exista no servidor, ele é um programa capaz de devolver texto... e esse texto é a página que o cliente vai interpretar.
Essa é a importância de um servidor: um programa que gera páginas a serem interpretadas pelo cliente. A página pode ser fixa ou dinâmica.




------------------------------------------------------------------------------------------------------------------
<h1>Seção 02 - Inserindo produtos no banco de dados</h1>

No capítulo anterior, vimos como criar uma página PHP, criar cabeçalhos e rodapés para evitar repetição de código e como ler parâmetros. O que falta agora é inserirmos esses parâmetros no banco de dados. Como já instalamos o MySQL (o XAMPP instalou para nós), vamos fazer uso dele.

Nosso primeiro passo é levantar o servidor do MySQL e conectar nele. Se formos na página de configuração do XAMPP (http://localhost/xampp), vemos que o MySQL está desativado. Em cada sistema operacional, isso é feito de uma maneira diferente.

Com o MySQL no ar, podemos ir no PHPMyAdmin, que é um excelente administrador de MySql, que vem no XAMPP. Basta clicar no link que existe na página de status do XAMPP, e estamos nele.

Caso a tela inicial peça o nome do utilizador, digite "root" e deixe o campo de senha em branco.

Em Create Databases, vamos criar um novo banco chamado "loja". Com o banco criado, vamos criar a tabela que armazenará a lista de produtos. Na aba SQL, digite:

create table produtos (id integer auto_increment primary key, nome varchar(255), preco decimal(10,2))
Clicando em Go, a tabela será criada. Aqui não entraremos a fundo em SQL. Se quiser entender um pouco mais, faça o curso online dedicado ao assunto.

Vamos agora inserir alguns produtos para ver o MySql funcionando. Novamente, na aba SQL:

insert into produtos values (1, 'Carro', 20000);
insert into produtos values (2, 'Motocicleta', 10000);
Podemos forçar o auto incremento, não passando o ID:

insert into produtos (nome, preco) values ('Bicicleta', 300);
Se clicarmos em Browse, vemos a lista de todos os produtos adicionados. No nosso caso, 3 produtos.

Agora que temos um banco de dados no nosso MySql, vamos fazer o PHP inserir algo nele. De volta ao adiciona-produto.php, vamos escrever a SQL nele:

<?php include("cabecalho.php"); ?>

<?php
$nome = $_GET["nome"];
$preco = $_GET["preco"];

$query = "insert into produtos (nome, preco) values (?????)";
?>

Produto <?= $nome; ?>, <?= $preco; ?> adicionado com sucesso!

<?php include("rodape.php"); ?>
Veja que guardamos a query em uma variável, mas precisamos trocar os "??" pelos valores passados pelo usuário. Geralmente, é comum que desenvolvedores concatenem esses valores na mão. Algo como:

$query = "insert into produtos (nome, preco) values ('" . $nome . "', " . $preco . ")";
Repare que o ponto (.) soma duas strings. Mas o problema disso é que é muito trabalhoso. O PHP nos dá uma maneira mais fácil de misturar strings e variáveis. Chamamos isso de interpolação, e para isso, basta usar o símbolo { e }:

$query = "insert into produtos (nome, preco) values ('{$nome}', {$preco})";
O PHP vai automaticamente pegar o valor da varíavel nome e preco e concatenar na string. Fica mais fácil de ler. Mas repare que isso só funciona se a string for declarada com aspas duplas.

Vamos continuar, e mandar essa SQL para o banco de dados. Em primeiro lugar, conectamos no banco de dados, passando endereço, usuário e senha:

$conexao = mysqli_connect('localhost', 'root', '', 'loja');
Em seguida, executamos a query:

mysqli_query($conexao, $query);
Por fim, fechamos a conexão:

mysqli_close($conexao);
Nosso código completo ficou:

$query = "insert into produtos (nome, preco) values ('{$nome}', {$preco})";

$conexao = mysqli_connect('localhost', 'root', '', 'loja');
mysqli_query($conexao, $query);
mysqli_close($conexao);
Se testarmos agora a inserção de um lápis pelo formulário, isso deve funcionar. Basta conferir no MySql para ver que a linha foi adicionada. Veja só como acessar o MySql pelo PHP é fácil. Basta apenas conhecer apenas alguns métodos da biblioteca.

Mas veja só o que acontece se não passarmos o preço no formulário. Apesar da aplicação web falar que a inserção foi feita, se formos no MySql, vemos que nenhuma linha foi adicionada. Isso acontece porque o MySql deu um erro (afinal a SQL, sem o preço, fica errada!), mas nós não tratamos esse erro.

Precisamos então tratar esse erro, e fazemos isso na função de mysqli_query. Ela devolve true em caso de sucesso, ou false em caso de falha:

if(mysqli_query($conexao, $query)) {
    // funcionou
} else {
    // nao deu certo
}
Vamos agora misturar HTML com PHP, e mostrar a mensagem de sucesso apenas se deu sucesso:

<?php
if(mysqli_query($conexao, $query)) {
?>
<p class="alert-success">Produto <?= $nome; ?>, <?= $preco; ?> adicionado com sucesso!</p>
<?php
} else {
?>
<p class="alert-danger">O produto <?= $nome; ?> não foi adicionado</p>
<?php
}
?>
Pronto. Agora nossa aplicação retorna um erro amigável caso a inserção falhe.

Um detalhe curioso do PHP é que ele fecha a conexão do MySql automaticamente. Ou seja, não precisamos colocar a linha mysqli_close(). Nesse caso, quando a última linha do seu script for executada, aí sim ele a fechará.

<h2>Inserindo no banco de dados</h2>
Escreva agora toda a lógica de inserção de um produto no banco de dados. Lembre-se de:
1 - conectar no banco

2 - escrever a query

3 - enviar para o banco

4 - verificar o resultado

Se foi inserido com sucesso, mostre na tela que foi adicionado. Se deu erro, diga que ocorreu um problema.

VER OPINIÃO DO INSTRUTOR
Opinião do Instrutor

<?php
include("cabecalho.php");

$nome = $_GET["nome"];
$preco = $_GET["preco"];

$query = "insert into produtos (nome, preco) values ('{$nome}', {$preco})";
$conexao = mysqli_connect('localhost', 'root', '', 'loja');

if(mysqli_query($conexao, $query)) {
?>
<p class="alert-success">Produto <?= $nome; ?>, <?= $preco; ?> adicionado com sucesso!</p>
<?php
} else {
?>
<p class="alert-danger">O produto <? = $nome; ?> não foi adicionado</p>
<?php
}

?>


<h2>Fechando a conexão</h2>

Por que podemos "esquecer" o mysql_close()?

Porque o PHP detecta automaticamente que a conexão está aberta, e a fecha. Isso é ótimo, pois é muito comum que aplicações web esqueçam conexões abertas, e isso gera diversos problemas quando a aplicação é muito acessada (afinal, o banco de dados, que não sabe que o PHP acabou, mantém a conexão aberta por um tempo).


<h2>O "i" nos métodos</h2>
Por que usamos os métodos mysqli_ e não mysql?
O mysqli_* é o novo pacote de acesso ao MySql, onde eles melhoraram toda a parte de acesso ao banco de dados.
O mysql_* ainda existe apenas por questões de compatibilidade.

------------------------------------------------------------------------------------------------------------------------------------------------------------
<h1>Seção 03 - Criando funções no PHP</h1>
No capítulo passado, vimos como fazer uma inserção no MySql. O próximo passo será mostrar a lista de produtos. Mas antes disso, vamos melhorar um pouco o que já escrevemos até então. Afinal, é fundamental que o programador escreva código que seja fácil de ser lido e mantido por outros desenvolvedores.

Nosso código atual, da página que adiciona produtos, é esse:

<?php include ("cabecalho.php"); ?>

<?php
$nome = $_GET['nome'];
$preco = $_GET['preco'];
$conexao = mysqli_connect("localhost", "root", "");

if(mysqli_query($conexao, $query)) {
?>
<p class="alert-success">Produto <?= $nome; ?>, <?= $preco; ?> adicionado com sucesso!</p>
<?php
} else {
?>
<p class="alert-danger">O produto <? = $nome; ?> não foi adicionado</p>
<?php
}
?>

<?php include ("rodape.php"); ?>
Esse if que verifica se deu sucesso está difícil de ler. Vamos extrair para uma variável:

$resultadoDaInsercao = mysqli_query($conexao, $query);
if($resultadoDaInsercao) {
 // codigo continua
Já está melhor. Mais fácil de ser lido. Mas vamos tentar extrair essa função de inserir produto para um método, com um nome mais semântico.

function insereProduto($nome, $preco) {
    $query = "insert into produtos (nome, preco) values ('{$nome}', {$preco})";
    $resultadoDaInsercao = mysqli_query($conexao, $query);
}
A função está quase pronta. Para que funcione bem, ela precisa receber a conexão também (veja a variável conexao). A função precisa também retornar o resultado:

function insereProduto($conexao, $nome, $preco) {
    $query = "insert into produtos (nome, preco) values ('{$nome}', {$preco})";
    $resultadoDaInsercao = mysqli_query($conexao, $query);
    return $resultadoDaInsercao;
}
Para usá-la, fica fácil:

if(insereProduto($conexao, $nome, $preco)) {
    // continua aqui
}
Fica fácil reutilizar agora. Basta invocar a função sempre que quisermos inserir um produto. O código fica muito mais fácil de ser mantido.

Vamos agora mudar a cor da mensagem de sucesso. Hoje, a mensagem e seu fundo ficam verdes. Vamos fazer com que só o texto fique verde. Para isso, basta trocar a classe alert-success e alert-danger para text-success e text-danger. Não deixe de estudar as classes do Bootstrap, pois ele realmente nos ajuda a melhorar a interface do nosso site.

Outro ponto que a interface ainda peca é na navegabilidade. Da página principal não há como chegar na página do formulário; do formulário não há como chegar na página principal.

Vamos mexer isso no cabecalho.php, criando um div novo. Veja que usamos as várias classes do Bootstrap, que começam com nav*. Essas classes nos ajudam a criar menus:

<html>
<head>
    <title>Minha loja</title>
    <meta charset="utf-8">
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/loja.css" rel="stylesheet" />
</head>

<body>
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <a href="index.php" class="navbar-brand">Minha Loja</a>
            </div>

               <div>
                <ul class="nav navbar-nav">
                     <li><a href="produto-formulario.php">Adiciona Produto</a></li>
                    <li><a href="sobre.php">Sobre</a></li>
                </ul>
            </div>
        </div><!-- container acaba aqui -->
    </div>

    <div class="container">

    <div class="principal">
Muito melhor, nosso site já está mais navegável.

Vamos agora melhorar o formulário, que ainda não está bonito. Para isso, vamos fazer uso de tabelas:

<html>
    <form action="adiciona-produto.php">
        <table class="table">
            <tr>
                <td>Nome</td>
                <td><input type="text" name="nome" /></td>
            </tr>

            <tr>
                <td>Preço</td>
                <td><input type="number" name="preco" /></td>
            </tr>

            <tr>
                <td><input type="submit" value="Cadastrar" /></td>
            </tr>

        </table>

    </form>
</html>
Já está melhor. O estilo de tabelas do Bootstrap são amigáveis. Podemos também por a classe form-control nas caixas de texto, que é o estilo próprio do Bootstrap para esse tipo de elemento. No botão, podemos por os estilos btn btn-primary.

Por fim, vamos melhorar a mensagem de erro. Hoje, quando algo falha, apenas exibimos uma mensagem avisando o usuário, mas não explicamos bem qual foi o erro. Vamos resolver isso, exibindo o erro que o próprio MySql nos envia. Para isso, basta usar mysqli_error:

<?php
if(insereProduto($conexao, $nome, $preco)) {
?>
<p class="alert-success">Produto <?= $nome; ?>, <?= $preco; ?> adicionado com sucesso!</p>
<?php
} else {
    $msg = mysqli_error($conexao);
?>
<p class="alert-danger">O produto <? = $nome; ?> não foi adicionado: <?= $msg ?></p>
<?php
}
?>
Excelente. Nesse capítulo, aprendemos como criar funções e capturar a mensagem de erro que vem do MySql.




-----------------------------------------------------------------------------------------------------------------------
<h1>Seção 04 - Listando todos os produtos</h1>

Nosso código de adicionar produto já está bem mais elegante. Nosso próximo passo agora é listar todos os produtos. Vamos começar a página produto-lista.php. O esqueleto inicial dessa página é igual a de todas as outras, com cabeçalho e rodapé:

<?php include("cabecalho.php"); ?>

-- CORPO AQUI --

<?php include("rodape.php"); ?>
No lugar do corpo, colocaremos todos os produtos. Para isso, precisaremos pegar todos eles do banco de dados. Os passos então serão: conectar no banco de dados, executar um SELECT, e exibir o resultado. Vamos começar por abrindo a conexão:

<?php
$conexao = mysqli_connect("localhost", "root", "", "loja");
?>
Veja só que começamos a repetir código novamente. Em toda página que precisamos acessar o banco de dados, temos essa linha. Sempre que temos código repetido, a ideia é colocar em algum lugar separado. Vamos criar um arquivo então somente para isso, responsável por abrir a conexão com o banco de dados. Criamos o arquivo conecta.php então, com o seguinte conteúdo:

<?php
$conexao = mysqli_connect("localhost", "root", "", "loja");
Veja que ele não tem cabeçalho ou rodapé. Repare também que nesse arquivo, não fechamos a tag php. Essa é uma boa prática da linguagem: se temos um arquivo que só tem código PHP, não a fechamos, pois assim o PHP sabe que esse arquivo não enviará nada (HTML, etc) para o usuário final.

De volta ao nosso arquivo de listagem, vamos incluir o conecta.php:

<?php include("cabecalho.php"); ?>
<?php include("conecta.php"); ?>

-- CORPO AQUI --

<?php include("rodape.php"); ?>
Podemos fazer uso desse novo arquivo em todos os lugares que conectam no banco de dados.

O próximo passo agora é trazer todos os produtos do banco de dados, com um SELECT. Vamos lá, no corpo:

<?php
$resultado = mysqli_query($conexao, "select * from produtos");
?>
Precisamos agora falar pro MySql pegar as informações que estão armazenadas nessa variável resultado. Para isso, usamos outra função do MySql, o mysqli_fetch_assoc. Essa instrução criará um array, com os dados de um produto:

<?php
$resultado = mysqli_query($conexao, "select * from produtos");
$produto = mysqli_fetch_assoc($resultado);

echo $produto['nome'];
?>
Se rodarmos isso no browser, veremos o nome do primeiro produto impresso na tela. Você pode colocar esse novo link no cabeçalho também, para que a aplicação fique navegável.

Mas, na prática, não temos somente um produto; temos vários. Para isso, precisaremos fazer um loop no resultado e pegar todos os produtos que lá estão. Fazemos esse loop no próprio mysqli_fetch_assoc:

<?php
$resultado = mysqli_query($conexao, "select * from produtos");

while($produto = mysqli_fetch_assoc($resultado)) {
    echo $produto['nome'] . "<br/>";
}
?>


Repare que agora a variável produto, a cada iteração do loop, apontará para um produto diferente. Se rodarmos, agora ele nos mostra (ainda que de maneira bem feia) todos os produtos que estão no banco de dados.

<h2>Não fechar o php</h2>
Pare para pensar no que acontece quando não fechamos o ?>? Fizemos isso no conecta.php, por exemplo.
Opinião do Instrutor

Quando não fechamos o comando do PHP, isso indica para um desenvolvedor que essa página não gera mais nenhuma saída para o usuário final.
Se fechássemos, por exemplo, poderíamos por descuido deixar um "espaço" ali, espaço esse que seria enviado ao usuário.


<h2>Isolando a conexão</h2>

O que você achou da ideia de isolarmos a criação da conexão em um único arquivo?
Selecione uma alternativa

A vantagem é que quando precisarmos mudar a string de conexão (e precisaremos no futuro), mudaremos apenas em um único lugar.




--------------------------------------------------------------------------------------------------------------
<h1>Seção 05 - Melhorando a listagem de produtos</h1>

Agora que já conseguimos executar a SQL no banco de dados, vamos melhorar nosso código. Vamos guardar a inteligência de trazer a lista de produtos em uma função específica, que nos devolverá a lista de produtos. Para isso, usaremos arrays. Arrays são um tipo especial no PHP, que nos possibilita guardar "muitos elementos".

Veja o código abaixo. Repare que precisamos ainda receber a conexão como parâmetro da função, já que a variável foi declarada do lado de fora:

<?php
function listaProdutos($conexao) {
    $produtos = array();
    $resultado = mysqli_query($conexao, "select * from produtos");

    while($produto = mysqli_fetch_assoc($resultado)) {
        array_push($produtos, $produto);
    }

    return $produtos;

}
?>
Veja que então criamos um array, e a cada iteração do loop, guardamos o novo produto nesse array. No fim, devolvemos todo o array. Isolar em funções é sempre uma boa ideia, já que aumenta o reuso e facilita a manutenção do código.

Mais abaixo, vamos agora usar essa função que acabamos de criar:

$produtos = listaProdutos($conexao);
Com esse array em mãos, podemos navegar na lista de todos os produtos, usando o foreach. Repare na sintaxe, passamos a lista e a variável que conterá cada um dos produtos:

$produtos = listaProdutos($conexao);
foreach($produtos as $produto) {
    echo $produto['nome'] . "<br/>";
}
Tudo continua funcionando.

Nosso código já está bem melhor, mas o problema que temos agora é que as consultas SQL estão separadas em diversos arquivos (temos no arquivo de listagem, e no arquivo de adição). Vamos centralizar todas elas em um único arquivo. Isso facilita a manutenção, pois o desenvolvedor saberá que todas as queries de produto estarão no mesmo arquivo. Vamos criar o banco-produto.php:

<?php
function listaProdutos($conexao) {
    $produtos = array();
    $resultado = mysqli_query($conexao, "select * from produtos");

    while($produto = mysqli_fetch_assoc($resultado)) {
        array_push($produtos, $produto);
    }

    return $produtos;

}

function insereProduto($conexao, $nome, $preco) {
    $query = "insert into produtos (nome, preco) values ('{$nome}', '{$preco}')";
    $resultadoDaInsercao = mysqli_query($conexao, $query);
    return $resultadoDaInsercao;
}
Vamos agora incluir esse arquivo nas outras páginas, e reutilizar essas funções. Toda nova consulta de produtos deve ser criada nesse arquivo. É assim que fazemos em qualquer linguagem de programação, seja PHP, Java ou C#. É sempre importante separar as responsabilidades em diferentes arquivos.

Pronto! Com o código PHP bonito, vamos trabalhar no nosso código HTML, para que a listagem de produtos fique bonita. Vamos usar uma tabela:

<?php
$produtos = listaProdutos($conexao);
?>
<table class="table table-striped table-bordered">

<?php
foreach($produtos as $produto) {
?>

    <tr>
        <td><?= $produto['nome'] ?></td>
        <td><?= $produto['preco'] ?></td>
    </tr>

<?php
}
?>
</table>


Observe o código direito. Veja que abrimos e fechamos PHP na hora de fazer uso de código HTML.

Alguns programadores não gostam desse abre e fecha chaves, que acontece em código PHP. Existe uma outra maneira de fazer a mesma coisa. Veja o código abaixo com o endforeach. Você pode aplicar a mesma ideia para qualquer outra tag, como if, e etc.

<?php
$produtos = listaProdutos($conexao);
?>
<table class="table table-striped table-bordered">

<?php
foreach($produtos as $produto) :
?>

    <tr>
        <td><?= $produto['nome'] ?></td>
        <td><?= $produto['preco'] ?></td>
    </tr>

<?php
endforeach
?>
</table>


<h2>Fechando o foreach</h2>
Muitos programadores preferem o endforeach porque, diferente da chave, com ele você consegue saber o que está sendo fechado (no caso o for each). Com as chaves, você precisa descobrir onde está o abre-chaves.
De qualquer maneira, um aglomerado de abre/fecha chaves fica difícil de compreender, e tentamos evitar isso extraindo o código para outros arquivos que incluímos.


---------------------------------------------------------------------------------------------------------------------------------
<h1>Seção 06 - Deletando produtos</h1>
Nosso próximo passo é fazer a deleção de um produto. Para isso, vamos colocar um link na listagem de produtos que, ao ser clicado, deletará o produto.

<table class="table table-striped table-bordered">

<?php
foreach($produtos as $produto) :
?>

    <tr>
        <td><?= $produto['nome'] ?></td>
        <td><?= $produto['preco'] ?></td>
        <td>
            <a href="remove-produto.php" class="text-danger">remover</a>
        </td>
    </tr>

<?php
endforeach
?>
</table>
O link está aparecendo certo na listagem. Mas ainda precisamos passar uma informação para esse link: qual produto eu quero remover? A melhor maneira de fazer isso é passando o ID do produto; afinal o ID identifica exclusivamente aquele produto em relação aos outros. Vamos passar o parâmetro pela própria URL, igual fizemos no primeiro capítulo:

<a href="remove-produto.php?id=<?=$produto['id']?>" class="text-danger">remover</a>


Agora, veja no browser, que os links são diferentes para cada produto. Com o link pronto, precisamos implementar o remove-produto.php. O corpo dele é igual o corpo das outras páginas, onde precisamos incluir as várias sub-páginas que criamos:

<?php 
include("cabecalho.php");
include("conecta.php");
include("banco-produto.php");

include("rodape.php");
?>
Vamos criar a query que deleta um produto. Já sabemos onde colocar, no banco-produto.php. Ele receberá a conexão e o id a ser deletado:

function removeProduto($conexao, $id) {
    $query = "delete from produtos where id = {$id}";
    return mysqli_query($conexao, $query);
}
De volta ao remove-produto.php, vamos agora invocar esse método criado. Basta pegar o id que veio como parâmetro, e passar para o método:

<?php 
include("cabecalho.php");
include("conecta.php");
include("banco-produto.php");

$id = $_GET['id'];
removeProduto($conexao, $id);
?>

<p class="text-success">Produto <?=$id?> removido!</p>

<?php
include("rodape.php");
?>
Legal. A remoção funciona. Mas a parte chata é que toda vez que deletamos, vamos pra página de sucesso, e precisamos voltar para a listagem. E o pior, quando o usuário usa o botão "back" do navegador, ele não atualiza a página; ele mostra a página antiga, que ele armazenou.

Vamos fazer então que, quando clicar em remover, o usuário seja automaticamente redirecionado para a listagem. Para fazer isso, precisamos entender um pouco mais sobre o HTTP. Geralmente toda resposta contém um corpo em HTML, que é o que o browser mostra pro usuário final. Mas, podemos responder outras coisas, e elas não precisam obrigatoriamente ter HTML. Podemos falar pro browser que o que ele deve fazer na verdade é acessar um outro endereço. E é assim que fazemos esse redirecionamento. Ao invés de devolver HTML, devolveremos essa instrução pro navegador. Ele, ao receber, faz uma nova requisição, sem que o usuário perceba.

Por padrão, quando uma requisição é bem sucedida, o servidor devolve um código (um status) avisando o navegador que está tudo certo. Quando tudo dá certo, o código é 200. Quando você tenta acessar um endereço que não existe, o código é 404 (Page Not Found). Erro no servidor? 500. Redirecionamento? 302. Existem vários outros códigos de status, mas esses são os mais importantes nesse momento.

Em código, vamos fazer o PHP devolver 302 para o browser:

<?php 
include("conecta.php");
include("banco-produto.php");

$id = $_GET['id'];
removeProduto($conexao, $id);

header("Location: produto-lista.php");
?>
Veja que colocamos um header, cuja chave é Location e o valor é a página que queremos que o browser redirecione automaticamente. Podemos ver que ele voltou 302, olhando a aba Network do Chrome Developer Tools. Lá, vemos que a requisição para o remove-produto.php devolve 302. Na mesma hora, o browser faz uma outra requisição, para a listagem.



Para garantir que a linha última executada é o header, podemos pedir para o PHP parar de processar ali mesmo, usando o método die():

<?php 
include("conecta.php");
include("banco-produto.php");

$id = $_GET['id'];
removeProduto($conexao, $id);

header("Location: produto-lista.php");
die();
Mas só redirecionar para a listagem não é suficiente. Precisamos exibir uma mensagem amigável na própria listagem. Vamos colocar a mensagem na listagem, lá em produto-lista.php:

<p class="alert-success">Produto apagado com sucesso.</p>
Mas essa mensagem não pode aparecer sempre; mas sim quando veio de uma deleção. Precisamos avisar a listagem então, que o comando anterior foi o de deleção. Vamos passar um parâmetro para a página, informando isso então, no próprio header:

header("Location: produto-lista.php?removido=true");
Agora, basta fazer o if na listagem:

<?php if(array_key_exists("removido", $_GET) && $_GET['removido']=='true') { ?>
<p class="alert-success">Produto apagado com sucesso.</p>
<?php } ?>
Agora sim, a mensagem aparece na hora certa! Nossa aplicação está evoluindo.

Agora faça o teste, passe o "true" sem aspas (passando o booleano true). Tudo continua funcionando. Por que? Porque o == do PHP consegue fazer a conversão dos tipos de maneira automática e descobre que eles são iguais. Se não quisermos que o PHP faça conversão de tipos (pois isso pode ser problemático em alguns casos), podemos fazer uso dos ===.


<h2>Os iguais</h2>
Quando usamos ==, estamos dizendo ao PHP que, se os tipos que estão sendo comparados são diferentes, ele pode tentar fazer a conversão. A conversão que ele realiza é um casting para o tipo bool.
Desta forma, tudo que for retornado será transformado para o tipo bool. Como estamos usando string, a string vazia ou com zero (0) será considerado false e a string com qualquer outra coisa será considerada true.

Quando usamos ===, dizemos ao PHP para nunca converter tipos.


-------------------------------------------------------------------------------------------------------------------------------------------
<h1>Seção 07 - Entendendo a diferença entre GET e POST</h1>


Vamos agora adicionar um campo de descrição no nosso cadastro de produtos. Um textarea é representado pela tag textarea. Vamos acrescentar esse campo então no formulário:

<form action="adiciona-produto.php">
    <table>
        <tr>
            <td>Nome</td>
            <td><input type="text" name="nome" class="form-control" /></td>
        </tr>

        <tr>
            <td>Preço</td>
            <td><input type="number" name="preco" class="form-control" /></td>
        </tr>

        <tr>
            <td>Descrição</td>
            <td><textarea name="descricao" class="form-control"></textarea></td>
        </tr>

        <tr>
            <td><input type="submit" value="Cadastrar" /></td>
        </tr>

    </table>

</form>
Lá na página de adição, precisamos passar esse parâmetro a mais:

$descricao = $_GET['descricao'];

if(insereProduto($conexao, $nome, $preco, $descricao)) {
    // continua...
}
E completar a linha de INSERT lá no nosso banco-produto.php:

function insereProduto($conexao, $nome, $preco, $descricao) {
    $query = "insert into produtos (nome, preco, descricao) values ('{$nome}', {$preco}, '{$descricao}')";
    $resultadoDaInsercao = mysqli_query($conexao, $query);
}
Agora, precisamos criar essa coluna no banco de dados. Vamos lá no PHPMyAdmin, e vamos criar o campo:

alter table produtos add column descricao text;
Se fizermos um SELECT na tabela agora, vemos que a coluna está com valores NULL. Vamos fazer um simples UPDATE para remover eles da nossa tabela:

update produtos set descricao = 'Descricao deste produto';
Falta agora a listagem. Vamos exibir o atributo descrição lá no produto-lista.php:

<tr>
    <td><?= $produto['nome'] ?></td>
    <td><?= $produto['preco'] ?></td>
    <td><?= $produto['descricao'] ?></td>
    <td>
        <a href="remove-produto.php?id=<?= $produto['id']?>" class="text-danger">remover</a>
    </td>
</tr>
Excelente. O novo campo agora existe, e podemos cadastrar produtos com essa descrição. Agora, um problema de interface: veja só o que acontece se cadastramos um produto com uma descrição muito grande. A tabela fica feia, pois a parte da descrição fica muito grande.



Vamos fazer então com que, na listagem, apareça apenas os 15 primeiros caracteres. Para isso, usaremos a função substr, que recebe dois parâmetros: a posição do caractere inicial, e a posição do caractere final:

<td><?= substr($produto['descricao'], 0, 15) ?></td>
Veja, agora ficou melhor:



Podemos mudar agora a quantidade de caracteres, pro tamanho que quisermos. Poderíamos colocar 40, por exemplo. Repare que a função é bastante inteligente: se o texto for menor que 40, a função simplesmente vai até o último caractere existente.

O PHP tem muitas outras funções, que nos ajudam em diversas tarefas, como manipulação de strings, e etc. Podemos vê-las no manual do php em http://www.php.net. O site é bem legal, e tem tanto em português quanto em inglês. Visite o site constantemente, afinal é impossível decorar todas as funções da linguagem.

Temos mais uma mudança importante a fazer. Veja que, sempre que adicionamos um produto, os parâmetros são enviados pela URL: adiciona-produto.php?nome=blabla&preco=blabla&descricao=blabla. O problema disso é que a URL tem um tamanho máximo de dados que podem ser passados por ela. E veja que isso pode ser um problema, já que nosso campo de descrição pode ter tamanho ilimitado!

Podemos resolver isso facilmente. Existem duas maneiras de fazer uma requisição. A que estamos fazendo até agora, chama-se GET. Sempre que você digita uma URL no browser, por exemplo, fazemos um GET. O nome desse tipo de requisição já diz o que ela faz: ela "pega" conteúdo. Existe uma outra maneira, mais adequada para quando temos dados a serem enviados, que chamamos de POST. O POST, cujo nome já deixa claro a ideia de "postar" dados, permite o envio de grandes quantidades de dados, sem preocupação.

E para mudar isso é fácil. Basta irmos na declaração do form, e acrescentar o "método":

<form action="adiciona-produto.php" method="post">
Mas agora que não estamos enviando por GET, mas sim por POST, precisamos mudar a maneira de receber esses dados no PHP. Basta mudar o array $_GET para $_POST:

$nome = $_POST['nome'];
$preco = $_POST['preco'];
$descricao = $_POST['descricao'];
Se você testar agora, você perceberá que os dados não são mais passados pela URL; eles vão por debaixo dos panos. É assim que o POST funciona. Se você ver a aba Network do Developer Tools, você verá que os dados são enviados por ali; repare nos "headers". É através do POST que enviamos arquivos binários, por exemplo, quando fazemos upload de arquivos.

Usar GET para adicionar ou remover coisas na nossa aplicação não é uma boa ideia. Plugins que aceleram a navegação, ou mesmo hardwares intermediários que rodam pela internet, tem o costume de cachear resultados de links; afinal, a ideia do GET é "pegar dados", um GET não deveria "mudar dados". Ou seja, sempre que você for alterar/adicionar algo, o ideal é que você use POST, e não GET.

Outro exemplo é o próprio Google. É assim que ele alimenta a sua própria base de dados: ele segue os links que acha na sua página. Ou seja, seu GET não pode ter efeitos colaterais, ou seja, não pode mexer no banco de dados.

Já corrigimos o formulário, falta agora corrigir o link de Remove, afinal é um link, que faz um GET, e deleta um produto. Vamos transformar isso em um POST:

<tr>
    <td><?= $produto['nome'] ?></td>
    <td><?= $produto['preco'] ?></td>
    <td><?= $produto['descricao'] ?></td>
    <td>
        <form action="remove-produto.php?id=<?=$produto['id']?>" method="post">
            <button class="btn btn-danger">remover</button>
        </form>
    </td>
</tr>
Agora lá no remove-produto.php, precisamos trocar a linha que pega o id do produto, e passar a pegar do POST:

$id = $_POST['id'];
Ainda não funcionou, pois ainda estamos passando o "id" pela URL. Vamos mudar isso, e passar por debaixo dos panos, usando o campo "hidden". Esse campo é um campo escondido, ou seja, não aparece para o usuário, mas é postado para o usuário final:

<tr>
    <td><?= $produto['nome'] ?></td>
    <td><?= $produto['preco'] ?></td>
    <td><?= $produto['descricao'] ?></td>
    <td>
        <form action="remove-produto.php" method="post">
            <input type="hidden" name="id" value="<?=$produto['id']?>" />
            <button class="btn btn-danger">remover</button>
        </form>
    </td>
</tr>
Veja que agora cada botão de remover tem o seu próprio formulário, com um campo "hidden" com o ID.

O POST é a alternativa certa para você enviar/adicionar/remover dados para o servidor. Lembre-se que o GET deve ser apenas para exibir dados. Aqui ainda não discutimos nada de segurança. O POST, apesar dos dados serem enviados por debaixo dos panos, não é "seguro"; ou seja, alguém consegue falsificar um post. Se precisar de segurança, você precisa usar HTTPS. Mas isso, discutiremos mais pra frente.

<h2>GET e POST</h2>

A ideia do GET, como o nome já diz, é pegar um conteúdo. Ele não deve realizar nenhuma mudança de estado, ou seja, não deve adicionar/deletar nada no banco de dados, ou coisa do tipo.
A ideia do POST, é postar uma informação. Ele sim deve fazer alguma mudança de estado, persistindo informações no banco de dados.

Nunca faça uma adição ou deleção com GETs. Isso pode gerar problemas, já que robôs da internet costumam visitar links de forma automática. E, visitar um link de deleção, pode gerar problemas.


-------------------------------------------------------------------------------------------------------------------------------------
<h1>Seção 08 - Relacionando Produtos com Categorais</h1>

O nosso sistema precisa evoluir. Nesse momento, já temos um sistema que faz todo o controle de produtos. Mas agora precisamos fazer com que cada produto tenha uma categoria associada.

Nosso primeiro passo será criar mais uma tabela no banco de dados, afinal precisamos salvá-las em algum lugar. No PhpMyAdmin:

create table categorias (id integer auto_increment primary key, nome varchar(255));
Vamos também já popular a tabela e inserir algumas categorias:

insert into categorias (nome) values ("esporte"), ("escolar"), ("mobilidade");
Agora, precisamos exibir as categorias disponíveis no formulário de adição de produtos. Faremos isso com aquelas "bolinhas", que permitem com que o usuário selecione uma dentre as várias opções. Essas bolinhas são chamadas de radio button. Vamos adicionar essa linha no formulário:

<tr>

    <td>Categoria</td>
    <td>
        <input type="radio" name="categoria">Esporte</br>
        <input type="radio" name="categoria">Escolar</br>
        <input type="radio" name="categoria">Mobilidade</br>
    </td>
</tr>
A lista de categorias já aparece direito no formulário de produtos. Mas precisamos ainda configurar o valor de cada radio, afinal é o valor que é postado para o PHP. É bem comum fazermos uso dos IDs. Cada categoria tem seu ID, então vamos colocar isso no formulário, renomeando inclusive o nome dos radios para deixar isso claro:

<tr>

    <td>Categoria</td>
    <td>
        <input type="radio" name="categoria_id" value="1">Esporte</br>
        <input type="radio" name="categoria_id" value="2">Escolar</br>
        <input type="radio" name="categoria_id" value="3">Mobilidade</br>
    </td>
</tr>
Apesar de estar funcionando, o problema é que as categorias estão fixas em nosso HTML. Se alguém inserir uma nova categoria no banco de dados, ela não será refletida automaticamente na listagem. Precisamos fazer com que isso seja dinâmico, ou seja, buscar as categorias do banco de dados.



Já sabemos que precisamos criar um novo arquivo para lidar com o acesso aos dados da Categoria. Então, no arquivo banco-categoria.php, fazemos:

<?php

function listaCategorias($conexao) {
    $categorias = array();
    $query = "select * from categorias";
    $resultado = mysqli_query($conexao, $query);
    while($categoria = mysqli_fetch_assoc($resultado)) {
        array_push($categorias, $categoria);
    }
    return $categorias;
}
Com esse arquivo pronto, podemos usá-lo agora no produto-formulario.php:

<?php
include("cabecalho.php");
include("conecta.php");
include("banco-categoria.php");

$categorias = listaCategorias($conexao);
?>

... codigo continua aqui ...

<tr>

    <td>Categoria</td>
    <td>
        <?php foreach($categorias as $categoria) : ?>
        <input type="radio" name="categoria_id" value="<?=$categoria['id']?>"><?=$categoria['nome']?></br>
        <?php endforeach ?>
    </td>
</tr>
Se agora voltarmos para o formulário, percebemos que eles vem do banco de dados. Para testar, adicione uma quarta categoria "guloseimas". Veja que ela aparecerá no formulário.

Agora precisamos salvar a categoria que é postada! Vamos começar criando a coluna na tabela produtos. Criaremos lá um campo inteiro que guardará o ID da categoria. É assim que fazemos: sempre guardamos os IDs das outras tabelas. Lembre-se de fazer o curso de SQL se esse conceito for novo pra você.

alter table produtos add column categoria_id integer
Agora todos os produtos tem categoria NULL. Vamos dar um UPDATE para setar um valor padrão:

update produtos set categoria_id = 3;
Podemos atualizar as categorias de maneira mais adequada. Mas aqui, para não perdermos tempo, vamos passar reto. Vamos agora no nosso código, fazer com que ele capture o ID da categoria:

$nome = $_POST['nome'];
$preco = $_POST['preco'];
$descricao = $_POST['descricao'];
$categoria_id = $_POST['categoria_id'];

if(insere_produto($conexao,$nome,$preco,$descricao,$categoria_id)) {
    // ...
}
No banco-produto.php, também recebemos a categoria e modificamos a query:

function insereProduto($conexao, $nome, $preco, $descricao, $categoria_id) {
    $query = "insert into produtos (nome, preco, descricao, categoria_id) values ('{$nome}', {$preco}, '{$descricao}', {$categoria_id})";
    $resultadoDaInsercao = mysqli_query($conexao, $query);
    return $resultadoDaInsercao;
}
Se cadastrarmos um produto agora, conseguimos selecionar uma categoria, e a mesma é salva direito no banco de dados. Podemos ver isso pelo PhpMyAdmin.

Próximo passo agora é exibir a categoria na listagem. Vamos adicionar uma coluna a mais na listagem:

<tr>
    <td><?= $produto['nome'] ?></td>
    <td><?= $produto['preco'] ?></td>
    <td><?= substr($produto['descricao'],0,40) ?></td>
    <td><?= $produto['categoria_id'] ?></td>
    <td>
        <a href="remove-produto.php?id=<?= $produto['id']?>" class="text-danger">remover</a>
    </td>

</tr>
Isso funciona, mas exibe um número! Não é útil para o usuário! Vamos exibir o nome. Para isso, precisamos mudar o SELECT que traz o produto, e fazer com que ele também traga o nome da categoria. Aqui faremos uma SQL mais avançada:

<?php
function listaProdutos($conexao) {
    $produtos = array();
    $resultado = mysqli_query($conexao, "select p.*, c.nome as categoria_nome from produtos as p join categorias as c on p.categoria_id = c.id");

    while($produto = mysqli_fetch_assoc($resultado)) {
        array_push($produtos, $produto);
    }

    return $produtos;

}
?>
Agora na listagem, exibimos o campo categoria_nome, que definimos na consulta SQL:

<tr>
    <td><?= $produto['nome'] ?></td>
    <td><?= $produto['preco'] ?></td>
    <td><?= $produto['descricao'] ?></td>
    <td><?= $produto['categoria_nome'] ?></td>
    <td>
        <a href="remove-produto.php?id=<?= $produto['id']?>" class="text-danger">remover</a>
    </td>

</tr>
Agora sim, a categoria aparece corretamente na nossa listagem!

---------------------------------------------------------------------------------------------------------------------------------------
<h1>Seção 09 - Lidando com Selects e Checkboxes</h1>

Nosso sistema está cada vez mais completo. Já aprendemos a criar telas de adição, remoção e listagem de produtos. Isso quer dizer que poderíamos replicar a mesma coisa para outras entidades do sistema, como por exemplo, cadastro de usuários, ou mesmo cadastro de categorias.

Vamos agora lidar com outros elementos HTML. Nesse momento, a escolha de uma categoria é dada por meio de radio buttons. Mas temos outras opções. Podemos usar, por exemplo, uma caixa de seleção, um select. Vamos alterar nosso código para tal. Veja que aqui usamos as tags select e a tag option:

<tr>

    <td>Categoria</td>
    <td>
        <select name="categoria_id">
        <?php foreach($categorias as $categoria) : ?>
        <option value="<?=$categoria['id']?>"><?=$categoria['nome']?></option>
        <?php endforeach ?>
        </select>
    </td>
</tr>
Veja como ficou:



Da mesma forma, o que é mostrado pro usuário é diferente do que é postado. O select post o valor que está na tag value, do option.

O próximo passo agora é dar a possibilidade do usuário dizer se aquele produto é usado ou não. Para isso, colocaremos um checkbox, aquele componente visual, que você seleciona ou desseleciona. Logo acima da tr da categoria, colocamos mais uma:

<tr>
    <td></td>
    <td><input type="checkbox" name="usado" value="true"> Usado</td>
</tr>
Veja como ficou:



Precisamos criar a coluna no nosso banco de dados. Ela se chamará usado e terá valor padrão falso (ou seja, o produto é novo por padrão):

alter table produtos add column usado boolean default false;
Precisamos agora capturar o valor do checkbox que foi postado em nosso adiciona-produto.php, igual fizemos com todos os outros campos:

$usado = $_POST['usado'];

if(insere_produto($conexao,$nome,$preco,$descricao,$categoria_id, $usado)) {
    // ...
}
Agora, no banco-produto.php, vamos mudar a função insere_produto para que ela passe esse valor na SQL:

function insereProduto($nome, $preco, $descricao, $categoria_id, $usado) {
    $query = "insert into produtos (nome, preco, descricao, categoria_id, usado) 
        values ('{$nome}', {$preco}, '{$descricao}', {$categoria_id}, {$usado})";
    $resultadoDaInsercao = mysqli_query($conexao, $query);
}
Se tentarmos adicionar um produto usado, tudo funciona. Mas e se adicionarmos um produto novo, o que acontece? Tomaremos um erro! A nossa query não vai funcionar. E nesse caso, ainda teremos mais de um erro, já que o PHP não para de executar seu programa caso um erro aconteça; ele vai até o fim.

Veja na aba Network, que quando o checkbox não é checado, o formulário não posta a informação! Esse é o funcionamento: checkbox não selecionado, não é enviado. Então precisaremos tratar isso no código. Lá no adiciona-produto.php:

if(array_key_exists('usado', $_POST)) {
    $usado = true;
} else {
    $usado = false;
}
Se testarmos de novo, tomaremos outro erro. Agora não tem jeito, precisamos descobrir o que está acontecendo. Uma maneira para isso, é exibir a query que está sendo executada. Vamos colocar um echo no insereProduto:

function insereProduto($nome, $preco, $descricao, $categoria_id, $usado) {
    $query = "insert into produtos (nome, preco, descricao, categoria_id, usado) 
        values ('{$nome}', {$preco}, '{$descricao}', {$categoria_id}, {$usado})";
    echo $query;
    $resultadoDaInsercao = mysqli_query($conexao, $query);
}
Veja que o usado ainda está indo vazio.

O que acontece é que quando a variável usado é false, na hora da concatenação, o PHP não escreve a palavra "false", mas sim põe um espaço vazio. Precisamos tomar bastante cuidado com isso. Para resolver, vamos colocar a string false dentro da variável (repare nas aspas):

if(array_key_exists('usado', $_POST)) {
    $usado = "true";
} else {
    $usado = "false";
}
Agora sim, tudo funciona. Não esqueça de tirar a mensagem de log que ficou dentro do insereProduto.


-----------------------------------------------------------------------------------------------------------------------------------------------
<h1>Seção 10 - Alterando Produtos</h1>


Vamos agora fazer o formulário de alteração de um produto. Para fazer essa funcionalidade, precisamos usar tudo que aprendemos até aqui, exibir formulário, criar um link, executar a consulta de atualização, mostrar a mensagem de sucesso, e etc.

Vamos começar adicionando mais um botão na listagem, que dará a opção para o usuário "alterar" o produto:

<tr>
    <td><?= $produto['nome'] ?></td>
    <td><?= $produto['preco'] ?></td>
    <td><?= substr($produto['descricao'],0,40) ?></td>
    <td><a href="produto-altera-formulario.php">alterar</a>
    <td>
        <form action="remove-produto?id=<?=$produto['id']?>" method="post">
            <button class="btn btn-danger">remover</button>
        </form>
    </td>
</tr>
O link já apareceu, mas ainda está bem feio. Vamos melhorar o layout desse link:

    <td><a class="btn btn-primary" href="produto-altera-formulario.php">alterar</a>
Agora, precisamos passar o ID para esse link, igual fizemos na exclusão. Vamos passar isso pela URL, já que estamos fazendo uma requisição do tipo GET:

    <td><a class="btn btn-primary" href="produto-altera-formulario.php?id=<?=$produto['id']?>">alterar</a>
Ótimo. Com o link funcionando, vamos criar o formulário produto-altera-formulario.php. Ele é bem parecido com o formulário de adição, então vamos copiar e colar a estrutura principal:

<?php include("cabecalho.php"); 
include("conecta.php");
include("banco-categoria.php");

$categorias = listaCategorias($conexao);
?>            
    <h1>Formulário de produto</h1>
    <form action="adiciona-produto.php" method="post">
        <table class="table">
            <tr>
                <td>Nome</td>
                <td> <input class="form-control" type="text" name="nome"></td>
            </tr>
            <tr>
                <td>Preço</td>
                <td><input  class="form-control" type="number" name="preco"></td>
            </tr>
            <tr>
                <td>Descrição</td>
                <td><textarea class="form-control" name="descricao"></textarea></td>
            </tr>
            <tr>
                <td></td>
                <td><input type="checkbox" name="usado" value="true"> Usado</td>
            </tr>
            <tr>
                <td>Categoria</td>
                <td>
                    <select name="categoria_id" class="form-control">
                    <?php foreach($categorias as $categoria) : ?>
                        <option value="<?=$categoria['id']?>">
                                <?=$categoria['nome']?>
                        </option>
                    <?php endforeach ?>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <button class="btn btn-primary" type="submit">Cadastrar</button>
                </td>
            </tr>
        </table>
    </form>
<?php include("rodape.php"); ?>
Apesar de parecidos, eles tem pequenas diferenças, que é o que vamos atacar agora. Vamos mudar o título:

<h1>Alterando produto</h1>
Vamos mudar a ação do formulário:

<form action="altera-produto.php" method="post">
Vamos mudar o nome do botão:

<button class="btn btn-primary" type="submit">Alterar</button>
Se entrarmos no browser, a página funciona. Mas tem algo estranho: em um formulário de alteração, geralmente o formulário vem com as informações atuais daquele produto, para que o usuário final apenas altere os valores que desejar.

Para isso funcionar, a primeira coisa que precisamos fazer é buscar o produto no banco de dados, para começar a exibir nos campos do formulário. Então, já que temos o ID do produto que foi passado pela URL, no começo da página, fazemos:

$id = $_GET['id'];
$produto = buscaProduto($conexao, $id);

// aqui continua normal
$categorias = listaCategorias($conexao);
Com essa variável produto, que veio do banco de dados, podemos exibir os dados no começo do formulário.

<tr>
    <td>Nome</td>
    <td> <input class="form-control" type="text" name="nome" value="<?=$produto['nome']?>"></td>
</tr>
<tr>
    <td>Preço</td>
    <td><input  class="form-control" type="number" name="preco" value="<?=$produto['preco']?>"></td>
</tr>
<tr>
    <td>Descrição</td>
    <td><textarea class="form-control" name="descricao"><?=$produto['descricao']?></textarea></td>
</tr>
Antes de continuarmos, vamos escrever a função buscaProduto no nosso banco-produto.php. Basta fazermos a query e retornar o fetch do primeiro elemento (afinal, só tem um):

function buscaProduto($conexao, $id) {
    $query = "select * from produtos where id = {$id}";
    $resultado = mysqli_query($conexao, $query);
    return mysqli_fetch_assoc($resultado);
}
Não esqueça também de incluir esse arquivo no formulário de alteração:

include("banco-produto.php");
Se abrirmos agora a página no browser, alguns valores já aparecem. Precisamos agora preencher o resto. No checkbox, caso o produto seja usado, precisamos escrever checked=checked. Vamos então criar uma variável que, caso o produto seja usado, ele preencha com o valor que precisamos:

<?php
$usado = $produto['usado'] ? "checked='checked'" : "";
?>
<tr>
    <td></td>
    <td><input type="checkbox" name="usado" <?=$usado?> value="true"> Usado
</tr>
Ótimo. Isso está funcionando! Repare no ?, essa é uma maneira de fazer um "if" numa única linha. Se a condição for verdadeira, ele retorna o primeiro valor; se for falsa, retorna o segundo valor.

Vamos agora trabalhar na categoria. Precisamos selecionar a categoria certa. A solução é análoga: no option certo, precisamos escrever selected="selected". Para isso, vamos verificar se o id da categoria do produto é igual a categoria que está dentro do loop:

<tr>
    <td>Categoria</td>
    <td>
        <select name="categoria_id" class="form-control">
        <?php 

            foreach($categorias as $categoria) : 
                $essaEhACategoria = $produto['categoria_id'] == $categoria['id'];
                $selecao = $essaEhACategoria ? "selected='selected'" : "";

        ?>
            <option value="<?=$categoria['id']?>" <?=$selecao?>>
                    <?=$categoria['nome']?>
            </option>
        <?php endforeach ?>
        </select>
    </td>
</tr>
Pronto. Nosso formulário agora já traz todos os dados atuais do produto para o usuário apenas alterar. Precisamos agora fazer a lógica de alteração, ou seja, o arquivo altera-produto.php. Ele é parecido com a regra de adicionar. Ele pega os valores do formulário e invoca a função de alterar (que ainda precisamos escrever). Vamos, por enquanto, só alterar o nome da função para alteraProduto:

<?php include("cabecalho.php");         
 include("conecta.php");            
 include("banco-produto.php"); 

$nome = $_POST['nome'];
$preco = $_POST['preco'];
$descricao = $_POST['descricao'];
$categoria_id = $_POST['categoria_id'];
if(array_key_exists('usado', $_POST)) {
    $usado = "true";
} else {
    $usado = "false";
}

if(alteraProduto($conexao, $nome, $preco, $descricao, $categoria_id, $usado)) { ?>
    <p class="text-success">O produto <?= $nome ?>, <?= $preco ?> foi alterado.</p>
<?php } else {
    $msg = mysqli_error($conexao);
?>
    <p class="text-danger">O produto <?= $nome ?> não foi alterado: <?= $msg?></p>
<?php
}
?>

<?php include("rodape.php"); ?>
Lá no banco-produto.php, vamos fazer algo parecido com o de inserir. Mas dessa vez, usaremos um UPDATE. Repare também que na atualização, precisamos passar o id, para alterar somente o de um produto:

function alteraProduto($conexao, $id, $nome, $preco, $descricao, $categoria_id, $usado) {
    $query = "update produtos set nome = '{$nome}', preco = {$preco}, descricao = '{$descricao}', 
        categoria_id= {$categoria_id}, usado = {$usado} where id = '{$id}'";
    return mysqli_query($conexao, $query);
}
Mas veja que se recebemos o id do produto aqui, esse id precisa ser fornecido pelo altera-produto.php:

$id = $_POST['id'];

// ...

if(alteraProduto($conexao, $id, $nome, $preco, $descricao, $categoria_id, $usado)) {
E já que pegamos ele com o $_POST, precisamos também enviá-lo pelo formulário. Vamos colocar um campo hidden, igual usamos nos capítulos anteriores, afinal o usuário não precisa ver essa informação:

<input type="hidden" name="id" value="<?=$produto['id']?>" />
Agora sim, a alteração funciona.



Veja que não há muita diferença para a inserção, a não ser o ID, que precisamos para alterar o produto específico.

---------------------------------------------------------------------------------------------------------------------
<h1>Subindo a aplicação para um Servidor</h1>
Agora que temos uma aplicação madura, precisamos colocá-la na internet. Pois, até esse momento, a aplicação está rodando local. Para colocá-la na internet, precisamos achar um "host". Aqui vamos usar um host gratuito, chamado hostinger.com.br.

Clique em Criar Conta e crie uma conta. Com o usuário logado, vá na aba Hosting. Clique em Create New, e escolha a opção gratuita. Escolha um nome qualquer, e uma senha qualquer para seu site. Não esqueça dela, você precisará mais pra frente.

Assim que a conta tiver sido criada, o servidor estará de pé. Clique em "Switch" para ir para o painel de administração. Dentro do painel, selecione o File Manager 3. Essa opcão nos possibilita subir arquivos para essa máquina.



Dentro da máquina, entre no diretório public_html. Clique em upload. A melhor opção é a da direita: subir um arquivo zip com todo o projeto, que será descompactado automaticamente na máquina. Zipe todo o diretório do projeto (cada sistema operacional faz isso de uma maneira diferente), e suba esse arquivo. Para enviar, clique no botão verde. No log, dá pra perceber que ele descompactou tudo. Confirme clicando no botão verde novamente.

Ótimo, agora todos os arquivos devem estar lá. Se você acessar o endereço nesse momento (no nosso caso, alura.esy.es), você já consegue ver a página inicial. Mas se tentarmos adicionar um produto, tomaremos um erro. O banco de dados ainda não existe!

De volta ao painel, clique na opção MySql databases. Lá dentro, clique na opção Create New Database. Vamos chamar esse banco de dados de "loja" (repare que o site completa com um nome grande, afim de evitar conflitos entre outros usuários). Defina também uma senha (aqui definimos lojaloja).



Agora precisamos criar as tabelas. Clique no link PhpMyAdmin, e vamos criar as tabelas. Clique em SQL, e execute as consultas:

create table produtos (id integer auto_increment primary key, nome varchar(255), descricao text, preco decimal(10,2), categoria_id integer, usado boolean default false);

create table categorias (id integer auto_increment primary key, nome varchar(255));
Vamos inserir algumas categorias também:

insert into categorias (nome) values ("esporte"), ("escola"), ("mobilidade"), ("guloseimas");
Vamos agora mudar nosso arquivo conecta.php, passando os novos dados de conexão. Ainda bem que isolamos esse código em um único lugar:

// coloque os seus dados aqui
$conexao = mysqli_connect("mysql.hostinger.com.br", "u548680052_loja", "lojaloja", "u548680052_loja");
Precisamos subir esse arquivo de novo, pelo File Manager. Dessa vez podemos subir só o conecta.php.

Agora, podemos testar nossa aplicação, adicionando produtos.



Veja como é fácil subir uma aplicação PHP para um servidor. Lembre-se só da diferença: a conexão com o banco de dados. Mas, como isolamos isso em um único arquivo, ficou fácil.

