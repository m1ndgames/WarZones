if (!isServer) exitWith {};

//null abstraction
#define _undefined objNull

#define isARRAY(x) \
(not(isNil {x}) && {typeName (x) == typeName []})

#define isSTRING(x) \
(not(isNil {x}) && {typeName (x) == typeName ""})

#define isSCALAR(x) \
(not(isNil {x}) && {typeName (x) == typeName 0})

#define isBOOLEAN(x) \
(not(isNil {x}) && {typeName (x) == typeName true})

#define isOBJECT(x) \
(not(isNil {x}) && {typeName (x) == typeName objNull})

#define isCODE(x) \
(not(isNil {x}) && {typeName (x) == typeName {}})

#define isNullable(x) (false ||{ \
  not(isNil {x}) &&{ \
  private["_t"]; \
  _t = typeName (x); \
  _t == typeName controlNull ||{ \
  _t == typeName displayNull ||{ \
  _t == typeName locationNull ||{ \
  _t == typeName taskNull ||{ \
  _t == typeName grpNull ||{ \
  _t == typeName objNull \
  }}}}}}})

//safer version of isNull that will not crap out when passed number, array, code, string
#define _isNull(x) (isNil {x} || ({isNullable(x) && {isNull x}}))
#define undefined(x) _isNull(x)
#define defined(x) (not(undefined(x)))

#define getIf(cond,v1,v2) \
(if (cond) then {v1} else {v2})

#define getUnless(cond,v1,v2) \
getIf(not(cond),v1,v2)


#define OR(x,y) \
getIf(defined(x),x,y)

#define AND(x,y) \
OR(v,y)

