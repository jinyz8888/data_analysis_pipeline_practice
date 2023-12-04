# Makefile
# Tiffany Timbers, Nov 2018

# Variables
DATA_DIR = data
RESULTS_DIR = results
FIGURES_DIR = $(RESULTS_DIR)/figure
WORDCOUNT_SCRIPT = scripts/wordcount.py
PLOTCOUNT_SCRIPT = scripts/plotcount.py

.PHONY: all clean count_words plot_counts report

all: count_words plot_counts report

count_words: $(RESULTS_DIR)/isles.dat $(RESULTS_DIR)/abyss.dat $(RESULTS_DIR)/last.dat $(RESULTS_DIR)/sierra.dat

plot_counts: $(FIGURES_DIR)/isles.png $(FIGURES_DIR)/abyss.png $(FIGURES_DIR)/last.png $(FIGURES_DIR)/sierra.png

report:
	jupyter-book build report

$(RESULTS_DIR)/%.dat: $(DATA_DIR)/%.txt
	python $(WORDCOUNT_SCRIPT) --input_file=$< --output_file=$@

$(FIGURES_DIR)/%.png: $(RESULTS_DIR)/%.dat
	python $(PLOTCOUNT_SCRIPT) --input_file=$< --output_file=$@

clean:
	rm -f $(RESULTS_DIR)/*.dat
	rm -f $(FIGURES_DIR)/*.png
	jupyter-book clean report

