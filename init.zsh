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
# Function: p6df::modules::linkedin::env::init()
#
#  Environment:	 P6_DFZ_SRC_P6M7G8_DOTFILES_DIR
#>
######################################################################
p6df::modules::linkedin::env::init() {

  local _module="$1"
  local _dir="$2"
  p6_python_path_if "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6df-linkedin/lib"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::linkedin::mcp()
#
#>
######################################################################
p6df::modules::linkedin::mcp() {

  p6_js_npm_global_install "linkedin-mcp-server"

  p6df::modules::anthropic::mcp::server::add "linkedin" "npx" "-y" "linkedin-mcp-server"
  p6df::modules::openai::mcp::server::add "linkedin" "npx" "-y" "linkedin-mcp-server"

  p6_return_void
}

######################################################################
#<
#
# Function: words linkedin $LINKEDIN_API_KEY = p6df::modules::linkedin::profile::mod()
#
#  Returns:
#	words - linkedin $LINKEDIN_API_KEY
#
#  Environment:	 LINKEDIN_API_KEY
#>
######################################################################
p6df::modules::linkedin::profile::mod() {

  p6_return_words 'linkedin' '$LINKEDIN_API_KEY'
}
