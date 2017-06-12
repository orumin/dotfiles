#!/usr/bin/env perl

$latex = 'uplatex %O -interaction=batchmode -synctex=1 %S';
$pdflatex = 'lualatex %O -synctex=1 %S';
$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$bibtex = 'upbibtex';
#$dvipdf = 'dvipdfmx %O -o $D %S';
$dvipdf = 'dvipdfmx %O %S';
$dvips = 'dvips %O -z -f -%S | convbkmk -u > %D';
$ps2pdf = 'ps2pdf %O %S %D';
$pdf_mode = 3;
$makeindex = 'mendex %O -o %D %S';
$max_repaet = 3;
$pdf_previewer = 'xdg-open';
