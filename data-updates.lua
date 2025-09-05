
data.raw["resource"]["steam-geyser"].category = "steam"

for _, proto in pairs(data.raw["mining-drill"]) do
    local should_add = false
    for _, item in pairs(proto.resource_categories) do
        if item == "basic-fluid" then
            should_add = true
            break
        end
    end
    if should_add then
        table.insert(proto.resource_categories, "steam")
    end
end