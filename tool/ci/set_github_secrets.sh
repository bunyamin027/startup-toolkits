#!/bin/sh
# Copies the signing keys and store API keys into the GitHub repository
# secrets used by .github/workflows/{android,ios}.yml. Values go straight
# from the files to GitHub and are never printed. Needs `gh auth login`.
#
#   tool/ci/set_github_secrets.sh [KEY_DIR] [ASC_P8]
#
# KEY_DIR holds startup-toolkit-upload.jks, key.properties.backup and the
# Play service account JSON; ASC_P8 is the App Store Connect API key.
set -eu

KEY_DIR=${1:-/Users/teknopark/Desktop/mobil/android-keys/startup-toolkit}
ASC_P8=${2:-"/Users/teknopark/Desktop/mobil/Claude AuthKey_D57J5U2XT8.p8"}
PROPS="$KEY_DIR/key.properties.backup"
PLAY_JSON=$(ls "$KEY_DIR"/*.json | head -1)

prop() { grep "^$1=" "$PROPS" | head -1 | cut -d= -f2- | tr -d '\n'; }

base64 -i "$KEY_DIR/startup-toolkit-upload.jks" | tr -d '\n' |
  gh secret set ANDROID_KEYSTORE_BASE64
prop storePassword | gh secret set ANDROID_KEYSTORE_PASSWORD
prop keyPassword | gh secret set ANDROID_KEY_PASSWORD
prop keyAlias | gh secret set ANDROID_KEY_ALIAS
gh secret set PLAY_SERVICE_ACCOUNT_JSON < "$PLAY_JSON"

gh secret set ASC_KEY_P8 < "$ASC_P8"
# Key and issuer IDs are not secret, but the workflow reads them here too.
basename "$ASC_P8" .p8 | sed 's/.*AuthKey_//' | tr -d '\n' |
  gh secret set ASC_KEY_ID
printf '3bac733c-9871-4aa6-88f4-9e8b55a27e32' | gh secret set ASC_ISSUER_ID

gh secret list
