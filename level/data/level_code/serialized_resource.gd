class_name SerializedResource
extends Resource


## Take this resource's data, and serialize it into a piece of level code.
## Make sure this piece can be read by the deserialize() function.
func serialize() -> String:
	return ""


## Take a piece of level code created by the serialize() function and decode it,
## then load that data into this object's properties.
func deserialize() -> Error:
	return Error.ERR_UNAVAILABLE
