resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

ui_page "script/nui/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"script/client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"cfg/webhooks.lua",
	"script/server.lua",
	"cfg/usoitem.lua"
}

files {
	"script/nui/index.html",
	"script/nui/jquery.js",
	"script/nui/css.css",
	"script/nui/images/*.png",
	"script/nui/fonts/*.*"
}