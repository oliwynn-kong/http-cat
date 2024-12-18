local MyHttpCatHandler = {
    PRIORITY = 1000,
    VERSION = "0.0.1",
}

function MyHttpCatHandler:response(conf)
    kong.response.set_header("X-MyHttpCat", "http://http.cat/"..kong.response.get_status());
end


return MyHttpCatHandler