# Package

version       = "0.1.0"
author        = "Pietro Peterlongo"
description   = "A port of mdbook to nim"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.4.0"
requires "nimib >= 0.1.2"
requires "jsony >= 1.0.1"

import os
task genbook, "build book":
  selfExec(" r -d:release genbook.nim")

task dumptoc, "dump toc.json":
  selfExec(" r -d:release -d:dumpToc genbook.nim")

task cleanbook, "remove all files created during build":
  # todo: it should remove all files and directories not tracked in git from docs
  for file in walkDirRec("docs"):
    if file.endsWith(".html"):
      rmFile(file)
      echo "removed ", file
  for file in ["book/toc.json"]: # hardcoded files to remove (one for now)
    if fileExists(file):
      rmFile(file)
      echo "removed ", file
  # if by mistake I create html in book folder, remove them
  for file in walkDirRec("book"):
    if file.endsWith(".html"):
      rmFile(file)
      echo "removed ", file


task srcpretty, "run nimpretty on nim files in src folder":
  for file in walkDirRec("src"):
    if file.endsWith(".nim"):
      let cmd = "nimpretty --maxLineLen:160 " & file
      echo "[executing] ", cmd
      exec(cmd)
