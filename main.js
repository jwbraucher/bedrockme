const puppeteer = require('puppeteer');

const minecraft_url = 'https://www.minecraft.net/en-us/download/server/bedrock';

async function executeJavaScript() {
  const browser = await puppeteer.launch({ 
    headless: true,
    pipe: true,
    args: [
      '--no-sandbox', 
      '--disable-gpu',
      '--disable-setuid-sandbox',
      '--disable-dev-shm-usage',
    ],
    executablePath: '/usr/bin/chromium-browser'
  });

  const page = await browser.newPage();
  const custom_user_agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36';
  await page.setUserAgent(custom_user_agent);

  await page.goto(minecraft_url);

  const result = await page.evaluate(() => {
    const title = document.title;
    const body = document.body.innerHTML;
    return { title, body };
  });

  console.log(result.body.match(/https.*bin-linux.*zip/g)[0]);
  await browser.close();
}

executeJavaScript();
