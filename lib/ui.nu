export const COLOR_ROSE = "\e[38;2;244;184;228m"
export const COLOR_LAVENDER = "\e[38;2;202;158;230m"
export const COLOR_PEACH = "\e[38;2;242;213;207m"
export const COLOR_MINT = "\e[38;2;166;209;137m"
export const COLOR_MUTED = "\e[38;2;131;139;167m"
export const RESET = "\e[0m"

export def print_banner [] {
  print $"(ansi {fg: '#f4b8e4' attr: b})"
  print "   ╭──────────────────────────────────────────────╮"
  print "   │         ♥  Z O E Y O S   S E T U P  ♥        │"
  print "   │    Fedora 44 KDE Pastel Desktop Edition      │"
  print "   ╰──────────────────────────────────────────────╯"
  print $"(ansi reset)"
}

export def log_step [section: string, message: string] {
  print $"($COLOR_LAVENDER)╭─[($COLOR_ROSE)♥ ($section)($COLOR_LAVENDER)]($RESET)"
  print $"($COLOR_LAVENDER)╰─➤($RESET) ($COLOR_PEACH)($message)($RESET)"
}

export def log_ok [message: string] {
  print $"  ($COLOR_MINT)✔ ($message)($RESET)"
}

export def log_warn [message: string] {
  print $"  ($COLOR_PEACH)⚠ ($message)($RESET)"
}
