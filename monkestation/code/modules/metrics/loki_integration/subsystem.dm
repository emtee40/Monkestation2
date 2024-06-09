/*
json needs to be structured in standard loki format or it will be rejected, does not support sending gzips through the ss
https://grafana.com/docs/loki/latest/reference/loki-http-api/#post-lokiapiv1push

*/

/client
	var/test_marked = FALSE

/datum/config_entry/string/loki_url
	default = ""

/datum/config_entry/flag/loki_enabled
	default = FALSE

SUBSYSTEM_DEF(loki)
	name = "Loki Sender"
	flags = SS_NO_FIRE


/datum/controller/subsystem/loki/Initialize()
	. = ..()
	if(!CONFIG_GET(flag/loki_enabled))
		return SS_INIT_NO_NEED
	return SS_INIT_SUCCESS

/datum/controller/subsystem/loki/proc/send_server_log(category, message, severity)


/datum/controller/subsystem/loki/proc/send_user_log(category, message, severity, source, target)
	var/list/built = list()
	built["streams"] = list()
	built["streams"]["stream"] = list("target" = "[target]", "source" = "[source]", "category" = "[category]", "level" = "[severity]")
	built["streams"]["values"] = list("[rustg_unix_timestamp() * 1000000000]", message)

	push_data(built)

/datum/controller/subsystem/loki/proc/push_data(json)
	if(!json || !CONFIG_GET(flag/loki_enabled))
		message_admins("NOT ABLE TO SEND")
		return
	var/list/headers = list()
	headers["Content-Type"] = "application/json"
	var/datum/http_request/request = new()
	//note about this, the loki_url also contains the api and userkey needed to actually send data if you are sending data outside of host box.
	request.prepare(RUSTG_HTTP_METHOD_POST, "[CONFIG_GET(string/loki_url)]/loki/api/v1/push", json_encode(json), headers, "tmp/response.json")
	request.begin_async()
	message_admins("SENT LOG")
