lesson_title "Return value"

test_return_value() {
  # &> redirects both the stdout and stderr to /dev/null
  # since we don't have a folder named 'ZOMGNODIRLIKETHIS', the 'cd' command will fail, and result in an exit code of 1
  cd /ZOMGNODIRLIKETHIS &> /dev/null

  # $? contains the exit status code of the last command executed
  assertEqual $? 1

  # this won't fail because we are executing the 'ls' command on the home folder
  ls ~/ > /dev/null

  assertEqual $? 0
}
