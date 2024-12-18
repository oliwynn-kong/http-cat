local MyHttpCatHandler = {
    PRIORITY = 1000,
    VERSION = "0.0.1",
}

function MyHttpCatHandler:response(conf)
    kong.response.set_header(conf.response_header_name, "http://http.cat/"..kong.response.get_status());
end


return MyHttpCatHandler