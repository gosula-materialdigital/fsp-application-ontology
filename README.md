# Flame Spray Pyrolysis Ontology

Description: Application ontology for the flame spray pyrolysis (FSP) process for manufacturing nanoparticles, aligned with the PMD Core Ontology (PMDco). Developed at Leibniz-IWT Bremen.

The initial term set (FSP_0000001 – FSP_0000034) was migrated from the earlier FSP ontology v3 (`FSP-ontology-V3/src/fsp_v3.ttl`, see also https://github.com/Leibniz-IWT/PMD-FSP-Ontology). New terms continue from FSP_0000035 within the ID range in `src/ontology/fsp-idranges.owl`.


## Versions

### Stable release versions

The latest version of the ontology can always be found at:

https://w3id.org/pmd/fsp.owl

(note: this needs a w3id redirect for `pmd/fsp` pointing to this repository's GitHub Pages; see the w3id section below)

### Editors' version

Editors of this ontology should use the edit version, [src/ontology/fsp-edit.owl](src/ontology/fsp-edit.owl)

## Contact

Please use this GitHub repository's [Issue tracker](https://github.com/gosula-materialdigital/fsp-application-ontology/issues) to request new terms/classes or report errors or specific concerns related to the ontology.

## Acknowledgements

This ontology repository was created using the [Ontology Development Kit (ODK)](https://github.com/INCATools/ontology-development-kit).
## Development

This ontology is developed using OWL and managed with the [Ontology Development Kit (ODK)](https://github.com/INCATools/ontology-development-kit).
To contribute or edit:

- Open  in [Protege](https://protege.stanford.edu/) or your preferred OWL editor.
- Create new entities within the namespace .
  Example IRI: 
  (the prefix portion is always uppercase).
- Use the  for automation:
  -  : Run quality control (reasoner checks, syntax validation).
  -  : Update imported ontologies via SLME extraction.
  -  : Build all release artifacts (TTL, OWL, JSON formats).
  -  : Sync repo structure after editing .

## Import Architecture

The modular import structure used by this ontology:



## Repository Structure

| Path | Description |
|------|-------------|
|  | GitHub Actions CI/CD workflows |
|  | Ontology source files (edit here) |
|  | Modular OWL component files |
|  | Extracted import modules (SLME) |
|  | ROBOT template TSV files for components |
|  | External ontology imports configuration |
|  | Creator names for ID range allocation |

## Contribution

We welcome contributions to the Flame Spray Pyrolysis Ontology ontology!

- **Issue tracker**: [github.com/gosula-materialdigital/fsp-application-ontology/issues](https://github.com/gosula-materialdigital/fsp-application-ontology/issues)
  Report errors, request new terms, or flag modeling concerns.
- **Discussion forum**: [github.com/gosula-materialdigital/fsp-application-ontology/discussions](https://github.com/gosula-materialdigital/fsp-application-ontology/discussions)
  Discuss modeling decisions with the community.
- **Application ontology template**:
  [application-ontology-template](https://github.com/materialdigital/application-ontology-template/)
  The framework used here; mirrors pmdco with all its modules.
- **PMD Playground Meetings**: Every second Friday, 1-2 pm CET.
  [Register via mailing list](https://www.lists.kit.edu/sympa/subscribe/ontology-playground?previous_action=info)
- **Contact**: [info@material-digital.de](mailto:info@material-digital.de)
