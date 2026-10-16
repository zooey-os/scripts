use ../lib/ui.nu [log_step, log_ok, log_warn]

export def configure_dnf [dry_run: bool = false] {
  log_step "System" "Optimizing DNF package manager for fast parallel downloads..."

  if $dry_run {
    log_warn "[Dry Run] Would configure max_parallel_downloads=10 and fastestmirror=True in /etc/dnf/dnf.conf"
    return
  }

  let dnf_conf = (open /etc/dnf/dnf.conf --raw)
  if not ($dnf_conf | str contains "max_parallel_downloads") {
    "max_parallel_downloads=10\nfastestmirror=True\ndefaultyes=True\n" | ^sudo tee -a /etc/dnf/dnf.conf | ignore
    log_ok "DNF parallel downloads and fastest mirror enabled."
  } else {
    log_ok "DNF is already optimized."
  }
}

export def enable_repos [dry_run: bool = false] {
  log_step "Repositories" "Enabling RPM Fusion (Free & Non-Free) and Flathub..."

  if $dry_run {
    log_warn "[Dry Run] Would enable RPM Fusion repositories and Flathub remote"
    return
  }

  let fedora_ver = (^rpm -E %fedora | str trim)
  let free_url = $"https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-($fedora_ver).noarch.rpm"
  let nonfree_url = $"https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-($fedora_ver).noarch.rpm"

  ^sudo dnf install -y $free_url $nonfree_url
  ^flatpak remote-add --if-not-exists flathub --user https://dl.flathub.org/repo/flathub.flatpakrepo
  log_ok "RPM Fusion and Flathub repositories active."
}

export def install_codecs [dry_run: bool = false] {
  log_step "Multimedia" "Installing full audio/video codecs and hardware acceleration..."

  let codec_packages = [
    "ffmpeg"
    "gstreamer1-plugins-bad-free"
    "gstreamer1-plugins-good"
    "gstreamer1-plugins-base"
    "gstreamer1-plugin-openh264"
    "libva-utils"
  ]

  if $dry_run {
    log_warn $"[Dry Run] Would isntall codecs: ($codec_packages | str join ',')"
    return
  }

  ^sudo dnf isntall -y --allowerasing ...$codec_packages
  log_ok "Multimedia codecs and hardware decoding installed."
}
