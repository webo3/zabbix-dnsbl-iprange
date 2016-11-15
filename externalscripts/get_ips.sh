#!/usr/bin/php
<?php

$networks = array();

switch($argv[1]) {

	// Created HOSTNAME
	case 'MYHOST-ip-dnsbl' :
		$networks = array(
			'1.2.3.4/32',
			'4.3.2.1/27'
		);
		break;

	case 'MYHOST2-ip-dnsbl' :
		$networks = array(
			'1.2.3.4/32',
			'4.3.2.1/27'
		);
		break;
}

$response = array('data' => array());

function getIpRang($cidr) {

	list($ip, $mask) = explode('/', $cidr);

	$maskBinStr =str_repeat("1", $mask) . str_repeat("0", 32-$mask);
	$inverseMaskBinStr = str_repeat("0", $mask ) . str_repeat("1",  32-$mask);

	$ipLong = ip2long($ip);

	$ipMaskLong = bindec( $maskBinStr );
	$inverseIpMaskLong = bindec( $inverseMaskBinStr );
	$netWork = $ipLong & $ipMaskLong;

	$start = $netWork;
	$end = ($netWork | $inverseIpMaskLong);
	return array($start, $end);
}


foreach($networks as $cidr) {
	list($start, $end) = getIpRang($cidr);

	for($i = $start; $i <= $end; $i++) {
		$ip = long2ip($i);
		$last = strrchr($ip, '.');
		if($last !== '.0' && $last != '.255') {
			$response['data'][] = array(
				'{#NETIP}' => long2ip($i)
			);
		}
	}

}

echo json_encode($response, JSON_PRETTY_PRINT);
