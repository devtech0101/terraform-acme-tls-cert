# Do all the documentation steps
docs:
	@make -s docs-md

# Generate markdown documentation.
docs-md:
	$(info ===> Generating markdown documentation)
	terraform-docs md > docs/specs.md