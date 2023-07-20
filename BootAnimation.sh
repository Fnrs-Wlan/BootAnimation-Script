#!/system/bin/sh
function main(){
  if [ -e temp ]; then
  sleep 0.1
  else
  mkdir temp
  fi
  clear
  echo " "
  echo "Selected Path [$path]"
  echo "Simple BootAnimation Script"
  echo "[1] Select Path"
  echo "[2] Create Module with Bootanim"
  echo "[3] Backup Bootanim"
  echo "[4] Exit Script"
  echo " "
  read a
  
  if [ "$a" -eq 1 ]; then
  savePath
  fi
  
  if [ "$a" -eq 2 ]; then
  module
  fi
  
  if [ "$a" -eq 3 ]; then
  backup
  fi
  
  if [ "$a" -eq 4 ]; then
  echo "Goodbye"
  sleep 1
  exit
  fi
}

function savePath(){
  clear
  echo " "
  echo "Selected Path [$path]"
  echo "Look for the folder containing"
  echo "the Bootanimation and select"
  echo "Correct Path"
  echo "[1] /system/product/media"
  echo "[2] /system/media"
  echo "[3] /system/customize/resource"
  echo "[4] Custom Path"
  echo "[5] Back"
  echo " "
  read d
  
  if [ "$d" -eq 1 ]; then
  path=system/product/media
  nmbr=1
  sleep 0.5
  main
  fi
  if [ "$d" -eq 2 ]; then
  path=system/media
  nmbr=2
  sleep 0.5
  main
  fi
  if [ "$d" -eq 3 ]; then
  path=system/customize/resource
  nmbr=3
  sleep 0.5
  main
  fi
  if [ "$d" -eq 4 ]; then
  clear
  echo " "
  echo "If your Path starts at Root dont add"
  echo "the /"
  echo "e.g. /system/media -> system/media"
  echo " "
  read path
  nmbr=4
  main
  fi
  if [ "$d" -eq 5 ]; then
  sleep 0.5
  main
  fi
}

#Copys the Bootanimation from the /system/product/media Path
function backup(){
  clear
  echo " "
  echo "Selected Path [$path]"
  echo "Backup gets created to /backup in"
  echo "the Directory of the Script"
  echo "[1] Create Backup"
  echo "[2] Output Path to Backup"
  echo "[3] Back"
  echo " "
  read b
  if [ "$b" -eq 1 ]; then
  if [ -e backup ]; then
  rm -r backup
  mkdir backup
  cp /$path/bootanimation.zip backup/bootanimation.bak
  backup
  else
  mkdir backup
  cp /$path/bootanimation.zip backup/bootanimation.bak
  backup
  fi
  fi
  if [ "$b" -eq 2 ]; then
  find "$(pwd)" -name "bootanimation.bak" | grep ".*"
  if [ "$?" -ne 0 ]; then
  echo "No Backup Created"
  sleep 3
  backup
  fi
  sleep 5
  backup
  fi
  if [ "$b" -eq 3 ]; then
  sleep 1
  main
  fi
}
#Used to Create Magisk Modules
function module(){
  clear
  echo " "
  echo "Selected Path [$path]"
  echo "Make sure your Bootanimation is in"
  echo "the same Folder as this Script and"
  echo "that its called Bootanimation.zip"
  echo "[1] Create Module"
  echo "[2] Remove Module"
  echo "[3] Back"
  echo " "
  read c
  if [ "$c" -eq 1 ]; then
  if [ "$nmbr" -ne 0 ]; then
  clear
  echo ""
  echo "Input a Name for the Module"
  echo ""
  read name
  cp Bootanimation.zip temp/bootanimation.zip
  sleep 0.5
  mkdir -p /data/adb/modules/$name/$path
  sleep 0.5
  cp temp/bootanimation.zip /data/adb/modules/$name/$path/bootanimation.zip
  sleep 0.5
  chmod +x /data/adb/modules/$name/$path/bootanimation.zip
  echo "Module created"
  sleep 2
  rm -r temp
  module
  else
  echo "No Path selected"
  sleep 2
  module
  fi
  fi
  if [ "$c" -eq 2 ]; then
  clear
  echo " "
  search_dir=/data/adb/modules
  for entry in "$search_dir"/*
  do
  echo "$entry"
  done
  echo "Input Module Name to remove"
  echo " "
  read modName
  rm -r /data/adb/modules/$modName
  sleep 1
  module
  fi
  if [ "$c" -eq 3 ]; then
  main
  fi
}
main