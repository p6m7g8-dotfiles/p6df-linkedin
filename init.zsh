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
# Function: p6df::modules::linkedin::init(_module, dir)
#
#  Args:
#	_module -
#	dir -
#
#>
######################################################################
p6df::modules::linkedin::init() {
  local _module="$1"
  local dir="$2"

  p6_python_path_if "$dir/lib"
}
