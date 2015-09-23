<?php
ini_set("display_errors","Off");
function httpRequestGET($url){
$url2 = parse_url($url);
$url2["path"] = ($url2["path"] == "" ? "/" : $url2["path"]);
$url2["port"] = ($url2["port"] == "" ? 80 : $url2["port"]);
$host_ip = @gethostbyname($url2["host"]);
$fsock_timeout=20;
if(($fsock = fsockopen($host_ip, 80, $errno, $errstr, $fsock_timeout)) < 0){
return false;
}

$request = $url2["path"] . ($url2["query"] != "" ? "?" . $url2["query"] : "") . ($url2["fragment"] != "" ? "#" . $url2["fragment"] : ""); 
$in = "GET " . $request . " HTTP/1.0\r\n";
$in .= "Accept: */*\r\n";
$in .= "User-Agent: Payb-Agent\r\n";
$in .= "Host: " . $url2["host"] . "\r\n";
$in .= "Connection: Close\r\n\r\n";
if(!@fwrite($fsock, $in, strlen($in))){
fclose($fsock);
return false;
}
unset($in);

$out = ""; 
while($buff = @fgets($fsock, 2048)){
$out .= $buff;
}
fclose($fsock);
$pos = strpos($out, "\r\n\r\n");
$head = substr($out, 0, $pos);    //http head
$status = substr($head, 0, strpos($head, "\r\n"));    //http status line
$body = substr($out, $pos + 4, strlen($out) - ($pos + 4));//page body
if(preg_match("/^HTTP\/\d\.\d\s([\d]+)\s.*$/", $status, $matches)){
if(intval($matches[1]) / 100 == 2){
return $body; 
}else{
return false;
}
}else{
return false;
}
}
function httpRequestPOST($url,$post_data){
$url2 = parse_url($url);
$url2["path"] = ($url2["path"] == "" ? "/" : $url2["path"]);
$url2["port"] = ($url2["port"] == "" ? 80 : $url2["port"]);
$host_ip = @gethostbyname($url2["host"]);
$fsock_timeout=20;//秒
if(($fsock = fsockopen($host_ip, 80, $errno, $errstr, $fsock_timeout)) < 0){
	return false;
}

$request = $url2["path"] . ($url2["query"] != "" ? "?" . $url2["query"] : "") . ($url2["fragment"] != "" ? "#" . $url2["fragment"] : ""); 

$needChar = false; 

foreach($post_data as $key => $val) { 

$post_data2 .= ($needChar ? "/" : "/") . urlencode($val); 
$needChar = true;
}

$in = "POST " . $request . " HTTP/1.0\r\n";
$in .= "Accept: */*\r\n";
$in .= "Host: " . $url2["host"] . "\r\n";
$in .= "User-Agent: Lowell-Agent\r\n";
$in .= "Content-type: application/x-www-form-urlencoded\r\n";
$in .= "Content-Length: " . strlen($post_data2) . "\r\n";
$in .= "Connection: Close\r\n\r\n";
$in .= $post_data2 . "\r\n\r\n";
echo $in;

unset($post_data2); 
if(!@fwrite($fsock, $in, strlen($in))){
fclose($fsock);
return false;
}
unset($in);

$out = ""; 
while($buff = fgets($fsock, 2048)){
$out .= $buff;
}

fclose($fsock); 
$pos = strpos($out, "\r\n\r\n");
$head = substr($out, 0, $pos);    //http head
$status = substr($head, 0, strpos($head, "\r\n"));    //http status line
$body = substr($out, $pos + 4, strlen($out) - ($pos + 4));//page body
echo $body;
if(preg_match("/^HTTP\/\d\.\d\s([\d]+)\s.*$/", $status, $matches)){
if(intval($matches[1]) / 100 == 2){
return $body;
}else{
return false;
}
}else{
return false;
}
}

$post_data = array("1"=>"13911111111","2"=>"123","3"=>"234");   
//httpRequestPOST("http://112.74.18.72/wgmSrv/Service1.svc/userRegisterJson/13911111112/123/234",$post_data);  
//httpRequestPOST("http://112.74.18.72/wgmSrv/Service1.svc/userRegisterCompleteJson/316/kate/Mircosoft/SHANXI/XiAN/WULUKOU/RAD/ENG/12@126.com/fangyuanroad/2",$post_data);  
//httpRequestPOST("http://112.74.18.72/wgmSrv/Service1.svc/userLoginJson/1391111111/asd",$post_data);  
//httpRequestPOST("http://112.74.18.72/wgmSrv/Service1.svc/getUserInfoJson/13",$post_data);  

//httpRequestPOST("http://112.74.18.72/wgmSrv/Service1.svc/setUserInfoJson/316/Mircosoft/SHANXI/XiAN/WULUKOU/RAD/ENG/12@126.com/suzhouroad",$post_data);  
//httpRequestPOST("http://112.74.18.72/wgmSrv/Service1.svc/setUserPasswordJson/112/asd/xcv",$post_data);  
//httpRequestPOST("http://112.74.18.72/wgmSrv/Service1.svc/getUserEquipmentListJson/1391/1/10/ss",$post_data);  
//httpRequestPOST("http://112.74.18.72/wgmSrv/Service1.svc/getUserRepairListJson/12/1/10",$post_data);  
//httpRequestPOST("http://112.74.18.72/wgmSrv/Service1.svc/getUserRepairInfoJson/12/1",$post_data);  
//httpRequestPOST("http://112.74.18.72/wgmSrv/Service1.svc/setVisitJson/1/abc/1/eng/1391111111/20150911/ssss/20121111",$post_data);  
//httpRequestPOST("http://112.74.18.72/wgmSrv/Service1.svc/getVisitListJson/1/1/1",$post_data);  
//httpRequestPOST("http://112.74.18.72/wgmSrv/Service1.svc/setFeedbackJson/1/1/1/1",$post_data);  
//httpRequestPOST("http://112.74.18.72/wgmSrv/Service1.svc/getMachineStatusListJson/11/2/10",$post_data);  
httpRequestPOST("http://112.74.18.72/wgmSrv/Service1.svc/setFeedback/11/2/10/1",$post_data);  
?>