<h1>Imagens do Projeto</h1>

<img src="https://github.com/GustavoPrimolan/Alura-PHPeMySQLIICookiesSessoesEMaisRecursos/blob/master/TelaInicial.PNG">
<img src="https://github.com/GustavoPrimolan/Alura-PHPeMySQLIICookiesSessoesEMaisRecursos/blob/master/Logado.PNG">
<img src="https://github.com/GustavoPrimolan/Alura-PHPeMySQLIICookiesSessoesEMaisRecursos/blob/master/Contado.PNG">

-------------------------------------------------------------------------------------------------------------------------------------------
<h1>Seção 01 - Uma ação de login</h1>

Bem vindo a segunda parte do nosso curso PHP Mysql e fundamentos da Web. Neste curso continuaremos a criação de um sistema de cadastro, listagem, atualização e remoção de produtos para adicionar uma camada de autenticação e autorização da minha loja: somente quem está cadastrado pode adicionar produtos. Veremos também como enviar email e boas práticas de código e da web, como por exemplo evitar concatenar strings (evitando SQL injection). Caso seja necessário, você pode baixar o dump dos dados aqui
Se você não fez a primeira parte do curso verá no primeiro exercício como baixar o projeto e configurar o banco para continuar a partir deste ponto.

No nosso sistema a última coisa que fizemos foi deployar o mesmo na internet. Por isso temos que alterar no nosso arquivo de conexão com o banco e alterar os dados para abrir a conexão com nosso banco local. No arquivo conecta.php alteramos para comentar a linha de conexão remota e usar a local:

# $conexao = mysqli_connect("mysql.hostinger.com.br", "u548680052_loja", "lojaloja", "u548680052_loja");
$conexao = mysqli_connect("localhost", "root", "", "loja");
Quero me logar no meu sistema, mas para me logar tenho que criar uma tabela no banco de dados e para isso vou ao mysql no phpMyAdmin:

create table usuarios (id integer auto_increment primary key, email varchar(255), senha varchar(255));
Preciso inserir também o meu usuário, o administrador do sistema:

insert into usuarios (email,senha) values ('guilherme.silveira@alura.com.br', '123456');
Mas poxa, se eu inserir esta senha, olha que bagunçado! Minha senha ficará armazenada solta, clara, em forma de texto em um banco de texto de uma empresa. Qualquer pessoa que tenha acesso a este banco terá acesso a senha pura de todos os usuários!

Na prática criptografaremos esta senha com o algoritmo MD5. Entramos em um site qualquer que faça encryption de md5 como md5encryption.com. Digito a minha senha '123456' e ele retorna a minha senha criptografada: 'e10adc3949ba59abbe56e057f20f883e'. Esta é minha senha que será armazenada no banco.

insert into usuarios (email,senha) values ('guilherme.silveira@alura.com.br', 'e10adc3949ba59abbe56e057f20f883e');
Quando eu me logar, o programa criptografará a senha '123456' novamente e terá um select que buscará 'e10adc3949ba59abbe56e057f20f883e'. O programa sempre pega a senha original e criptografa para conferir se as senhas são as mesmas.

Agora que temos nosso usuário vamos criar nosso formulário de login. No arquivo index.php adicionaremos ele, com os campos email e senha. Note que continuamos usando o bootstrap:

            <h2>Login</h2>
            <form action="login.php" method="post">
            <table class="table">
                <tr>
                    <td>Email</td>
                    <td><input class="form-control" type="email" name="email"></td>
                </tr>
                <tr>
                    <td>Senha</td>
                    <td><input class="form-control" type="password" name="senha"></td>
                </tr>
                <tr>
                    <td><button type="submit" class="btn btn-primary">Login</button></td>
                </tr>
            </table>
            </form>
Testamos nossa aplicação e o formulário aparece bonito:



Vamos agora criar nossa lógica, a página login.php que recebe os dados do formulário, criamos esse arquivo e acessaremos o banco de dados:

<?php 
include("conecta.php");
include ("banco-usuario.php");
Desejamos buscar um único usuário através de seu email e senha:

$usuario = buscaUsuario($conexao, $_POST["email"], $_POST["senha"]);
Queremos ter uma noção se funcionou ou não:

echo $usuario;
Vamos adicionar o arquivo banco-usuario.php com a função que desejamos, a que recebe a conexão, o email e a senha:

<?php
function buscaUsuario($conexao, $email, $senha) {
}
Desejamos fazer um select com o email e a senha:

<?php
function buscaUsuario($conexao, $email, $senha) {
    $query = "select * from usuarios where email='{$email}' and senha='{$senha}'";
}
Queremos agora executar essa query e retornar o primeiro elemento, usando as funções de mysqli que já conhecemos:

<?php
function buscaUsuario($conexao, $email, $senha) {
    $query = "select * from usuarios where email='{$email}' and senha='{$senha}'";
    $resultado = mysqli_query($conexao, $query);
    $usuario = mysqli_fetch_assoc($resultado);
    return $usuario;
}
Perfeito, o primeiro usuário será retornado. Se eu passar o email 'guilherme.silveira@alura.com.br' e senha '123456' ele fará a query:

"select * from usuarios where email='guilherme.silveira@alura.com.br' and senha='123456'";
Mas não é isso que queremos, é? Desejamos criptografar a senha! Rodar o algortimo de md5, e o php já tem a função md5:

function buscaUsuario($conexao, $email, $senha) {
    $senhaMd5 = md5($senha);
    $query = "select * from usuarios where email='{$email}' and senha='{$senhaMd5 }'";
    $resultado = mysqli_query($conexao, $query);
    $usuario = mysqli_fetch_assoc($resultado);
    return $usuario;
}
Perfeito, agora sabemos que nossa senha será sempre criptografada antes de ser salva. Vamos testar? Vamos no navegador, colocamos os dados corretos de usuário e senha e temos:



Que estranho. Ele mostrou que tentou converter uma array em uma string. Faz sentido, queremos saber os valores de nossa array usuario, mas estamos tentando convertê-la em string.. e isso não é feito automaticamente pelo echo. Vamos então chamar a função que imprime a array com todos os seus valores, a var_dump:

<?php 
include("conecta.php");
include ("banco-usuario.php");

