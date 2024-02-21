module.exports = {
    apps: [{
        name: "app1",
        script: "dhttpd",
        args: "--path outputs/web/",
        interpreter : "/snap/bin/dart",
        watch: true
    }]
}