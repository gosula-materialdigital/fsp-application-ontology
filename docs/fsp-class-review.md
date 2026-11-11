# FSP class review: suggested definitions, parents and axioms

Review of all classes in `src/ontology/fsp-edit.owl` (state 2026-11-11, FSP_0000000–FSP_0000047).
Nothing here has been applied yet. Each item is a suggestion to accept, change or reject.

Conventions used for the suggestions:
- Definitions follow the **genus–differentia** form used by PMDco/OBO: *"A <parent class> that <what makes it special>."*
- Axioms are written in **Manchester syntax** (as typed in Protégé under *SubClass Of*) and are **SubClassOf** (necessary conditions), not EquivalentTo.
- **⚑** marks things that should be fixed regardless of the axioms (wrong parent, copied text, typo, unclear fact).
- Optional set-up parts (sheath gas, enclosure, second nozzle) get **no** "some" axiom on the whole process or reactor, so the ontology does not claim every run has them.

Terms that are not yet imported from PMDco and would need to go into `src/ontology/imports/pmdco_terms.txt`
are marked *(import)*: `gas` PMD_0020289, `liquid` PMD_0020290, `distance` PMD_0000141, `fraction property` PMD_0020101 (already a parent, ok),
`process attribute` PMD_0000008, `solvent role` PMD_0020228, `solute role` PMD_0020227, `has role` RO_0000087,
`has part` BFO_0000051, `part of` BFO_0000050, `has participant` RO_0000057, `occurs in` BFO_0000066,
`has specified output` OBI_0000299, `output of` RO_0002353, `has occurrent part` BFO_0000117. Several of these may already be
in the import as side effects. They will be listed explicitly when applied.

---

## 1. Processes

| ID | Label | Current | Suggested definition | Suggested axioms |
|----|-------|---------|----------------------|------------------|
| FSP_0000008 | nanoparticle synthesis | "A manufacturing process with the intend to synthesize nanoparticles." | A manufacturing process that has nanoparticles as its specified output. | `'has specified output' some nanoparticle` |
| FSP_0000009 | flame spray pyrolysis | "A manufacturing process with the intend to synthesize aggregated nanoparticles …" ⚑ genus says *manufacturing process*, but the parent is *nanoparticle synthesis* | A nanoparticle synthesis in which a precursor solution is atomised by a dispersion gas into a spray and combusted in a flame, so that nanoparticles form in the gas phase. | `'has specified input' some precursor`<br>`'has occurrent part' some 'precursor feeding process'`<br>`'has occurrent part' some 'dispersion gas flow process'`<br>`'has occurrent part' some 'fuel gas flow process'`<br>`'has occurrent part' some 'oxygen gas flow process'`<br>`'occurs in' some 'flame spray pyrolysis reactor'`<br>(no sheath gas axiom, since it is optional) |
| FSP_0000028 | precursor feeding process | – | A continuous transport in which the precursor solution is fed at a controlled feed rate through the capillary of the nozzle. | existing: `'has specified input' some precursor`, `'has process attribute' some 'precursor feed rate'`<br>add: `'has participant' some 'syringe pump'` |
| FSP_0000029 | gas flow process | – | A continuous transport in which a gas is supplied at a controlled flow rate to a flame spray pyrolysis reactor. | `'has specified input' some gas` *(import gas)*<br>`'has participant' some 'mass flow controller'`<br>`'has process attribute' some 'gas flow'` |
| FSP_0000035–38 | oxygen / fuel / dispersion / sheath gas flow process | defined today | (keep) | (keep; they inherit the mass flow controller axiom from *gas flow process*) |

## 2. Materials and gases