$usuario = buscaUsuario($conexao, $_POST["email"], $_POST["senha"]);
var_dump($usuario);
Testamos novamente o formulário e agora temos o resultado positivo. Podemos ver o usuário e senha em nossa array:



Vamos tentar agora com um usuário inválido?



O resultado é NULL, vazio. Legal mas eu gostaria de mostrar uma mensagem de sucesso ou de fracasso. Vou então no login.php e adiciono uma condição de sucesso ou fracasso:

$usuario = buscaUsuario($conexao, $_POST["email"], $_POST["senha"]);
if($usuario == null) {
  echo "Fracasso";
} else {
  echo "Logado";
}
Maravilha, testamos e funciona. Mas ao invés de só mostrar uma mensagem seca, gostaria de voltar para a página principal com a mensagem de sucesso ou fracasso. Já sabemos fazer isso com o redirect, usando o Header Location. Passamos também um parâmetro dizendo se o login foi um sucesso ou não:

$usuario = buscaUsuario($conexao, $_POST["email"], $_POST["senha"]);
if($usuario == null) {
    header("Location: index.php?login=false");
} else {
    header("Location: index.php?login=true");
}
die();
Vamos agora no index.php. Desejamos mostrar agora uma mensagem. Como checar se o parâmetro login existe na array _GET?

isset($_GET["login"])
Perfeito, se tem o parâmetro login E ele é true, então mostra a mensagem de sucesso:

<?php
if(isset($_GET["login"]) && $_GET["login"]==true) {
?>
<p class="alert-success">Logado com sucesso!</p>
<?php
}
?>
<?php
if(isset($_GET["login"]) && $_GET["login"]==false) {
?>
<p class="alert-danger">Usuário ou senha inválida!</p>
<?php
}
?>
Testamos com um usuário válido e temos sucesso!



Testamos agora com uma senha inválida:



Não deu certo! Ele mostrou a mensagem de sucesso. Como assim? Vamos olhar nosso código. Sabemos que o parâmetro login é "false". Mas a string false vale true.... No php o == faz a conversão automática lembra? E nele, toda string é true. Somente duas strings valem false. Uma delas é "0" e a outra é a string vazia "". Vamos testar? Na URI testamos com index.php?login=false:



E com index.php?login=0:



Ambos agora funcionam. Então temos que passar 0 no nosso redirecionamento. 0 quando dá erro e 1 (que será avaliado como verdadeiro, ou seja, true) quando sucesso:

$usuario = buscaUsuario($conexao, $_POST["email"], $_POST["senha"]);
if($usuario == null) {
    header("Location: index.php?login=0");
} else {
    header("Location: index.php?login=1");
}
die();
Mas ainda falta um passo importante. Queremos que quando o usuário se logue, nós possamos lembrar quem ele é. Queremos mostrar um botão de logout. Queremos esconder o formulário de login quando o usuário já está logado, mostrando algo como "Bem vindo guilherme.silveira@alura.com.br". Queremos também esconder esses parâmetros 0 e 1 que aparecem na URI. Tem muita coisa que desejamos fazer ainda e veremos tudo isso nos próximos capítulos.


<h2>Quais strings são false?</h2>

Quais strings são consideradas false em PHP?
Selecione uma alternativa

"FALSE", "0" e ""
 
"0" e "empty"
 
"0", "empty" e ""
 
"0" e ""
 
"0", "empty", "" e "FALSE"
As strings "0" e "" são consideradas false pelo PHP.


<h2>Testando o "true" e true</h2>
Já sabemos que === evita a mudança de tipo enquanto == faz a conversão. Compare "true" com true das duas maneiras. Quais os resultados? Qual o motivo?
"true" == true pois toda string diferente de "0" e "" é verdadeira. "true" !== true pois os tipos são diferentes, um é string, o outro é boolean.

--------------------------------------------------------------------------------------------------------------------------
<h1>Seção 02 - Efetuando o login e cookies</h1>
Legal, temos um formulário de login onde digitamos o usuário e senha e ao enviarmos ele mostra uma mensagem de sucesso ou fracasso.

Agora eu gostaria de mostrar uma mensagem de logado e sumir com o formulário enquanto você está logado. Isto é, gostaria de saber se você é a pessoa que se logou ou não. Em uma segunda requisição, eu tenho que saber que você é aquela pessoa que havia se logado em outra requisição anterior.

Para fazer isso tenho que conseguir marcar você, cliente, com alguma informação. Tenho que deixar minha marca em você, algo como "usuario_logado = guilherme.silveira@alura.com.br" para que você em todas as requisições subsequentes envie essa marca de volta, me dizendo que você é o usuario logado guilherme.silveira@alura.com.br. A sacada aqui é conseguir entregar algo para você que deixe essa marca, e você envie de volta essa marca toda vez que fizer uma requisição. Quero deixar um cookie com você, e você enviar de volta esse cookie.

Vamos então ao login.php e fazemos no caso de login com sucesso:

setcookie("usuario_logado", $usuario["email"]);
Abrimos o navegador e a aba de desenvolvimento (View, Developer, Developer Tools, Network no caso do Google Chrome). Fazemos o login e ele mostra a mensagem de logado com sucesso. Se olharmos o resultado, temos o resultado de nosso POST como um 302, redirect:



Descendo, encontramos as informações do formulário enviado:



Mas e se escolhermos o item Cookies?



Podemos ver nosso cookie com a informação usuario_logado = guilherme.silveira@alura.com.br. Se clicarmos em uma requisição podemos ver que sempre, como cliente, passamos a enviar o cookie:



Se eu estou no servidor, consigo então verificar se o cliente enviou esse cookie. Vou então na minha página index.php e verifico se a variável está setada:

if(isset($_COOKIE["usuario_logado"])) {
}
No caso de sucesso quero mostrar o email do usuário logado usando $_COOKIE["usuario_logado"] logo após a mensagem de bem vindo:

<?php
if(isset($_COOKIE["usuario_logado"])) {
?>
<p class="text-success">Você está logado como <?= $_COOKIE["usuario_logado"] ?></p>
<?php
}
?>
Fazemos o teste com o cookie no nosso navegador e vemos:



Agora vamos remover o formulário caso você esteja logado. Isto é, só mostramos o formulário caso ele não esteja logado:

