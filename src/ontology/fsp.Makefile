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
