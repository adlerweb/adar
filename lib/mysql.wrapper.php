<?php
    require_once('vendor/adlerweb/awtools/mysql.stmt.php');

    if(!defined('AW_SQL_NOAUTO')) {
        $GLOBALS['adlerweb']['sql'] = new ATK_mysql(AW_SQL_SERV,AW_SQL_USER,AW_SQL_PASS,AW_SQL_DATB);
	if(!$GLOBALS['adlerweb']['sql'] || $GLOBALS['adlerweb']['sql']->errno > 0) die('Can not access database. Check credentials (config.php) and database structure (doc/mysql.sql)');
    }
?>
