<?php

include 'conn.php';

    $id = $_POST['id'];
    $acara = $_POST['acara'];
    $tanggal = $_POST['tanggal'];
	$waktu = $_POST['waktu'];
	$tempat = $_POST['tempat'];
    $keterangan= $_POST['keterangan'];
    $tujuan_undangan = $_POST['tujuan_undangan'];
	$penanggung_jawab = $_POST['penanggung_jawab'];
	$yang_menghadiri = $_POST['yang_menghadiri'];
    $pejabat= $_POST['pejabat'];
    
    $connect->query("UPDATE jadwal SET acara='".$acara."', waktu='".$waktu."', tempat='".$tempat."', keterangan='".$keterangan."', tujuan_undangan='".$tujuan_undangan."', penanggung_jawab='".$penanggung_jawab."', yang_menghadiri='".$yang_menghadiri."', pejabat='".$pejabat."' WHERE id=".$id);


?>