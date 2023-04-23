import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class diferentesDominios {
    @Test
    @DisplayName("Acessar o site da amazon via serviço de busca")
    public void AcessarAmazonSiteViaServicoBusca(){
        System.setProperty("webdriver.chrome.driver", "src/test/resources/chromedriver");
        WebDriver driver = new ChromeDriver();
        driver.manage().window().maximize();
        Actions actions = new Actions(driver);
        WebDriverWait wait = new WebDriverWait(driver, 10);

        driver.get("https://google.com.br");
        WebElement campoBuscaGoogle = driver.findElement(By.xpath("//textarea[@type='search']"));
        actions.moveToElement(campoBuscaGoogle).click().perform();
        campoBuscaGoogle.sendKeys("Amazon");
        campoBuscaGoogle.submit();
        WebElement amazonSite = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//a[@href='https://www.amazon.com.br/']")));
        actions.moveToElement(amazonSite).click().perform();
        wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@id='twotabsearchtextbox']")));
        driver.findElement(By.xpath("//a[@aria-label='Amazon.com.br']"));
        driver.close();
    }

}