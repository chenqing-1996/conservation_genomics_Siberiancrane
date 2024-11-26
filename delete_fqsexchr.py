#!/usr/bin/env python3.6.4
# coding: utf-8
# Author: jyro

zifu = ''
cut = False
f2 =open('path/to/SC01W_withoutsexchr.fq','a+')
fi = open('path/to/sex_contig.txt','r')
scalist = []
for lin in fi:
    scalist.append(lin)
with open ('path/to/SC01W.fq','r')as f:
    for line in f:
        if line.startswith('@Contig') or line.startswith('@C1'):
            for lin in scalist:
                if zifu.startswith(lin) or zifu.startswith(lin):
                    cut = True
            if cut:
                zifu = line
            if not cut:
                print(zifu,file = f2)
                zifu =line
            cut = False
        else:
            zifu +=line
f.close()
fi.close()
f2.close()
