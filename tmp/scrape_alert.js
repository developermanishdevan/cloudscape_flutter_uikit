const axios = require('axios');
const cheerio = require('cheerio');
const fs = require('fs');

async function scrapeAlert() {
    const url = 'https://cloudscape.design/components/alert/';

    try {
        const response = await axios.get(url);
        const $ = cheerio.load(response.data);

        // We want the text content of the page
        $("script, style").remove();
        const content = $('main').text().replace(/\s+/g, ' ').trim();

        fs.writeFileSync('alert_scraped.txt', content || $('body').text().replace(/\s+/g, ' ').trim());
        console.log("Alert content successfully scraped and saved to alert_scraped.txt");
    } catch (error) {
        console.error("Error scraping alert:", error);
    }
}

scrapeAlert();
