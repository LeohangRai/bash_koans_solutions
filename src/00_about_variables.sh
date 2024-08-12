# About environment variables

lesson_title "Variables"

test_setting_the_variable() {
  local variable=1
  assertEqual 1 $variable
}

test_using_double_quotes() {
  local variable=2
  assertEqual "foo $variable" "foo 2"
}

test_unsetting_variables() {
  local newVariable="Foooo"
  unset newVariable # the 'unset' command undefines the variable
  assertEqual $newVariable 
}

# Variables defined in global namespace are available everywhere
THIS_VARIABLE_IS_GLOBAL=42
test_global_variables() {
  assertEqual $THIS_VARIABLE_IS_GLOBAL 42
}

# In this function we define a global variable, it becomes available outside
function_with_a_global_variable() {
  THIS_VARIABLE_IS_GLOBAL_FROM_A_FUNCTION=42
}
# Run the function
function_with_a_global_variable

test_global_variables_from_functions() {
  assertEqual $THIS_VARIABLE_IS_GLOBAL_FROM_A_FUNCTION 42
}

# In this function we define a local variable, it is not accessible outside
function_with_a_local_variable() {
  local THIS_VARIABLE_IS_LOCAL=42
}
# Run the function
function_with_a_local_variable

test_local_variables() {
  assertEqual $THIS_VARIABLE_IS_LOCAL # the local variable 'THIS_VARIABLE_IS_LOCAL' is not defined within the scope of this function but in another function
}

test_variable_name_expansion_within_text() {
  local var1=myvar
  assertEqual this_is_${var1}_yay this_is_myvar_yay
}

# 'support/variable_check' is the path to the 'variable_check' file in the 'support' folder
# the contents of the file are:
# printf "%s" "$MY_EXPORTED_VARIABLE"
test_only_exported_variables_are_accessible_by_another_process() {
  # The $(support/variable_check) command runs a subshell, resulting in a different process
  # note that sourcing (using the 'source' command) is different from what we have done here.
  # the variable must be exported using the 'export' command in order for it to be accessible by other processes
  local MY_EXPORTED_VARIABLE=43

  assertEqual "$(support/variable_check)"

  MY_EXPORTED_VARIABLE=43

  assertEqual "$(support/variable_check)" 

  export MY_EXPORTED_VARIABLE=43

  assertEqual "$(support/variable_check)" 43
}

