use ../lib/ui.nu [log_step, log_ok, log_warn]

export def install_edge_browser [dry_run: bool = false] {
  log_step "Browsers" "Configuring Microsoft Edge repository and ensuring Firefox is installed..."

  if $dry_run {
    log_warn "[Dry Run] Would import Microsoft GPG key, add Edge repo, and install firefox + microsoft-edge-stable"
    return
  }

  ^sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  ^sudo dnf config-manager addrepo --overwrite --from-repofile=https://packages.microsoft.com/yumrepos/edge
  ^sudo dnf install -y firefox microsoft-edge-stable
  log_ok "Firefox and Microsoft Edge installed."
}

export def install_rpm_apps [dry_run: bool = false] {
  log_step "Desktop Apps" "Installing creative, media, and office packages via DNF..."

  let rpm_apps = [
    "obs-studio"
    "vlc"
    "gimp"
    "krita"
    "libreoffice"
  ]

  if $dry_run {
    log_warn $"[Dry Run] Would install DNF apps: ($rpm_apps | str join ', ')"
    return
  }

  ^sudo dnf install -y ...$rpm_apps
  log_ok "OBS Studio, VLC, GIMP, Krita, and LibreOffice installed."
}

export def install_flatpak_apps [dry_run: bool = false] {
  log_step "Flatpaks" "Installing Spotify and Equibop from FlatHub..."

  let flatpaks = [
    "com.spotify.Client"
    "org.equicord.Equibop"
  ]

  if $dry_run {
    log_warn $"[Dry Run] Would install Flathub apps: ($flatpaks | str join ', ')"
    return
  }

  ^flatpak install -y --noninteractive flathub ...$flatpaks
  log_ok "Spotify, Equibop installed."
}

export def install_all_apps [dry_run: bool = false] {
  install_edge_browser $dry_run
  install_rpm_apps $dry_run
  install_flatpak_apps $dry_run
}
