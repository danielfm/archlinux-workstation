# Secret token generation
alias token="dd if=/dev/random bs=1 count=64 2>/dev/null | base64 | tr -d '=\n'"

# Password management
alias pass='gopass'

# Display the qrcode as a ANSI utf-8 string in the terminal.
# Usage: text2qrcode SECRET
text2qrcode() {
  qrencode -t ansiutf8 "$1"
}

# Display the qrcode for a TOTP secret.
# Usage: totpqrcode ISSUER LABEL SECRET
totpqrcode() {
  if [ "$#" -ne 3 ]; then
    echo "Usage: $0 ISSUER LABEL SECRET"; return
  fi
  text2qrcode "otpauth://totp/$(echo -n "$2" | jq -sRr @uri)?secret=$3&issuer=$(echo -n "$1" | jq -sRr @uri)"
}