#define def(x) \
private[#x]

#define init(x,v) def(x); \
x = v

#define setIf(cond,x,v1,v2) \
x = if (cond) then {v1} else {v2}

#define assignIf setIf

#define setUnless(cond,x,v1,v2) \
x = if (cond) then {v2} else {v1}


#define assignUnless setUnless

#define initIf(cond,x,v1,v2) \
def(x); \
setIf(cond,x,v1,v2)

#define initUnless(cond,x,v1,v2) \
def(x); \
setUnless(cond,x,v1,v2)


//Assign argument at index o to variable v if it's of type t, else default to d
#define ARGV4(o,v,t,d) \
private[#v]; \
if (undefined(_this) ||{ \
   typeName _this != typeName [] ||{ \
   o >= (count _this) ||{ \
   v = _this select o; undefined(v) ||{ \
   (#t != "nil" && {typeName v != typeName t}) \
   }}}}) then { \
  v = d; \
};

//Assign argument at index o, to variable v if it's of type t, else default to nil
#define ARGV3(o,v,t) ARGV4(o,v,t,nil)

//Assign argument at index o to variable v, else default to nil
#define ARGV2(o,v) ARGV3(o,v,nil)


//Assign argument at index o to variable v if it's of type t, else exit with d
#define ARGVX4(o,v,t,d) \
private[#v]; \
if (undefined(_this) ||{ \
   typeName _this != typeName [] ||{ \
   o >= (count _this) ||{ \
   v = _this select o; undefined(v) ||{ \
   (#t != "nil" && {typeName v != typeName t}) \
   }}}}) exitWith { \
  d \
};

//Assign argument at index o, to variable v if it's of type t, else exit with nil
#define ARGVX3(o,v,t) ARGVX4(o,v,t,nil)

//Assign argument at index o to variable v, else exit with nil
#define ARGVX2(o,v) ARGVX3(o,v,nil)

#define DO if (true) then

#define xGet(x,o) (if (o >= count(x)) then {nil} else {x select o})
#define xSet(x,o,v) (x set [o, OR(v,nil)])
#define xPush(x,v) (xSet(x,count(x),v))
#define xPushIf(cond,x,v) if (cond) then {xPush(x,v);}
#define xPushUnless(cond,x,v) xPushIf(not(cond),x,v)

#define isClient not(isServer) || {isServer && not(isDedicated)}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

diag_log format["loading log library ..."];

//Log levels (from highest to lowest)
LOG_SEVERE_LEVEL=6;
LOG_WARNING_LEVEL=5;
LOG_INFO_LEVEL=4;
LOG_CONFIG_LEVEL=3;
LOG_FINE_LEVEL=2;
LOG_FINER_LEVEL=1;
LOG_FINEST_LEVEL=0;

//Default system-wide log level
SYS_LOG_LEVEL = LOG_SEVERE_LEVEL;

/**
* Sets the logging level for a component
*
* @param _component_name (String) - Name of the component
* @param _component_level (int) - Logging level for the component
*
* @return
* On success, returns the logging level that was just set
* On failure, returns nil
*/
log_set_level = {
  if (isNil "_this") exitWith {};
  if (typeName _this != typeName []) exitWith {};
  if (count _this < 2) exitWith {};

  private["_component_name"];
  _component_name = _this select 0;
  _component_level = _this select 1;

  if (isNil "_component_name" || {typeName _component_name != typeName ""}) exitWith {};
  if (isNil "_component_level" || {typeName _component_level != typeName 0}) exitWith {};

  missionNamespace setVariable [format["%1_LOG_LEVEL", _component_name], _component_level];

  _component_level
};

/**
* Gets the logging level of a component
*
* @param _component_name (String) - Name of the component
*
* @return
* On success returns the logging level of the specified component.
* On failure, if the specified component does not exist, it returns the system wide log-level
*/
log_get_level = {
  private["_component_name"];
  if (isNil "_this") exitWith {SYS_LOG_LEVEL};
  _component_name = _this;
  if (typeName _component_name != typeName "") exitWith {SYS_LOG_LEVEL};

  private["_component_level"];
  _component_level = missionNamespace getVariable [format["%1_LOG_LEVEL", toUpper(_component_name)], SYS_LOG_LEVEL];
  _component_level
};


/**
* Converts a logging level value to string
*
* @param _level (String) - The logging level value to convert
*
* @return
* On success, returns the string for the specified logging @{code _level}
* On failure, returns empty string.
*
*/
log_get_level_name = {
  private["_level"];
  if (isNil "_this") exitWith {""};
  if (typeName _this != typeName 0) exitWith {""};

  private["_level"];
  _level = _this;

  if (_level == LOG_SEVERE_LEVEL) exitWith {"severe"};
  if (_level == LOG_WARNING_LEVEL) exitWith {"warning"};
  if (_level == LOG_INFO_LEVEL) exitWith {"info"};
  if (_level == LOG_CONFIG_LEVEL) exitWith {"config"};
  if (_level == LOG_FINE_LEVEL) exitWith {"fine"};
  if (_level == LOG_FINER_LEVEL) exitWith {"finer"};
  if (_level == LOG_FINEST_LEVEL) exitWith {"finest"};

  ""
};

/**
* Prints a logging string to the game's RPT file
*
* @param _level (int) - Logging level at which to log the message
* @param _component (String) - Name of the component that is logging the message
* @param _message (String) - Message to print in the RPT file
*/
log_rpt = {
  private["_level", "_component", "_message"];
  if (isNil "_this") exitWith {};
  if (count _this < 3) exitWith {};

  _level = _this select 0;
  _component = _this select 1;
  _message = _this select 2;

  if (isNil "_level" || {typeName _level != typeName 0}) exitWith {};
  if (isNil "_component" || {typeName _message != typeName ""}) exitWith {};
  if (isNil "_message" || {typeName _message != typeName ""}) exitWith {};

  private["_component_level"];
  _component_level = _component call log_get_level;
  if (_level < _component_level) exitWith {};

  private["_level_str"];
  _level_str = _level call log_get_level_name;

  diag_log (_component + ": " + _level_str + ": " + _message);
};


/**
* Prints a logging message at SEVERE level for the specified component
* @param _component_name (String) - Name of the component that is logging the message
* @param _message (String) - Message to be logged
*/
log_severe = {
  ([LOG_SEVERE_LEVEL] + _this) call log_rpt
};

/**
* Prints a logging message at WARNING level for the specified component
* @param _component_name (String) - Name of the component that is logging the message
* @param _message (String) - Message to be logged
*/
log_warning = {
  ([LOG_WARNING_LEVEL] + _this) call log_rpt
};

/**
* Prints a logging message at INFO level for the specified component
* @param _component_name (String) - Name of the component that is logging the message
* @param _message (String) - Message to be logged
*/
log_info = {
  ([LOG_INFO_LEVEL] + _this) call log_rpt
};

/**
* Prints a logging message at CONFIG level for the specified component
* @param _component_name (String) - Name of the component that is logging the message
* @param _message (String) - Message to be logged
*/
log_config = {
  ([LOG_CONFIG_LEVEL] + _this) call log_rpt
};

/**
* Prints a logging message at FINE level for the specified component
* @param _component_name (String) - Name of the component that is logging the message
* @param _message (String) - Message to be logged
*/
log_fine = {
  ([LOG_FINE_LEVEL] + _this) call log_rpt
};

/**
* Prints a logging message at FINER level for the specified component
* @param _component_name (String) - Name of the component that is logging the message
* @param _message (String) - Message to be logged
*/
log_finer = {
  ([LOG_FINER_LEVEL] + _this) call log_rpt
};

/**
* Prints a logging message at FINEST level for the specified component
* @param _component_name (String) - Name of the component that is logging the message
* @param _message (String) - Message to be logged
*/
log_finest = {
  ([LOG_FINEST_LEVEL] + _this) call log_rpt
};


diag_log format["loading log library complete"];

//////////////////////////////////////////////////////////////////////////////////////////////////////

diag_log format["loading sock library ..."];

//Some wrappers for logging
sock_log_severe = {
  ["sock", _this] call log_severe;
};

sock_log_info = {
  ["sock", _this] call log_info;
};

sock_log_fine = {
  ["sock", _this] call log_fine;
};

sock_log_finer = {
  ["sock", _this] call log_finer;
};

sock_log_finest = {
  ["sock", _this] call log_finest;
};


sock_log_set_level = {
  ["sock", _this] call log_set_level;
};


//Set default logging level for this component
LOG_INFO_LEVEL call sock_log_set_level;



sock_raw = {
  _this = _this select 0;

  private["_stack","_holder"];
  _holder = [];
  _stack = [[0,_holder,_this]]; //seed the stack

  while {count(_stack) > 0} do {
    private["_current","_parent","_index", "_params"];
    _params = _stack deleteAt (count(_stack)-1);
    _index = _params select 0;
    _parent = _params select 1;
    _current = _params select 2;

    private["_clone"];
    _clone = [];

    {
      if (isNil "_x") then {
        _clone pushBack {nil};
      }
      else {private["_type"]; _type = typeName _x; if( _type == "STRING") then {
        _clone pushBack ([toArray _x,{}]);
      }
      else { if(_type == "SCALAR" || {_type == "BOOL"}) then {
        _clone pushBack _x;
      }
      else { if(_type == "CODE") then {
        _clone pushBack {};
      }
      else { if (_type == "ARRAY") then {
        _stack pushBack [_forEachIndex,_clone,_x];
      }
      else {
        _clone pushBack {nil};
      };};};};};
    } forEach _current;

    _parent set [_index, _clone];

  };

  ("RAW:" + str(_holder select 0))
};


/**
* This function is used for creating JSON hash/object from an array with a set of key-value pairs
*
* @param _key_value_pairs (Array type) - An array containing key-value pairs e.g. [["key1", "val1"], ...]
* @return
*
* Returns the hash representation.
*/
sock_hash = {
  ([{},OR(_this,nil)])
};

/**
* This function talks directly to the sock.dll extension using the SOCK-SQF protocol.
*
* @param _request (String type) - This is the actual text to be sent to the remote side.
* @return
*
* On success, returns the reponse string that was sent by the remote side
* On failure, returns nil
*/
sock_get_response = {
  if (isNil "_this") exitWith {};
  format["%1 call sock_get_response;", _this] call sock_log_finest;

  if (typeName _this != typeName "") exitWith {};


  init(_request,_this);
  init(_extension,"sock");

  //("sock_get_response: _request=" + _request) call sock_log_fine;

  def(_response_info);
  _response_info = call compile (_extension callExtension _request);

  if (undefined(_response_info)) exitWith {
    (format["protocol error: Was expecting response of typeName of %1, but got %2", (typeName []), "nil"]) call sock_log_severe;
    nil
  };


  if (isSTRING(_response_info)) exitWith {
    ("error: " + _response_info) call sock_log_severe;
    nil
  };

  if (not(isARRAY(_response_info))) exitWith {
   (format["protocol error: Was expecting response of typeName of %1, but got %2", (typeName []), typeName _response_info]) call sock_log_severe;
   nil
  };

  init(_chunks,_response_info);
  init(_chunk_count,count(_chunks));

  init(_i,0);
  init(_response,"");

  //retrieve all the response chunks, and concatenate them
  while {_i < _chunk_count } do {
    init(_address,xGet(_chunks,_i));
    def(_data);
    _data = _extension callExtension (_address);
     _response = _response + _data;
     _i = _i + 1;
  };

  format["sock_get_response: _response = %1",  OR(_response,"nil")] call sock_log_finest;
  OR(_response,nil)
};


/**
* This function sends a JSON-RPC request using the sock.dll/sock.so extension.
*
* @param _method (String type) - This is the name of the remote method to be invoked
* @param _params (Array type) - This is an array of arguments to be passed in, when invoking {@code _method}
* @param default (Any type) - This is the value to return if there is an error
* @return
*
* On success, returns the response from the RPC server
* On failure, returns the value of the {@code _default} argument, or nil if {@code _default} was not specified.
*/
sock_rpc = {
  if (isNil "_this") exitWith {nil};
  format["%1 call sock_rpc;", _this] call sock_log_finest;

  if (not(isServer)) exitWith {
    (_this call sock_rpc_remote)
  };

  (_this call sock_rpc_local)
};


sock_rpc_remote = {
  if (isNil "_this") exitWith {nil};
  format["%1 call sock_rpc_remote;", _this] call sock_log_finest;

  init(_request,_this);

  if (not(isClient)) exitWith {nil};

  def(_var_name);
  _var_name = format["sock_rpc_remote_response_%1",ceil(random 10000)];
  missionNamespace setVariable [_var_name, nil];
  missionNamespace setVariable [sock_rpc_remote_request_name, [player, _var_name, _request]];
  publicVariableServer sock_rpc_remote_request_name;


  def(_response);
  init(_end_time, time + 60);
  while {true} do {
    _response = missionNamespace getVariable [_var_name, nil];
    if (!isNil "_response") exitWith {};
    if (time > _end_time) exitWith {};
    sleep 0.01;
  };
  missionNamespace setVariable [_var_name, nil];

  if (undefined(_response)) exitWith {
    format["timeout occurred while waiting for response of %1", _var_name] call sock_log_severe;
    nil
  };

  if (not(isARRAY(_response))) exitWith {
    format["protocol error, expected response to be of type %1", typeName []] call sock_log_severe;
    nil
  };

  if (count(_response) == 0) exitWith {
    format["protocol error, expected response to have at least one element"] call sock_log_severe;
    nil
  };

  (_response select 0)
};




sock_rpc_remote_request_listener = {
  if (isNil "_this") exitWith {nil};
  format["%1 call sock_rpc_remote_request_listener;", _this] call sock_log_finest;

  private["_variable", "_request"];

  ARGV3(0,_variable,"");
  ARGV3(1,_request,[]);

  if (undefined(_variable) || {undefined(_request)}) exitWith {nil};

  _this = _request;
  ARGVX3(0,_client,objNull);
  ARGVX3(1,_var_name,"");
  ARGVX3(2,_args,[]);

  private["_response"];
  _response = _args call sock_rpc_local;
  _response = [OR(_response,nil)];

  private["_client_id"];
  _client_id = owner _client;

  missionNamespace setVariable [_var_name, _response];
  format["sock_rpc_remote_request_listener: client_id: %1", _client_id] call sock_log_finest;
  format["sock_rpc_remote_request_listener: response: %1", _response] call sock_log_finest;
  _client_id publicVariableClient _var_name;
  missionNamespace setVariable [_var_name, nil];
};



sock_rpc_local = {
  if (isNil "_this") exitWith {nil};
  format["%1 call sock_rpc_local;", _this] call sock_log_finest;

  ARGV3(0,_method,"");
  ARGV3(1,_params,[]);
  ARGV2(2,_default)

  if (undefined(_method)) exitWith {nil};

  private["_raw_rpc"];
  _raw_rpc = [([["method",_method],["params",OR(_params,[])]] call sock_hash)] call sock_raw;

  private["_result_container"];
  _result_container = call compile(_raw_rpc call sock_get_response);

  if (isNil "_result_container") exitWith {
    (format["protocol error: Was expecting response of typeName of %1, but got %2", (typeName []), "nil"]) call sock_log_severe;
    if (isNil "_default") exitWith {nil};
    OR(_default,nil)
  };

  if (typeName _result_container != typeName []) exitWith {
    (format["protocol error: Was expecting response of typeName of %1, but got %2", (typeName []), (typeName _result_container)]) call sock_log_severe;
    if (isNil "_default") exitWith {nil};
    OR(_default,nil)
  };

  if (count _result_container < 2) exitWith {
    (format["protocol error: Was expecting response count of %1, but got %2 ", 2, count(_result_container)]) call sock_log_severe;
    if (isNil "_default") exitWith {nil};
    OR(_default,nil)
  };

  private["_error", "_result"];
  _this = _result_container;
  ARGV3(0,_error,false);
  ARGV2(1,_result);

  //success case
  if (not(_error)) exitWith {
    OR(_result,nil)
  };

  //error cases
  if (typeName _result != typeName "") exitWith {
    (format["protocol error: Was expecting error response of typeName %1, but got %2", (typeName ""), (typeName _result)]) call sock_log_severe;
    if (isNil "_default") exitWith {nil};
    OR(_default,nil)
  };

  (format["remote error: %1", _result]) call sock_log_severe;
  OR(_default,nil)
};




sock_init = {
  init(_flag_name, "sock_init_complete");

  sock_rpc_remote_request_name = "sock_rpc_remote_request";
  //Server-side init
  if (isServer) then {
    sock_rpc_remote_request_name addPublicVariableEventHandler { _this call sock_rpc_remote_request_listener;};

    //tell clients that server pstats has initialized
    missionNamespace setVariable[_flag_name, true];
    publicVariable _flag_name;
    "sock_rpc library loaded on server ..." call sock_log_info;
  };

  //Client-side init (must wait for server-side init to complete)
  if (isClient) then {
    "waiting for server to load sock_rpc library ..." call sock_log_info;
    waitUntil {not(isNil _flag_name)};
    "waiting for server to load sock_rpc library ... done" call sock_log_info;
  };
};


[] call sock_init;

diag_log format["loading sock library complete"];

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

diag_log format["loading stats library ..."];

//Some wrappers for logging
stats_log_severe = {
  ["stats", _this] call log_severe;
};

stats_log_warning = {
  ["stats", _this] call log_warning;
};

stats_log_info = {
  ["stats", _this] call log_info;
};

stats_log_fine = {
  ["stats", _this] call log_fine;
};

stats_log_finer = {
  ["stats", _this] call log_finer;
};

stats_log_finest = {
  ["stats", _this] call log_finest;
};

stats_log_set_level = {
  ["stats", _this] call log_set_level;
};


//Set default logging level for this component
LOG_INFO_LEVEL call stats_log_set_level;


stats_build_params = {
  if (isNil "_this") exitWith {};
  format["%1 stats_build_params;", _this] call stats_log_finest;

  ARGV3(0,_scope,"");
  ARGV2(1,_key_or_pairs);
  ARGV2(2,_default);


  if (undefined(_scope)) exitWith {nil};

  init(_params,[]);
  xPush(_params,_scope);


  //get(scope)
  if (undefined(_key_or_pairs)) exitWith {
    (_params)
  };

  if (not(isARRAY(_key_or_pairs) || {isSTRING(_key_or_pairs)})) exitWith {nil};

  //get(scope, pair,...)
  if (isARRAY(_key_or_pairs)) exitWith {
    init(_i,1);
    init(_count,count(_this));
    for [{}, {_i < _count}, {_i = _i + 1}] do { DO {
      ARGV3(_i,_pair,[]);
      if (undefined(_pair) || {count(_pair) == 0}) exitWith {};
      if (!isSTRING(xGet(_pair,0))) exitWith {};

      xPushIf(count(_pair) == 1,_pair,nil);
      xPush(_params,_pair);
    };};

    (_params)
  };

  //get(scope, key, default)
  xPush(_params,_key_or_pairs);
  xPush(_params,_default);

  (_params)
};


/**
* This function sets the given {@code _key}, and {@code _value} within the specified {@code _scope}
*
* e.g.
*
*   //set the value for "key1" in "scope1"
*   ["scope1", "key1", "value1"] call stats_set;
*
* @param {String} _scope  Name of the scope to use
* @param {String} _key Name of the key to set
* @param {*} _value Value to set
*
* @returns {boolean}  true on success, false on failure
*/


/**
 * This function sets one or more key-value {@code _pair}s within the specified {@code _scope}
 *
 * e.g.
 *
 *   //set values for "key1", and "key2" in "scope1"
 *   ["scope1", ["key1", "value1"], ["key2", "value2"])] call stats_set;
 *
 *
 * @param {String} _scope Name of the scope to use
 * @param {...Array} _pair  Key-value pair
 * @param {String} _pair[0] Name of the key
 * @param {*} _pair[1] Value for the key
 *
 * @returns true on success, false on failure
 *
 */

stats_set = {
  (["set", _this] call stats_write)
};


/**
* This function pushes the given {@code _value} to the end of the array at {@code _key}, and within the specified {@code _scope}
*
* e.g.
*
*   //push the value into the array at "key1" within "scope1"
*   ["scope1", "key1", "value1"] call stats_push;
*
* @param {String} _scope  Name of the scope to use
* @param {String} _key Name of the key to push into
* @param {*} _value Value to push
*
* @returns {boolean}  true on success, false on failure
*/


/**
 * This function pushes one or more values into the specified keys within the given {@code _scope}
 *
 * e.g.
 *
 *   //push values into arrays at "key1", and "key2" within "scope1"
 *   ["scope1", ["key1", "value1"], ["key2", "value2"]] call stats_push;
 *
 *
 * @param {String} _scope Name of the scope to use
 * @param {...Array} _pair  Key-value pair
 * @param {String} _pair[0] Name of the key to push into
 * @param {*} _pair[1] Value to push
 *
 * @returns true on success, false on failure
 *
 */
stats_push = {
  (["push", _this] call stats_write)
};

/**
* This function unshifts the given {@code _value} to the begining of the array at {@code _key}, and within the specified {@code _scope}
*
* e.g.
*
*   //unshift the value into the array at "key1" within "scope1"
*   ["scope1", "key1", "value1"] call stats_unshift;
*
* @param {String} _scope  Name of the scope to use
* @param {String} _key Name of the key to unshift into
* @param {*} _value Value to unshift
*
* @returns {boolean}  true on success, false on failure
*/


/**
 * This function unshifts one or more values into the specified keys within the given {@code _scope}
 *
 * e.g.
 *
 *   //unshift values into arrays at "key1", and "key2" within "scope1"
 *   ["scope1", ["key1", "value1"], ["key2", "value2"]] call stats_unshift;
 *
 *
 * @param {String} _scope Name of the scope to use
 * @param {...Array} _pair  Key-value pair
 * @param {String} _pair[0] Name of the key to push into
 * @param {*} _pair[1] Value to push
 *
 * @returns true on success, false on failure
 *
 */
stats_unshift = {
  (["unshift", _this] call stats_write)
};

/**
* This function merges the given {@code _value} with the existing value at the specified {@code _key}, and within the given scope {@code _scope}
*
* e.g.
*
*   //merges the _hash into the existing value at "key1"
*   private["_hash"];
*   _hash = [
*             ["child1", "val1"],
*             ["child2", "val2"]
*           ] call sock_hash;
*
*   ["scope1", "key1", _hash] call stats_merge;
*
* @param {String} _scope  Name of the scope to use
* @param {String} _key Name of the key to merge into
* @param {*} _value Value to merge
*
* @returns {boolean}  true on success, false on failure
*/


/**
 * This function merges one or more values into the existing values at the specified keys within the given {@code _scope}
 *
 * e.g.
 *
 *   private["_hash1", "_hash2"];
 *   _hash1 = [
 *             ["child1", "val1"],
 *             ["child2", "val2"]
 *           ] call sock_hash;
 *
 *   _hash12= [
 *             ["child1", "val1"],
 *             ["child2", "val2"]
 *           ] call sock_hash;
 *
 *   //merges _hash1 into the value at "key1", and _hash2 into the value at "key2"
 *   ["scope1", ["key1", _hash1], ["key2", _hash2]] call stats_merge;
 *
 *
 * @param {String} _scope Name of the scope to use
 * @param {...Array} _pair  Key-value pair
 * @param {String} _pair[0] Name of the key to merge into
 * @param {*} _pair[1] Value to merge
 *
 * @returns true on success, false on failure
 *
 */

stats_merge = {
  (["merge", _this] call stats_write)
};

stats_write = {
  if (isNil "_this") exitWith {false};
  format["%1 stats_set;", _this] call stats_log_finest;

  ARGVX3(0,_operation,"");
  ARGVX3(1,_this,[]);

  init(_method,_operation);
  def(_params);
  _params = _this call stats_build_params;

  if (undefined(_params)) exitWith {false};


  def(_result);
  _result = ([_method, _params] call sock_rpc);
  if (undefined(_result)) exitWith {false};


  if (isSTRING(_result)) exitWith {
    _result call stats_log_severe;
    false
  };

  if (not(isBOOLEAN(_result))) exitWith {
    format["protocol error: was expecting _result of typeName %1, but instead got typeName %2", typeName true, typeName _result] call stats_log_severe;
    false
  };

  _result
};



/**
* This function gets the value of the given {@code _key}, within the specified {@code _scope}
*
* e.g.
*
*  //get the value for "key1"
*  stats_get("scope", "key1");
*
*  //get the value for "key1", or use "default1" if not found
*  ["scope", "key1", "default1"] call stats_get;
*
* @param {String} _scope  Name of the scope to use
* @param {String} _key Name of the key to set
* @param {*} [_default] Default value to use if {@code _key} does not exist
* @return
*
* The value assocaited with the specified {@code _key}
*
*/

/**
* This function gets multiple (or all) key-value pairs within the specified {@code _scope}
*
* e.g.
*
*   //get the values for all keys within "scope1"
*   ["scope1"] call stats_get;
*
*   //get the values for "key1", "key2", and "key3"
*   ["scope1", ["key1", "default1"], [key2, "default2"], ["key3"]] call stats_get;
*
*
* @param {Strnig} _scope  Name of the scope to use
* @param {...Array} [_pair] One or more key-value pairs to retrieve
* @param {String} [_pair[0]] Name of the key
* @param {*} [_pair[1]] Default value to use, if key is not found
*
* @return
*
* On success, returns array containing the key-value pairs.
* e.g.
*
* [["key1","value1"],["key2", "value2"],...]
*
* On failure, returns nil
*
*/

stats_get = {
  (["get", _this] call stats_read)
};



/**
* This function pops the value at the end of the array at {@code _key}, within the specified {@code _scope}
*
* e.g.
*
*  //pop the value for array at "key1"
*  ["scope", "key1"] call stats_pop;
*
*  //pop the value for array at "key1", or use "default1" if not found
*  ["scope", "key1", "default1"] call stats_pop;
*
* @param {String} _scope  Name of the scope to use
* @param {String} _key Name of the key to pop value off
* @param {*} [_default] Default value to use if {@code _key} does not exist
* @return
*
* The value assocaited with the specified {@code _key}
*
*/

/**
* This function pops multiple values for the arrays at the specified keys, within the given {@code _scope}
*
* e.g.
*
*
*   //pop the values for arrays at "key1", "key2", and "key3"
*   ["scope1", ["key1", "default1"], [key2, "default2"], ["key3"]] call stats_pop;
*

* @param {Strnig} _scope  Name of the scope to use
* @param {...Array} [_pair] One or more key-value pairs to retrieve
* @param {String} [_pair[0]] Name of the key to pop value off
* @param {*} [_pair[1]] Default value to use, if key is not found
*
* @return
*
* On success, returns array containing the key-value pairs.
* e.g.
*
* [["key1","value1"],["key2", "value2"],...]
*
* On failure, returns nil
*
*/

stats_pop = {
  (["pop", _this] call stats_read)
};


/**
* This function shifts the value at the begining of the array at {@code _key}, within the specified {@code _scope}
*
* e.g.
*
*  //shift the value for array at "key1"
*  ["scope", "key1"] call stats_shift;
*
*  //shift the value for array at "key1", or use "default1" if not found
*  ["scope", "key1", "default1"] call stats_shift;
*
* @param {String} _scope  Name of the scope to use
* @param {String} _key Name of the key to shift value out
* @param {*} [_default] Default value to use if {@code _key} does not exist
* @return
*
* The value assocaited with the specified {@code _key}
*
*/

/**
* This function shifts multiple values for the arrays at the specified keys, within the given {@code _scope}
*
* e.g.
*
*
*   //shift the values for arrays at "key1", "key2", and "key3"
*   ["scope1", ["key1", "default1"], [key2, "default2"], ["key3"]] call stats_shift;
*
*
* @param {Strnig} _scope  Name of the scope to use
* @param {...Array} [_pair] One or more key-value pairs to retrieve
* @param {String} [_pair[0]] Name of the key to shift value out
* @param {*} [_pair[1]] Default value to use, if key is not found
*
* @return
*
* On success, returns array containing the key-value pairs.
* e.g.
*
* [["key1","value1"],["key2", "value2"],...]
*
* On failure, returns nil
*
*/
stats_shift = {
  (["shift", _this] call stats_read)
};

/**
* This function counts the child keys within the given {@code _scope}
*
* e.g.
*
*  //count child keys at "scope1"
*  ["scope"] call stats_count;
*
*
* @param {String} _scope  Name of the scope to use
*
* @return
*
* The count of child keys at the specified {@code _scope}
*
*/

/**
* This function counts the child keys at the specified {@code _key}, within the given {@code _scope}
*
* e.g.
*
*  //count child keys at "key1"
*  ["scope", "key1"] call stats_count;
*
*  //count the child keys at "key1", or use -1 if not found
*  ["scope", "key1", -1] call stats_count;
*
* @param {String} _scope  Name of the scope to use
* @param {String} _key Name of the key where child keys will be counted
* @param {*} [_default] Default value to use if {@code _key} does not exist
* @return
*
* The count of child keys at the specified {@code _key}
*
*/

/**
* This function counts the child keys for one or more of the specified keys, within the given {@code _scope}
*
* e.g.
*
*
*   //count the child keys at "key1", "key2", and "key3"
*   ["scope1", ["key1", -1], [key2, -1], ["key3", -1]] call stats_count;
*
*
* @param {Strnig} _scope  Name of the scope to use
* @param {...Array} [_pair] One or more key-value pairs
* @param {String} [_pair[0]] Name of the key where child keys will be counted
* @param {*} [_pair[1]] Default value to use, if key is not found
*
* @return
*
* On success, returns array containing the key-value pairs.
* e.g.
*
* [["key1", 0],["key2", 2], ["key3", -1], ...]
*
* On failure, returns nil
*
*/
stats_count = {
  (["count", _this] call stats_read)
};



/**
* This function retrieves the names of child keys within the given {@code _scope}
*
* e.g.
*
*  //retrieve the names of child keys at "scope1"
*  ["scope"] call stats_keys;
*
*
* @param {String} _scope  Name of the scope to use
*
* @return
*
* Array containing the names of child keys
*
* e.g.
*
*   ["key1", "key2", "key3", ...]
*
*
*/

/**
* This function retrievs the names of child keys at the specified {@code _key}, within the given {@code _scope}
*
* e.g.
*
*  //retrieve the names of child keys at "key1"
*  ["scope", "key1"] call stats_keys;
*
*  //retrieve the names of child keys at "key1", or use nil if not found
*  ["scope", "key1", nil] call stats_keys;
*
* @param {String} _scope  Name of the scope to use
* @param {String} _key Name of the key where the names of child keys will be retrieved
* @param {*} [_default] Default value to use if {@code _key} does not exist
* @return
*
* On success returns an array with the names of the child keys within specified {@code _key}
*
* e.g.
*
*  [ "a", "b", "c"]
*
* On failure, or if the key is not found, returns the default value
*
*/

/**
* This function retrieves the names of child keys for one or more of the specified keys, within the given {@code _scope}
*
* e.g.
*
*
*   //retrieve the names of child keys at "key1", "key2", and "key3"
*   ["scope1", ["key1", nil], ["key2", []], ["key3", nil]] call stats_keys;
*
*
* @param {Strnig} _scope  Name of the scope to use
* @param {...Array} [_pair] One or more key-value pairs
* @param {String} [_pair[0]] Name of the key where the names of chikd keys will be retreived
* @param {*} [_pair[1]] Default value to use, if key is not found
*
* @return
*
* On success, returns array containing the key-value pairs.
* e.g.
*
* [["key1", ["a", "b", "c"]],["key2", []], ["key3", nil], ...]
*
* On failure, returns nil
*
*/

stats_keys = {
  (["keys", _this] call stats_read)
};


stats_read = {
  if (isNil "_this") exitWith {};
  format["%1 stats_get;", _this] call stats_log_fine;

  ARGVX3(0,_operation,"");
  ARGVX3(1,_this,[]);

  init(_method, _operation);
  init(_params,_this call stats_build_params);
  if (undefined(_params)) exitWith {nil};

  def(_result);
  _result = [_method, _params] call sock_rpc;


  /* For single result operations,  - Expect anything
   *   get(scope, key, default)
   *   shift(scope, key default)
   *   pop(scope, key, default)
   *   count(scope)
   *   keys(scope)
   * Expect anything as the result
   */
  if (isSTRING(xGet(_params,1)) || {
      ((["keys","count"] find _method) >= 0 && { undefined(xGet(_params,1))})
      }) exitWith {
    OR(_result,nil)
  };

  /* For multi result operations,
   *   get(scope)
   *   get(scope, [k,v],...)
   *   pop(scope, [k,v],...)
   *   shift(scope, [k,v],...)
   *   keys(scope, [k,v],...)
   *   count(scope, [k,v],...)
   * Expect  as result
   *
   * A code {[["k", "v"],["k", "v"],...]} for a sucessful response
   * A string result might indicate an error message
   * A nil result is an outright failure
   */


  if (undefined(_result)) exitWith {
    format["was expecting _result of typeName %1, but instead got nil during %2 operation", typeName {}, _method] call stats_log_severe;
    nil
  };

  //an error must have occurred
  if (isSTRING(_result)) exitWith {
    _result call stats_log_severe;
    nil
  };

  if (not(isCODE(_result))) exitWith {
    format["was expecting _result of typeName %1, but instead got typeName %2 during %3 operation", typeName {}, typeName _result, _method] call stats_log_severe;
    nil
  };

  (call _result)
};

/**
* This function flushes data (on server side) associated with one or more scopes
*
* Flushing means that the remote data will be saved to the database, and removed from memory.
* This is useful to call once a player has disconnected from the server.
*
* e.g.
*
*  //flush the stats for "scope1"
*  stats_flush("scope1");
*
*  //flush the stats for "scope1", and "scope2"
*  stats_flush("scope1", "scope2")
*
* @param {...String} _scope One or more scope anmes
* @return
*
* The the number of scopes that were flushed.
*
*/
stats_flush = {
  if (isNil "_this") exitWith {};
  format["%1 stats_flush;", _this] call stats_log_fine;

  if (!isARRAY(_this)) exitWith {nil};

  init(_method, "flush");
  init(_params,_this);

  def(_result);
  _result = [_method, _params] call sock_rpc;
  if (undefined(_result)) exitWith {nil};


  if (isSTRING(_result)) exitWith {
    _result call stats_log_severe;
    nil
  };

  if (not(isSCALAR(_result))) exitWith {
    format["protocol error: was expecting _result of typeName %1, but instead got typeName %2", typeName 0, typeName _result] call stats_log_severe;
    nil
  };

  _result
};




/**
* This function wipes all keys within a specific scope
*
*
* e.g.
*
*  //wipe all keys for "scope1"
*  stats_wipe("scope1");
*
* @param {String} _scope Scope to wipe
* @return
*
* True on success, false on failure
*
*/
stats_wipe = {
  if (isNil "_this") exitWith {fale};
  format["%1 stats_wipe;", _this] call stats_log_fine;

  if (!isARRAY(_this)) exitWith {false};

  init(_method, "wipe");
  init(_params,_this);

  def(_result);
  _result = [_method, _params] call sock_rpc;
  if (undefined(_result)) exitWith {false};


  if (isSTRING(_result)) exitWith {
    _result call stats_log_severe;
    false
  };

  if (not(isBOOLEAN(_result))) exitWith {
    format["protocol error: was expecting _result of typeName %1, but instead got typeName %2", typeName false, typeName _result] call stats_log_severe;
    false
  };

  _result
};

diag_log format["loading stats library complete"];

findPlayerViaUID = {
   private ["_player"];
   _player = objNull;
   {
     if (getPlayerUID _x == _this select 0) exitWith {
          _player = _x;
     };
   } forEach playableUnits;
   _player;
};