| ID | Label | Current | Suggested definition | Suggested parent / axioms |
|----|-------|---------|----------------------|---------------------------|
| FSP_0000023 | precursor | "Liquid solution composed of solvent and solute that is dispersed and combusted in a flame spray pyrolysis process." | A solution of one or more metal-containing solutes in a solvent that is fed to a flame spray pyrolysis process and combusted to form nanoparticles. | parent ⚑ `fluid (object)` → **`solution`** (PMD_0020229)<br>`'has part' some solvent`<br>`'has part' some solute` |
| FSP_0000024 | solvent | – (missing) | A liquid that bears a solvent role in a precursor solution; it dissolves the solutes and is the main fuel of the spray flame (e.g. xylene, ethanol, 2-ethylhexanoic acid). | parent `fluid (object)` → **`liquid`** *(import)*<br>`'has role' some 'solvent role'` |
| FSP_0000025 | solute | – (missing) | A portion of matter that bears a solute role in a precursor solution and supplies the metal of the product nanoparticles (e.g. a metal-organic compound or metal salt). | parent ⚑ `object` (BFO) → **`portion of matter`** (PMD_0000001); a dissolved substance is not an object<br>`'has role' some 'solute role'` |
| FSP_0000007 | dispersion gas | "Gas which is used to disperse a liquid into droplets." | A gas (typically oxygen) that flows through the annular gap of the nozzle and atomises the precursor solution into a spray; it also supplies oxygen for the spray combustion. | parent `fluid (object)` → **`gas`** *(import)* |
| FSP_0000006 | fuel gas | "Educt gas taking part in a combustion process." | A combustible gas (typically methane) that is burned together with the oxidation gas in the pilot flame to ignite and stabilise the spray flame. | parent → **`gas`** |
| FSP_0000005 | oxidation gas | "Educt gas which contributes as an oxygen source in a combustion process." | A gas (typically oxygen) that is premixed with the fuel gas and supplies the oxidant for its combustion in the pilot flame. | parent → **`gas`** |
| FSP_0000004 | sheath gas | "Gas which protects an entity from ambient influences, e.g. oxygen entrainment." | A gas that is supplied around the flame of a flame spray pyrolysis reactor to shield it from ambient influences (e.g. entrainment of ambient air) and to stabilise it. | parent → **`gas`** |
| FSP_0000010 | nanoparticle | "A nanoscale particle" (circular) | An engineered material that is a particle with all three external dimensions in the nanoscale (approx. 1–100 nm, cf. ISO/TS 80004-1). | `'output of' some 'nanoparticle synthesis'` |

> Gases: the alternative, role-based model (the same O₂ portion bearing a *dispersion gas role* or an *oxidation gas role*) was discussed separately. The suggestions above keep your current class-based model and only move the classes under `gas`.

## 3. Devices and components

| ID | Label | Current | Suggested definition | Suggested axioms / notes |
|----|-------|---------|----------------------|--------------------------|
| FSP_0000002 | reactor | "An entity which contains and controls a process." (too broad) | A device that encloses a space in which a chemical reaction is carried out under controlled conditions. | – |
| FSP_0000003 | flame spray pyrolysis reactor | "static experimental set-up of the flame spray pyrolysis process, including nozzle and deposition specifications" | A reactor in which flame spray pyrolysis is carried out; it comprises at least one nozzle, a nanoparticle filter and a vacuum pump, and optionally an enclosure. | `'has part' some nozzle`<br>`'has part' some 'nanoparticle filter'`<br>`'has part' some 'vacuum pump'`<br>(no enclosure axiom: open reactors exist) |
| FSP_0000016 | enclosure | "Physical hollow body which surrounds an entitiy …" (typo) | A component that is a hollow body surrounding the flame of a flame spray pyrolysis reactor to protect the process from ambient influences (closed reactor). | `'part of' some 'flame spray pyrolysis reactor'` |
| FSP_0000017 | nozzle | ⚑ "A short tube with a taper or constriction used (as on a hose) to speed up or direct a flow of fluid." This is a dictionary definition taken over verbatim; replace it with your own wording. | A component of a flame spray pyrolysis reactor that comprises a capillary for the precursor solution, an annular gap for the dispersion gas and a pilot flame ring, and forms the spray and the flame. | `'part of' some 'flame spray pyrolysis reactor'` |
| FSP_0000018 | spray syn nozzle | "A standard for a free-jet type burner …" (genus is "standard") | A nozzle built to the SpraySyn standard burner design, a free-jet spray flame burner with well-defined, simulation-friendly boundary conditions and geometry and optical access for diagnostics. | label → **"SpraySyn nozzle"** (proper name) |
| FSP_0000019 | tethis nozzle | detailed geometry | (keep the geometry, start with "A nozzle that …") | label → **"Tethis nozzle"**. ⚑ Text says *"Precursor and fuel flow through the capillary tube"*. In the usual design only the precursor (liquid) flows through the capillary; fuel gas goes through the pilot ring. Please check whether "fuel" here means the liquid fuel (solvent) and reword. |
| FSP_0000013 | deposition component | "The component used to separate an entity from a gas flow, e.g. a filter." | A component that separates particles from a gas flow and collects them, e.g. a filter. | – |
| FSP_0000014 | nanoparticle filter | ok | A deposition component on which nanoparticles from the off-gas accumulate and from which they can later be scraped off. | `'part of' some 'flame spray pyrolysis reactor'` |
| FSP_0000015 | GD/F filter | "Filter class, made of amorphous silicon dioxide." | A nanoparticle filter made of glass microfibre (amorphous silicon dioxide) of grade … | ⚑ **Label check:** glass-fibre filter grades are named GF/A, GF/B, GF/C, **GF/D**, **GF/F**; "GD/F" does not exist. Probably GF/D or GF/F. Please check the filter box. |
| FSP_0000020 | vacuum pump | "A piece of equipment for removing air or gas from a container …" (general dictionary style) | A device that removes gas from an enclosed volume; in a flame spray pyrolysis reactor it draws the off-gas with the particles through the nanoparticle filter. | `'part of' some 'flame spray pyrolysis reactor'`. Note: parent is *component*, while syringe pump and mass flow controller are *device*; as part of the reactor, *component* is fine. |
| FSP_0000030 | mass flow controller | – (missing) | A device that measures the mass flow of a gas and controls it to a set point. | – (linked from *gas flow process* via `has participant`) |
| FSP_0000031 | syringe pump | – (missing) | A device that delivers a liquid at a constant, set volumetric flow rate by advancing the plunger of a syringe. | – (linked from *precursor feeding process*) |
| FSP_0000032 | pipette | – (missing) | A device for transferring a defined volume of liquid; used to dose solute and solvent when preparing a precursor solution. | – |

