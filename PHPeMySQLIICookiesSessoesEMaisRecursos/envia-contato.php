<?php
session_start();
$nome = $_POST['nome'];
$email = $_POST['email'];
$mensagem = $_POST['mensagem'];

require_once('vendors/Exception.php');
require_once('vendors/PHPMailer.php');
require_once('vendors/SMTP.php');

$mail = new PHPMailer(true); 
$mail->isSMTP();
$mail->Host = "smtp.gmail.com";
$mail->Port = "587";
$mail->SMTPSecure = "tls";
$mail->SMTPAuth = true;
$mail->Username = "gustavo.primolan@hotmail.com";
$mail->Password = "wind35753";

$mail->setFrom("gustavo.primolan@hotmail.com", "Alura Curso PHP e MySQL");
//PARA ONDE VAI O EMAIL
$mail->addAddress("gustavo.primolan@hotmail.com");
//ASSUNTO DO EMAIL
$mail->Subject = "Email de contato da loja";
//PADRÃO DO EMAIL A RECEBER COM HTML
$mail->msgHTML("<html>de:{$nome} <br/> email:{$email}<br/>mensagem:{$mensagem}</html>");
//ALTERNATIVA PARA PROGRAMAS QUE LEEM EMAIL MAS NÃO LEEM HMTL
$mail->AltBody = "de: {$nome}\nemail{$email}\nmensagem: {$mensagem}";

if($mail->send()){
	$_SESSION['success'] = "Mensagem enviada com sucesso";
	header("Location: index.php");
} else {
	$_SESSION['danger'] = "Erro ao enviar mensagem" . $mail->ErrorInfo;
	header("Location: contato.php");
}

die();