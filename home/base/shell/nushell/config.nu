# Nushell Config File
#
# version = 0.81.1

# let's define some colors

# https://github.com/catppuccin/i3/blob/main/themes/catppuccin-macchiato
let rosewater = "#f4dbd6"
let flamingo  = "#f0c6c6"
let pink      = "#f5bde6"
let mauve     = "#c6a0f6"
let red       = "#ed8796"
let maroon    = "#ee99a0"
let peach     = "#f5a97f"
let green     = "#a6da95"
let yellow    = "#eed49f"
let teal      = "#8bd5ca"
let sky       = "#91d7e3"
let sapphire  = "#7dc4e4"
let blue      = "#8aadf4"
let lavender  = "#b7bdf8"
let text      = "#cad3f5"
let subtext1  = "#b8c0e0"
let subtext0  = "#a5adcb"
let overlay2  = "#939ab7"
let overlay1  = "#8087a2"
let overlay0  = "#6e738d"
let surface2  = "#5b6078"
let surface1  = "#494d64"
let surface0  = "#363a4f"
let base      = "#24273a"
let mantle    = "#1e2030"
let crust     = "#181926"

# we're creating a theme here that uses the colors we defined above.

let catppuccin_theme = {
    separator: $overlay2
    leading_trailing_space_bg: $surface2
    header: $red
    date: $pink
    filesize: $green
    row_index: $text
    bool: $peach
    int: $red
    duration: $sky
    range: $sapphire
    float: $lavender
    string: $text
    nothing: $overlay1
    binary: $subtext1
    cellpath: $subtext0
    hints: dark_gray

    shape_garbage: { fg: $overlay2 bg: $red attr: b}
    shape_bool: $maroon
    shape_int: { fg: $pink attr: b}
    shape_float: { fg: $pink attr: b}
    shape_range: { fg: $overlay0 attr: b}
    shape_internalcall: { fg: $maroon attr: b}
    shape_external: $mauve
    shape_externalarg: { fg: $red attr: b}
    shape_literal: $flamingo
    shape_operator: $rosewater
    shape_signature: { fg: $red attr: b}
    shape_string: $red
    shape_filepath: $peach
    shape_globpattern: { fg: $teal attr: b}
    shape_variable: $pink
    shape_flag: { fg: $mauve attr: b}
    shape_custom: {attr: b}
}

# The default config record. This is where much of your global configuration is setup.
$env.config = {
  color_config: $catppuccin_theme  # <-- this is the theme
  use_ansi_coloring: true

  # true or false to enable or disable the welcome banner at startup
  show_banner: false

  table: {
    mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
    index_mode: always # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
    show_empty: true # show 'empty list' and 'empty record' placeholders for command output
    trim: {
      methodology: wrapping # wrapping or truncating
      wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
      truncating_suffix: "..." # A suffix used by the 'truncating' methodology
    }
  }

  completions: {
    case_sensitive: false # set to true to enable case-sensitive completions
    quick: true  # set this to false to prevent auto-selecting completions when only one remains
    partial: true  # set this to false to prevent partial filling of the prompt
    algorithm: "prefix"  # prefix or fuzzy
    external: {
      enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up may be very slow
      max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
      completer: null # check 'carapace_completer' above as an example
    }
  }
  filesize: {
    metric: true # true => KB, MB, GB (ISO standard), false => KiB, MiB, GiB (Windows standard)
    format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, zb, zib, auto
  }
  cursor_shape: {
    emacs: line # block, underscore, line, blink_block, blink_underscore, blink_line (line is the default)
    vi_insert: block # block, underscore, line , blink_block, blink_underscore, blink_line (block is the default)
    vi_normal: underscore # block, underscore, line, blink_block, blink_underscore, blink_line (underscore is the default)
  }
  use_grid_icons: true
  footer_mode: "25" # always, never, number_of_rows, auto
  float_precision: 2 # the precision for displaying floats in tables
  # buffer_editor: "emacs" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
  bracketed_paste: true # enable bracketed paste, currently useless on windows
  edit_mode: emacs # emacs, vi
  shell_integration: true # enables terminal markers and a workaround to arrow keys stop working issue
  render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.

  hooks: {
    env_change: {
      PWD: {
        if (which direnv | is-empty) {
            return
        }
        direnv export json | from json | default {} | load-env
      }
    }
  }

}

source ~/.local/share/atuin/init.nu
source ~/.local/share/atuin/autocompletion.nu
