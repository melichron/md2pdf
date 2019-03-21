#!/usr/bin/env bash

if [ $(id -u) != 0  ]
then
echo "Must be executed with root rights!.."
exit 1
fi

which whiptail; WHIP=$?
case $WHIP in
'0')
;;
'1')
echo "Need installed whiptail, trying to install"
apt install whiptail -y; WHIP=$?
    case $WHIP in
    '0')
    echo "Whiptail successfully installed"
    ;;
    '1')
    echo "Whiptail not installed, try to install it manually"
    exit 1
    ;;
    esac
esac

INSTALLTYPE=$(whiptail --title  "md2pdf install" --menu  "Choose install type" 15 60 4 \
"1" "For all users" \
"2" "Only for current user"  3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ];  then

     case $INSTALLTYPE in
     1)
     TEXFOLDER=$(kpsewhich -expand-var='$TEXMFLOCAL')
     EXECPATH="/usr/local/bin/"
     ;;
     2)
    TEXFOLDER=$(kpsewhich -expand-var='$TEXMFHOME')
    EXECPATH="$HOME/.local/bin"
    ;;
    esac
else
     echo "You chose Cancel."
     exit 0
fi

dpkg -s texlive-full pandoc; inststatus=$?

case $inststatus in
'0')
echo "TexLiv and Pandoc installed"
;;
'1')
echo "Texlive-full or Pandoc not installed, installing..."
apt install pandoc texlive-full -y
;;
esac


cp -r ./src/template.tex $TEXFOLDER
echo "#!/bin/bash" | tee ./src/md2pdf
echo "pandoc --output=\$1.pdf --from=markdown_github --latex-engine=pdflatex --listings --template=$TEXFOLDER/template.tex \$1" | tee -a ./src/md2pdf
cp -r ./src/md2pdf $EXECPATH/
chmod 555 $EXECPATH//md2pdf

echo "md2pdf installed"
