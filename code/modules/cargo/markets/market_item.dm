/datum/market_item
	/// Name for the item entry used in the uplink.
	var/name
	/// Description for the item entry used in the uplink.
	var/desc
	/// The category this item belongs to, should be already declared in the market that this item is accessible in.
	var/category
	/// "/datum/market"s that this item should be in, used by SSblackmarket on init.
	var/list/markets = list(/datum/market/blackmarket)

	/// Price for the item, if not set creates a price according to the *_min and *_max vars.
	var/price
	/// How many of this type of item is available, if not set creates a price according to the *_min and *_max vars.
	var/stock

	/// Path to or the item itself what this entry is for, this should be set even if you override spawn_item to spawn your item.
	var/obj/item/item

	/// Minimum price for the item if generated randomly.
	var/price_min = 0
	/// Maximum price for the item if generated randomly.
	var/price_max = 0
	/// Minimum amount that there should be of this item in the market if generated randomly. This defaults to 1 as most items will have it as 1.
	var/stock_min = 1
	/// Maximum amount that there should be of this item in the market if generated randomly.
	var/stock_max = 0
	/// Probability for this item to be available. Used by SSblackmarket on init.
	var/availability_prob = 0
	///do we use stock
	var/uses_stock = TRUE

/datum/market_item/New()
	if(isnull(price))
		price = rand(price_min, price_max)
	if(isnull(stock))
		stock = rand(stock_min, stock_max)

/datum/market_item/Destroy()
	item = null
	return ..()

/// Used for spawning the wanted item, override if you need to do something special with the item.
/datum/market_item/proc/spawn_item(loc)
	if(ismovable(item))
		item.forceMove(loc)
		return item
	if(ispath(item))
		return new item(loc)
	CRASH("Invalid item type for market item [item || "null"]")

/// Buys the item and makes SSblackmarket handle it.
/datum/market_item/proc/buy(obj/item/market_uplink/uplink, mob/buyer, shipping_method)
	// Sanity
	if(!istype(uplink) || !istype(buyer))
		return FALSE

	// This shouldn't be able to happen unless there was some manipulation or admin fuckery.
	if(!item || stock <= 0)
		return FALSE

	// Alright, the item has been purchased.
	var/datum/market_purchase/purchase = new(src, uplink, shipping_method)

	// SSblackmarket takes care of the shipping.
	if(SSblackmarket.queue_item(purchase))
		if(uses_stock)
			stock--
		buyer.log_message("has succesfully purchased [name] using [shipping_method] for shipping.", LOG_ECON)
		return TRUE
	return FALSE

// This exists because it is easier to keep track of all the vars this way.
/datum/market_purchase
	/// The entry being purchased.
	var/datum/market_item/entry
	/// Instance of the item being sent.
	var/item
	/// The uplink where this purchase was done from.
	var/obj/item/market_uplink/uplink
	/// Shipping method used to buy this item.
	var/method


//needs to be here
/datum/market_purchase/New(_entry, _uplink, _method)
	entry = _entry
	if(!ispath(entry.item))
		item = entry.item
	uplink = _uplink
	method = _method
