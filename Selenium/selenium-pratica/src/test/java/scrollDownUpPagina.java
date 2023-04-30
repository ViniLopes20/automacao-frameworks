import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class scrollDownUpPagina {
    @Test
    @DisplayName("Scroll down e up na tela de um produto")
    public void ScrollDownAndUp(){
        System.setProperty("webdriver.chrome.driver", "src/test/resources/chromedriver");
        WebDriver driver = new ChromeDriver();
        driver.manage().window().maximize();
        Actions actions = new Actions(driver);
        WebDriverWait wait = new WebDriverWait(driver, 10);
        JavascriptExecutor js = (JavascriptExecutor) driver;

        driver.get("https://amazon.com.br");
        wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@id='twotabsearchtextbox']")));
        js.executeScript("window.scrollTo(0, document.body.scrollHeight);");
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState == 'complete';"));

        long scrollHeightDown = (long) js.executeScript("return document.body.scrollHeight;");
        long windowHeightDown = (long) js.executeScript("return window.innerHeight;");
        long scrollPositionDown = (long) js.executeScript("return window.scrollY;");

        // Verifica se a posição do scroll é menor do que a altura total da página menos a altura da janela
        if (scrollPositionDown == (scrollHeightDown - windowHeightDown)) {
            // Se a condição for atendida, o scroll chegou ao final da página
            System.out.println("Chegou ao final da página.");
        } else {
            // Se a condição não for atendida, o scroll não chegou ao final da página e uma exceção é lançada
            throw new AssertionError("O scroll não chegou ao final da página.");
        }

        js.executeScript("window.scrollTo(0, -document.body.scrollHeight);");
        wait.until(ExpectedConditions.jsReturnsValue("return document.readyState == 'complete';"));

        long scrollPositionUp = (long) js.executeScript("return window.scrollY;");

        if (scrollPositionUp == 0) {
            System.out.println("Chegou ao topo da página.");
        } else {
            throw new AssertionError("O scroll não voltou ao topo da página.");
        }
        driver.close();
    }

}