catalog:
	(cd xml; cat */catalog > catalog)
	(cd xml; cat */catalog | grep "\.dtd\"" | grep "^PUBLIC"   | sed 's/\.dtd/\.ced/' > ecatalog)
	(cd sgml; cat */catalog | grep -v DTDDECL > catalog)
	(cd sgml; cat */catalog | grep "\.dtd\"" | grep "^PUBLIC"  | sed 's/\.dtd/\.ced/' > ecatalog)

