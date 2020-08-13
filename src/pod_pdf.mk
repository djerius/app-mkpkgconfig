##============================================================================
## pod_pdf.mk

%C%_POD_PDF_MK =

## Prerequistes:
HOOKS_MK +=
%C%_POD_ALL_MK +=

##----------------------------------------
## caller must define these
##
## A simple list of POD files to process.  Just the basename's, no suffix.
## No Make Magic
%C%_PODS +=

## A simple list of the generated PDF files.  No Make Magic!
%C%_POD_PDF +=

## the suffix of the files containing POD
%C%_POD_SFX +=

dist_pdf_DATA		+= $(%C%_POD_PDF)

if MST_POD_GEN_DOCS_PDF

MAINTAINERCLEANFILES	+= $(%C%_POD_PDF)

CLEANFILES	+= $(%C%_POD_PDF)

SUFFIXES	+= .pdf $(%C%_POD_SFX)

if MST_POD_GEN_DOCS_PDF_MAN_PS

SUFFIXES	+= .man .ps .pdf

$(POD_SFX).man:
	pod2man  --release=' ' --center=' ' $< > $@

.man.ps:
	groff -man $< > $@

.ps.pdf :
	ps2pdf $< $@

endif  MST_POD_GEN_DOCS_PDF_MAN_PS

if HAVE_POD2PDF

$(%C%_POD_SFX).pdf:
	pod2pdf --title=`basename $< $(%C%_POD_SFX)` --output-file $@ --page-size=Letter $<

endif  HAVE_POD2PDF

else !MST_POD_GEN_DOCS_PDF

## can't create documentation.  for end user, the distributed
## documentation will get installed.

## for maintainer, must create fake PDF docs or make will fail,
## but don't distribute

$(%C%_POD_SFX).pdf:
	touch $@

DIST_HOOKS += POD_PDF_FALSE_DIST_HOOK
.PHONY: POD_PDF_FALSE_DIST_HOOK
POD_PDF_FALSE_DIST_HOOK:
	echo >&2 "Cannot create distribution as cannot create PDF documentation"
	echo >&2 "Install ps2pdf or App::pod2pdf (from CPAN)"
	false

endif !MST_POD_GEN_DOCS_PDF



