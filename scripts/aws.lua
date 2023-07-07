#!/usr/bin/env lua

Credentials = {
  aws_access_key_id = "",
  aws_secret_access_key = "",
  aws_account_id = "",
  password = "",
}

Copy = {
  enabled = false
}


STRING = "string"
FMT_TABLE = "%s = %s,"
FMT_CONSOLE = "%s=%s"
FMT_EXPORT = "export %s=%s"

function Credentials:format(format, lowercase)
  local line = ""
  local lines = ""
  for key, value in pairs(self) do
    if type(value) == STRING then
      line = string.format(format, lowercase and key or key:upper(), value)
      lines = lines .. line .. '\n'
    end
  end
  return lines
end

function Credentials:loadFromFile(name)
  local command = string.format("pass %s", name)
  local handle = io.popen(command)
  for line in handle:lines() do
    for k, v in string.gmatch(line, "(.-)%s*=%s*(.*),?$") do
      self[string.lower(k)] = v:gsub(",$", "")
    end
  end
  return self
end

function Credentials:insert(name)
  print "AWS_ACCOUNT_ID"
  self.aws_account_id = io.read("*l")
  print "AWS_ACCESS_KEY_ID"
  self.aws_access_key_id = io.read("*l")
  print "AWS_SECRET_ACCESS_KEY"
  self.aws_secret_access_key = io.read("*l")
  print "PASSWORD"
  self.password = io.read("*l")
  local command = string.format("echo '%s' | pass insert %s -m", self:format(FMT_TABLE, true), name)
  os.execute(command)
  --return self
end

function Credentials:AWSConsoleLogin(name)
  os.execute(string.format("echo 'type %s' | dotool", self.aws_account_id))
  os.execute(string.format("echo 'type %s' | dotool", "\t"))
  os.execute(string.format("echo 'type %s' | dotool", name))
  os.execute(string.format("echo 'type %s' | dotool", "\t"))
  os.execute(string.format("echo 'type %s' | dotool", self.password))
end

function Copy:print(input)
  if self.enabled then
    os.execute(string.format("echo '%s' | wl-copy", input))
    return
  end
  print(input)
end

-- paws aws
if arg[1] == nil then
  os.execute("pass")
  os.exit(0, true)
end

-- pass aws (-c | --clip)
for _, v in pairs(arg) do
  if v == "--clip" or v == "-c" then
    Copy.enabled = true
  end
end
-- pass aws insert (-c | --clip)
if arg[1] == "insert" then
  Credentials:insert(arg[2])
  os.exit(0, true)
end
-- pass aws export (-c | --clip)
if arg[1] == "export" then
  Credentials:loadFromFile(arg[2])
  Copy:print(Credentials:format(FMT_EXPORT, false))
  os.exit(0, true)
end
if arg[1] == "password" then
  Credentials:loadFromFile(arg[2])
  Copy:print(Credentials.password)
  os.exit(0, true)
end
if arg[1] == "console" then
  Credentials:loadFromFile(arg[2])
  local captured = string.match(arg[2], ".*/(.*)$") or arg[2]
  Credentials:AWSConsoleLogin(captured)
  os.exit(0, true)
end
if arg[1] == "help" then
  local help = string.format("Usage:", "")
  print(help)
  os.exit(0, true)
end

Credentials:loadFromFile(arg[1])
Copy:print(Credentials.password)
os.exit(0, true)
