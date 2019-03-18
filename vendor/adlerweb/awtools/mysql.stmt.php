<?php
    /**
     * Adlerweb Toolkit - MySQL/MariaDB wrapper
     *
     * @package awtools
     * @category database
     * @author Florian Knodt <adlerweb@adlerweb.info>
     * @copyright 2003-2014 Florian "adlerweb" Knodt <adlerweb@adlerweb.info>
     * @version 0.2.2
     *
     * MySQL/MariaDB wrapper including extensive helper functions to simplify
     * usage of prepared statements
     */

  /**
     * @var mysqli_object MySQLi-connection
     */
    private $sql;

    /**
     * @var int Last MySQL error number
     */
    public $errno = 0;

    /*
     * @var bool|int false=off, >0 = on
     * false = report only stripped errors
     * 1     = report full SQL string on errors
     * 2     = report full SQL string and attributes on errors
     * 3     = report all SQL strings
     * 4     = report all SQL strings and attributes
     **/
    public $debug = false;

    public function __construct($serv, $user, $pass, $datb) {
        $this->sql = new mysqli("localhost", "root", "", "adar");
        $this->errno = $this->sql->connect_errno;
    }

    /**
     * Execute query as prepared statement
     *
     * @var string SQL-query - ? as placeholder for variables
     * @var string string of argument types. 1 character per argument.
     *      i corresponding variable has type integer
     *      d corresponding variable has type double
     *      s corresponding variable has type string
     *      b corresponding variable is a blob and will be sent in packets
     * @var string|array variable(s)
     *      array containing intended variables
     *      number of elements must match character count in argument type list
     *      if only one argument is used it may be supplied as string

     * @return bool|int|array returned data
     *         returns false if an error occours
     *         returns number of affected rows as integer for UPDATE/DELETE queries
     *         returns inserted ID as integer for INSERT queries
     *         returns array of matching data for SELECT queries.
     *                 contains one associated array per result line
     *
     * @note Since all results are loaded into RAM this function should not be
     *       used for queries that are supposed to return massive datasets
     *
     * @see http://www.moyablog.com/2012/01/20/wrapper-php-classes-for-prepared-statements-queries/
     **/
    public function querystmt($sql, $argtypes, $args) {
        if(strlen($argtypes) <1) {
            $msg = '[SQL] Argument types missing';
            if($this->debug >= 1) $msg .= ' - >>'.$sql.'<<"';
            if($this->debug >= 2) $msg .= ' - >>'.print_r($argtypes, true).'<< - >>'.print_r($args, true).'<<"';
            trigger_error($msg, E_USER_ERROR);
            return false;
        }
  if(strlen($argtypes) != count($args)) {
            $msg = '[SQL] Argument count mismatch';
            if($this->debug >= 1) $msg .= ' - >>'.$sql.'<<"';
            if($this->debug >= 2) $msg .= ' - >>'.print_r($argtypes, true).'<< - >>'.print_r($args, true).'<<"';
            trigger_error($msg, E_USER_ERROR);
            return false;
        }
        $msg='';
        if($this->debug >= 3) $msg .= '[SQL] >>'.$sql.'<<"';
        if($this->debug >= 4) $msg .= ' - >>'.print_r($argtypes, true).'<< - >>'.print_r($args, true).'<<"';
        if($msg != '') trigger_error($msg, E_USER_NOTICE);


        $type = strtoupper(strstr(trim($sql), ' ', true));


        $stmt = $this->sql->stmt_init();
        if(!$stmt->prepare($sql)) {
            $msg = $stmt->error;
            if($this->debug >= 1) $msg .= ' - >>'.$sql.'<<"';
            if($this->debug >= 2) $msg .= ' - >>'.print_r($argtypes, true).'<< - >>'.print_r($args, true).'<<"';
            trigger_error($msg, E_USER_ERROR);
        }
        call_user_func_array(array($stmt, "bind_param"), $this->util_refValues(array_merge((array)$argtypes, $args)));

        if(!$stmt->execute()) {
            $msg = $stmt->error;
            if($this->debug >= 1) $msg .= ' - >>'.$sql.'<<"';
            if($this->debug >= 2) $msg .= ' - >>'.print_r($argtypes, true).'<< - >>'.print_r($args, true).'<<"';
            trigger_error($msg, E_USER_ERROR);
        }


        if($type == 'INSERT') return $stmt->insert_id;
        if($type == 'UPDATE') return $stmt->affected_rows;
        if($type == 'DELETE') return $stmt->affected_rows;

        $meta = $stmt->result_metadata();
        while ($metaArray = $meta->fetch_field()) {
            $parameters[] = &$row[$metaArray->name];
        }
        call_user_func_array(array($stmt, 'bind_result'), $parameters);

        $items = array();
        while ($stmt->fetch()) {
            foreach($row as $key => $value) {
                $copy[$key] = $value;
            }
            $items[] = $copy;
        }

        if(count($items) == 0) return false;

        return $items;
    }



    /**
     * Execute SELECT query as prepared statement and return a single element
     *
     * @var string SQL-query - ? as placeholder for variables
     * @var string string of argument types. 1 character per argument.
     *      i corresponding variable has type integer
     *      d corresponding variable has type double
     *      s corresponding variable has type string
     *      b corresponding variable is a blob and will be sent in packets
     * @var string|array variable(s)
     *      array containing intended variables
     *      number of elements must match character count in argument type list
     *      if only one argument is used it may be supplied as string
     * @var string return only this field (optional)
     *
     * @return bool|int|array returned data
     *         returns false if an error occours
     *         returns number of affected rows as integer for UPDATE/DELETE queries
     *         returns inserted ID as integer for INSERT queries
     *         returns associated array of the first result line
     *         returns string when a single field was requested
     *
     * @note Since all results are loaded into RAM this function should not be
     *       used for queries that are supposed to return massive datasets. Use
     *       LIMIT 1; whenever possible.
     *
     **/
    function querystmt_single($sql, $argtypes, $args, $field=false) {
        $res = $this->querystmt($sql, $argtypes, $args);


        if(!is_array($res)) return $res;
        if(!$field) return $res[0];

        if(!isset($res[0][$field])) return false;

        return $res[0][$field];
    }


    /**
     * Execute query as standard SQL query
     *
     * Extends original method to conform to this class' error methology
     *
     * @var string SQL-query
     * @return bool|mysqli_result returned data
     *         returns false if an error occours
     *         returns mysqli_result on success
     **/
    public function query($sql) {
        $ret = $this->sql->query($sql);
        if(!$ret) {
            $msg = '[SQL] SQL query error';
            if($this->debug >= 1) $msg .= ' - >>'.$sql.'<<"';
            trigger_error($msg, E_USER_ERROR);
            return false;
        }
        return $ret;
    }



    /**
     * Execute standard SELECT query and return a single element
     *
     * @var string SQL-query - ? as placeholder for variables
     * @var string return only this field (optional)
     * @return bool|array|string returned data
     *         returns false if an error occours
     *         returns associated array of the first result line on success
     *         returns string when a single field was requested
     *
     * @note Use LIMIT 1; whenever possible.
     *
     **/
    function query_single($sql, $field=false) {
        $res = $this->query($sql);
        if(!$res) return false;

   /**
     * Check if a dataset exists
     *
     * Check if a row with the named fields exists in the database.
     *
     * @var string SQL-Table to check
     * @var sting|array Fieldnames to check
     *      All keys should offer an index for performance reasons.
     *      if only one key is used it may be supplied as string
     * @var string string of argument types. 1 character per argument.
     *      i corresponding variable has type integer
     *      d corresponding variable has type double
     *      s corresponding variable has type string
     *      b corresponding variable is a blob and will be sent in packets
     * @var string|array variable(s)
     *      array containing intended variables
     *      number of elements must match character count in argument type list
     *      if only one argument is used it may be supplied as string
     * @return bool|int returned data
     *      returns false if an error occours
     *      returns number of rows as integer if no error occours
     */
    public function querystmt_exists($table, $fields, $argtypes, $args) {
        if(!is_array($fields)) {
            $fields = array($fields);
        }

   /**
     * Update or Insert a dataset
     *
     * Checks if a row with the named fields exists in the database. If no row
     * is found the function will INSERT one as specified, otherwise a UPDATE
     * is issued. SQL-statements are used here.
     *
     * @var string SQL-Table to check
     * @var sting|array Fieldnames to insert or update
     *      if only one key is used it may be supplied as string
     * @var string string of argument types. 1 character per argument.
     *      i corresponding variable has type integer
     *      d corresponding variable has type double
     *      s corresponding variable has type string
     *      b corresponding variable is a blob and will be sent in packets
     * @var string|array variable(s)
     *      array containing intended variables
     *      number of elements must match character count in argument type list
     *      if only one argument is used it may be supplied as string
     * @var string|array key names to determinate a duplicate (optional)
     *      This should match at least the tables PRIMARY KEY. All keys should
     *      offer an index for performance reasons. There is no code to check
     *      for invalid duplicates here. The keys given here must be mentioned
     *      in Fieldnames. If only one argument is used it may be supplied as
     *      string. If no argument is given all fieldnames are checked

     *

     * @return bool|int returned data
     *         returns false if an error occours
     *         returns number of affected rows (=1) as integer for UPDATEs
     *         returns inserted ID as integer for INSERT queries
     */
    public function querystmt_update($table, $fields, $argtypes, $args, $index=false) {
        if(!is_array($fields)) {
            $fields = array($fields);
        }

        if(!is_array($args)) {
            $args = array($args);
        }

        if($index === false) {
            $index = $fields;
        }else if(!is_array($index)) {
            $index = array($index);
        }        foreach($index as $index_temp) {
            $fi = array_search($index_temp, $fields);
            if($fi === false) {
                $msg='';
                if($this->debug >= 3) $msg .= '[SQL] Update-query unsuccessful - could not find key in fieldlist!';
                if($this->debug >= 4) $msg .= ' - >>'.$index_temp.'<< - >>'.print_r($fields, true).'<<"';
                if($msg != '') trigger_error($msg, E_USER_WARNING);
            }else{
                $index_clean_fields[] = $index_temp;
                $index_clean_argtype .= $argtypes{$fi};
                $index_clean_args[] = $args[$fi];
            }
        }


        if(count($index_clean_fields) == 0) {
            $msg='';
            if($this->debug >= 3) $msg .= '[SQL] Update-query unsuccessful - not enough keys to compare!';
            if($this->debug >= 4) $msg .= ' - >>'.$index_temp.'<< - >>'.print_r($fields, true).'<<"';
            if($msg != '') trigger_error($msg, E_USER_WARNING);
            return false;
        }

          return $this->querystmt(
                                    'INSERT INTO `'.$table.'`
                                    (`'.implode('`, `', $fieldstr).'`)
                                    VALUES
                                    (?'.str_repeat(', ?', (count($args)-1)).')
                                    ;',
                                    $argtypes,
                                    $args
                                );
        }else{
            //update

            $updatestr = array();
            for($i=0; $i<count($fieldstr); $i++) {
                $updatestr[] = $fieldstr[$i].' = ?';
            }


            $field_query = array();
            foreach($index_clean_fields as $index_clean_field) {
                $field_query[] = '`'.$this->sql->real_escape_string($index_clean_field).'` = ?';
            }


            return $this->querystmt(
                                    'UPDATE `'.$table.'`
                                    SET
                                        '.implode(', ', $updatestr).'
                                    WHERE
                                        '.implode(' AND ', $field_query).'
                                    LIMIT 1;',
                                    $argtypes.$index_clean_argtype,
                                    array_merge($args, $index_clean_args)
                                );
        }

    }

}



?>
