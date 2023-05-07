# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::linkedin::deps()
#
#>
######################################################################
p6df::modules::linkedin::deps() {
  ModuleDeps=(
    p6m7g8-dotfiles/p6df-python
  )
}

######################################################################
#<
#
# Function: p6df::modules::linkedin::init()
#
#  Environment:	 P6_DFZ_SRC_P6M7G8_DOTFILES_DIR
#>
######################################################################
p6df::modules::linkedin::init() {
  
  p6_python_path_if "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6df-linkedin/lib"
}
