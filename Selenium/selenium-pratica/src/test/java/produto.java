import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.openqa.selenium.JavascriptExecutor;

public class produto {
    @Test
    @DisplayName("Adicionar novos filtros para o resultado dos produtos")
    public void AdicionarNovosFiltrosResultadoProdutos(){
        System.setProperty("webdriver.chrome.driver", "src/test/resources/chromedriver");
        WebDriver driver = new ChromeDriver();
        driver.manage().window().maximize();
        Actions actions = new Actions(driver);
        WebDriverWait wait = new WebDriverWait(driver, 10);
        double limite = 50.0;

        driver.get("https://amazon.com.br");
        WebElement campoBusca = driver.findElement(By.xpath("//input[@id='twotabsearchtextbox']"));
        actions.moveToElement(campoBusca).click().perform();
        campoBusca.sendKeys("Mac");
        campoBusca.submit();
        wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//div[@data-component-type='s-search-result'][1]")));
        WebElement resultadoListaProduto1 = driver.findElement(By.xpath("//span[@data-component-type='s-search-results']"));
        String htmlDoElemento1 = resultadoListaProduto1.getAttribute("innerHTML");
        Assertions.assertTrue(htmlDoElemento1.contains("Apple notebook MacBook"));
        Assertions.assertTrue(htmlDoElemento1.contains("Batom Mac"));
        WebElement filtroMarcaLogitech = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//div[@id='brandsRefinements']//li[@aria-label='Logitech']//input")));
        actions.moveToElement(filtroMarcaLogitech).click().perform();
        WebElement resultadoListaProduto2 = driver.findElement(By.xpath("//span[@data-component-type='s-search-results']"));
        String htmlDoElemento2 = resultadoListaProduto2.getAttribute("innerHTML");
        Assertions.assertFalse(htmlDoElemento2.contains("Apple notebook MacBook"));
        Assertions.assertFalse(htmlDoElemento2.contains("Batom Mac"));
        Assertions.assertTrue(htmlDoElemento2.contains("Logitech Teclado mecânico"));
        Assertions.assertTrue(htmlDoElemento2.contains("Logitech MX Master"));
        WebElement filtroPreco = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//div[@id='priceRefinements']//span[text()='Até R$50']")));
        actions.moveToElement(filtroPreco).click().perform();
        wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//div[@data-cel-widget='search_result_1']//span[@class='a-price']")));
        WebElement produto1 = driver.findElement(By.xpath("//div[@data-cel-widget='search_result_1']//span[@class='a-price-whole']"));
        double precoProduto1 = Double.parseDouble(produto1.getText());
        Assertions.assertTrue(precoProduto1 <= limite);
        WebElement produto2 = driver.findElement(By.xpath("//div[@data-cel-widget='search_result_2']//span[@class='a-price-whole']"));
        double precoProduto2 = Double.parseDouble(produto2.getText());
        Assertions.assertTrue(precoProduto2 <= limite);
        WebElement produto3 = driver.findElement(By.xpath("//div[@data-cel-widget='search_result_3']//span[@class='a-price-whole']"));
        double precoProduto3 = Double.parseDouble(produto3.getText());
        Assertions.assertTrue(precoProduto3 <= limite);
        driver.close();
    }

