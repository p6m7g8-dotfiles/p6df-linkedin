# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::vim::deps()
#
#>
######################################################################
p6df::modules::linkedin::deps() {
  ModuleDeps=(
    p6m7g8-dotfiles/p6df-python
  )
}

p6df::modules::linkedin::init() {
  
  p6_python_path_if "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6df-linkedin/lib"
}

p6df::modules::linkedin::langs() {

  pip install selenium

  p6_return_void
}
