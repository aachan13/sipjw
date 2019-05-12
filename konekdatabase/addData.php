<?php
	include 'conn.php';
	
    $acara = $_POST['acara'];
    $tanggal = $_POST['tanggal'];
	$waktu = $_POST['waktu'];
	$tempat = $_POST['tempat'];
    $keterangan= $_POST['keterangan'];
    $tujuan_undangan = $_POST['tujuan_undangan'];
	$penanggung_jawab = $_POST['penanggung_jawab'];
	$yang_menghadiri = $_POST['yang_menghadiri'];
	$pejabat= $_POST['pejabat'];
	
	$connect->query("INSERT INTO jadwal (tanggal,waktu,tempat,acara, tujuan_undangan,penanggung_jawab, yang_menghadiri, keterangan, pejabat) VALUES ('".$tanggal."','".$waktu."','".$tempat."','".$acara."','".$tujuan_undangan."','".$penanggung_jawab."','".$yang_menghadiri."','".$keterangan."','".$pejabat."')")
?>