<?php
if(isset($_COOKIE["usuario_logado"])) {
?>
<p class="text-success">Você está logado como <?= $_COOKIE["usuario_logado"] ?></p>
<?php
} else {
?>
CODIGO DO FORMULARIO AQUI
<?php
}
?>
Pronto, testamos novamente e conseguimos mostrar a mensagem sem o formulário:



Mas e para testar o formulário deslogado? Temos que esperar o cookie expirar, ele deixar de ser válido. O padrão de um novo cookie é até o navegador ser fechado, enquanto isso não acontecer o mesmo cookie será enviado para o servidor. Fecho o navegador e acesso novamente, pronto, estou deslogado e vejo o formulário de login.

Mas e se eu quiser um tempo de expiração diferente deste, por exemplo 1 minuto. Quando criamos nosso cookie com o setcookie, dizemos o tempo:

setcookie("usuario_logado", $usuario["email"], time() + 60);
Testamos o login e podemos no network verificar que o cookie expirará em 1 minuto. Esperamos e testamos novamente, estamos deslogados.

Vimos como marcar um usuário com uma determinada informação, que fica do lado do cliente. Toda nova requisição ele envia todos os dados novamente para nós. Quanto maior essa informação, mais dados enviados de lá para cá (cliente para o servidor) e vice versa. Além disso, tudo que salvamos é uma string, não é número, não é objeto, não é data. Os cookies são strings e, portanto, chatos de manipular. Além disso tudo temos probleminhas de segurança quando abordamos assim com cookies que guardam o email. Veremos como melhorar tudo isso nos próximos capítulos, mas primeiro vamos proteger nossa página, no próximo capítulo veremos como impedir que o usuário adicione um produto caso ele não esteja logado.


<h2>Mudando o tempo de logout</h2>
Teste um valor positivo como time() + 60. Quando o cookie expira? E se você fechar o navegador o cookie expira?
O cookie expira em um minuto, e se fecharmos o navegador o cookie continua lá durante um minuto. Somente se fecharmos o navegador e passar um minuto o cookie vai embora.

Existem diversos problemas possíveis com o cookie mas o principal deles envolve nossa abordagem atual: colocamos o email do usuário logado no cookie, e o CLIENTE é responsável por enviar este valor para nós. O cliente pode enviar o que quiser, ele pode fingir ter um cookie que não tem, e quebrar nosso sistema, como veremos em breve!


------------------------------------------------------------------------------------------------------------------
<h1>Seção 03 - Protegendo o acesso as páginas, refatorando e extraindo a lógica</h1>


Legal, fizemos um formulário onde o usuário coloca o usuário e senha e mostramos se ele fez login com sucesso (através de um cookie) ou não. Mas queremos mostrar o formulário de produto somente se ele estiver logado!

Como fazer isso? Verificando se o usuário está logado antes de mostrar o formulário. Então vamos no nosso produto-formulario.php e verificamos se o usuário não tem o cookie de usuário logado:

if(!isset($_COOKIE["usuario_logado"])) {
  Header("Location: index.php?falhaDeSeguranca=true");
  die();
}
E no nosso index.php devemos verificar se o parâmetro GET está setado:

<?php
if(isset($_GET["falhaDeSeguranca"])) {
?>
  <p class="alert-danger">Você não tem acesso a esta funcionalidade!</p>
<?php
}
?>
Perfeito, deslogados tentamos acessar o formulário de produto e recebemos a mensagem:



Mas tem algo de estranho. Protegemos o nosso formulário, mas o que alguém maldoso poderia fazer? Poderia criar um arquivo html que tem um formulário igual ao de adicionar, mas salvo na própria máquina. Ele pode enviar esse formulário para a URI adiciona-produto.php. Ele pode acessar o html pois é um html qualquer na máquina dele, e quando fizer o post, ele vai para nosso arquivo, que adiciona. A falha de segurança é que o adiciona-produto não verificou se o usuário está logado, e é muito importante proteger a lógica no adiciona-produto.php:

if(!isset($_COOKIE["usuario_logado"])) {
  Header("Location: index.php?falhaDeSeguranca=true");
  die();
}
Agora sim, se ele acessar o formulário ou o adiciona-produto, estamos protegidos. Claro, ficou um copy e paste meio feinho, o que podemos fazer? Extrair o código, extrair a lógica para uma função verificaUsuario*:

function verificaUsuario() {
  if(!usuarioEstaLogado()) {
     header("Location: index.php?falhaDeSeguranca=true");
     die();
  }
}
Mas se esta função ficar em cada um dos arquivos, ainda não removemos os dois copy e paste. Devemos extrair este código para algum lugar comum, um arquivo que contenha todas as lógicas de um usuário logado. Chamaremos esse arquivo de logica-usuario.php:

<?php
function verificaUsuario() {
  if(!isset($_COOKIE["usuario_logado"])) {
     header("Location: index.php?falhaDeSeguranca=true");
     die();
  }
}
E em nosso formulário e adiciona-produto:

include("logica-usuario.php");
verificaUsuario();
Já que estamos refatorando e melhorando nosso código, vamos trazer todo o código de lógica de usuário logado para cá. O próximo passo é a extração deste usuário logado, que aparece em diversos lugares. No index.php perguntamos se o usuário está logado, então extraímos para uma função que diz se ele está logado ou não:

function usuarioEstaLogado() {
    return isset($_COOKIE["usuario_logado"]);
}
E também acessamos em diversos lugares o usuário logado:

function usuarioLogado() {
    return $_COOKIE["usuario_logado"];
}
Podemos agora deixar o código mais limpo e fazer com que a function verificaUsuario() utlize a usuarioEstaLogado(), ficando de maneira mais simples e completa.

<?php

function usuarioEstaLogado() {
    return isset($_COOKIE["usuario_logado"]);
}

function verificaUsuario() {
  if(!usuarioEstaLogado()) {
     header("Location: index.php?falhaDeSeguranca=true");
     die();
  }
}

function usuarioLogado() {
    return $_COOKIE["usuario_logado"];
}
Podemos alterar agora nosso index.php para não acessar mais a variável cookie. Mas ainda temos um único lugar que acessa o cookie fora de nosso arquivo logica-usuario. Quando o usuário se loga temos o acesso dentro do login.php. No caso de sucesso queremos agora chamar um método que loga o usuário:

