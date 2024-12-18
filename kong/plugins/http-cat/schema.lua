
local PLUGIN_NAME = "http-cat"
local typedefs = require "kong.db.schema.typedefs"

local schema = {
  name = PLUGIN_NAME,
  fields = {
    { config = {
        type = "record",
        fields = {
          { response_header_name = typedefs.header_name {
            required = false,
            default = "X-MyHttpCat" } },
        },
      },
    },
  },
}

return schema

