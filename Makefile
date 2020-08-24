# Terraform helper Makefile.
.PHONY: setup setup-gitignore docs docs-md \
				tg-plan tg-apply
GI_TEMPLATES := Global/Windows.gitignore Global/Linux.gitignore Global/macOS.gitignore \
								Global/VisualStudioCode.gitignore Global/Vim.gitignore \
								Terraform.gitignore

# Include any .env file for further environment variables.
-include .env

setup:
	@make -s setup-gitignore

setup-gitignore:
	$(info ===> Generating a default .gitignore)
	# Zero out the .gitignore or start a new one.
	echo -n > .gitignore
	# Fetch all the .gitignore templates into one .gitignore.
	for t in $(GI_TEMPLATES); do curl https://raw.githubusercontent.com/github/gitignore/master/$$t >> .gitignore ; done

# Do all the documentation steps
docs:
	@make -s docs-md

# Generate markdown documentation.
docs-md:
	$(info ===> Generating markdown documentation)
	terraform-docs md > docs/specs.md
