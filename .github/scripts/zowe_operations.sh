#!/bin/bash
# zowe_operations.sh
set -e

# Convert username to lowercase
LOWERCASE_USERNAME=$(echo "$ZOWE_USERNAME" | tr '[:upper:]' '[:lower:]')
USS_DIR="/z/$LOWERCASE_USERNAME/cobolcheck"

# Parâmetros de conexão reutilizáveis para o Zowe CLI
ZOWE_CONN=(
  --host "$ZOWE_HOST"
  --port "$ZOWE_PORT"
  --user "$ZOWE_USERNAME"
  --password "$ZOWE_PASSWORD"
  --reject-unauthorized false
)

# Check if directory exists, create if it doesn't
if ! zowe zos-files list uss-files "$USS_DIR" "${ZOWE_CONN[@]}" &>/dev/null; then
  echo "Directory does not exist. Creating it..."
  zowe zos-files create uss-directory "$USS_DIR" "${ZOWE_CONN[@]}"
else
  echo "Directory already exists."
fi

# Upload directory files (text/config)
echo "Uploading cobol-check directory..."
zowe zos-files upload dir-to-uss "./cobol-check" "$USS_DIR" \
  --recursive \
  "${ZOWE_CONN[@]}"

# Upload the .jar file explicitly in binary mode so it doesn't get corrupted
echo "Uploading cobol-check-0.2.9.jar in binary mode..."
zowe zos-files upload file-to-uss "./cobol-check/cobol-check-0.2.9.jar" "$USS_DIR/cobol-check-0.2.9.jar" \
  --binary \
  "${ZOWE_CONN[@]}"

# Verify upload
echo "Verifying upload:"
zowe zos-files list uss-files "$USS_DIR" "${ZOWE_CONN[@]}"
