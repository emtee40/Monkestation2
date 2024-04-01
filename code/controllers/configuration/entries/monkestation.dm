/datum/config_entry/string/regular_mentorhelp_webhook_url

/datum/config_entry/string/mentorhelp_webhook_pfp

/datum/config_entry/string/mentorhelp_webhook_name

/datum/config_entry/string/mhelp_message
	default = ""

/datum/config_entry/string/patreon_link_website

/datum/config_entry/string/twitch_link_website

/datum/config_entry/string/regular_roundend_webhook_url

/datum/config_entry/string/roundend_webhook_pfp

/datum/config_entry/string/roundend_webhook_name

/datum/config_entry/string/bot_dump_url

//API key for Github Issues.
/datum/config_entry/string/issue_key
	protection = CONFIG_ENTRY_HIDDEN

//Endpoint for Github Issues, the `owner/repo` part.
/datum/config_entry/string/issue_slug
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/flag/looc_enabled

/datum/config_entry/flag/log_storyteller

/datum/config_entry/number/roundstart_research_boost
	min_val = 1
	default = 1.5
	integer = FALSE

/datum/config_entry/number/roundstart_research_time
	min_val = 0
	default = 20
	integer = FALSE

/datum/config_entry/number/roundstart_research_time/ValidateAndSet(str_val)
	. = ..()
	if(.)
		config_entry_value *= 600 //documented as minutes in config.txt
