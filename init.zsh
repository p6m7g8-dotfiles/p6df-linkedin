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

######################################################################
#<
#
# Function: p6df::modules::linkedin::profile::on(profile, code)
#
#  Args:
#	profile -
#	code - shell code block (export LINKEDIN_ACCESS_TOKEN=... LINKEDIN_PERSON_URN=...)
#
#  Environment:	 LINKEDIN_ACCESS_TOKEN LINKEDIN_PERSON_URN P6_DFZ_PROFILE_LINKEDIN
#>
######################################################################
p6df::modules::linkedin::profile::on() {
  local profile="$1"
  local code="$2"

  p6_run_code "$code"

  p6_env_export "P6_DFZ_PROFILE_LINKEDIN" "$profile"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::linkedin::profile::off(code)
#
#  Args:
#	code - shell code block previously passed to profile::on
#
#  Environment:	 LINKEDIN_ACCESS_TOKEN LINKEDIN_PERSON_URN P6_DFZ_PROFILE_LINKEDIN
#>
######################################################################
p6df::modules::linkedin::profile::off() {
  local code="$1"

  p6_env_unset_from_code "$code"
  p6_env_export_un P6_DFZ_PROFILE_LINKEDIN

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