## 4. Process attributes and qualities

| ID | Label | Current | Suggested definition | Suggested parent / axioms |
|----|-------|---------|----------------------|---------------------------|
| FSP_0000001 | pressure drop | "A significant change in pressure measured over a time span or in a direction." (vague: "significant", time *or* direction) | A process attribute of a fluid flow process that is the difference between the static pressure of the fluid upstream and downstream of a flow-restricting component, e.g. the nozzle gap or the filter. | parent ⚑ `pressure` → **`process attribute`** *(import)*; later subclasses *nozzle pressure drop* / *filter pressure drop* (ELN: "pressure drop at nozzle [bar]", "final pressure drop [mbar]") |
| FSP_0000026 | feed rate | "Temporal rate with which a defined volume of a species is fed into a process." | A flow rate that is the volume of a liquid fed into a process per unit time. | (ok) |
| FSP_0000027 | gas flow | "The volume flow of a gas." | A flow rate that is the volume of a gas supplied per unit time. | Note: mass flow controllers usually work in **standard** litres per minute (slm, at reference temperature and pressure). If the IWT values are slm, say so in the definition or in the unit. |
| FSP_0000021 | molarity | ⚑ "Molarity is a unit of concentration …" (it is a property, not a unit) | A fraction property of a solution that is the amount of substance of a solute per volume of the solution, usually expressed in mol/L. | `'quality of' some solution` *(optional)* |
| FSP_0000022 | purity | ⚑ "The quality or state of being pure" (dictionary wording, circular) | A fraction property of a portion of matter that is the proportion of its main substance, e.g. a gas purity grade 5.0 corresponds to 99.999 %. | parent `relational quality` → **`fraction property`** (PMD_0020101), the same parent as molarity |
| FSP_0000011 | nozzle nozzle distance | "Euclidean distance between  the annular gaps of two nozzles." | A distance between the outlets (annular gaps) of two nozzles in a multi-flame flame spray pyrolysis reactor. | parent `length` → **`distance`** *(import)*; label → **"nozzle-nozzle distance"** |
| FSP_0000012 | nozzle filter distance | "Distance bewtween …" (typo) | A distance between the outlet (annular gap) of a nozzle and the filter medium. | parent → **`distance`**; label → **"nozzle-filter distance"** |
| FSP_0000000, 39–42 | gas flow rates, precursor feed rate | defined today | (keep) | ⚑ FSP_0000000 should get a regular ID (FSP_0000048) |

## 5. Information entities

| ID | Label | Current | Suggested definition | Suggested axioms |
|----|-------|---------|----------------------|------------------|
| FSP_0000033 | mixing recipe | – (missing) | A recipe that specifies the solutes, solvents and their amounts for preparing a precursor solution. | – |
| FSP_0000034 | flame spray pyrolysis recipe | – (missing) | A recipe that specifies the set points of a flame spray pyrolysis process, such as gas flow rates, precursor feed rate and nozzle settings. | `'has part' some 'specified precursor feed rate datum'`<br>`'has part' some 'specified dispersion gas flow rate datum'`<br>`'has part' some 'specified fuel gas flow rate datum'`<br>`'has part' some 'specified oxygen gas flow rate datum'`<br>(no sheath gas datum axiom, since it is optional) |
| FSP_0000043–47 | specified … datum | defined today | (keep) | (keep) |

## 6. Labels

- Proper names capitalised: **SpraySyn nozzle**, **Tethis nozzle**.
- Hyphenated compounds: **nozzle-nozzle distance**, **nozzle-filter distance**.
- German labels exist for 2 classes (Flammensprühpyrolyse, Reinheit). Either add `@de` labels for all classes or for none. The ODK report also flags two labels per class as an issue; moving German to `skos:altLabel` avoids that.
- All definitions should get the language tag `@en` (the older ones have none).
