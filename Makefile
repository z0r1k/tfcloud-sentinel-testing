pack:
	@echo ">>> Creating package..."
	@zip -r function.zip index.js
	@echo ">>> Done."

fmt:
	@echo ">>> Formatting..."
	@terraform fmt -recursive
	@echo ">>> Done."