if($usuario == null) {
    header("Location: index.php?login=0");
} else {
    logaUsuario($usuario["email"]);
    header("Location: index.php?login=1");
}
die();
Para isso implementamos a função:

function logaUsuario($email) {
  setcookie("usuario_logado", $email);
}
No login.php e no index.php usamos o logica-usuario:

include("logica-usuario.php");
Pronto! Toda nossa lógica de login está concentrada aqui. Quando precisarmos alterar algo basta utilizar este arquivo. Nossa próxima preocupação é que ainda armazenamos dados em nosso cliente e não podemos confiar nele, como veremos em breve.

<h2>Devemos proteger a lógica?</h2>

Tem algo de estranho ainda. Se o usuário escrever um formulário html em sua própria máquina e efetuar um POST para adiciona-produto.php ele será capaz de adicionar um produto. Faça o teste. Crie um arquivo html em seu computador, abra ele no navegador e faça o post. O que sugere fazer?

A solução é sempre protegermos tanto a lógica quanto o formulário.


--------------------------------------------------------------------------------------------------------------------------------------------------
<h1>Seção 04 - Insegurança com cookie, segurança com session e efetuando logout</h1>

Criamos uma loja, adicionamos o sistema de login e protegemos nossa página. Mas nosso cliente, administrador da loja, nos liga dizendo que tem uma pessoa qualquer logado com o usuário dele. Como assim? Não nos protegemos?

Vamos dar uma olhada no que acontece com os cookies? Nos logamos no sistema e verificamos o cookie:



Lembra que o cookie fica no cliente? Como não temos controle sobre o cookie, será que o cliente consegue alterar ele? Com certeza, ele pode fazer o que quiser com os cookies, não temos como saber. Executamos, por exemplo, um código na aba de console para alterar o valor de um cookie:



Voltamos na aba de resources e nosso cookie se tornou:



Agora podemos voltar a home e temos que o usuário logado é o:



Podemos usar cookies mas não adicionar valores claramente de segurança em dados do cliente. Não podemos colocar seu email, seu id ou qualquer outra coisa similar. Devemos adicionar um código difícil de "chutar", um código qualquer para cada usuário como "74923878r8y9fwe8hr32nu" para esse usuário específico e "79y2huifenbu9fv98" para o próximo.

Gerando códigos muito diferentes para cada usuário faz com que eles não possam ficar chutando sem serem percebidos (muitas requisições). Para isso é importante usar um gerador bem elaborado. E do lado do servidor temos que atrelar a informação "74923878r8y9fwe8hr32nu" com "usuario_logado = guilherme.silveira@alura.com.br". Assim o cliente só consegue alterar o valor do cookie, mas não existe nada no servidor para um número de cookie que não existe! Perfeito. Esse é o conceito de sessão: damos um código gerado para o cliente e do lado do servidor armazenamos este código com uma série de chaves e valores. O cliente só pode alterar aquele código, e terá que chutar muito para encontrar outro código válido.

Como mudamos para deixar de usar cookie e passar a usar sessão? Bom tudo será feito com o usuário logado, isto é, no único arquivo que usa os cookies, o logica-usuario. Primeiro, no começo do arquivo, devemos indicar que usaremos a sessão. Se não existe uma sessão ainda, desejamos criá-la, e se ela já existe, desejamos usá-la:

<?php
session_start();
function usuarioEstaLogado() {
  # codigo da função
}
# resto do arquivo aqui
Como colocar o usuário logado? O logaUsuario? Simples:

function logaUsuario($email) {
    $_SESSION["usuario_logado"] = $email;
}
Para verificar se o usuário está logado basta chamarmos o método de usuario logado:

function verificaUsuario() {
  if(!usuarioEstaLogado()) {
     header("Location: index.php?falhaDeSeguranca=true");
     die();
  }
}
E como verificar se ele está logado? Basta verificar se isset esta variável:

function usuarioEstaLogado() {
    return isset($_SESSION["usuario_logado"]);
}
Por fim, o método que extrai o usuário logado:

function usuarioLogado($email) {
    return $_SESSION["usuario_logado"];
}
Repare como foi fácil trocar todas as invocações de cookie para sessão! Acessamos agora nosso navegador e temos o novo cookie, o cookie que o PHP utiliza para marcar a sessão:



Ao nos logarmos, não há nada de diferente nos cookies. O valor do usuário logado fica armazenado no servidor e não no cliente! Agora como fazemos o logout?

