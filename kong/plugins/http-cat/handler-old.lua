local BasePlugin = require "kong.plugins.base_plugin"
local HTTP_CAT_URL = "https://http.cat/"

local HTTP_CatHandler = BasePlugin:extend()

function HTTP_CatHandler:new()
    HTTP_CatHandler.super.new(self, "http-cat")
end

function HTTP_CatHandler:header_filter(conf)
    HTTP_CatHandler.super.header_filter(self)

    local status = kong.response.get_status()
    local http_cat_image = HTTP_CAT_URL .. status

    -- Inject HTTP Cat URL into the response headers
    kong.response.set_header("X-HTTP-Cat", http_cat_image)
end

function HTTP_CatHandler:body_filter(conf)
    HTTP_CatHandler.super.body_filter(self)

    local status = kong.response.get_status()
    local http_cat_image = HTTP_CAT_URL .. status

    -- Append HTTP Cat URL to the response body
    local chunk = kong.response.get_raw_body() or "{}"
    local json = require "cjson"
    local body = json.decode(chunk)

    body["http_cat"] = http_cat_image
    kong.response.set_raw_body(json.encode(body))
end

return HTTP_CatHandler