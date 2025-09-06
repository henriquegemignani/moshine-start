script.on_init(function()
    local created_items = remote.call("freeplay", "get_created_items")
    created_items["wood"] = nil
    remote.call("freeplay", "set_created_items", created_items)
end)