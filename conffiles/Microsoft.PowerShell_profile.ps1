# netsh 命令无法在普通用户运行的powershell中使用因此注释
# function setpxy {netsh winhttp set proxy proxy-server="http=http://127.0.0.1:8889;https=https://127.0.0.1:8889"}
# function unpxy {netsh winhttp reset proxy}
# function scanpxy {netsh winhttp show proxy}
function sethttp { $env:HTTP_PROXY="http://127.0.0.1:8889" }
function sethttps { $env:HTTPS_PROXY="https://127.0.0.1:8889" }
function unhttp { $env:HTTP_PROXY="" }
function unhttps { $env:HTTPS_PROXY="" }
