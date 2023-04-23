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

public class navegacaoSite {
    @Test
    @DisplayName("Navegar pelo pelo menu de navegação lateral")
    public void NavegarMenuLateral(){
        System.setProperty("webdriver.chrome.driver", "src/test/resources/chromedriver");
        WebDriver driver = new ChromeDriver();
        driver.manage().window().maximize();
        Actions actions = new Actions(driver);
        WebDriverWait wait = new WebDriverWait(driver, 10);

        driver.get("https://amazon.com.br");
        WebElement menuLateral = driver.findElement(By.xpath("//a[@id='nav-hamburger-menu']"));
        actions.moveToElement(menuLateral).click().perform();
        WebElement primeiroBotaoVerTudo = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("(//a[contains(@class,'hmenu-compressed-btn')])[1]")));
        actions.moveToElement(primeiroBotaoVerTudo).click().perform();
        WebElement opcaoCategoria = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//a[@class='hmenu-item']//div[text()='Games e Consoles']")));
        actions.moveToElement(opcaoCategoria).click().perform();
        WebElement opcaoSubcategoria = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//a[@class='hmenu-item' and text()='Tudo em Games e Consoles']")));
        actions.moveToElement(opcaoSubcategoria).click().perform();
        wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//span[contains(@class,'apb-browse-refinements-indent-1')]")));
        String filtroBarraPesquisa = driver.findElement(By.xpath("//option[@selected='selected']")).getText();
        Assertions.assertTrue(filtroBarraPesquisa.equals("Games"));
        Assertions.assertEquals("Games e Consoles | Amazon.com.br", driver.getTitle());
        String nomeDepartamento = driver.findElement(By.xpath("//span[contains(@class,'apb-browse-refinements-indent-1')]")).getText();
        Assertions.assertTrue(nomeDepartamento.equals("Games e Consoles"));
        driver.close();
    }

    @Test
    @DisplayName("Navegar pelo menu suspenso das opções do usuário")
    public void NavegarMenuSuspensoUsuario(){
        System.setProperty("webdriver.chrome.driver", "src/test/resources/chromedriver");
        WebDriver driver = new ChromeDriver();
        driver.manage().window().maximize();
        Actions actions = new Actions(driver);
        WebDriverWait wait = new WebDriverWait(driver, 10);

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
        WebElement botaoContaUsuario = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//a[@data-nav-ref='nav_youraccount_btn']")));
        actions.moveToElement(botaoContaUsuario).build().perform();
        WebElement botaoSeusPedidos = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//a[@id='nav_prefetch_yourorders']")));
        actions.moveToElement(botaoSeusPedidos).click().perform();
        wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//h1[text()='Seus pedidos']")));
        String currentUrl = driver.getCurrentUrl();
        Assertions.assertTrue(currentUrl.contains("AccountFlyout_orders"));
        driver.close();
    }

}