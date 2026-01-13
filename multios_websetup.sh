#!/usr/bin/env bash
set -Eeuo pipefail

# ---------------------------
# Config (edit if you want)
# ---------------------------
URL="https://www.tooplate.com/zip-templates/2098_health.zip"
ART_NAME="2098_health"
WEB_ROOT="/var/www/html"
TEMPDIR="/tmp/webfiles"

# ---------------------------
# Helpers
# ---------------------------
log() { printf '\n[%s] %s\n' "$(date +'%F %T')" "$*"; }

die() { printf '\nERROR: %s\n' "$*" >&2; exit 1; }

need_cmd() { command -v "$1" >/dev/null 2>&1 || die "Missing required command: $1"; }

cleanup() {
  if [[ -d "$TEMPDIR" ]]; then
    rm -rf "$TEMPDIR"
  fi
}
trap cleanup EXIT

require_root_or_sudo() {
  if [[ $EUID -ne 0 ]]; then
    need_cmd sudo
  fi
}

run() {
  # Run command with sudo only if not root
  if [[ $EUID -ne 0 ]]; then
    sudo "$@"
  else
    "$@"
  fi
}

detect_os() {
  [[ -r /etc/os-release ]] || die "Cannot detect OS (missing /etc/os-release)"
  # shellcheck disable=SC1091
  . /etc/os-release

  case "${ID_LIKE:-$ID}" in
    *debian*|*ubuntu*)
      PKG_MGR="apt"
      PACKAGE_LIST=(apache2 wget unzip)
      SVC="apache2"
      ;;
    *rhel*|*fedora*|*centos*|*rocky*|*almalinux*)
      PKG_MGR="yum"
      PACKAGE_LIST=(httpd wget unzip)
      SVC="httpd"
      ;;
    *)
      die "Unsupported distro: ID=$ID ID_LIKE=${ID_LIKE:-}"
      ;;
  esac
}

install_packages() {
  log "Installing packages: ${PACKAGE_LIST[*]}"
  case "$PKG_MGR" in
    apt)
      run apt-get update -y
      run apt-get install -y "${PACKAGE_LIST[@]}" >/dev/null
      ;;
    yum)
      run yum install -y "${PACKAGE_LIST[@]}" >/dev/null
      ;;
    *)
      die "Unknown package manager: $PKG_MGR"
      ;;
  esac
}

enable_and_start_service() {
  log "Enabling and starting service: $SVC"
  run systemctl enable --now "$SVC"
}

download_and_deploy() {
  log "Deploying artifact to $WEB_ROOT"

  mkdir -p "$TEMPDIR"
  cd "$TEMPDIR"

  # Use -L to follow redirects, -f to fail on HTTP errors, -s for quiet, -S to show errors
  need_cmd curl
  curl -fLsS "$URL" -o "${ART_NAME}.zip"

  unzip -q "${ART_NAME}.zip"

  [[ -d "$ART_NAME" ]] || die "Expected folder '$ART_NAME' not found after unzip"

  # Clear old content (optional; comment out if you don't want this)
  run rm -rf "${WEB_ROOT:?}/"*

  run cp -r "${ART_NAME}/." "$WEB_ROOT/"
}

restart_service() {
  log "Restarting service: $SVC"
  run systemctl restart "$SVC"
}

show_status() {
  log "Service status + deployed files"
  run systemctl --no-pager --full status "$SVC" || true
  ls -la "$WEB_ROOT" | head -n 40
}

main() {
  require_root_or_sudo
  detect_os
  log "Detected OS family -> package manager: $PKG_MGR, service: $SVC"

  install_packages
  enable_and_start_service
  download_and_deploy
  restart_service
  show_status

  log "Done."
}

main "$@"