    @Test
    @DisplayName("Interagir com as funcionalidades do reprodutor de vídeo dos produtos")
    public void InteragirReprodutorVideo() throws InterruptedException {
        System.setProperty("webdriver.chrome.driver", "src/test/resources/chromedriver");
        WebDriver driver = new ChromeDriver();
        driver.manage().window().maximize();
        Actions actions = new Actions(driver);
        WebDriverWait wait = new WebDriverWait(driver, 10);
        JavascriptExecutor js = (JavascriptExecutor) driver;

        driver.get("https://www.amazon.com.br/Logitech-MX-Master-3S-Superf%C3%ADcie/dp/B0B11LJ69K/ref=sr_1_2?__mk_pt_BR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=EY6N70D07TZP&keywords=logitech+mx+master+3s&qid=1682869534&sprefix=logitech+mx+master+3s%2Caps%2C251&sr=8-2&ufe=app_do%3Aamzn1.fos.25548f35-0de7-44b3-b28e-0f56f3f96147");
        wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@id='twotabsearchtextbox']")));
        js.executeScript("window.scrollBy(0,3300)");
        WebElement containerVideo = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//div[contains(@class,'vse-player-container')]")));
        WebElement reproduzirVideo = driver.findElement(By.xpath("//button[@title='Play Video']"));
        actions.moveToElement(reproduzirVideo).click().perform();
        actions.moveToElement(containerVideo);
        WebElement tempoReproducao = driver.findElement(By.xpath("//span[@class='vjs-remaining-time-display']"));
        actions.moveToElement(containerVideo);
        String valorTempoReproducao1 = tempoReproducao.getText();
        Thread.sleep(3000);
        actions.moveToElement(containerVideo);
        String valorTempoReproducao2 = tempoReproducao.getText();
        Assertions.assertFalse(valorTempoReproducao2.equals(valorTempoReproducao1));
        WebElement pausarVideo = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//button[@title='Pause']")));
        actions.moveToElement(containerVideo);
        actions.moveToElement(pausarVideo).click().perform();
        String valorTempoPausado1 = tempoReproducao.getText();
        String valorTempoPausado2 = tempoReproducao.getText();
        Assertions.assertTrue(valorTempoPausado2.equals(valorTempoPausado1));
        WebElement volumeSom = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//button[contains(@class,'vjs-mute-control')]")));
        actions.moveToElement(volumeSom).click().perform();
        String volumeSomDesligadoClass = volumeSom.getAttribute("class");
        Assertions.assertTrue(volumeSomDesligadoClass.contains("vjs-vol-0"));
        actions.moveToElement(volumeSom).click().perform();
        String volumeSomLigadoClass = volumeSom.getAttribute("class");
        Assertions.assertFalse(volumeSomLigadoClass.contains("vjs-vol-0"));
        driver.close();
    }

    @Test
    @DisplayName("Escrever uma avaliação para um produto")
    public void EnviarAvaliaçãoProduto(){
        System.setProperty("webdriver.chrome.driver", "src/test/resources/chromedriver");
        WebDriver driver = new ChromeDriver();
        driver.manage().window().maximize();
        Actions actions = new Actions(driver);
        WebDriverWait wait = new WebDriverWait(driver, 10);
        JavascriptExecutor js = (JavascriptExecutor) driver;
        String filePath = "/home/me/Vinicius/automacao.png";

        driver.get("https://amazon.com.br");
        WebElement botaoLogin = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//div[@id='nav-signin-tooltip']//span[@class='nav-action-inner']")));
        actions.moveToElement(botaoLogin).click().perform();
        WebElement campoEmail = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@id='ap_email']")));
        campoEmail.sendKeys("test@hotmail.com");
        WebElement botaoContinuar = driver.findElement(By.xpath("//input[@id='continue']"));
        actions.moveToElement(botaoContinuar).click().perform();
        WebElement campoSenha = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@id='ap_password']")));
        campoSenha.sendKeys("test");
        WebElement botaoFinalizarLogin = driver.findElement(By.xpath("//input[@id='signInSubmit']"));
        actions.moveToElement(botaoFinalizarLogin).click().perform();
        WebElement campoBusca = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@id='twotabsearchtextbox']")));
        actions.moveToElement(campoBusca).click().perform();
        campoBusca.sendKeys("logitech mx master 3s");
        campoBusca.submit();
        WebElement primeiroProduto = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//div[@data-component-type='s-search-result'][1]")));
        actions.moveToElement(primeiroProduto).click().perform();
        wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//span[@id='productTitle']")));
        js.executeScript("window.scrollBy(0,7000)");
        WebElement botaoAvaliacao = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//span[contains(@class,'writeReviewButton')]")));
        actions.moveToElement(botaoAvaliacao).click().perform();
        WebElement cincoEstrelas = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//img[contains(@alt,'cinco estrelas')]")));
        actions.moveToElement(cincoEstrelas).click().perform();
        WebElement campoTituloAvaliacao = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@id='scarface-review-title-label']")));
        actions.moveToElement(campoTituloAvaliacao).click().perform();
        campoTituloAvaliacao.sendKeys("Test Avaliação");
        WebElement uploadImagem = driver.findElement(By.xpath("//input[@id='ryp__media-upload-banner-input']"));
        uploadImagem.sendKeys(filePath);
        WebElement campoAvalicaoEscrita = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//textarea[@id='scarface-review-text-card-title']")));
        actions.moveToElement(campoAvalicaoEscrita).click().perform();
        campoAvalicaoEscrita.sendKeys("Muito bom Test");
        WebElement enviarAvaliacao = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//button[@value='Enviar']")));
        actions.moveToElement(enviarAvaliacao).click().perform();
        wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//div[contains(@class,'a-alert-success')]")));
        driver.close();
    }

}