Primeiro queremos um link de logout na página inicial, caso você esteja logado:

            <?php if(usuarioEstaLogado()) {?>
                <p class="text-success">Você está logado como <?= usuarioLogado() ?>.
                <a href="logout.php">Deslogar</a></p>
            <?php } else {?>
Precisamos criar o logout.php. Mais simples do que o login, ele chama uma função de logout e redireciona:

<?php include("logica-usuario.php");
logout();
header("Location: index.php?logout=true");
die();
Vamos agora criar a função logout no logica-usuario destruindo nossa sessão:

function logout() {
    session_destroy();
}
E no index.php vamos mostrar a mensagem de deslogado:

<?php
     if(isset($_GET["logout"]) && $_GET["logout"]==true) {
?>
    <p class="alert-danger">Deslogado com sucesso</p>
<?php
     }
?>
Vamos no navegador, clicamos deslogar e.. perfeito, deslogado com sucesso.


------------------------------------------------------------------------------------------------------------------------------------
<h1>Seção 05 - Passando parâmetros para a próxima requisição</h1>

Ainda há algumas coisas estranhas em nosso código, por exemplo, se tentamos nos logar no sistema com um usuário e senha inválido. Lá em cima, na URI, aparece login=0, e o nosso usuário final pode brincar com isso, ele pode alterar esse parâmetro e mostrar uma mensagem indesejada. Temos que tomar muito cuidado com esses parâmetros. Imagina se passamos um parâmetro:

http://localhost/loja/index.php?mensagem=Logado com sucesso!
Mas um usuário espertinho poderia colocar um palavrão. Por mais que não seja uma brecha de segurança, é uma brecha que pode causar vergonha para uma empresa. Evitamos essas situações. O que devemos fazer então? Quando o usuário é logado ou o login fracassa queremos marcá-lo com essa informação, para que no redirect, quando ele fizer a próxima requisição como cliente, nós possamos mostrar para ele a mensagem que armazenamos. Isto é queremos colocar a mensagem na session. E na próxima requisição queremos tirar ela da session e mostrar para o usuário.

Vamos começar? Primeiro no formulário de produto e no adiciona produto temos a chamada para verificaUsuario, no arquivo logica-usuario.php. Essa função faz:

function verificaUsuario() {
  if(!usuarioEstaLogado()) {
     header("Location: index.php?falhaDeSeguranca=true");
     die();
  }
}
Primeiro deixamos de passar a falha de segurança como parâmetro:

function verificaUsuario() {
  if(!usuarioEstaLogado()) {
     header("Location: index.php");
     die();
  }
}
E agora adicionamos uma variável na sessão, algo que será um aviso de erro, portanto um danger:

function verificaUsuario() {
  if(!usuarioEstaLogado()) {
      $_SESSION["danger"] = "Você não tem acesso a esta funcionalidade.";
     header("Location: index.php");
     die();
  }
}
Agora no nosso arquivo index.php não precisamos mais ler o parâmetro falha de segurança. Ao invés daquele if, colocamos um if para o danger, e mostramos a mensagem do servidor, da sessão, que não foi para o cliente:

     if(isset($_SESSION["danger"])) {
?>
    <p class="alert-danger"><?= $_SESSION["danger"]?></p>
<?php
     }
Mas precisamos remover a variável da sessão. Para remover, usamos o unset:

     if(isset($_SESSION["danger"])) {
?>
    <p class="alert-danger"><?= $_SESSION["danger"]?></p>
<?php
        unset($_SESSION["danger"]);
     }
Testamos a aplicação e tudo funciona, mas agora não temos mais o parâmetro lá em cima:



Agora devemos fazer o mesmo processo de usar a sessão em outros casos que usávamos parâmetros de URI para trocar informações. Vamos ao login.php e no caso de usuário com senha inválida usamos a mesma mensagem de danger:

if($usuario == null) {
    $_SESSION["danger"] = "Usuário ou senha inválido.";
    header("Location: index.php");
} else {
E agora no index.php não precisamos mais do caso login==false já que nunca mais enviamos ele. Enviamos agora pelo atributo da sessão. Então removemos o if do caso de login==false.

Seguindo o padrão, farei a mesma coisa no login com sucesso. A diferença é que agora configuraremos a mensagem de success* ao invés de danger**:

if($usuario == null) {
    $_SESSION["danger"] = "Usuário ou senha inválido.";
    header("Location: index.php");
} else {
    $_SESSION["success"] = "Usuário logado com sucesso.";
    logaUsuario($usuario["email"]);
    header("Location: index.php");
}
E no index.php podemos remover completamente os ifs de login. Precisamos adicionar um if para o caso de success:

     if(isset($_SESSION["success"])) {
?>
    <p class="alert-success"><?= $_SESSION["success"]?></p>
<?php
        unset($_SESSION["success"]);
     }
Só falta agora o if de logout. Vamos no logout.php e trocamos para usar a sessão:

$_SESSION["success"] = "Deslogado com sucesso.";
header("Location: index.php");
die();
E no index.php removemos este caso. Testamos o login e tudo está funcionando, perfeito. Mas o logout não funciona. A mensagem não aparece. O que aconteceu com ele? Vamos olhar seu código:

logout();
$_SESSION["success"] = "Deslogado com sucesso.";
header("Location: index.php");
die();
Repare que nós matamos a sessão e depois colocamos algo nela, mas ela será jogada fora! Portanto dentro do método logout devemos destruir a sessão atual e criar uma nova sessão:

function logout() {
    session_destroy();
    session_start();
}
Existe mais um lugar onde fazemos o if, a listagem de produto. Assim como no produto-lista.php, faremos o if de sucesso nele:

     if(isset($_SESSION["success"])) {
?>
    <p class="alert-success"><?= $_SESSION["success"]?></p>
<?php
        unset($_SESSION["success"]);
     }
Perfeito, mas agora no remove-produto devemos enviar esse parâmetro success na session:

$id = $_POST['id'];
 removeProduto($conexao, $id);
 $_SESSION["success"] = "Produto removido com sucesso.";
 header("Location: produto-lista.php");
 die();
Como o arquivo passa a usar a sessão, precisamos ter certeza que ela existe:

include("logica-usuario.php");
Talvez fosse um caso interessante colocar o session_start em outro lugar, tudo depende de cada projeto: no cabeçalho, em uma lógica etc. Devemos colocar o include também no produto-lista.php.

Testamos e o produto é removido com sucesso, sem passar parâmetros na URI.

--------------------------------------------------------------------------------------------------------------------------------------------
<h1>Seção 06 - Refatoração, escopo de flash e controle de erro</h1>

Nosso código ainda está muito espalhado. Temos dois trechos muito parecidos no index.php e um outro igual no produto-lista.php. Vamos extrair este código?

Pegamos o código de sucesso:

     if(isset($_SESSION["success"])) {
?>
    <p class="alert-success"><?= $_SESSION["success"]?></p>
<?php
        unset($_SESSION["success"]);
     }
E extraímos para uma função que mostra um alerta de acordo com o tipo:

function mostraAlerta($tipo) {
}
Agora queremos verificar se este tipo de alerta está setado:

function mostraAlerta($tipo) {
     if(isset($_SESSION["success"])) {
    }
}
E aí dentro, em caso positivo, queremos mostrar a mensagem e remover o campo da sessão:

 function mostraAlerta($tipo) {
     if(isset($_SESSION[$tipo])) {
?>
    <p class="alert-<?= $tipo ?>"><?= $_SESSION[$tipo]?></p>
<?php
        unset($_SESSION[$tipo]);
     }
 }
Perfeito. Basta invocarmos esta função com o parâmetro success para que executemos o código de mostrar alerta de sucesso:

mostraAlerta("success");
E queremos mostrar também o alerta de danger:

mostraAlerta("success");
mostraAlerta("danger");
O código fica bem mais simples, mas desejamos usar ele não só no index.php, mas também em outro arquivo. Portanto extraímos essa função para outro arquivo, um chamado mostra-alerta.php:

<?php
 function mostraAlerta($tipo) {
     if(isset($_SESSION[$tipo])) {
?>
    <p class="alert-<?= $tipo ?>"><?= $_SESSION[$tipo]?></p>
<?php
        unset($_SESSION[$tipo]);
     }
 }
Agora no index.php e no produto-lista.php basta importar e usar:

            <?php  mostraAlerta("success"); ?>
            <?php mostraAlerta("danger"); ?>
Mas é assim mesmo que queremos trabalhar? Toda página que precisa mostrar um alerta de sucesso ou erro tem que lembrar de chamar essa função? Não, ao invés de usarmos a invocação em cada página, jogamos ela no fim de nosso cabecalho.php:

            <?php  mostraAlerta("success"); ?>
            <?php mostraAlerta("danger"); ?>
E no início do cabecalho:

<?php include("mostra-alerta.php"); ?>
Perfeito. Mas repare que o mostra-alerta usa a sessão, certo? E já chamamos o session_start()? Parece que não, então vamos jogar o session_start dentro de nosso arquivo mostra-alerta.php. Assim sempre que carregar o arquivo, a sessão já existe:

<?php
session_start();
 function mostraAlerta($tipo) {
     if(isset($_SESSION[$tipo])) {
?>
    <p class="alert-<?= $tipo ?>"><?= $_SESSION[$tipo]?></p>
<?php
        unset($_SESSION[$tipo]);
     }
 }
Testamos o login mas dá um erro estranho, um tal de sessão já foi inicializada:



É só uma informação, um notice, não significa que é um erro, mas que eu possa estar fazendo algo que achava que funcionava de outra maneira. O que acontece é que chamamos o session_start duas vezes. Uma primeira dentro do mostra-alerta e outra no logica-usuario. No nosso caso queremos deixar de visualizar esse tipo de erro, erros do tipo E_NOTICE. Como desejamos mostrar todos os tipos de erro (E_ALL) exceto E_NOTICE, podemos fazer a exclusão de bits:

E_ALL ^ E_NOTICE
Essa configuração pode ser feita no php.ini ou via programática. Como em alguns deploys você não tem acesso ao arquivo de configuração, faremos dessa vez via código, chamando o error_reporting:

error_reporting(E_ALL ^ E_NOTICE);
Fazemos isso em nosso cabeçalho:

<?php
error_reporting(E_ALL ^ E_NOTICE);
include("mostra-alerta.php"); ?>
Testamos novamente e sucesso!

Agora que refatoramos nosso arquivo de mostrar alertas podemos analisar melhor o que fizemos: setamos um atributo no escopo de sessão que será removido e na próxima requisição. Esse escopo que criamos, que dura mais do que uma requisição (dura exatamente duas requisições, a atual e a próxima) e menos do que uma sessão (dura diversas requisições), é chamado de escopo de flash. Na prática, se não usamos nenhum framework temos que criá-lo na mão, ou se usamos frameworks eles já fornecem esse escopo para nós, da mesma maneira que acessamos o escopo de cookies ou de session.

<h2>Removendo o alerta da sessão</h2>

Testando a aplicação está tudo funcionando mas ele nos mostra o NOTICE de que a sessão tem o método chamado duas vezes em algumas ocasiões. Vamos resolver isso dizendo no nosso cabeçalho que desejamos todos os erros exceto NOTICE:

error_reporting(E_ALL ^ E_NOTICE);
Após a mudança teste sua aplicação. Pesquise na documentação o que devemos passar para desabilitar todas as mensagens de erro. Faz sentido desabilitar todas?

RESPONDER
Opinião do Instrutor

Passando zero temos todos os erros desabilitados. O perigo disso é receber uma tela em branco e ficar sem saber o que aconteceu. Em produção é interessante deixar ativo somente aquilo que não comprometerá dados internos de sua aplicação (por exemplo, você não quer que uma query apareça em uma mensagem de erro).

-------------------------------------------------------------------------------------------------------------
<h1>Seção 07 - Um único formulário para adicionar e alterar</h1>
Ainda temos uma questão estranha: o formulário de alterar e o de adicionar ainda são muito parecidos. Repara que os dois formulários tem o form, o table e todos os campos. Cada um tem uma pequena diferença: o título, o valor padrão, o campo extra hidden no caso da edição e o valor de botão de envio. Mas se eu adicionar agora um campo novo tenho que alterar os dois formulários, algo muito ruim.

Como seria se juntássemos esses dois arquivos para quando uma modificação fosse feita ela fosse aplicada aos dois formulários? Bom, começamos olhando o que eles não tem em comum e é grosseiro: a action do formulário e o campo hidden no caso de alteração. Os trs são muito parecidos até o penúltimo tr, exceto o de botão de envio. Então cortamos tudo o que está entre um table e o último tr. E no lugar desses campos colocamos um include:

include("produto-formulario-base.php");
Fazemos a mesma coisa no formulário de alterar. Mas repara que ele tem mais conteúdo do que o adiciona: ele já coloca os valores dos campos preenchidos. Portanto removemos também os campos daqui, incluindo a tag include. Mas o código que ficará no produto-formulario-base.php será o de alteração, para que já venha preenchido:

<tr>
    <td>Nome</td>
    <td> <input class="form-control" type="text" name="nome" value="<?=$produto['nome']?>"></td>
</tr>
<tr>
    <td>Preço</td>
    <td><input  class="form-control" type="number" name="preco" 
        value="<?=$produto['preco']?>"></td>
</tr>
<tr>
    <td>Descrição</td>
    <td><textarea class="form-control" name="descricao"><?=$produto['descricao']?></textarea></td>
</tr>
<tr>
    <td></td>
    <td><input type="checkbox" name="usado" <?=$usado?> value="true"> Usado
</tr>
<tr>
    <td>Categoria</td>
    <td>
        <select name="categoria_id" class="form-control">
        <?php foreach($categorias as $categoria) : 
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
Com isso a tela de alterar produto continuará funcionando, mas a tela de novo não vai funcionar, pois a variável produto não funciona. Se ela não existe, vamos criá-la. No arquivo produto-formulario.php definimos uma array que será nosso produto:

$produtos = array();
Quais serão os valores preenchidos por padrão para um novo produto? Vazio, portanto:

$produto = array("nome" => "", "descricao" => "", "preco" => "");
E a categoria? Vamos selecionar a categoria 1 por padrão:

$produto = array("nome" => "", "descricao" => "", "preco" => "", "categoria_id" => "1");
Perfeito, quase todos os campos virão preenchidos como vazio agora na tela de novo produto, faltou somente a variável usado. Desejamos que o produto novo venha com o campo setado? Não, portanto:

$produto = array("nome" => "", "descricao" => "", "preco" => "", "categoria_id" => "1");
$usado = "";
Perfeito. Testamos e o formulário de adicionar e alterar continuam funcionando. Repara que foi muito fácil, extraímos o código comum em um php específico e inicializamos as variáveis que eram necessárias para esse arquivo comum (o arquivo de base) em nossas duas páginas.

-------------------------------------------------------------------------------------------------------------------------------
<h1>Seção 08 - SQL Injection</h1>

Vamos fazer um teste com um produto novo. Nos logamos e tentamos adicionar uma Bola D'água, com uma aspas simples entre D e a. O que acontece? Dá um erro?



Como assim? Funcionava até agora. Vamos descobrir o que aconteceu? Imprimimos nossa query modificando o banco-produto, a função insereProduto:

function insereProduto($conexao, $nome, $preco, $descricao, $categoria_id, $usado) {
    $query = "insert into produtos (nome, preco, descricao, categoria_id, usado) values ('{$nome}', {$preco}, '{$descricao}', {$categoria_id}, {$usado})";
    var_dump($query);
    return mysqli_query($conexao, $query);
}
Cadastramos novamente e temos a query:



Note que as aspas simples do nome do produto bagunçou a nossa query. O que temos que fazer? Tratar a aspas simples, cuidar de possíveis aspas simples que o usuário pode escrever. Mas não só isso, o usuário pode escrever outros tipos de caracteres ou combinações de caracteres que quebrem nossa query.

Nesse caso vimos que a query quebra mas nada que parece ser uma falha de segurança, mas vamos passar por um segundo exemplo de não tratar as aspas simples (e outros caracteres)?

Nos deslogamos e vamos para o formulário de login. Tentamos nos logar com um email malicioso:

' or id=1  or 'guilherme'='
E podemos colocar qualquer senha como 241y79h89fwe98f23nch8hif28jf3. Tentamos nos logar e ele não deixa. O navegador bloqueou um campo de email inválido pois estamos usando html5. Você pode imaginar que estamos protegidos de um usuário que parece ser malvado. Bom, como usuário final, clico da direita e vou no Developer Tools. Algo bem simples. Clicamos da direita no elemento de campo de texto do email, clicamos da direita, Inspect Element.



Agora damos um duplo clique em type e mudamos para text. Agora podemos enviar o formulário e, surpresa...



Conseguimos nos logar com o usuário de id 1 mesmo sem saber o email e senha dele. Da mesma maneira que conversamos sobre cookies, não podemos confiar em dados que nosso cliente final envia. O usuário pode inserir um código malicioso para quebrar nossa query de login. Vamos conferir ela? No nosso arquivo banco-usuario dentro da função buscaUsuario damos um var_dump da query:

<?php
include("conecta.php");            
function buscaUsuario($conexao, $email, $senha) {
    $senhaMd5 = md5($senha);
    $query = "select * from usuarios where email='{$email}' and senha='{$senhaMd5}'";
    var_dump($query);
    die();
    $resultado = mysqli_query($conexao, $query);
    $usuario = mysqli_fetch_assoc($resultado);
    return $usuario;
}
Testamos novamente e o resultado é a query que seleciona o primeiro usuário que tenha o id igual a 1. A precedência dos operadores é utilizada para isolar o or id=1.



Portanto é importantíssimo validarmos a entrada de dados e limparmos ela de quaisquer caracteres que possam quebrá-la. Desejamos evitar que o usuário final possa inserir código sql dentro de nossa query, que ele não possa injetar SQL, que ele não possa fazer SQL Injection.

Como fazer isso? Antes de executar a query com o email puro, desejamos tratar as aspas simples etc, desejamos escapar caracteres especiais:

<?php
include("conecta.php");            
function buscaUsuario($conexao, $email, $senha) {
    $senhaMd5 = md5($senha);
    $email = mysqli_real_escape_string($conexao, $email);
    $query = "select * from usuarios where email='{$email}' and senha='{$senhaMd5}'";
    var_dump($query);
    die();
    $resultado = mysqli_query($conexao, $query);
    $usuario = mysqli_fetch_assoc($resultado);
    return $usuario;
}
Atualizamos e testamos. A query faz o escape da aspas simples, maravilha. Removemos agora o var_dump e o die:

<?php
include("conecta.php");            
function buscaUsuario($conexao, $email, $senha) {
    $senhaMd5 = md5($senha);
    $email = mysqli_real_escape_string($conexao, $email);
    $query = "select * from usuarios where email='{$email}' and senha='{$senhaMd5}'";
    $resultado = mysqli_query($conexao, $query);
    $usuario = mysqli_fetch_assoc($resultado);
    return $usuario;
}
Atualizamos e o código de injection para de funcionar. A mesma coisa temos que fazer sempre que nosso usuário final nos envia dados, jamais confie nos dados do cliente, sempre lembre de cuidar deles.


-------------------------------------------------------------------------------------------------------------------------------------
<h1>Seção 09 - Include, require, require_once</h1>
Ainda tem uma coisa bagunçada: em muitos lugares como no adiciona-produto pedimos para incluir o banco-produto e o conecta. Mas sempre que adicionamos o banco-produto queremos incluir o conecta. Legal, podemos remover a linha de include do arquivo adiciona-produto e colocar no banco-produto:

<?php
include("conecta.php");            
# resto do codigo do banco-produto aqui...
Perfeito, mas tenho que tomar um cuidado. Não quero que ninguém inclua o conecta.php duas vezes! Se fizermos isso, ele pode executar as mesmas funções, definir as mesmas variáveis etc. Não queremos fazer isso. Ao invés de fazer o include desejamos requerer uma única vez. Desejamos require_once. Perfeito.

Qual a diferença entre include, require e require_once? O include funciona como vimos até agora, se o arquivo existe, inclue, se não existe, dá uma mensagem de erro. O require dá um erro fatal caso não encontre o arquivo. E o require_once faz o papel do require e garante que o arquivo seja incluído uma única vez.

Então abrimos todos os nossos arquivos banco- para incluir o conecta.php via require_once.

Mudamos todos os outros arquivos para não incluir mais o conecta.php e para sempre utilizar require_once em todos os lugares que existia include. Passamos um a um e fazemos as alterações.

<h2>Include</h2>
O que acontece quando tentamos dar um include em um arquivo que não existe?
O include gera uma mensagem de erro e continua a execução caso o arquivo não seja encontrado.

-------------------------------------------------------------------------------------------------------------------------------------------------------
<h1>Envio de email via SMTP</h1>

Gostaria de ser capaz de enviar um email para o dono da loja... queremos uma página de entrar em contato. Primeiro mudamos nosso cabeçalho para mudar para contato:

<li><a href="contato.php">Contato</a></li>
Criamos um arquivo chamado contato.php que inclue o cabeçalho, o rodapé:

<?php require_once("cabecalho.php"); ?>

<?php require_once("rodape.php"); ?>
Sem segredos, incluimos também o formulário de contato: um campo de email, um de nome e um de mensagem, com o método post para envia-contato.php:

<?php require_once("cabecalho.php"); ?>

<form action="envia-contato.php" method="post">
    <table class="table">
        <tr>
            <td>Nome</td>
            <td><input type="text" name="nome" class="form-control"></td>
        </tr>
        <tr>
            <td>Email</td>
            <td><input type="email" name="email" class="form-control"></td>
        </tr>
        <tr>
            <td>Mensagem</td>
            <td><textarea class="form-control" name="mensagem"></textarea></td>
        </tr>
        <tr>
            <td><button type="submit" class="btn btn-primary">Enviar</button></td>
        </tr>
    </table>

</form>


<?php require_once("rodape.php"); ?>
O formulário fica bonito, mas quero implementar o arquivo que envia o email. Criamos o arquivo envia-contato.php e lemos os três campos:

<?php
$nome = $_POST["nome"];
$email = $_POST["email"];
$mensagem = $_POST["mensagem"];
Precisamos agora da biblioteca que envia emails. Uma biblioteca bem comum no mundo php sem frameworks é o PHPMailer. Entramos no site https://github.com/PHPMailer/PHPMailer

Clicamos no link download que baixa o zip com tudo o que é contido neste projeto dentro do github. Descompactamos o arquivo e dentro dele copiaremos somente alguns arquivos: o código fonte do PHPMailer, que são os arquivos: class.pop3.php, class.smtp.php e class.phpmailer.php. Copiaremos também o arquivo que carrega a biblioteca dinamicamente, o PHPMailerAutoload.php.

Vamos usar somente smtp, por isso não precisávamos do class.pop3.smtp, mas copiamos somente para mostrar como funciona essa cópia de biblioteca. Jogamos os arquivos dentro do diretório de nosso projeto e agora é hora de carregar a biblioteca:

require_once("PHPMailerAutoload.php");
Criamos agora um novo email a ser enviado:

$mail = new PHPMailer();
E configuramos os dados do servidor gmail para envio de emails:

$mail->isSMTP();
$mail->Host = 'smtp.gmail.com';
$mail->Port = 587;
$mail->SMTPSecure = 'tls';
$mail->SMTPAuth = true;
$mail->Username = "alura.php.e.mysql@gmail.com";
$mail->Password = "123456";
Agora vamos ao email, primeiro quem está enviando o email, no nosso caso é o administrador da loja, quem fez o site:

$mail->setFrom("alura.php.e.mysql@gmail.com", "Alura Curso PHP e MySQL");
E quem vai receber o email, no nosso caso, o mesmo usuário:

$mail->addAddress("alura.php.e.mysql@gmail.com");
Confiramos o título da mensagem:

$mail->Subject = "Email de contato da loja";
E o corpo da mensagem como HTML:

$mail->msgHTML("<html>de: {$nome}<br/>email: {$email}<br/>mensagem: {$mensagem}</html>");
Por fim, caso o usuário não abra o email em modo html, mas sim em modo txt, você pode querer mostrar uma mensagem diferente:

$mail->AltBody = "de: {$nome}\nemail:{$email}\nmensagem: {$mensagem}";
E agora enviamos nosso email, verificando se deu algum erro:

if($mail->send()) {
} else {
}
Dependendo do caso (sucesso ou fracasso), desejamos redirecionar para a página principal com uma mensagem de sucesso ou para o formulário de email com uma mensagem de fracasso:

if($mail->send()) {
    $_SESSION["success"] = "Mensagem enviada com sucesso";
    header("Location: index.php");
} else {
    $_SESSION["danger"] = "Erro ao enviar mensagem " . $mail->ErrorInfo;
    header("Location: contato.php");
}
die();
Lembre-se: como já colocamos a invocação de mostraAlerta no cabeçalho, não precisamos nos preocupar. Como estamos usando a sessão, vamos garantir que ela seja criada:

<?php
session_start();
$nome = $_POST["nome"];
$email = $_POST["email"];
$mensagem = $_POST["mensagem"];

require_once("PHPMailerAutoload.php");

$mail = new PHPMailer();
$mail->isSMTP();
$mail->Host = 'smtp.gmail.com';
$mail->Port = 587;
$mail->SMTPSecure = 'tls';
$mail->SMTPAuth = true;
$mail->Username = "alura.php.e.mysql@gmail.com";
$mail->Password = "123456";

$mail->setFrom("alura.php.e.mysql@gmail.com", "Alura Curso PHP e MySQL");
$mail->addAddress("alura.php.e.mysql@gmail.com");
$mail->Subject = "Email de contato da loja";
$mail->msgHTML("<html>de: {$nome}<br/>email: {$email}<br/>mensagem: {$mensagem}</html>");
$mail->AltBody = "de: {$nome}\nemail:{$email}\nmensagem: {$mensagem}";

if($mail->send()) {
    $_SESSION["success"] = "Mensagem enviada com sucesso";
    header("Location: index.php");
} else {
    $_SESSION["danger"] = "Erro ao enviar mensagem " . $mail->ErrorInfo;
    header("Location: contato.php");
}
die();
Pronto! Testamos e o email é enviado:



