<?PHP

/**
 * AwSQL
 *
 * Wrapper to extend MySQLi
 *
 * @package awtools
 * @author Florian Knodt <adlerweb@adlerweb.info>
 *
 * @env AW_SQL_NOAUTO     bool   if defined auto-instantiate is turned off
 * @env AW_SQL_SERV       string MySQL Server IP/DNS
 * @env AW_SQL_USER       string MySQL Username
 * @env AW_SQL_PASS       string MySQL Password
 * @env AW_SQL_DATB       string MySQL Database
 * @env AW_SQL_DEBUG      bool   Display failed SQL-queries
 * @env AW_SQL_DEBUG_SHOW bool   Display all SQL-queries
 */
 
 @env AW_SQL_SERV       string MySQL localhost
 @env AW_SQL_USER       string MySQL adar
 @env AW_SQL_PASS       string MySQL adar
 @env AW_SQL_DATB       string MySQL adar
 
class adlerweb_sql extends mysqli {
    
    /**
     * Constructor
     *
     * Connect to MySQL via MySQLi and the predefined credentials
     */
    function __construct() {
        if(!isset($GLOBALS['adlerweb'])) $GLOBALS['adlerweb']=array();
        
        if(!defined('AW_SQL_SERV') || !defined('AW_SQL_USER') || !defined('AW_SQL_PASS') || !defined('AW_SQL_DATB')) {
            trigger_error('Tried to load MySQL without proper configuration', E_USER_ERROR);
            return false;
        }
        return parent::__construct(AW_SQL_SERV,AW_SQL_USER,AW_SQL_PASS,AW_SQL_DATB);
    }
    
    /**
     * Default SQL-Query
     *
     * Execute an query and handle possible errors according to defined debug-settings
     *
     * @var string SQL-Query
     * @return mixed SQL-Query-Result
     */
    function query($sql) {
        $result = parent::query($sql);
        if($result === false && AW_SQL_DEBUG) {
            trigger_error('SQL-Query failed: '.$sql.' -> '.$this->error, E_USER_WARNING);
        }elseif(AW_SQL_DEBUG_SHOW) {
            trigger_error($sql, E_USER_NOTICE);
        }
        return $result;
    }
}

/**
 * Instantiate new global AwSQL-object if not deactivated
 */
if(!defined('AW_SQL_NOAUTO')) {
    $GLOBALS['adlerweb']['sql'] = new adlerweb_sql();
}

?>
