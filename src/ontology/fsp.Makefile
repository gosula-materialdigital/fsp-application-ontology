## Customize Makefile settings for fsp
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

## OBI import (minimal): same as the ODK-generated rule, but with "individuals"
## in --select (the generated rule says "individual", so ROBOT never removes the
## ~200 OBI individuals such as manufacturers and file formats).
ifeq ($(IMP),true)
$(IMPORTDIR)/obi_import.owl: $(MIRRORDIR)/obi.owl $(IMPORTDIR)/obi_terms.txt $(IMPORTSEED) | all_robot_plugins
	$(ROBOT) annotate --input $< --remove-annotations \
		 odk:normalize --add-source true \
		 extract --term-file $(IMPORTDIR)/obi_terms.txt $(T_IMPORTSEED) \
		         --copy-ontology-annotations true --force true --method BOT \
		 remove --axioms external --preserve-structure false --trim false \
		        --base-iri http://purl.obolibrary.org/obo/OBI_ \
		        --base-iri http://purl.obolibrary.org/obo/COB_0000110 \
		 odk:normalize --base-iri https://w3id.org/pmd --subset-decls true \
		               --synonym-decls true \
		 repair --merge-axiom-annotations true \
		 remove $(foreach p, $(ANNOTATION_PROPERTIES), --term $(p)) \
		        --term rdfs:label \
		        --term IAO:0000115 \
		        --term OMO:0002000 \
		        --term-file $(IMPORTDIR)/obi_terms.txt $(T_IMPORTSEED) \
		        --select complement \
		        --select "classes individuals annotation-properties" \
		 $(ANNOTATE_CONVERT_FILE)
endif

## ChEBI import (custom module, no mirror): imports/chebi_import.owl is a small fixed
## file and is NOT rebuilt by normal builds (ChEBI is several hundred MB).
## To add ChEBI terms: list them in imports/chebi_terms.txt, then run
##   sh run.sh make build-chebi-import
## It takes the listed terms and their ChEBI ancestors up to 'molecular entity'
## (CHEBI_23367, which PMD Core already contains).
ifeq ($(IMP),true)
$(IMPORTDIR)/chebi_import.owl:
	@test -f $@ || { echo "ERROR: $@ is missing; run 'make build-chebi-import'"; false; }
endif

.PHONY: build-chebi-import
build-chebi-import: | $(TMPDIR)
	curl -sSL http://purl.obolibrary.org/obo/chebi/chebi_lite.owl.gz -o $(TMPDIR)/chebi_lite.owl.gz
	$(ROBOT) extract --input $(TMPDIR)/chebi_lite.owl.gz --method MIREOT \
		 --lower-terms $(IMPORTDIR)/chebi_terms.txt \
		 --upper-term http://purl.obolibrary.org/obo/CHEBI_23367 \
		 --intermediates all \
		 remove --term rdfs:label --term IAO:0000115 --select complement --select annotation-properties \
		 annotate --ontology-iri $(URIBASE)/fsp/imports/chebi_import.owl \
		          --version-iri $(URIBASE)/fsp/releases/$(TODAY)/imports/chebi_import.owl \
		          --annotation owl:versionInfo $(TODAY) \
		 convert -f ofn --output $(IMPORTDIR)/chebi_import.owl
	rm -f $(TMPDIR)/chebi_lite.owl.gz
