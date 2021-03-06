# Copyright (c) 2008-2009 solvethis
# Copyright (c) 2010-2012 Casper Ti. Vector
# Public domain.

# 被编译的主文件的文件名，不包括扩展名。
JOBNAME = main
# 这个变量的值可以为 latex、pdflatex 或 xelatex。
LATEX = xelatex
BIBTEX = biber -l zh__pinyin
DVIPDF = dvipdfmx

# 如果用 LaTeX 编译，则使用 dvipdfmx 将 dvi 转成 pdf。
ifeq ($(LATEX), latex)
	DODVIPDF = $(DVIPDF) $(JOBNAME)
endif

# 区分是 Windows 环境还是类 UNIX 环境。
# 如果是后者，则 GNU make 将可以检测到已经定义 PATH 环境变量。
ifdef PATH
	MAKE = make
	RM = rm -f
else
	MAKE = mingw32-make
	RM = del
endif

doc:
	$(LATEX) $(JOBNAME)
	$(BIBTEX) $(JOBNAME)
	$(LATEX) $(JOBNAME)
	$(LATEX) $(JOBNAME)
	$(DODVIPDF)
	
doc1:
	$(LATEX) $(JOBNAME)
	
doc2:
	$(LATEX) $(JOBNAME)
	$(LATEX) $(JOBNAME)

clean:
	$(RM) $(JOBNAME).aux $(JOBNAME).bbl $(JOBNAME).bcf $(JOBNAME).blg \
		$(JOBNAME).dvi $(JOBNAME).lof $(JOBNAME).log $(JOBNAME).lot \
		$(JOBNAME).run.xml $(JOBNAME).toc $(JOBNAME).out $(JOBNAME).bak \
		missfont.log texput.log x.log */*.aux */*~ *~

distclean: clean
	$(RM) $(JOBNAME).pdf

# vim:ts=4:sw=4
