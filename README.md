# md2pdf
## Описание
Простой скрипт для установки конвертера Markdown2PDF. Требует наличия установленного пакета TexLive-Full или, по крайней мере, пакетов LaTeX, перечисленных в преамбуле TeX шаблона проекта *template.tex*. В случае использования Ubuntu-based дистрибутива в случае необходимости установит необходимые пакеты. В случае использования другого дистрибутива, установите **texlive-full** и **pandoc** методами своей системы.

## Заметки по использованию

В шаблоне методом проб и ошибок настроена корректная конвертация md2pdf.

Замеченные моменты, которые следует упомянуть - в блоках исходного кода строки, которые начинаются с русских символов, должны начинатся по крайней мере с одного пробела, иначе в итоговом блоке кода в PDF это будет выглядеть так:

```bash
apt search brainили 
apt install brainили 
apt remove --purge brain
```
Хотя должны выглядеть так:
```bash
apt search brain
или
apt install brain
или 
apt remove --purge brain
```
Комментариев в коде это тоже касается. Используя тот же пример, если комментарий имеет вид **#Какой нибудь текст на русском**, то получится так:
```bash
apt search brainКакой 
#нибудь текст на русском
apt install brainКакой 
#нибудь текст на русском
apt remove --purge brain
```
А если **# Какой нибудь текст на русском**, то:
```bash
apt search brain
# Какой нибудь текст на русском
apt install brain
# Какой нибудь текст на русском
apt remove --purge brain
```
## Установка

Откройте терминал и выполните:
```bash
git clone https://github.com/melichron/md2pdf.git && cd md2pdf
```
Затем выполните с правами суперпользователя, например:
```bash
sudo ./install.sh
```
Имейте в виду скрипт использует утилиту для построения консольных диалогов **whiptail**. Если она у вас не установлена, или ставить ее вы не желаете, или хотите все сделать сами, то установите **texlive-full** и **pandoc** вручную и действуйте по инструкции дальше.

Установка **md2pdf** для всех пользователей:
```bash
root@host:~/md2pdf# cp ./src/template.tex $(kpsewhich -expand-var='$TEXMFLOCAL')
root@host:~/md2pdf# echo "#!/bin/bash" | tee usr/local/bin/md2pdf
root@host:~/md2pdf# echo "pandoc --output=\$1.pdf --from=markdown_github --latex-engine=pdflatex --listings --template=$(kpsewhich -expand-var='$TEXMFLOCAL')/template.tex \$1" | tee -a usr/local/bin/md2pdf
root@host:~/md2pdf# chmod 755 /usr/local/bin/md2pdf
```
Установка **md2pdf** для текущего пользователя:
```bash
user@host:~/md2pdf$ cp ./src/template.tex $(kpsewhich -expand-var='$TEXMFHOME')
user@host:~/md2pdf$ echo "#!/bin/bash" | tee ~/.local/bin/md2pdf
user@host:~/md2pdf$ echo "pandoc --output=\$1.pdf --from=markdown_github --latex-engine=pdflatex --listings --template=$(kpsewhich -expand-var='$TEXMFHOME')/template.tex \$1" | tee -a ~/.local/bin/md2pdf
user@host:~/md2pdf$ chmod 755 ~/.local/bin/md2pdf
```
