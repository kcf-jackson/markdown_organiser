shiny:
	scp -r ./src/* ./shiny_markdown_organiser/src/
	scp -r ./assets/* ./shiny_markdown_organiser/assets/
	scp -r ./data/* ./shiny_markdown_organiser/data/
	scp -r ./img/* ./shiny_markdown_organiser/www/img/

clean:
	rm -r ./shiny_markdown_organiser/src/
	rm -r ./shiny_markdown_organiser/assets/
	rm -r ./shiny_markdown_organiser/data/
	rm -r ./shiny_markdown_organiser/www/img/
	mkdir ./shiny_markdown_organiser/src/
	mkdir ./shiny_markdown_organiser/assets/
	mkdir ./shiny_markdown_organiser/data/
	mkdir ./shiny_markdown_organiser/www/img/
