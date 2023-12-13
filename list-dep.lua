function extractDependencies(filename, processedFiles, allDependencies)
    if processedFiles[filename] then
        return
    end

    local file = io.open(filename, "r")

    if not file then
        return
    end

    processedFiles[filename] = true

    for line in file:lines() do
        local _, _, dependency = string.find(line, 'require%s*%("?([^"%s]+)"?%)')
        if dependency then
            table.insert(allDependencies, dependency)
            extractDependencies(dependency .. ".lua", processedFiles, allDependencies)
        end
    end

    file:close()
end

local filename = arg[1]

if not filename then
    print("Usage: lua dependency_extractor.lua <filename.lua>")
    os.exit(1)
end

local allDependencies = {}
local processedFiles = {}

extractDependencies(filename, processedFiles, allDependencies)

for _, dependency in ipairs(allDependencies) do
    print(dependency)
end
