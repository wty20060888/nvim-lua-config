local MY_FQBN = "arduino:avr:uno"
lspconfig.arduino_language_server.setup {
    cmd = {
        "arduino-language-server",
        "-cli-config", "/path/to/arduino-cli.yaml/usr/local/bin/arduino-cli",
        "-fqbn",
        MY_FQBN
    }
}
